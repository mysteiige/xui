local ns = XUI

local function newDropdown(column, text, tip, db, options)
    --genesis 1
    local dropdown = CreateFrame("Frame", nil, xgui)
    dropdown:SetSize(180, 50)

    --widget
    local dropWidget = CreateFrame("Frame", nil, dropdown, "UIDropDownMenuTemplate")
    dropWidget:SetPoint("TOP", dropdown, "TOP", 0, -15)
    UIDropDownMenu_SetWidth(dropWidget, 150)

    local label = dropdown:CreateFontString(nil, "ARTWORK")
    label:SetPoint("BOTTOM", dropWidget, "TOP", 0, 0)
    ns.styleText(label)
    label:SetText(text)

    if not xuidb[db] then 
        xuidb[db] = 1
    end

    UIDropDownMenu_Initialize(dropWidget, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        for i, option in ipairs(options) do 
            info.text = option
            info.func = function()
                UIDropDownMenu_SetText(dropWidget, option)
                UIDropDownMenu_JustifyText(dropWidget, "CENTER")
                xuidb[db] = i 

                print("newDropdown: dropdown value changed:", db, "=", option)

                --stuff for later
                if ns.ApplySettings then 
                    ns.ApplySettings()
                end
            end
            info.checked = (i == xuidb[db])
            UIDropDownMenu_AddButton(info)
        end
    end)

    --initial text
    UIDropDownMenu_SetText(dropWidget, options[xuidb[db]])
    --center align for looks
    UIDropDownMenu_JustifyText(dropWidget, "CENTER")

    dropWidget:EnableMouse(true)

    --tooltip
    if tip then
        dropWidget:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tip, nil, nil, nil, nil, true)
            GameTooltip:Show()
        end)
        dropWidget:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
    end

    return dropdown 
end

ns.newDropdown = newDropdown