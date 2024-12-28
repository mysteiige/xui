local ns = XUI
local eventFrame
local handlers = {}

--if user has any of these other addons installed, the ui will bug and throw this error message.
local function otherUI()
    if C_AddOns.IsAddOnLoaded("ElvUI") then
        print("ElvUI is installed. This addon will not work with this UI package installed. Please uninstall ElvUI and try again.")
        return
    end
    if C_AddOns.IsAddOnLoaded("NDui") then
        print("NDui is installed. This addon will not work with this UI package installed. Please uninstall NDui and try again.")
        return
    end
end

ns.xuifuncs = function() end


function ns.xuie(event, handler)

    if not eventFrame then
        eventFrame = CreateFrame("Frame")
        eventFrame:SetScript("OnEvent", function(_, event, ...)
            local eventHandlers = handlers[event]
            if eventHandlers then
                for i = 1, #eventHandlers do
                    eventHandlers[i](...)
                end
            else
                print("no handlers found: ", event) 
            end
        end)
    end

    if not handlers[event] then
        handlers[event] = {}
        eventFrame:RegisterEvent(event)
    end

    handlers[event][#handlers[event] + 1] = handler

end

ns.debugEvents = function()
    --print("event frame exists: ", eventFrame ~= nil) 
    --print("handlers table exists: ", handlers ~= nil)
    for event, eventHandlers in pairs(handlers) do
        --print("Event: ", event, "Handlers: ", #eventHandlers)
    end
end

return ns