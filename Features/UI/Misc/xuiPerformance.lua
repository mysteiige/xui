local ns = XUI 
local CreateFrame = CreateFrame
local min, max = math.min, math.max
local EasyMenu = EasyMenu
local UIDropDownMenu_Initialize = UIDropDownMenu_Initialize
local UIDropDownMenu_CreateInfo = UIDropDownMenu_CreateInfo
local UIDropDownMenu_AddButton = UIDropDownMenu_AddButton
local ToggleDropDownMenu = ToggleDropDownMenu

local perf = {}
ns.perf = perf --expose globally

local defaults = {
    perfPosition = {"TOP", "UIParent", "TOP", 0, -5}
}


local isMoving

local function ShowMenu(frame, menuList)
    local dropDown = CreateFrame("Frame", "xuiTempDropDown", UIParent, "UIDropDownMenuTemplate")

    UIDropDownMenu_Initialize(dropDown, function(self, level) 
    
        for _, item in ipairs(menuList) do
            local info = UIDropDownMenu_CreateInfo()
            for k, v in pairs(item) do 
                info[k] = v 
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end, "MENU")

    ToggleDropDownMenu(1, nil, dropDown, frame, 0, 0)
end

local function InitializePerformanceFrame() 
    if perf.frame then return end

    --genesis 1
    perf.frame = CreateFrame("Button", "xuiPerformanceFrame", UIParent, "BackdropTemplate")
    local frame = perf.frame
    frame:SetSize(150, 20)
    frame:SetPoint(unpack(ns.xuidb.perfPosition))
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:RegisterForClicks("AnyUp")

    --background for dragging
    frame.bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.bg:SetAllPoints()
    frame.bg:SetColorTexture(0, 0, 0, 0.5)

    --BUILD THE WALL
    frame.border = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    frame.border:SetPoint("TOPLEFT", -1, 1)
    frame.border:SetPoint("BOTTOMRIGHT", 1, -1)
    frame.border:SetBackdrop({
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    frame.border:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)

    --container
    frame.container = CreateFrame("Frame", nil, frame)
    frame.container:SetPoint("TOPLEFT", 2, -2)
    frame.container:SetPoint("BOTTOMRIGHT", -2, 2)

    --dragging functionality
    frame:SetScript("OnDragStart", function(self)
        if isMoving then return end
        self:StartMoving()
        isMoving = true
    end)

    frame:SetScript("OnDragStop", function(self) 
    
        if not isMoving then return end --dont do shit if she isnt moving
        self:StopMovingOrSizing()
        isMoving = false --put that hoe in her place

        local point, _, relPoint, x, y = self:GetPoint()
        ns.xuidb.perfPosition = {point, "UIParent", relPoint, x, y}
    end)

    frame:SetScript("OnHide", function(self) 
        if isMoving then 
            self:StopMovingOrSizing()
            isMoving = false
        end
    end)

    --draggable icon
    frame:SetScript("OnEnter", function(self) 

        frame.border:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:AddLine("XUI Performance Monitor")
        GameTooltip:AddLine("Left-click and drag to move")
        GameTooltip:Show()    
    end)

    frame:SetScript("OnLeave", function()

        frame.border:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)

        GameTooltip:Hide()    
    end)

    --context menu
    --frame:RegisterForClicks("RightButtonUp")
    frame:SetScript("OnClick", function(self, button) 
    
        if button == "RightButton" then 
            local menu = {
                {text = "XUI Performance Options", isTitle = true},
                {text = "Show FPS", checked = ns.xuidb.perfFPS, func = function()
                    ns.xuidb.perfFPS = not ns.xuidb.perfFPS
                    perf:ApplySettings()
                end},
                {text = "Show Latency", checked = ns.xuidb.perfLatency, func = function()
                    ns.xuidb.perfLatency = not ns.xuidb.perfLatency
                    perf:ApplySettings()
                end},
                {text = "Show Memory", checked = ns.xuidb.perfMemory, func = function()
                    ns.xuidb.perfMemory = not ns.xuidb.perfMemory
                    perf:ApplySettings()
                end},
                {text = "Show Stats", checked = ns.xuidb.perfStats, func = function()
                    ns.xuidb.perfStats = not ns.xuidb.perfStats
                    perf:ApplySettings()
                end},
                {text = "Reset Position", func = function()
                    frame:ClearAllPoints()
                    frame:SetPoint(unpack(defaults.perfPosition))
                    ns.xuidb.perfPosition = defaults.perfPosition
                end},
            }
            ShowMenu(self, menu)
        end
    end)

    perf.frame = frame

    return frame
