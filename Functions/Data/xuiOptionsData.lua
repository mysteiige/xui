local ns = XUI 

ns.optionsData = {
    categories = {
        playerFrame = {
            name = "Player Frame",
            options = {
                classColorHealth = {
                    type = "checkbox", 
                    column = 1,
                    text = "Class Color Health",
                    tip = "Colors your health bar based on your Blizzard class color",
                    db = "classColorHealth",
                    order = 1
                }
            },
            order = 1
        },
        otherFrame = {
            name = "Other Frames",
            options = {
                chatButtons = {
                    type = "checkbox",
                    column = 1, 
                    text = "Chat Buttons",
                    tip = "Shows quick access buttons for the chatbox in the bottom left",
                    db = "chatButtons",
                    order = 1
                },
                chatHistory = {
                    type = "checkbox",
                    column = 1, 
                    text = "Save Chat History",
                    tip = "Preserves your chat history between game sessions",
                    db = "chatHistory",
                    order = 2
                }
            },
            order = 2
        },
        actionBar = {
            name = "Action Bars",
            options = {

            },
            order = 3
        },
        nameplates = {
            name = "Nameplates",
            options = {
                
            },
            order = 4
        },
        example3 = {
            name = "Soon",
            options = {
                
            },
            order = 5
        },
        other = {
            name = "Other",
            options = {
                perfEnable = {
                    type = "checkbox",
                    column = 1,
                    text = "Performance Monitors",
                    tip = "Enable performance monitor displays",
                    db = "perfEnable",
                    order = 1
                },
                perfFPS = {
                    type = "checkbox",
                    column = 1,
                    text = "Show FPS",
                    tip = "Display the frames per second counter",
                    db = "perfFPS",
                    order = 2,
                    depends = "perfEnable"
                },
                perfLatency = {
                    type = "checkbox",
                    column = 1,
                    text = "Show Latency",
                    tip = "Display network latency",
                    db = "perfLatency",
                    order = 3,
                    depends = "perfEnable"
                },
                perfMemory = {
                    type = "checkbox",
                    column = 1,
                    text = "Show Memory Usage",
                    tip = "Display addon memory usage",
                    db = "perfMemory",
                    order = 4,
                    depends = "perfEnable"
                },
                perfStats = {
                    type = "checkbox",
                    column = 1,
                    text = "Show System Stats",
                    tip = "Display detailed system statistics",
                    db = "perfStats",
                    order = 5,
                    depends = "perfEnable"
                }
            },
            order = 6
        }
    }
}