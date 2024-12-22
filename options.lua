print("ns value at start:", ns)
local addonName = ... 
local ns = ns or {}

--create frame
xgui = CreateFrame("Frame")
cat = Settings.RegisterCanvasLayoutCategory(xgui, "XUI")
Settings.RegisterAddOnCategory(cat)

SLASH_xuicmd1 = "/xui"
--slash opens menu
SlashCmdList["xuicmd"] = function()
    Settings.OpenToCategory(cat:GetID())
end

-- Font settings depending on the locale
local alpha = GetLocale()
local alphaSwitch = {
    zhCN = function()
        return "fonts\\ARHei.ttf"
    end,
    zhTW = function()
        return "fonts\\ARHei.ttf"
    end,
    enUS = function()
        print("Locale is English (US). Using LexieReadable font.")
        return "fonts\\LexieReadable-Regular.ttf"
    end,
    default = function()
        return "fonts\\ARHei.ttf"
    end
}

local fontPath = (alphaSwitch[alpha] or alphaSwitch["default"])()
print("Font path set to: " .. fontPath)

--create font cache
local fontCache = {}
--new font function
local function newFont(xOff, yOff, createFrame, anchorA, anchorFrame, anchorB, text, fontsize)
    --create the key
    local cacheKey = fontPath .. fontsize
    --reuse font if it exists
    local font = fontCache[cacheKey]
    if not font then 
        font = createFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        font:SetFont(fontPath, fontsize, "OUTLINE")
        fontCache[cacheKey] = font
    end

    font:SetPoint(anchorA, anchorFrame, anchorB, xOff, yOff)
    font:SetText(text)

    return font
end

ns.xuie("PLAYER_LOGIN", function() --reset button

    print("PLAYER_LOGIN FUNCTION WORKING CORRECTLY")

    local reset = CreateFrame("Button", "xuiSaveButton", xgui, "UIPanelButtonTemplate")
    reset:SetText(GetLocText("Reset to Default"))
    --dynamic button width depending on the language
    local buttonWidth, buttonHeight = ns.getButtonSize(reset)
    reset:SetSize(buttonWidth, buttonHeight)
    reset:SetPoint("TOPRIGHT", 0, 0)
    reset:SetScript("OnClick", function()
        xuidb = xduidbd
        ReloadUI()
    end)

end)

ns.xuie("PLAYER_LOGIN", function () --reload button

    local reload = CreateFrame("Button", "xuiReload", xgui, "UIPanelButtonTemplate")
    reload:SetText(GetLocText("Reload"))
    local buttonWidth, buttonHeight = ns.getButtonSize(reload)
    reload:SetSize(buttonWidth, buttonHeight)
    reload:SetPoint("BOTTOMRIGHT")
    reload:SetScript("OnClick", function() ReloadUI() end)

end)

ns.xuie("PLAYER_LOGIN", function() --adverts lol

    local adverts = xgui:CreateFontString(nil, "ARTWORK", "GameTooltipText")
    adverts:SetFont(fontPath, 14, "OUTLINE")
    adverts:SetPoint("BOTTOMLEFT", 30, -30)
    adverts:SetText("X: Steiige         Version: |cff00FFFF" .. ns.xuidbv)
    adverts:SetJustifyH("LEFT")

end)

ns.xuie("PLAYER_LOGIN", function() --title and description from AddUI

    local xui = newFont(0, 0, xgui, "TOPLEFT", xgui, "TOPLEFT", "XUI", 30)
    local xui2 = newFont(0, 5, xgui, "BOTTOMLEFT", xui, "BOTTOMRIGHT", " - An AddUI fork.", 15)

end)

local function createOptions()
    ns.newCheckbox(1, "Enable Feature", "This enables or disables the feature.", "enableFeature")
end
createOptions()

ns.debugEvents()

-- Add a test message to the settings frame to check
local testLabel = newFont(0, 0, xgui, "CENTER", xgui, "CENTER", "Testing Font in XUI", 14)

-- Simple event handling (ensure it's being triggered)
local function onPlayerLogin(event)
    print("PLAYER_LOGIN event triggered!")  -- Should appear in the chat log
end

-- Register event handler for PLAYER_LOGIN
xgui:RegisterEvent("PLAYER_LOGIN")
xgui:SetScript("OnEvent", onPlayerLogin)

-- Debug to confirm the frame creation
print("Addon Loaded: " .. addonName)