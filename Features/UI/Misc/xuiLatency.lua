local ns = XUI 
local CreateFrame = CreateFrame 
local GetNetStats = GetNetStats
local format = string.format

local latency = {
    updateInterval = 1.0,
    timer = 0
}
ns.perfLatency = latency

function latency:Create()

    if self.text then return end

    self.text = ns.perf.frame.container:CreateFontString(nil, "OVERLAY")
    self.text:SetFont(ns.fontPath, 12, "OUTLINE")
    self.text:SetTextColor(1, 1, 1)
end

function latency:Update(elapsed)

    self.timer = self.timer + elapsed

    if self.timer >= self.updateInterval then 
        local _, _, homeLatency, worldLatency = GetNetStats()
        local latencyTotal = homeLatency + worldLatency
        local color = latencyTotal < 200 and "|cff00ff00" or latencyTotal < 400 and "|cffffff00" or "|cffff0000"
        self.text:SetText(format("%s%d|r ms", color, latencyTotal))
        self.timer = 0
    end
end

function latency:Enable()

    if not self.text then 
        self:Create()
    end

    self.text:Show()
    self:RegisterUpdate()
end

function latency:Disable()

    if not self.text then return end

    self.text:Hide()
    self:Unregisterupdate()
end

function latency:RegisterUpdate()

    if self.frame then return end

    self.frame = CreateFrame("Frame")
    self.frame:SetScript("OnUpdate", function(frame, elapsed) 
        self:Update(elapsed)    
    end)
end

function latency:UnregisterUpdate()

    if not self.frame then return end


    self.frame:SetScript("OnUpdate", nil)
    self.frame = nil
end