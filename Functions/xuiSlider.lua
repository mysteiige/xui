local ns = XUI

local function newSlider(column, text, tip, db, min, max, step)
    print("Creating slider:", text, " in column: ", column)

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

    local slider = CreateFrame("Slider", "xuiSlider" .. text, xgui, "OptionsSliderTemplate")

    if not slider then
        print("Failed to create slider frame")
        return
    end

    --positioning
    slider:SetPoint("TOPLEFT", xgui, "TOPLEFT", xOffset[column], yOffset)
    yOffset = yOffset - 30

    --min, max, increments
    slider:SetMinMaxValues(min, max)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)

    -- Set slider value
    if ns.xuidb[db] ~= nil then
        slider:SetValue(ns.xuidb[db])
    else
        slider:SetValue(min)
        ns.xuidb[db] = min
    end

    print("Slider made successfully")

    slider.text = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    slider.text:SetText(text)
    slider.text:SetPoint("BOTTOM", slider, "TOP", 0, 5)

    slider.tooltipText = tip
    slider.db = db

    slider:SetScript("OnValueChanged", function(self, value)
        ns.xuidb[db] = value
        print("Slider", text, "value changed to:", value)
    end)

    --tooltip
    slider:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(tip, nil, nil, nil, nil, true)
        GameTooltip:Show()
    end)

    slider:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    ns.ApplyFontStyle(_G[slider:GetName() .. "Text"], "NORMAL")
    ns.ApplyFontStyle(_G[slider:GetName() .. "Low"], "NORMAL")
    ns.ApplyFontStyle(_G[slider:GetName() .. "High"], "NORMAL")

    return slider
end

ns.newSlider = newSlider
