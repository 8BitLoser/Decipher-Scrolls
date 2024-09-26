local cfg = require("BeefStranger.Decipher Scrolls.config")
local bs = require("BeefStranger.Decipher Scrolls.common")

local CostTrack = {} ---Used to track scrolls cost to modify label color

---@class bsDecipherScroll
local Learn = {}
Learn.ID = tes3ui.registerID("BS_DecipherScroll")
Learn.gemProp = tes3ui.registerID("BS_Learn_soulGem")
Learn.gemDataProp = tes3ui.registerID("BS_Learn_soulData")

function Learn:get() return tes3ui.findMenu(Learn.ID) end
function Learn:child(child) return self:get():findChild(child) end
function Learn:SoulGemIcon() return self:child("SoulGem_Icon") end
function Learn:getGem() return self:get():getPropertyObject(self.gemProp) end
---@return tes3itemData
function Learn:getGemData() return self:get():getPropertyObject(self.gemDataProp, "tes3itemData") end
function Learn:getGemSoul() return self:getGemData() and self:getGemData().soul.soul end
---@param selectedGem tes3ui.showInventorySelectMenu.callbackParams
function Learn:setGem(selectedGem)
    self:get():setPropertyObject(self.gemProp, selectedGem.item)
    self:get():setPropertyObject(self.gemDataProp, selectedGem.itemData)
end

-- function Learn:clearGem()
--     self:get():setPropertyObject(self.gemProp, "")
--     self:get():setPropertyObject(self.gemDataProp, "")
-- end

---Slightly tweaked Vanilla Enchant ChargeCost calc, takes into account player enchant level 
---@param enchant tes3enchantment
local function magickaCost(enchant)
    local baseCost = enchant.chargeCost * 1.05
    local actualCost = baseCost - (baseCost / 100) * (tes3.mobilePlayer.enchant.current - 50)
    return math.max(1, math.ceil(actualCost))
end

---Reset all scroll label colors
local function resetLabelColor()
    for id, _ in pairs(CostTrack) do
        Learn:child(id):findChild("Label").color = bs.rgb.focusColor
    end
end

---Create Spell from enchantment and destroy scroll/gem
---@param stack tes3itemStack
---@param e tes3uiEventData
local function spellCreation(stack, e)
    local enchant = stack.object.enchantment
    local cost = magickaCost(enchant)
    if Learn:getGem() and Learn:SoulGemIcon().visible then
        if Learn:getGemSoul() > cost then
            local spell = tes3.createObject({ id = "bs" .. stack.object.id, objectType = tes3.objectType.spell })
            for index, value in ipairs(enchant.effects) do
                spell.effects[index] = value
            end
            spell.magickaCost = cost
            spell.name = "[D] " .. string.gsub(stack.object.name, "Scroll of ", "")
            tes3.addSpell { spell = spell, mobile = tes3.mobilePlayer }
            tes3.updateMagicGUI({ reference = tes3.player })
            Learn:SoulGemIcon().visible = false
            Learn:get():findChild("SoulGem_Value").text = "Charge: 0"
            debug.log(cost)

            resetLabelColor()
            CostTrack[e.source.name] = nil

            tes3.removeItem{reference = tes3.player, item = stack.object}
            tes3.removeItem{reference = tes3.player, item = Learn:getGem(), itemData = Learn:getGemData()}
            e.source:destroy()
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
            -- listBlock.autoWidth = true
            listBlock.widthProportional = 1

            local icon = listBlock:createImage({ id = "Icon", path = "Icons\\" .. stack.object.icon })
            local label = listBlock:createLabel({ id = "Label", text = stack.object.name })
            label.color = bs.rgb.focusColor
            -- if Learn:getGemSoul() and Learn:getGemSoul() then
            --     label.color = Learn:getGemSoul() > magickaCost(enchant) and bs.rgb.normalColor or bs.rgb.negativeColor
            -- end
            local costLabel = listBlock:createLabel({ id = "Decipher_Cost", text = "Cost: " .. magickaCost(enchant) })
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

local function setLabelColor()
    for id, cost in pairs(CostTrack) do
        if cost <= Learn:getGemSoul() then
            Learn:child(id):findChild("Label").color = bs.rgb.normalColor
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
                    Learn:SoulGemIcon().contentPath = "Icons\\" .. select.item.icon
                    Learn:SoulGemIcon().visible = true
                    Learn:setGem(select)
                    Learn:get():findChild("SoulGem_Value").text = "Charge: " .. select.itemData.soul.soul

                    setLabelColor()

                    e.source:getTopLevelMenu():updateLayout()
                end
            end
        })
    end)
end

event.register("keyUp", function(e)
    if not tes3ui.menuMode() then
        local menu = tes3ui.createMenu { id = Learn.ID, fixedFrame = true }
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

        local close = menu:createButton({ id = "Close", text = "Close" })
        close:register(tes3.uiEvent.mouseClick, function(e)
            e.source:getTopLevelMenu():destroy()
            tes3ui.leaveMenuMode()
        end)

        tes3ui.enterMenuMode("BS_LearnScroll")
    end
end, { filter = cfg.key.keyCode })


event.register("initialized", function()
    print("[MWSE:Decipher Scrolls] initialized")
end)