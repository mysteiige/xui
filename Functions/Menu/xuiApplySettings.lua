local ns = XUI 

local ApplySettings = {}

local function RegisterApplySettings(moduleName, func)
    ApplySettings[moduleName] = func
end

ns.RegisterApplySettings = RegisterApplySettings
ns.ApplySettings = ApplySettings
