local ns = XUI

local function newCheckbox(column, text, tip, db) 

    --genesis 1
    local check = CreateFrame("Frame", nil, xgui)
    check:SetSize(180, 30)

    local checkWidget = CreateFrame("CheckButton", nil, check, "InterfaceOptionsCheckButtonTemplate")
    checkWidget:SetPoint("LEFT", check, "LEFT", 0, 0)

    if xuidb[db] == nil then 
        xuidb[db] = false
    end
    checkWidget:SetChecked(xuidb[db])

    local label = check:CreateFontString(nil, "ARTWORK")
    if not label then print("newCheckbox: failed to create font string") return end
    label:SetPoint("LEFT", checkWidget, "RIGHT", 0, 0)
    ns.styleText(label)
    label:SetText(text)

    checkWidget:EnableMouse(true)

    checkWidget:SetScript("OnClick", function(self) 
    
        local newState = self:GetChecked()
        xuidb[db] = newState

        print("newCheckbox: checkbox value changed:", db, "=", newState)

        --settings function for later
        if ns.ApplySettings then 
            for moduleName, func in pairs(ns.ApplySettings) do 
                func()
            end
        end
    end)

    if tip then 
        checkWidget:SetScript("OnEnter", function(self) 
    
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tip, nil, nil, nil, true)
            GameTooltip:Show()

        end)

        checkWidget:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
    
    end

    if checkWidget.text then checkWidget.text:Hide() end

    return check

end

ns.newCheckbox = newCheckbox