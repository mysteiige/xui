local ns = XUI

local function newTextbox(column, text, tip, db)
    print("Creating textbox:", text, " in column: ", column)

    if column < 1 or column > 3 then
        print("Invalid column value: ", column)
        return
    end

    local xOffset = {16, 226, 446} -- Horizontal offsets for columns
    local yOffset = -60 -- Initial vertical offset

    -- Create the textbox
    local textbox = CreateFrame("EditBox", "xuiTextbox" .. text, xgui, "InputBoxTemplate")

    if not textbox then
        print("Failed to create textbox frame")
        return
    end

    --position
    textbox:SetPoint("TOPLEFT", xgui, "TOPLEFT", xOffset[column], yOffset)
    yOffset = yOffset - 30

    textbox:SetSize(200, 30)
    textbox:SetAutoFocus(false)

    if ns.xuidb[db] ~= nil then
        textbox:SetText(ns.xuidb[db])
    else
        textbox:SetText("")
        ns.xuidb[db] = ""
    end

    print("Textbox made successfully")

    textbox.text = textbox:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    textbox.text:SetText(text)
    textbox.text:SetPoint("BOTTOM", textbox, "TOP", 0, 5)

    textbox.tooltipText = tip
    textbox.db = db

    textbox:SetScript("OnTextChanged", function(self)
        ns.xuidb[db] = self:GetText()
        print("Textbox", text, "value changed to:", self:GetText())
    end)

    --tooltip
    textbox:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tip, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)

    textbox:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    return textbox
end

ns.newTextbox = newTextbox
