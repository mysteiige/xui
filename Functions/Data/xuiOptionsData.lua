local ns = XUI 

ns.optionsData = {
    categories = {
        general = {
            name = "General",
            options = {
                enableFeature = {
                    type = "checkbox",
                    column = 1,
                    text = "Enable Feature",
                    tip = "This enables or disables the feature.",
                    db = "enableFeature",
                    order = 1
                },
                fontSize = {
                    type = "slider",
                    column = 1,
                    text = "Font Size",
                    tip = "Adjusts the size of the addon's font.",
                    db = "fontSize",
                    min = 8,
                    max = 24,
                    step = 1,
                    order = 2
                },
                hpUnit = {
                    type = "dropdown",
                    column = 1,
                    text = "HP Unit Style",
                    tip = "Choose how health values are displayed",
                    db = "hpUnit",
                    options = {
                        [1] = "Imperial (K/M/B)",
                        [2] = "Chinese (万/亿)",
                        [3] = "Alternate Chinese"
                    },
                    order = 3
                }
            },
            order = 1
        },
        nameplates = {
            name = "Soon",
            options = {
                
            },
            order = 2
        },
        example1 = {
            name = "Soon",
            options = {

            },
            order = 3
        },
        example2 = {
            name = "Soon",
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
        example4 = {
            name = "Soon",
            options = {

            },
            order = 6
        }
    }
}

print("xuiOptionsData.lua loaded successfully") --debug
print("options data structure: ", ns.optionsData)