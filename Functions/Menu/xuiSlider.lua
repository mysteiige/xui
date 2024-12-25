local ns = XUI

local function newSlider(column, text, tip, db, min, max, step)
    --genesis 1
    local slider = CreateFrame("Frame", nil, xgui)
    slider:SetSize(180, 50)

    -- make it
    local sliderWidget = CreateFrame("Slider", nil, slider, "OptionsSliderTemplate")
    sliderWidget:SetPoint("TOP", slider, "TOP", 0, -15)
    sliderWidget:SetWidth(180)
    sliderWidget:SetHeight(15)
    sliderWidget:SetOrientation('HORIZONTAL')
    sliderWidget:SetMinMaxValues(min, max)
    sliderWidget:SetValueStep(step)
    sliderWidget:SetObeyStepOnDrag(true)
    
    --default values
    if not xuidb[db] then
        xuidb[db] = min
    end
    sliderWidget:SetValue(xuidb[db])

    --just hide the default text (lazy do something about this later)
    if sliderWidget.Text then sliderWidget.Text:Hide() end
    if sliderWidget.Low then sliderWidget.Low:Hide() end
    if sliderWidget.High then sliderWidget.High:Hide() end

    --text
    local label = slider:CreateFontString(nil, "ARTWORK")
    label:SetPoint("BOTTOM", sliderWidget, "TOP", 0, 0)
    ns.styleText(label)
    label:SetText(text)
    
    local lowText = slider:CreateFontString(nil, "ARTWORK")
    lowText:SetPoint("TOPLEFT", sliderWidget, "BOTTOMLEFT", 2, -3)
    ns.styleText(lowText)
    lowText:SetText(min)
    
    local highText = slider:CreateFontString(nil, "ARTWORK")
    highText:SetPoint("TOPRIGHT", sliderWidget, "BOTTOMRIGHT", -2, -3)
    ns.styleText(highText)
    highText:SetText(max)

    --current value
    local valueText = slider:CreateFontString(nil, "ARTWORK")
    valueText:SetPoint("TOP", sliderWidget, "BOTTOM", 0, -3)   
    ns.styleText(valueText)
    valueText:SetText(xuidb[db])

    -- make sure mouse can interact
    sliderWidget:EnableMouse(true)
    
    --self explanatory
    sliderWidget:SetScript("OnValueChanged", function(self, value)
        --round to nearest whole number
        value = math.floor(value * 10 + 0.5) / 10
        
        --update db
        xuidb[db] = value
        
        --update value
        valueText:SetText(value)
        
        -- Print for debugging
        print("Slider value changed:", db, "=", value)
        
        --settings function for later
        if ns.ApplySettings then
            for moduleName, func in pairs(ns.ApplySettings) do 
                func()
            end
        end
    end)
    
    --tooltip
    if tip then
        sliderWidget:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tip, nil, nil, nil, nil, true)
            GameTooltip:Show()
        end)
        sliderWidget:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
    end

    return slider
end

ns.newSlider = newSlider