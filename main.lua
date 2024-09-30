local cfg = require("BeefStranger.Decipher Scrolls.config")
local bs = require("BeefStranger.Decipher Scrolls.common")

local newName

---@class bsDecipherScrollMenu
local Menu = {}
Menu.ID = {
    main = tes3ui.registerID("BS_DecipherScroll"),
    scroll = "Scroll_",
    scrollIcon = "Scroll_Icon",
    scrollLabel = "Scroll_Label",
    scrollCost = "Scroll_Cost",
    header = "Header",
    headerText = "Header_Text",
    headerCost = "Header_Cost",
    gemBlock = "SoulGem_Block",
    gemValue = "SoulGem_Value",
    gemSelect = "SoulGem_Select",
    gemIcon = "SoulGem_Icon",
    scrollList = "Scroll_List",
    footer = "Footer",
    renameHint = "Rename Hint",
    close = "Close",
}
local id = Menu.ID

Menu.gemProp = tes3ui.registerID("BS_Learn_soulGem")
Menu.gemDataProp = tes3ui.registerID("BS_Learn_soulData")

function Menu:get() return tes3ui.findMenu(id.main) end
function Menu:child(child) return self:get():findChild(child) end
function Menu:ScrollList() return self:child("Scroll_List") end
function Menu:SoulGemIcon() return self:child(id.gemIcon) end
function Menu:SoulGemValue() return self:child(id.gemValue) end
function Menu:Cost(element) return element:getPropertyInt("BS_Scroll_Cost") end---@return number

function Menu:getGem() return self:get():getPropertyObject(self.gemProp) end ---@return tes3misc
function Menu:getGemData() return self:get():getPropertyObject(self.gemDataProp, "tes3itemData") end ---@return tes3itemData
function Menu:getSoul() return self:getGemData() and self:getGemData().soul.soul or 0 end

function Menu:setLabelColor()
    for _, child in ipairs(self:ScrollList():getContentElement().children) do
        if self:getSoul() >= self:Cost(child) then
            child:findChild(id.scrollLabel).color = bs.rgb.normalColor
        else
            child:findChild(id.scrollLabel).color = bs.rgb.focusColor
        end
    end
    -- for id, cost in pairs(CostTrack) do
    --     if self:getGem() and cost <= self:getGemSoul() then
    --         self:child(id):findChild(self.ID.scrollLabel).color = bs.rgb.normalColor
    --     else
    --         self:child(id):findChild(self.ID.scrollLabel).color = bs.rgb.focusColor
    --     end
    -- end
end

function Menu:updateGemDisplay()
    if self:getGem() then
        self:SoulGemIcon().contentPath = "Icons\\" .. self:getGem().icon
        self:SoulGemIcon().visible = true
        self:get():findChild(id.gemValue).text = "Charge: "..self:getSoul()
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

---Clear gem properties/update menu
function Menu:clearGem()
    self:get():removeProperty(Menu.gemProp)
    self:get():removeProperty(Menu.gemDataProp)
    self:updateGemDisplay()
    self:setLabelColor()
end

---@param spell tes3spell
---@param scroll tes3book
function Menu:addSpell(spell, scroll)
    tes3.addSpell { spell = spell, mobile = tes3.mobilePlayer }
    tes3.updateMagicGUI({ reference = tes3.player })
    tes3.removeItem { reference = tes3.player, item = scroll }
    tes3.removeItem { reference = tes3.player, item = self:getGem(), itemData = self:getGemData() }
    self:clearGem()
end

---Slightly tweaked Vanilla Enchant ChargeCost calc, takes into account player enchant level 
---@param enchant tes3enchantment
local function magickaCost(enchant)
    local baseCost = enchant.chargeCost * cfg.costMult
    local actualCost = baseCost - (baseCost / 100) * (tes3.mobilePlayer.enchant.current - 50)
    return math.max(1, math.ceil(actualCost))
end

---@param enchant tes3enchantment
---@return tes3spell
local function createSpell(enchant)
    local spell = tes3.createObject({objectType = tes3.objectType.spell })
    for index, value in ipairs(enchant.effects) do
        spell.effects[index] = value
    end
    spell.magickaCost = magickaCost(enchant)
    return spell
end

function Menu:updateCost()
    for _, element in ipairs(Menu:ScrollList():getContentElement().children) do
        local obj = element:getPropertyObject("BS_Scroll_Object") ---@type tes3book
        element:findChild(id.scrollCost).text = tostring(magickaCost(obj.enchantment))
    end
end

---Create Spell from enchantment and destroy scroll/gem
---@param stack tes3itemStack
---@param e tes3uiEventData
local function scrollClick(stack, e)
    local enchant = stack.object.enchantment
    -- local cost = magickaCost(enchant)
    local cost = Menu:Cost(e.source)

    if Menu:getGem() then
        if Menu:getSoul() > cost then
            local name = string.gsub(stack.object.name, "Scroll of ", "")
            if newName and newName ~= "Rename" then
                name = newName
                newName = nil
            end
            local spell = createSpell(enchant)
            spell.name = cfg.spellPrefix and "[D] "..name or name

            local xp = (cost / 10) + ((Menu:getSoul() - cost) / 10)

            Menu:addSpell(spell, stack.object)
            tes3.mobilePlayer:exerciseSkill(tes3.skill.enchant, xp)
            e.source:destroy()
            tes3.messageBox("You've learned to cast %s", spell.name)
        else
            tes3.messageBox("Soul not powerful enough. Needed: %s", cost)
        end
    else
        tes3.messageBox("You have to select a soul gem first.")
    end
