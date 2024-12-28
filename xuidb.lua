local AddonName = ...
local ns = XUI

--version info
ns.xuidbv = C_AddOns.GetAddOnMetadata(AddonName, "Version")

--defaults
local defaults = {
    buttonWidthPadding = 20,
    buttonHeightPadding = 10,
    classColorHealth = false,
    customPlayerFont = false,
    chatButtons = true,
    chatHistory = true,
    savedChatHistory = {}
}

-- mergeDefaults into the db
local function mergeDefaults(target, source)
    for key, val in pairs(source) do
        if type(val) == "table" then
            if type(target[key]) ~= "table" then
                target[key] = {}
            end
            mergeDefaults(target[key], val)
        else
            if target[key] == nil then
                target[key] = val
            end
        end
    end
    return target
end

--init db
local function initializeDB()

    _G.xuidb = _G.xuidb or {}
    
    _G.xuidb = mergeDefaults(_G.xuidb, defaults)
    
    ns.xuidb = _G.xuidb
end

--handle that hoe
local loadFrame = CreateFrame("FRAME")
loadFrame:RegisterEvent("ADDON_LOADED")

loadFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == AddonName then
        initializeDB()
        --unregistering since only using one time
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

initializeDB()