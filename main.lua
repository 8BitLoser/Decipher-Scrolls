local cfg = require("BeefStranger.Decipher Scrolls.config")
local bs = require("BeefStranger.Decipher Scrolls.common")

local CostTrack = {} ---Used to track scrolls cost to modify label color

---@class bsDecipherScrollMenu
local Menu = {}
Menu.ID = tes3ui.registerID("BS_DecipherScroll")
Menu.gemProp = tes3ui.registerID("BS_Learn_soulGem")
Menu.gemDataProp = tes3ui.registerID("BS_Learn_soulData")

function Menu:get() return tes3ui.findMenu(Menu.ID) end
function Menu:child(child) return self:get():findChild(child) end
function Menu:SoulGemIcon() return self:child("SoulGem_Icon") end
function Menu:SoulGemValue() return self:child("SoulGem_Value") end
function Menu:getGem() return self:get():getPropertyObject(self.gemProp) end ---@return tes3misc
function Menu:getGemData() return self:get():getPropertyObject(self.gemDataProp, "tes3itemData") end ---@return tes3itemData
function Menu:getGemSoul() return self:getGemData() and self:getGemData().soul.soul end

function Menu:setLabelColor()
    for id, cost in pairs(CostTrack) do
        if self:getGem() and cost <= self:getGemSoul() then
            self:child(id):findChild("Label").color = bs.rgb.normalColor
        else
            self:child(id):findChild("Label").color = bs.rgb.focusColor
        end
    end
end

function Menu:updateGemDisplay()
    if self:getGem() then
        self:SoulGemIcon().contentPath = "Icons\\" .. self:getGem().icon
        self:SoulGemIcon().visible = true
        self:get():findChild("SoulGem_Value").text = "Charge: "..self:getGemSoul()
    else
        self:SoulGemIcon().visible = false
        self:SoulGemValue().text = "Charge: 0"
    end
end

---@param selectedGem tes3ui.showInventorySelectMenu.callbackParams
function Menu:setGem(selectedGem)
    self:get():setPropertyObject(self.gemProp, selectedGem.item)
    self:get():setPropertyObject(self.gemDataProp, selectedGem.itemData)
    self:updateGemDisplay()
    self:setLabelColor()
end

function Menu:clearGem()
    self:get():removeProperty(Menu.gemProp)
    self:get():removeProperty(Menu.gemDataProp)
    self:updateGemDisplay()
    self:setLabelColor()
end

---Slightly tweaked Vanilla Enchant ChargeCost calc, takes into account player enchant level 
---@param enchant tes3enchantment
local function magickaCost(enchant)
    local baseCost = enchant.chargeCost * cfg.costMult
    local actualCost = baseCost - (baseCost / 100) * (tes3.mobilePlayer.enchant.current - 50)
    return math.max(1, math.ceil(actualCost))
end

---Create Spell from enchantment and destroy scroll/gem
---@param stack tes3itemStack
---@param e tes3uiEventData
local function spellCreation(stack, e)
    local enchant = stack.object.enchantment
    local cost = magickaCost(enchant)
    if Menu:getGem()--[[  and Learn:SoulGemIcon().visible ]] then
        if Menu:getGemSoul() > cost then
            local spell = tes3.createObject({ id = "bs" .. stack.object.id, objectType = tes3.objectType.spell })
            for index, value in ipairs(enchant.effects) do
                spell.effects[index] = value
            end
            local name = string.gsub(stack.object.name, "Scroll of ", "")
            spell.magickaCost = cost
            spell.name = cfg.spellPrefix and "[D] "..name or name
            tes3.addSpell { spell = spell, mobile = tes3.mobilePlayer }
            tes3.updateMagicGUI({ reference = tes3.player })

            CostTrack[e.source.name] = nil

            tes3.removeItem{reference = tes3.player, item = stack.object}
            tes3.removeItem{reference = tes3.player, item = Menu:getGem(), itemData = Menu:getGemData()}

            Menu:clearGem()
            e.source:destroy()
            tes3.messageBox("You've learned to cast %s", spell.name)
        else
            tes3.messageBox("Soul not powerful enough. Needed: %s", cost)
        end
    else
        tes3.messageBox("You have to select a soul gem first.")
    end
