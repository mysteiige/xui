--rounding logic
local ns = XUI 
local eventFrame

--format helper function
local function formatNumber(wknumber, thresholds)
    for _, threshold in ipairs(thresholds) do
        if wknumber >= threshold.min then
            return string.format(threshold.format, wknumber / threshold.min) .. threshold.unit
        end
    end
    return "" 
end

function ns.xuiRound(numbers) 
    local unitSystem = xuidb and xuidb.hpUnits or 1  --default to imperial
    local wknumber = (type(numbers) == "number") and numbers or 0 
    local w = (unitSystem == 2) and "万" or "w"  --chinese formatting (ten thousands)

    --thresholds
    local formatSwitch = {
        [1] = {  -- American system (K, M, B)
            {min = 1e9, format = "%.2f", unit = "B"},
            {min = 1e8, format = "%d", unit = "M"},
            {min = 1e7, format = "%.1f", unit = "M"},
            {min = 1e6, format = "%.2f", unit = "M"},
            {min = 1e5, format = "%d", unit = "K"},
            {min = 1e4, format = "%.1f", unit = "K"},
            {min = 1e3, format = "%.2f", unit = "K"},
        },
        
        [2] = {  --chinese system
            {min = 1e9, format = "%.1f", unit = "亿"},
            {min = 1e8, format = "%.2f", unit = "亿"},
            {min = 1e6, format = "%d", unit = w},
            {min = 1e5, format = "%.1f", unit = w},
            {min = 1e4, format = "%.2f", unit = w},
        },
        
        [3] = {  --another chinese system (how many do you need)
            {min = 1e9, format = "%.1f", unit = "亿"},
            {min = 1e8, format = "%.2f", unit = "亿"},
            {min = 1e6, format = "%d", unit = w},
            {min = 1e5, format = "%.1f", unit = w},
            {min = 1e4, format = "%.2f", unit = w},
        },
        
        default = {  --fallback
            {min = 0, format = "", unit = ""},
        }
    }

    --actually use the correct thresholds
    local thresholds = formatSwitch[unitSystem] or formatSwitch["default"]
    return formatNumber(wknumber, thresholds)
end