local ns = XUI
local CreateFrame = CreateFrame 
local UpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage 
local GetAddOnMemoryUsage = GetAddOnMemoryUsage
local format = string.format 
local collectgarbage = collectgarbage

local memory = {
    updateInterval = 1.0,
    timer = 0
}
ns.perfMemory = memory

function memory:Create()

    if self.text then return end

    self.text = ns.perf.frame.container:CreateFontString(nil, "OVERLAY")
    self.text:SetFont(ns.fontPath, 12, "OUTLINE")
    self.text:SetTextColor(1, 1, 1)
end

function memory:GetFormattedMemory(mem)

    if mem > 1024 then 
        return format("%.2f|r mb", mem / 1024)
    else
        return format("%.0f|r kb", mem)
    end 
end 

function memory:Update(elapsed)

    if not elapsed then return end 
    
    self.timer = (self.timer or 0) + elapsed

    if self.timer >= self.updateInterval then 
        UpdateAddOnMemoryUsage()
        local addonMemory = GetAddOnMemoryUsage("XUI")
        local color = addonMemory < 1024 and "|cff00ff00" or addonMemory < 2048 and "|cffffff00" or "|cffff0000"
        self.text:SetText(format("%s%s", color, self:GetFormattedMemory(addonMemory)))
        self.timer = 0
    end
end

function memory:Enable()

    if not self.text then 
        self:Create()
    end 

    self.text:Show()
    self:RegisterUpdate()
end

function memory:Disable()

    if not self.text then return end 

    self.text:Hide()
    self:UnregisterUpdate()
    collectgarbage("collect")
end

function memory:RegisterUpdate()

    if self.frame then return end 

    self.frame = CreateFrame("Frame")
    self.frame:SetScript("OnUpdate", function(frame, elapsed)
        memory:Update(elapsed)
    end)
end

function memory:UnregisterUpdate()

    if not self.frame then return end

    self.frame:SetScript("OnUpdate", nil)
    self.frame = nil
    self.timer = 0
end