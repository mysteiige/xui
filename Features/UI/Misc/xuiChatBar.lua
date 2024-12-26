local ns = XUI 

local channels = {
    {name = "Say",      text = "S",    command = "/s ",     color = {1, 1, 1}},         --white
    {name = "Yell",     text = "Y",    command = "/y ",     color = {1, 0.25, 0.25}},   --red
    {name = "Party",    text = "P",    command = "/p ",     color = {0.1, 0.6, 1}},     --blue
    {name = "Guild",    text = "G",    command = "/g ",     color = {0.1, 1, 0.1}},     --green
    {name = "Raid",     text = "R",    command = "/raid ",  color = {1, 0.1, 0.1}},     --red
    {name = "Instance", text = "I",    command = "/i ",     color = {1, 0.8, 0}}        --orange
}

local function CreateChannelButtons()
    --genesis 1
    local buttonContainer = CreateFrame("Frame", "xuiChatBar", UIParent)
    buttonContainer:SetPoint("BOTTOMLEFT", 0, 0)
    buttonContainer:SetHeight(50) --make it show
    buttonContainer:Show()

    local function CreateChannelButton(index, channel)
        --genesis 1.1
        local button = CreateFrame("Button", "xuicChannel" .. channel.name, buttonContainer)
        button:SetWidth(25)
        button:SetHeight(25)
        button:RegisterForClicks("AnyUp")
        button:SetScript("OnClick", function() ChatFrame_OpenChat(channel.command, SELECTED_CHAT_FRAME) end)

        --text
        local buttonText = button:CreateFontString(nil, "OVERLAY")
        ns.ApplyFontStyle(buttonText, "CHATBAR")
        buttonText:SetJustifyH("CENTER")
        buttonText:SetWidth(25)
        buttonText:SetHeight(25)
        buttonText:SetText(channel.text)
        buttonText:SetPoint("CENTER", button, "CENTER")

        --colors
        local r, g, b = channel.color[1], channel.color[2], channel.color[3]
        buttonText:SetTextColor(r, g, b)

        return button 
    end

    --fetches character stats and puts them in chat for you to copy or submit
    local function CreateStatButton()
        local stats = CreateFrame("Button", "xuiStatsButton", buttonContainer)
        stats:SetWidth(25)
        stats:SetHeight(25)
        stats:RegisterForClicks("AnyUp")

        stats:SetScript("OnClick", function() 
        
            local S_C = UnitStat("player",1)  --strength
            local AG_C = UnitStat("player",2)  --agility
            local IN_C = UnitStat("player",4)  --intellect
            local S

            if S_C > AG_C and S_C > IN_C then
                S = "STR:" .. S_C
            elseif AG_C > S_C and AG_C > IN_C then
                S = "AGI:" .. AG_C
            elseif IN_C > S_C and IN_C > AG_C then
                S = "INT:" .. IN_C
            end

            local stat = {
                "iLvl:" .. format("%.1F", select(2, GetAverageItemLevel())) .. "/" .. format("%.1F", select(1, GetAverageItemLevel())),
                "Class:" .. UnitClass("player"),
                "Spec:" .. select(2, GetSpecializationInfo(GetSpecialization())),
                S,
                "Crit:" .. format("%.2F%%", GetSpellCritChance(2)),
                "Haste:" .. format("%.2F%%", GetHaste()),
                "Mastery:" .. format("%.2F%%", select(1, GetMasteryEffect())),
                "Vers:" .. format("%.2F%%", GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE))
            }

            local line = "/s " .. table.concat(stat, " ")
            ChatFrame_OpenChat(line, SELECTED_CHAT_FRAME)
        
        end)

        local statText = stats:CreateFontString(nil, "OVERLAY")
        ns.ApplyFontStyle(statText, "CHATBAR")
        statText:SetJustifyH("CENTER")
        statText:SetWidth(25)
        statText:SetHeight(25)
        statText:SetText("ST")
        statText:SetPoint("CENTER", stats, "CENTER")
        statText:SetTextColor(1, 1, 0)

        return stats
    end

    --roll button
    local function CreateRollButton()
        local roll = CreateFrame("Button", "xuiRoll", buttonContainer) --create attributes
        roll:SetWidth(25)
        roll:SetHeight(25)
        roll:RegisterForClicks("AnyUp")
        roll:SetScript("OnClick", function() RandomRoll(1, 100) end)

        local rollTexture = roll:CreateTexture(nil, "ARTWORK")
        rollTexture:SetWidth(25)
        rollTexture:SetHeight(25)
        rollTexture:SetTexture("Interface\\Buttons\\UI-GroupLoot-Dice-Up")
        rollTexture:SetPoint("CENTER", roll, "CENTER")

        return roll
    end

    local buttonSpacing = 5
    local xOffset = 0

    for i, channel in ipairs(channels) do 
        local channelButton = CreateChannelButton(i, channel)
        channelButton:SetPoint("BOTTOMLEFT", buttonContainer, "BOTTOMLEFT", xOffset, 0)
        xOffset = xOffset + (channelButton:GetWidth() + buttonSpacing)
    end

    --add stats to the end
    local statButton = CreateStatButton()
    statButton:SetPoint("BOTTOMLEFT", buttonContainer, "BOTTOMLEFT", xOffset, 0)
    xOffset = xOffset + (statButton:GetWidth() + buttonSpacing)

    --add roll to the end
    local rollButton = CreateRollButton()
    rollButton:SetPoint("BOTTOMLEFT", buttonContainer, "BOTTOMLEFT", xOffset, 0)
    xOffset = xOffset + (rollButton:GetWidth() + buttonSpacing)

    buttonContainer:SetWidth(xOffset)

    return buttonContainer

end

ns.xuie("ADDON_LOADED", function(addon)

    if addon ~= "xui" then return end
    CreateChannelButtons()

end)
