local addonName = ...
local ns = XUI
ns.controls = ns.controls or {}
ns.tabs = ns.tabs or {}

local xgui

-- Font settings
local alpha = GetLocale()
local alphaSwitch = {
    zhCN = function() return "fonts\\ARHei.ttf" end,
    zhTW = function() return "fonts\\ARHei.ttf" end,
    enUS = function()
        print("Locale is English (US). Using LexieReadable font.")
        return "fonts\\LexieReadable-Regular.ttf"
    end,
    default = function() return "fonts\\ARHei.ttf" end
}

local fontPath = (alphaSwitch[alpha] or alphaSwitch["default"])()
print("Font path set to: " .. fontPath)

-- Create font cache
local fontCache = {}

-- New font function
local function newFont(xOff, yOff, createFrame, anchorA, anchorFrame, anchorB, text, fontsize)
    local cacheKey = fontPath .. fontsize
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

-- Create controls for a specific category
local function createControls(categoryKey)
    if not ns.optionsData or not ns.optionsData.categories then
        print("Error: Options data not available")
        return
    end

    local category = ns.optionsData.categories[categoryKey]
    if not category then
        print("Error: Category not found:", categoryKey)
        return
    end

    -- Hide existing controls
    for _, control in pairs(ns.controls) do
        control:Hide()
    end
    wipe(ns.controls)  -- Clear existing controls

    -- Create new controls
    local yOffset = -60
    for _, option in pairs(category.options) do
        local control
        if option.type == "checkbox" then
            control = ns.newCheckbox(option.column, option.text, option.tip, option.db)
        elseif option.type == "slider" then
            control = ns.newSlider(option.column, option.text, option.tip, option.db,
                option.min, option.max, option.step)
        elseif option.type == "dropdown" then
            control = ns.newDropdown(option.column, option.text, option.tip, option.db, option.options)
        elseif option.type == "textbox" then
            control = ns.newTextbox(option.column, option.text, option.tip, option.db)
        end

        if control then
            control:SetPoint("TOPLEFT", xgui, "TOPLEFT", (option.column - 1) * 220, yOffset)
            table.insert(ns.controls, control)
            yOffset = yOffset - 30
        end
    end
end

-- Create the tab frame
local function createTabFrame()
    local tabFrame = CreateFrame("Frame", "xuiTabFrame", xgui)
    tabFrame:SetSize(800, 30)
    tabFrame:SetPoint("TOPLEFT", xgui, "TOPLEFT", 0, -30)

    ns.tabs = {}
    return tabFrame
end

-- Select a tab and show its options
local function selectTab(categoryKey)
    for _, control in pairs(ns.controls) do
        control:Hide()
    end

    createControls(categoryKey)

    for key, tab in pairs(ns.tabs) do
        if key == categoryKey then
            tab:LockHighlight()
        else
            tab:UnlockHighlight()
        end
    end
end

local function getSortedCategories()
    local categories = {}
    for key, category in pairs(ns.optionsData.categories) do 
        table.insert(categories, {
            key = key, 
            data = category 
        })
    end

    table.sort(categories, function(a, b)
        return (a.data.order or 999) < (b.data.order or 999)
    end)

    return categories
end

local function styleButtonText(button, size) 
    local buttonText = button:GetFontString()
    if buttonText then 
        buttonText:SetFont(fontPath, size or 12, "OUTLINE")
        --buttonText:SetShadowColor(0, 0, 0, 0)
        --buttonText:SetShadowOffset(1, -1)
    end
end

-- Create tabs for each category
local function createTabs()
    print("ns.optionsData exists:", ns.optionsData ~= nil)
    print("ns.optionsData.categories exists:", ns.optionsData.categories ~= nil)

    if not ns.optionsData or not ns.optionsData.categories then
        print("Error: ns.optionsData.categories is nil. Cannot create tabs.")
        return
    end

    local tabFrame = createTabFrame()
    local numTabs = 0

    --fetch sorted categories
    local sortedCategories = getSortedCategories()

    for _, categoryInfo in ipairs(sortedCategories) do 
        
        local categoryKey = categoryInfo.key 
        local category = categoryInfo.data 
        numTabs = numTabs + 1

        local tab = CreateFrame("Button", "xuiTab" .. categoryKey, tabFrame, "UIPanelButtonTemplate")
        tab:SetText(category.name)
        tab:SetSize(100, 30)
        tab:SetPoint("LEFT", tabFrame, "LEFT", (numTabs - 1) * 110, 0)

        ns.StyleButton(tab, "NORMAL")

        tab:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
        
        ns.tabs[categoryKey] = tab

        tab:SetScript("OnClick", function()
            selectTab(categoryKey)
        end)
    end

    if numTabs > 0 then 
        selectTab(sortedCategories[1].key)
    end
end

-- Initialize the UI
ns.xuie("ADDON_LOADED", function(addonName)
    if addonName ~= "xui" then return end
    
    print("ADDON_LOADED fired for XUI")
    print("Options data exists:", ns.optionsData ~= nil)
    
    if not ns.optionsData then
        print("Error: Options data not loaded")
        return
    end

    xgui = CreateFrame("Frame")
    _G.xgui = xgui

    local cat = Settings.RegisterCanvasLayoutCategory(xgui, "XUI")
    Settings.RegisterAddOnCategory(cat)

    --header + subheader
    local header = ns.CreateFontString(xgui, "HEADER")
    header:SetPoint("TOPLEFT", xgui, "TOPLEFT", 0, 0)
    header:SetText("XUI")

    local header = ns.CreateFontString(xgui, "SUBHEADER")
    header:SetPoint("BOTTOMLEFT", xgui, "BOTTOMRIGHT", 5, 0)
    header:SetText(" - a lightweight user interface.")


    -- Create tabs only after ensuring options data is loaded
    print("Creating tabs...")
    createTabs()

    -- Create buttons
    local reset = CreateFrame("Button", "xuiSaveButton", xgui, "UIPanelButtonTemplate")
    reset:SetText(GetLocText("Reset to Default"))
    local buttonWidth, buttonHeight = ns.getButtonSize(reset)
    reset:SetSize(buttonWidth, buttonHeight)
    reset:SetPoint("TOPRIGHT", 0, 0)
    reset:SetScript("OnClick", function()
        xuidb = xduidbd
        ReloadUI()
    end)

    local reload = CreateFrame("Button", "xuiSave", xgui, "UIPanelButtonTemplate")
    reload:SetText(GetLocText("Save"))
    local buttonWidth, buttonHeight = ns.getButtonSize(reload)
    reload:SetSize(buttonWidth, buttonHeight)
    reload:SetPoint("BOTTOMRIGHT")
    reload:SetScript("OnClick", function() ReloadUI() end)

    -- Create version text
    local adverts = ns.CreateFontString(xgui, "NORMAL")
    adverts:SetPoint("BOTTOMLEFT", 30, -30)
    adverts:SetText("X: Steiige         Version: |cff00FFFF" .. ns.xuidbv)

    -- Register slash command
    SLASH_xuicmd1 = "/xui"
    SlashCmdList["xuicmd"] = function()
        Settings.OpenToCategory(cat:GetID())
    end

    --stylize the buttons
    ns.StyleButton(reset, "NORMAL")
    ns.StyleButton(reload, "NORMAL")

    print("XUI Menu initialized")
end)

ns.xuie("ADDON_LOADED", function()
    print("Options frame exists: ", xgui ~= nil)
    print("Options data exists: ", ns.optionsData ~= nil)

    ns.debugEvents()
end)
