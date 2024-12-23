local ns = XUI

--expose globally

local function styleText(fontString) 
    if not fontString then return end
    ns.ApplyFontStyle(fontString, "NORMAL")
    fontString:SetTextColor(1, 0.82, 0, 1)
end
ns.styleText = styleText