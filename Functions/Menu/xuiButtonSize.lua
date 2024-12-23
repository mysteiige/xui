local ns = XUI
function ns.getButtonSize(text)
    local textWidth = text:GetTextWidth()
    local textHeight = text:GetTextHeight()

    local paddingWidth = ns.xuidb.buttonWidthPadding or 20
    local paddingHeight = ns.xuidb.buttonHeightPadding or 10
    
    local buttonWidth = math.min(textWidth + paddingWidth)
    local buttonHeight = textHeight + paddingHeight

    return buttonWidth, buttonHeight
end