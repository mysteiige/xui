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
                
            },
            order = 6
        }
    }
}