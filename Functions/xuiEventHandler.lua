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

    print("eventFrame created:", eventFrame ~= nil)

    if not eventFrame then
        print("CREATING EVENT FRAME")
        eventFrame = CreateFrame("Frame")
        print("CREATED EVENT FRAME")
        eventFrame:SetScript("OnEvent", function(_, event, ...)
            print("Event fired: ", event)
            if event == "ADDON_LOADED" then
                print("ADDON_LOADED EVENT FIRED")
            end
            local eventHandlers = handlers[event]
            if eventHandlers then
                print("number of handlers: ",  #eventHandlers)
                for i = 1, #eventHandlers do
                    print("executing handler ", i, " for event ", event)
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
        print("Registering event:", event)
        eventFrame:RegisterEvent(event)
    end

    handlers[event][#handlers[event] + 1] = handler
    print("Handler added for event:", event, "Total handlers:", #handlers[event])

end

ns.debugEvents = function()
    print("event frame exists: ", eventFrame ~= nil) 
    print("handlers table exists: ", handlers ~= nil)
    for event, eventHandlers in pairs(handlers) do
        print("Event: ", event, "Handlers: ", #eventHandlers)
    end
end

return ns