local ns = XUI

local function newCheckbox(clickX, text, tip, db)
    print("Creating checkbox:", text, "DB Key:", db) -- Debug
    
    local xOffset = {16, 226, 446}
    local yOffset = {0, 0, 0}
    
    if clickX < 1 or clickX > 3 then return end
    
    local x = xOffset[clickX]
    local y = yOffset[clickX] * 30 - 100
    yOffset[clickX] = yOffset[clickX] + 1
    
    if text == "" then return end

    -- Defer checkbox creation to PLAYER_LOGIN to ensure database is loaded
    ns.xuie("PLAYER_LOGIN", function()
        print("DB value for", db, ":", ns.xuidb[db]) -- Debug
        
        local check = CreateFrame("CheckButton", "xuiCheck" .. text, xgui, "InterfaceOptionsCheckButtonTemplate")
        check:SetPoint("TOPLEFT", xgui, "TOPLEFT", x, y)
        
        -- Set initial state from database
        check:SetChecked(ns.xuidb[db])
        check.text:SetText(text)
        
        -- Tooltip handling
        check:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine("|cffFFFFFF" .. tip .. "|r")
            GameTooltip:Show()
        end)
        
        check:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        
        -- Save state changes
        check:SetScript("OnClick", function(self)
            local newState = self:GetChecked()
            ns.xuidb[db] = newState
            print("Checkbox", text, "state changed to:", newState) -- Debug
        end)
    end)
end

ns.newCheckbox = newCheckbox