end

---@param list tes3uiElement
local function createScrollList(list)
    CostTrack = {}
    local counter = 0
    for i, stack in pairs(tes3.mobilePlayer.inventory) do
        if stack.object.objectType == tes3.objectType.book and stack.object.enchantment then
            local enchant = stack.object.enchantment
            local cost = magickaCost(enchant)

            local listBlock = list:createBlock { id = "Item_" .. counter }
            listBlock.autoHeight = true
            listBlock.widthProportional = 1

            local icon = listBlock:createImage({ id = "Icon", path = "Icons\\" .. stack.object.icon })

            local label = listBlock:createLabel({ id = "Label", text = stack.object.name })
            label.color = bs.rgb.focusColor

            local costLabel = listBlock:createLabel({ id = "Decipher_Cost", text = tostring(magickaCost(enchant))})
            costLabel.absolutePosAlignX = 1

            CostTrack[listBlock.name] = cost

            listBlock:register(tes3.uiEvent.mouseOver, function(e)
                local scrollTooltip = tes3ui.createTooltipMenu({ item = stack.object })
                scrollTooltip:createLabel({ "LearnCost", text = "Decipher Cost: " .. cost })
            end)

            listBlock:register(tes3.uiEvent.mouseClick, function(e)
                spellCreation(stack, e)
            end)

            counter = counter + 1
        end
    end
end

---@param gemSelect tes3uiElement
local function soulGemSelect(gemSelect)
    gemSelect:register(tes3.uiEvent.mouseClick, function(e)
        tes3ui.showInventorySelectMenu({
            title = "Soul Gems",
            filter = function(f)
                return ((f.item.isSoulGem and f.itemData) and true) or false
            end,
            callback = function(select)
                if select.item then
                    Menu:setGem(select)
                    e.source:getTopLevelMenu():updateLayout()
                end
            end
        })
    end)
end

---@param e keyUpEventData
local function keyDown(e)
    if not tes3ui.menuMode() then
        if tes3.isKeyEqual({actual = e, expected = cfg.key}) then
            local menu = tes3ui.createMenu { id = Menu.ID, fixedFrame = true }
            menu.width = 400
            menu.height = 600
            menu.autoWidth = false
            menu.autoHeight = false

            local header = menu:createBlock { id = "Header" }
            header.autoHeight = true
            header.widthProportional = 1
            header:createLabel { id = "Header_Text", text = "Decipher Scrolls" }

            local gemBlock = header:createBlock { id = "SoulGem_Block" }
            gemBlock.autoHeight = true
            gemBlock.widthProportional = 1
            gemBlock.childAlignX = 1

            local soulValue = gemBlock:createLabel { id = "SoulGem_Value", text = "Charge: 0" }
            soulValue.borderTop = 10
            soulValue.borderRight = 30

            local gemSelect = gemBlock:createImage({ id = "SoulGem_Select", path = "Textures\\menu_icon_equip.tga" })
            gemSelect.absolutePosAlignX = 1

            local soulGem = gemSelect:createImage { id = "SoulGem_Icon" }
            soulGem.borderAllSides = 6

            soulGemSelect(gemSelect)

            local list = menu:createVerticalScrollPane({ id = "Scroll_List" })
            createScrollList(list)

            list:getContentElement():sortChildren(function (a, b)
                local costA = tonumber(a:findChild("Decipher_Cost").text) or 0
                local costB = tonumber(b:findChild("Decipher_Cost").text) or 0
                return costA < costB
            end)

            local close = menu:createButton({ id = "Close", text = "Close" })
            close:register(tes3.uiEvent.mouseClick, function(e)
                e.source:getTopLevelMenu():destroy()
                tes3ui.leaveMenuMode()
            end)

            tes3ui.enterMenuMode("BS_LearnScroll")
        end
    end
end
event.register("keyDown", keyDown)

event.register("initialized", function()
    print("[MWSE:Decipher Scrolls] initialized")
end)