end

local function renameMenu(stack, e)
    local rename = tes3ui.createMenu({id = "Rename", fixedFrame = true})
    rename.autoWidth = false
    rename.autoHeight = true
    rename.width = 256
    -- rename.color = bs.rgb.answerOverColor
    local textBox = rename:createThinBorder({id = "Text Box"})
    textBox.widthProportional = 1
    textBox.autoHeight = true

    local text = textBox:createTextInput({id = "Text", autoFocus = true, placeholderText = "Rename"})
    text.borderAllSides = 3

    local footer = rename:createBlock({id = "Footer"})
    footer.autoHeight = true
    footer.widthProportional = 1
    footer.childAlignX = 1

    local close = footer:createButton({id = "Close", text = "Close"})
    close:register(tes3.uiEvent.mouseClick, function (e)
        e.source:getTopLevelMenu():destroy()
    end)

    local confirm = footer:createButton({id = "Confirm", text = "Confirm"})
    confirm:register(tes3.uiEvent.mouseClick, function (click)
        newName = text.text
        scrollClick(stack, e)
        click.source:getTopLevelMenu():destroy()
    end)
end

---@param list tes3uiElement
local function createScrollList(list)
    local counter = 0
    for i, stack in pairs(tes3.mobilePlayer.inventory) do
        if stack.object.objectType == tes3.objectType.book and stack.object.enchantment then
            local enchant = stack.object.enchantment
            local cost = magickaCost(enchant)

            local itemBlock = list:createBlock { id = id.scroll .. counter }
            itemBlock.autoHeight = true
            itemBlock.widthProportional = 1
            itemBlock:setPropertyInt("BS_Scroll_Cost", cost)
            itemBlock:setPropertyObject("BS_Scroll_Object", stack.object)

            local icon = itemBlock:createImage({ id = id.scrollIcon, path = "Icons\\" .. stack.object.icon })

            local label = itemBlock:createLabel({ id = id.scrollLabel, text = stack.object.name })
            label.borderTop = 5
            label.color = bs.rgb.focusColor

            local costLabel = itemBlock:createLabel({ id = id.scrollCost, text = tostring(magickaCost(enchant))})
            costLabel.absolutePosAlignX = 0.95
            costLabel.ignoreLayoutY = true
            costLabel.positionY = -5

            itemBlock:register(tes3.uiEvent.mouseOver, function(e)
                local scrollTooltip = tes3ui.createTooltipMenu({ item = stack.object })
                scrollTooltip:createLabel({ id = "LearnCost", text = "Decipher Cost: " .. cost })
            end)

            itemBlock:register(tes3.uiEvent.mouseClick, function(e)
                if Menu:getSoul() >= Menu:Cost(e.source) and bs.isKeyDown(tes3.scanCode.lShift) then
                    renameMenu(stack, e)
                else
                    scrollClick(stack, e)
                end
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
            local menu = tes3ui.createMenu { id = id.main, fixedFrame = true }
            menu.width = 400
            menu.height = 600
            menu.autoWidth = false
            menu.autoHeight = false

            local header = menu:createBlock { id = id.header }
            header.autoHeight = true
            header.widthProportional = 1

            local headerText = header:createLabel { id = id.headerText, text = "Decipher Scrolls" }
            headerText.borderLeft = 3
            headerText.borderTop = 13

            local gemBlock = header:createBlock { id = id.gemBlock }
            gemBlock.autoHeight = true
            gemBlock.childAlignX = 1
            gemBlock.widthProportional = 1

            local gemValue = gemBlock:createLabel { id = id.gemValue, text = "Charge: 0" }
            gemValue.borderRight = 10
            gemValue.borderTop = 13

            local gemSelect = gemBlock:createImage({ id = id.gemSelect, path = "Textures\\menu_icon_equip.tga" })
            gemSelect.absolutePosAlignX = 1

            local soulGem = gemSelect:createImage { id = id.gemIcon }
            soulGem.borderAllSides = 6

            local costLabel = header:createLabel({id = id.headerCost, text = "Cost:"})
            costLabel.absolutePosAlignX = 0.93
            costLabel.absolutePosAlignY = 0.96

            soulGemSelect(gemSelect)

            local list = menu:createVerticalScrollPane({ id = id.scrollList })
            createScrollList(list)


            
            local footer = menu:createBlock({id = "Footer"})
            footer.autoHeight = true
            footer.borderTop = 5
            footer.widthProportional = 1
            
            local tip = footer:createLabel({id = "Rename Tip", text = "Hold Shift to Rename:"})
            tip.ignoreLayoutY = true
            tip.positionY = -5
            
            local close = footer:createButton({id = id.close, text = "Close"})
            close.absolutePosAlignX = 1
            close.positionY = -3
            close:register(tes3.uiEvent.mouseClick, function(e)
                e.source:getTopLevelMenu():destroy()
                tes3ui.leaveMenuMode()
            end)
            
            list:getContentElement():sortChildren(function (a, b)
                local costA = tonumber(a:findChild(id.scrollCost).text) or 0
                local costB = tonumber(b:findChild(id.scrollCost).text) or 0
                return costA < costB
            end)

            tes3ui.enterMenuMode("BS_LearnScroll")
        end
    end
end
event.register("keyDown", keyDown)


--- @param e exerciseSkillEventData
local function learn(e)
    if e.skill == tes3.skill.enchant then
        if Menu:get() then
            Menu:updateCost()
        end
    end
end
event.register(tes3.event.skillRaised, learn)


event.register("initialized", function()
    print("[MWSE:Decipher Scrolls] initialized")
end)