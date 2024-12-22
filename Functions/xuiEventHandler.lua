local ns = XUI
print("ns value at start: ", ns)
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

    print("Registering event", event) 

    if not eventFrame then
        eventFrame = CreateFrame("Frame")
        eventFrame:SetScript("OnEvent", function(_, event, ...)
            print("Event fired: ", event)
            local eventHandlers = handlers[event]
            if eventHandlers then
                print("number of handlers: ",  #eventHandlers)
                for i = 1, #eventHandlers do
                    eventHandlers[i](...)
                end
            else
                print("no handlers found: ", event) 
            end
        end)
    end

    if not handlers[event] then
        print("creating a new handler table for event: ", event) 
        handlers[event] = {}
        eventFrame:RegisterEvent(event)
    end

    handlers[event][#handlers[event] + 1] = handler
    print("total handlers for event: ", #handlers[event])

end

ns.debugEvents = function()
    print("event frame exists: ", eventFrame ~= nil) 
    for event, eventHandlers in pairs(handlers) do
        print("Event: ", event, "Handlers: ", #eventHandlers)
    end
end

return ns