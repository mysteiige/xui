local ns = XUI 
local CreateFrame = CreateFrame 
local GetBuildInfo = GetBuildInfo
local GetCurrentRegion = GetCurrentRegion
local C_AddOns = C_AddOns
local format = string.format 

local stats = {
    updateInterval = 1.0,
    timer = 0
}
ns.perfStats = stats

function stats:Create()

    if self.text then return end 

    self.text = ns.perf.frame.container:CreateFontString(nil, "OVERLAY")
    self.text:SetFont(ns.fontPath, 12, "OUTLINE")
    self.text:SetTextColor(1, 1, 1)
end

function stats:GetClientInfo()

    local version, build, date, tocversion = GetBuildInfo()
    local region = GetCurrentRegion()
    local pte = C_AddOns.IsAddOnLoaded("Blizzard_PTRFeedback")

    local clientInfo = format("Client: %s (%s)", version, build)
    if ptr then 
        clientInfo = clientInfo .. " |cffff0000PTR|r"
    end

    return clientInfo
end

function stats:Update(elapsed)

    if not elapsed then return end 

    self.timer = (self.timer or 0) + elapsed

    if self.timer >= self.updateInterval then 
        self.text:SetText(self:GetClientInfo())
        self.timer = 0
    end 
end

function stats:Enable()

    if not self.text then 
        self:Create()
    end

    self.text:Show()
    self:RegisterUpdate()
end

function stats:Disable()

    if not self.text then return end

    self.text:Hide()
    self:Unregisterupdate()
end

function stats:RegisterUpdate()

    if self.frame then return end

    self.frame = CreateFrame("Frame")
    self.frame:SetScript("OnUpdate", function(frame, elapsed) 
        self:Update(elapsed)    
    end)
end

function stats:UnregisterUpdate()

    if not self.frame then return end


    self.frame:SetScript("OnUpdate", nil)
    self.frame = nil
    self.frame = 0
end