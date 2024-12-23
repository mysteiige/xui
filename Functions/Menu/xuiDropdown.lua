local ns = XUI

local function newDropdown(column, text, tip, db, options)
    print("Creating dropdown:", text, " in column: ", column)

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

    local dropdown = CreateFrame("Frame", "xuiDropdown" .. text, xgui, "UIDropDownMenuTemplate")
    dropdown:SetWidth(180)

    if not dropdown then
        print("Failed to create dropdown frame")
        return
    end

    --position
    dropdown:SetPoint("TOPLEFT", xgui, "TOPLEFT", xOffset[column], yOffset)
    yOffset = yOffset - 30

    UIDropDownMenu_SetWidth(dropdown, 150)
    UIDropDownMenu_SetText(dropdown, text)

    UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        for i, option in ipairs(options) do
            info.text = option
            info.func = function()
                UIDropDownMenu_SetText(dropdown, option)
                ns.xuidb[db] = i
                print("Dropdown", text, "value changed to:", option)
            end
            UIDropDownMenu_AddButton(info)
        end
    end)

    if ns.xuidb[db] ~= nil then
        UIDropDownMenu_SetText(dropdown, options[ns.xuidb[db]])
    else
        UIDropDownMenu_SetText(dropdown, options[1])
        ns.xuidb[db] = 1
    end

    print("Dropdown made successfully")

    dropdown.tooltipText = tip
    dropdown.db = db

    --tooltip
    dropdown:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tip, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)

    dropdown:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    local label = ns.CreateFontString(dropdown, "NORMAL")
    label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 16, 3)
    label:SetText(text)

    return dropdown
end

ns.newDropdown = newDropdown
