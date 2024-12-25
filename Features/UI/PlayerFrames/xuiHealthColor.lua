local ns = XUI

local function UpdatePlayerFrameHealth() 
    if not PlayerFrame then return end

    local healthBar = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarsContainer.HealthBar

    if not healthBar then 
        print("XUI: health bar not found!")
        return
    end

    if xuidb.classColorHealth then 
        local _, className = UnitClass("player")
        print("xuiPlayerFrame: getting unitclass")

        if className then 
            local classColor = RAID_CLASS_COLORS[className]
            if classColor then 
                print("xuiPlayerFrame: starting coloring")
                healthBar:SetStatusBarDesaturated(true)
                healthBar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
                --healthBar.Fill:SetVertexColor(classcolor.r, classColor.g, classColor.b)
                healthBar:SetValue(UnitHealth("player"))
                print("xuiPlayerFrame: success coloring!")
            end
        end
    else
        healthBar:SetStatusBarDesaturated(false)
        healthBar:SetStatusBarColor(0, 1, 0)
        --healthBar.Fill:SetVertexColor(0, 1, 0)
        healthBar:SetValue(UnitHealth("player"))
        print("xuiPlayerFrame: something failed! back to default values.")
    end
end

ns.RegisterApplySettings("PlayerFrame", UpdatePlayerFrameHealth)

ns.xuie("ADDON_LOADED", function(addon) 

    if addon ~= "xui" then return end

    ns.xuie("PLAYER_ENTERING_WORLD", function() 
    
        UpdatePlayerFrameHealth()
    
    end)
    --[[
    ns.xuie("UNIT_HEALTH", function(unit) 
        if unit == "player" then 
            UpdatePlayerFrameHealth()
        end    
    end)
    ]]
end)

ns.UpdatePlayerFrameHealth = UpdatePlayerFrameHealth()