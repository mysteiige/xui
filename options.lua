local addonName = ...
local ns = XUI
ns.controls = ns.controls or {}
ns.tabs = ns.tabs or {}

local xgui

local LAYOUT = {
    COLUMN_WIDTH = 220,
    INITIAL_Y_OFFSET = -60, --below tabs
    ITEM_HEIGHT = 30,
    LEFT_MARGIN = 0,
    COLUMN_PADDING = 20,
    SLIDER_EXTRA_HEIGHT = 25,
    DROPDOWN_HEIGHT = 40, --height for dropdowns, remove later (maybe)
    TAB_WIDTH = 100,
    TAB_SPACING = 110
}

-- Font settings
local alpha = GetLocale()
local alphaSwitch = {
    zhCN = function() return "fonts\\ARHei.ttf" end,
    zhTW = function() return "fonts\\ARHei.ttf" end,
    enUS = function()
        return "fonts\\LexieReadable-Regular.ttf"
    end,
    default = function() return "fonts\\ARHei.ttf" end
}

local fontPath = (alphaSwitch[alpha] or alphaSwitch["default"])()
ns.fontPath = fontPath --expose globally to use elsewhere

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

--creating controls for a category, hiding all the others
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

    --hide them
    for _, control in pairs(ns.controls) do
        control:Hide()
    end
    wipe(ns.controls)  --wipe me down - boosie badazz

    --sort options by columns and order
    local columnedOptions = {}
    for optionKey, option in pairs(category.options) do 
        local column = option.column or 1 --default to column 1 if no column specified
        columnedOptions[column] = columnedOptions[column] or {}
        table.insert(columnedOptions[column], {
            key = optionKey,
            data = option,
            order = option.order or 999 --if no order specified, SEND HER TO THE BACK
        })
    end

    --sorting within the column
    for _, column in pairs(columnedOptions) do 
        table.sort(column, function(a, b) return a.order < b.order end)
    end

    for column, options in pairs(columnedOptions) do 
        local xOffset = (column - 1) * LAYOUT.TAB_WIDTH + ((column - 1) * LAYOUT.COLUMN_PADDING)
        local yOffset = LAYOUT.INITIAL_Y_OFFSET

        for _, optionData in ipairs(options) do 
            local option = optionData.data 
            local control 

            if option.type == "checkbox" then 
                control = ns.newCheckbox(option.column, option.text, option.tip, option.db)
            elseif option.type == "slider" then 
                control = ns.newSlider(option.column, option.text, option.tip, option.db, option.min, option.max, option.step)
            elseif option.type == "dropdown" then 
                control = ns.newDropdown(option.column, option.text, option.tip, option.db, option.options)
            elseif option.type == "textbox" then 
                control = ns.newTextbox(option.column, option.text, option.tip, option.db)
            end

            if control then 
                
                control:ClearAllPoints()
                control:SetPoint("TOPLEFT", xgui, "TOPLEFT", xOffset, yOffset)

                table.insert(ns.controls, control)

                if option.type == "slider" then 
                    yOffset = yOffset - (LAYOUT.ITEM_HEIGHT + LAYOUT.SLIDER_EXTRA_HEIGHT) --more space needed because of the text
                elseif option.type == "dropdown" then 
                    yOffset = yOffset - LAYOUT.DROPDOWN_HEIGHT 
                else
                    yOffset = yOffset - LAYOUT.ITEM_HEIGHT
                end

                yOffset = yOffset - 5
                
            end
        end
    end
end

local function createTabFrame()
    local tabFrame = CreateFrame("Frame", "xuiTabFrame", xgui)
    tabFrame:SetSize(800, 30)
    tabFrame:SetPoint("TOPLEFT", xgui, "TOPLEFT", 0, -30) --anchor

    ns.tabs = {}
    return tabFrame
end

--select the tab and hide the other shit
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

--create the tab buttons if it meets certain checks
local function createTabs()

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
    
    if not ns.optionsData then
        print("Error: Options data not loaded")
        return
    end

    xgui = CreateFrame("Frame")
    xgui:EnableMouse(true)
    xgui:SetSize(800, 600)
    _G.xgui = xgui
    ns.xgui = xgui

    local cat = Settings.RegisterCanvasLayoutCategory(xgui, "XUI")
    Settings.RegisterAddOnCategory(cat)

    --header + subheader
    local header = ns.CreateFontString(xgui, "HEADER")
    header:SetPoint("TOPLEFT", xgui, "TOPLEFT", 0, 0)
    header:SetText("XUI")

    local header = ns.CreateFontString(xgui, "SUBHEADER")
    header:SetPoint("TOPLEFT", xgui, "TOPLEFT", 60, -10)
    header:SetText(" - a lightweight user interface.")


    -- Create tabs only after ensuring options data is loaded
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

    local save = CreateFrame("Button", "xuiSave", xgui, "UIPanelButtonTemplate")
    save:SetText(GetLocText("Apply"))
    local buttonWidth, buttonHeight = ns.getButtonSize(save)
    save:SetSize(buttonWidth, buttonHeight)
    save:SetPoint("BOTTOMRIGHT")
    save:SetScript("OnClick", function() ReloadUI() end)

    --[[
    local apply = CreateFrame("Button", "xuiApply", xgui, "UIPanelButtonTemplate")
    apply:SetText(GetLocText("Apply"))
    local buttonWidth2, buttonHeight2 = ns.getButtonSize(apply)
    apply:SetSize(buttonWidth, buttonHeight)
    apply:SetPoint("BOTTOMRIGHT", save, "BOTTOMLEFT", 0, 0)
    apply:SetScript("OnClick", function() 
        if ns.ApplySettings then 
            for _, func in pairs(ns.ApplySettings) do 
                func()
            end
        end
    end)
    ]]

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
    ns.StyleButton(save, "NORMAL")
    ns.StyleButton(apply, "NORMAL")

end)

ns.xuie("ADDON_LOADED", function()
    ns.debugEvents()
end)
