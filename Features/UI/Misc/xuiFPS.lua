local ns = XUI 
local CreateFrame = CreateFrame
local GetFramerate = GetFramerate
local format = string.format

local fps = {
    updateInterval = 1.0,
    timer = 0
}

ns.perfFPS = fps

function fps:Create()

    if self.text then return end

    self.text = ns.perf.frame.container:CreateFontString(nil, "OVERLAY")
    self.text:SetFont(ns.fontPath, 12, "OUTLINE")
    self.text:SetTextColor(1, 1, 1)
end

function fps:Update(elapsed)

    if not elapsed then return end

    self.timer = (self.timer or 0) + elapsed

    if self.timer >= self.updateInterval then 
        local framerate = GetFramerate()
        local color = framerate >= 30 and "|cff00ff00" or framerate >= 15 and "|cfffff00" or "|cffff0000"
        self.text:SetText(format("%s%.0f|r fps", color, framerate))
        self.timer = 0
    end
end

function fps:Enable()
    if not self.text then 
        self:Create()
    end

    self.text:Show()
    self:RegisterUpdate()
end

function fps:Disable()

    if not self.text then return end

    self.text:Hide()
    self:UnregisterUpdate()
end

function fps:RegisterUpdate()

    if self.frame then return end

    self.frame = CreateFrame("Frame")
    self.frame:SetScript("OnUpdate", function(frame, elapsed) 
        self:Update(elapsed)            
    end)
end

function fps:UnregisterUpdate()

    if self.frame then return end

    self.frame:SetScript("OnUpdate", nil)
    self.frame = nil
    self.timer = 0
end