end

--update the layout
function perf:UpdateLayout()
    
    if not self.frame then return end

    local padding = 8
    local leftMargin = 5
    local rightMargin = 5
    local totalWidth = leftMargin

    local elementWidths = {}
    --[[
    local elements = {
        { module = ns.perfFPS, enabled = ns.xuidb.perfFPS },
        { module = ns.perfLatency, enabled = ns.xuidb.perfLatency },
        { module = ns.perfMemory, enabled = ns.xuidb.perfMemory },
        { module = ns.perfStats, enabled = ns.xuidb.perfStats }
    }
    ]]

    if ns.perfFPS and ns.perfFPS.text then 
        ns.perfFPS.text:ClearAllPoints()
    end
    if ns.perfFPS and ns.perfFPS.text then 
        ns.perfFPS.text:ClearAllPoints()
    end
    if ns.perfFPS and ns.perfFPS.text then 
        ns.perfFPS.text:ClearAllPoints()
    end
    if ns.perfFPS and ns.perfFPS.text then 
        ns.perfFPS.text:ClearAllPoints()
    end

    if ns.xuidb.perfFPS and ns.perfFPS.text then
        ns.perfFPS.text:SetPoint("LEFT", self.frame.container, "LEFT", totalWidth, 0)
        totalWidth = totalWidth + ns.perfFPS.text:GetStringWidth() + 10
    end
    
    if ns.xuidb.perfLatency and ns.perfLatency.text then
        ns.perfLatency.text:SetPoint("LEFT", self.frame.container, "LEFT", totalWidth, 0)
        totalWidth = totalWidth + ns.perfLatency.text:GetStringWidth() + 10
    end
    
    if ns.xuidb.perfMemory and ns.perfMemory.text then
        ns.perfMemory.text:SetPoint("LEFT", self.frame.container, "LEFT", totalWidth, 0)
        totalWidth = totalWidth + ns.perfMemory.text:GetStringWidth() + 10
    end
    
    if ns.xuidb.perfStats and ns.perfStats.text then
        ns.perfStats.text:SetPoint("LEFT", self.frame.container, "LEFT", totalWidth, 0)
        totalWidth = totalWidth + ns.perfStats.text:GetStringWidth() + 10
    end


    for i, module in ipairs(activeElements) do
        module.text:ClearAllPoints()
        module.text:SetPoint("LEFT", self.frame.container, "LEFT", xOffset, y)
        xOffset = xOffset + module.text:GetStringWidth() + 10 --padding
    end

    --[[
    for _, element in ipairs(elements) do
        if element.enabled and element.module.text then 
            element.module.text:ClearAllPoints()
            element.module.text:SetPoint("LEFT", self.frame.container, "LEFT", xOffset, 0)
            xOffset = xOffset + element.module.text:GetStringWidth() + 5
        end
    end
    ]]
    --update based on size
    totalWidth = totalWidth + 5
    self.frame:SetWidth(max(150, totalWidth))
end

function perf:ApplySettings()
    if ns.xuidb.perfEnable then 
        self:Enable()
    else 
        self:Disable()
    end
end

function perf:Enable()
    if not self.frame then 
        InitializePerformanceFrame()
    end

    if ns.xuidb.perfFPS then 
        ns.perfFPS:Enable()
    end

    if ns.xuidb.perfLatency then 
        ns.perfLatency:Enable()
    end

    if ns.xuidb.perfMemory then 
        ns.perfMemory:Enable()
    end

    if ns.xuidb.perfStats then 
        ns.perfStats:Enable()
    end

    self:UpdateLayout()
    self.frame:Show()

end

function perf:Disable()

    if not self.frame then return end

    --disable
    ns.perfFPS:Disable()
    ns.perfLatency:Disable()
    ns.perfMemory:Disable()
    ns.perfStats:Disable()

    self.frame:Hide()
end

ns.RegisterApplySettings("performance", function() 
    perf:ApplySettings()
end)

ns.xuie("PLAYER_LOGIN", function() 
    perf:ApplySettings()
end)

ns.perf.UpdateLayout = perf.UpdateLayout