local ns = XUI 

print("XUI Chat History: Module Loading")

local MAX_MESSAGES = 100

--all the channels
local SAVE_CHANNELS = {
    "SYSTEM",
    "SAY",
    "YELL",
    "GUILD",
    "OFFICER",
    "PARTY",
    "RAID",
    "RAID_WARNING",
    "INSTANCE_CHAT",
    "WHISPER",
    "BN_WHISPER"
}

local messageHistory = {} --initialize the message history
local isInitialized = false

local function SaveChatMessage(msg, author, ...)

    print("message:", msg)
    print("author:", author)

    if not xuidb.chatHistory then print("XUI Chat History: Chat history is disabled, not saving") return end

    --initialize channel history
    local chatEvent = select(2, ...)
    messageHistory[chatEvent] = messageHistory[chatEvent] or {}

    local timeStamp = date("%H:%M:%S")
    local entry = {
        time = timeStamp,
        msg = msg,
        author = sender,
        args = {...}
    }

    --add to table
    table.insert(messageHistory[chatEvent], 1, entry)
    print("XUI Chat History: Message saved successfully")

    --exclude if exceeding maximum
    while #messageHistory[chatEvent] > MAX_MESSAGES do
        table.remove(messageHistory[chatEvent])
    end
    
end

local function RestoreChatHistory()
    print("XUI Chat History: Attempting to restore history")

    if not xuidb.chatHistory then print("XUI Chat History: Chat history is disabled, not restoring") return end 

    if not xuidb.savedChatHistory then print("XUI Chat History: No saved history found!") return end 

    print("XUI Chat History: Found saved history, beginning restoration")

    --get chat
    local chatFrame = DEFAULT_CHAT_FRAME
    chatFrame:AddMessage("|cFFFFFF00[Chat History Begin]|r")

    --for each channel
    for event, messages in pairs(messageHistory) do 
        print("XUI Chat History: Restoring channel:", event)
        print("XUI Chat History: Number of messages:", #messages)
        for i = #messages, 1, -1 do 
            local entry = messages[i]
            local timeString = "|cFF888888[" .. entry.time .. "]|r "

            --reconstruction with proper formatting
            local messageString = timeString
            if entry.author then 
                messageString = messageString .. "<" .. entry.author .. "> " 
            end
            chatFrame:AddMessage(messageString)
        end
    end

    chatFrame:AddMessage("|cFFFFFF00[Chat History End]|r")
    print("XUI Chat History: Restoration complete")
end

--register events
local function Initialize()

    print("XUI Chat History: Initializing")

    if isInitialized then print("XUI Chat History: Already initialized, skipping") return end

    ns.xuie("CHAT_MSG_CHANNEL", function(...) SaveChatMessage() end)

    --all chat messages
    for _, channel in ipairs(SAVE_CHANNELS) do 
        local event = "CHAT_MSG_" .. channel
        print("XUI Chat History: Registering event:", event)
        ns.xuie(event, SaveChatMessage)
    end

    if xuidb.chatHistory then 
        print("XUI Chat History: Chat history is enabled")
        if xuidb.savedChatHistory then 
            print("XUI Chat History: Found saved history")
            messageHistory = xuidb.savedChatHistory
            C_Timer.After(1, RestoreChatHistory)
        else 
            print("XUI Chat History: No saved history found")
        end
    else
        print("XUI Chat History: Chat history is disabled")
    end
    isInitialized = true
    print("XUI Chat History: Initialization complete")
end

--save when logging out
local function OnPlayerLogout()
    print("XUI Chat History: Player logging out")
    if xuidb.chatHistory then 
        print("XUI Chat History: Saving history to database")
        xuidb.savedChatHistory = messageHistory
        print("XUI Chat History: History saved")
    else
        print("XUI Chat History: Chat history disabled, not saving")
    end
end

--load when logging in 
local function UpdateChatHistory() 
    print("XUI Chat History: Settings updated")
    if not xuidb.chatHistory then 
        print("XUI Chat History: Chat history disabled, clearing history")
        messageHistory = {}
        xuidb.savedChatHistory = nil
    end
end

ns.xuie("ADDON_LOADED", function(addon) 
    if addon ~= "xui" then return end
    print("XUI Chat History: XUI addon loaded, starting initialization")
    Initialize()
end)

ns.xuie("PLAYER_LOGOUT", OnPlayerLogout)

--register with settings
ns.RegisterApplySettings("chatHistory", UpdateChatHistory)

print("XUI Chat History: Module Loaded")