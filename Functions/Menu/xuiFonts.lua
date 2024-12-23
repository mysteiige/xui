local ns = XUI

ns.FONTS = {
    PATH = (function()
        local locale = GetLocale()
        if locale == "zhCN" or locale == "zhTW" then
            return "fonts\\ARHei.ttf"
        elseif locale == "enUS" then
            return "fonts\\LexieReadable-Regular.ttf"
        end
        return "fonts\\ARHei.ttf"
    end)(),
    
    STYLES = {
        NORMAL = {
            size = 12,
            flags = "OUTLINE",
            color = {1, 0.82, 0, 1},
            shadow = {
                color = {0, 0, 0, 1},
                offset = {1, -1}
            }
        },
        HEADER = {
            size = 30,
            flags = "OUTLINE",
            color = {1, 0.82, 0, 1},
            shadow = {
                color = {0, 0, 0, 1},
                offset = {1, -1}
            }
        },
        SUBHEADER = {
            size = 15,
            flags = "OUTLINE",
            color = {1, 0.82, 0, 1},
            shadow = {
                color = {0, 0, 0, 1},
                offset = {1, -1}
            }
        }
    }
}

function ns.ApplyFontStyle(fontString, style)
    if not fontString or not style then return end
    
    local styleData = ns.FONTS.STYLES[style] or ns.FONTS.STYLES.NORMAL
    fontString:SetFont(ns.FONTS.PATH, styleData.size, styleData.flags)
    
    if styleData.color then
        fontString:SetTextColor(unpack(styleData.color))
    end
    
    if styleData.shadow then
        fontString:SetShadowColor(unpack(styleData.shadow.color))
        fontString:SetShadowOffset(unpack(styleData.shadow.offset))
    end
end

function ns.CreateFontString(parent, style, layer)
    local fontString = parent:CreateFontString(nil, layer or "OVERLAY")
    ns.ApplyFontStyle(fontString, style or "NORMAL")
    return fontString
end

function ns.StyleButton(button, style)
    local fontString = button:GetFontString()
    if fontString then
        ns.ApplyFontStyle(fontString, style)
    end
end