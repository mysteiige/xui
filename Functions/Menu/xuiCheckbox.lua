local ns = XUI

local function newCheckbox(column, text, tip, db)
    print("Creating checkbox:", text, " in column: ", column)

    if column < 1 or column > 3 then
        print("Invalid column value: ", column)
        return
    end

    local xOffset = {16, 226, 446} 
    local yOffset = -60

    --[[
        Changes here will be nessecary in the long term. Mostly going to be re-doing all the menu content.
        Right now everything is hard-coded in place inside the menu
    ]]

    --creation
    local check = CreateFrame("CheckButton", "xuiCheck" .. text, xgui, "InterfaceOptionsCheckButtonTemplate")

    if not check then
        print("Failed to create checkbox frame")
        return
    end

    --set position (remove later)
    check:SetPoint("TOPLEFT", xgui, "TOPLEFT", xOffset[column], yOffset)
    yOffset = yOffset - 30 -- Adjust vertical spacing for the next control

    --populate button if needed
    if ns.xuidb[db] ~= nil then
        check:SetChecked(ns.xuidb[db])
    else
        check:SetChecked(false)
        ns.xuidb[db] = false
    end

    print("Checkbox made successfully")

    check.text:SetText(text)
    check.tooltipText = tip
    check.db = db

    check:SetScript("OnClick", function(self)
        local newState = self:GetChecked()
        ns.xuidb[db] = newState
        print("Checkbox", text, "state changed to:", newState)
    end)

    --tooltip
    check:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tip, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)

    check:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    ns.ApplyFontStyle(check.text, "NORMAL")

    return check
end

ns.newCheckbox = newCheckbox
