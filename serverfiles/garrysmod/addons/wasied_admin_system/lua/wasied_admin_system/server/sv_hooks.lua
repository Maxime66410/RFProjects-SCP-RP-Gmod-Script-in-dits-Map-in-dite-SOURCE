--[[ Hooks ]]--
hook.Add("PlayerSay", "Wasied:AdminSystem:PlayerSay", function(ply, text)
    if !IsValid(ply) then return end
    if !ply:Alive() then return end

    text = string.lower(text)

    if text == WasiedAdminSystem.Config.AdminModeCommand then
        if WasiedAdminSystem.CheckStaff(ply) then
        
            WasiedAdminSystem.UpdateAdminMod(ply)
            if WasiedAdminSystem.Config.HideCommands then return "" end

        end
    elseif text == WasiedAdminSystem.Config.AdminMenuCommand && WasiedAdminSystem.Config.AdminMenuEnabled then
        if WasiedAdminSystem.CheckStaff(ply) then
            
            net.Start("AdminSystem:AdminMenu:Open")
            net.Send(ply)

            if WasiedAdminSystem.Config.HideCommands then return "" end

        end
    elseif text == WasiedAdminSystem.Config.TicketMenuCommand && WasiedAdminSystem.Config.TicketEnabled then
    
        net.Start("AdminSystem:Tickets:Open")
        net.Send(ply)

        if WasiedAdminSystem.Config.HideCommands then return "" end

    elseif text == WasiedAdminSystem.Config.PlayerManagMenuCommand && WasiedAdminSystem.Config.PlayerManagmentEnabled then
        if WasiedAdminSystem.CheckStaff(ply) then
            
            net.Start("AdminSystem:PlayerManag:Open")
            net.Send(ply)

            if WasiedAdminSystem.Config.HideCommands then return "" end

        end
    elseif text == WasiedAdminSystem.Config.RefundMenuCommand && WasiedAdminSystem.Config.RefundMenuEnabled then
        if WasiedAdminSystem.CheckStaff(ply) then
            
            net.Start("AdminSystem:RefundMenu:Open")
            net.Send(ply)

            if WasiedAdminSystem.Config.HideCommands then return "" end

        end
    end
end)

hook.Add("PlayerNoClip", "Wasied:AdminSystem:Noclip", function(ply)
    
    if !IsValid(ply) then return end
    if !ply:Alive() then return end
    if ply:GetMoveType() == MOVETYPE_NOCLIP then return end
    if !WasiedAdminSystem.Config.AdminOnNoclip then return end
    if !WasiedAdminSystem.Config.AdminSystemEnabled then return end
    if ply:GetNWInt("AdminSystem:AdminMode") > 0 then return end

    WasiedAdminSystem.UpdateAdminMod(ply)
    return false
    
end)

hook.Add("PlayerSpawn", "Wasied:AdminSystem:Spawn", function(ply)
    if !IsValid(ply) then return end

    ply:SetNWInt("AdminSystem:AdminMode", 0) -- set disabled by default

    -- Freeze physgun
    if WasiedAdminSystem.ULXorFAdmin() then
        if ply._ulx_physgun then
            if ply._ulx_physgun.b and ply._ulx_physgun.p then
                timer.Simple(0.001, function()
                    ply:SetPos(ply._ulx_physgun.p)
                    ply:SetMoveType(MOVETYPE_NONE)
                end)
            end
        end
    end
end)

local function isPlayer(ent) 
    return (IsValid(ent) && ent.GetClass && ent:GetClass() == "player")
end
hook.Add("PhysgunPickup", "Wasied:AdminSystem:PhysgunGrab", function(ply, targ)

    if IsValid(ply) and isPlayer(targ) and WasiedAdminSystem.CheckStaff(ply) then

        -- Code Wasied
        if WasiedAdminSystem.Config.AutoCloakPhys then targ:SetNoDraw(true) end
        --

        if ply:query("ulx physgunplayer") then
            local allowed, _ = ULib.getUser( "@", true, ply )
            if isPlayer(allowed) then
                if allowed.frozen && ply:query( "ulx unfreeze" ) then
                    allowed.phrozen = true
                    allowed.frozen = false
                end
                allowed._ulx_physgun = {p=targ:GetPos(), b=true}
            end
        end
    end

end, HOOK_HIGH)
 
local function physgun_freeze( calling_ply, target_ply, should_unfreeze)
    if WasiedAdminSystem.ULXorFAdmin() then

        local v = target_ply
        if v:InVehicle() then
            v:ExitVehicle()
        end
    
        if not should_unfreeze then
            v:Lock()
            v.frozen = true
            v.phrozen = true
            ulx.setExclusive( v, "frozen" )
        else
            v:UnLock()
            v.frozen = nil
            v.phrozen = nil
            ulx.clearExclusive( v )
        end
    
        v:DisallowSpawning( not should_unfreeze )
        ulx.setNoDie( v, not should_unfreeze )
    
        if v.whipped then
            v.whipcount = v.whipamt
        end
    end
end
 
hook.Add("PhysgunDrop", "_ulx_physgunfreeze", function(pl, ent)    

    if isPlayer(ent) then
        ent:SetMoveType( MOVETYPE_WALK )
        ent._ulx_physgun = {p=ent:GetPos(), b=false}
    end

    if IsValid(pl) and WasiedAdminSystem.CheckStaff(pl) and isPlayer(ent) then
        
        -- Code Wasied
        if WasiedAdminSystem.Config.AutoCloakPhys then ent:SetNoDraw(false) end
        --

        if pl:query("ulx physgunplayer") then
            local isFrozen = ( ent:IsFrozen() or ent.frozen or ent.phrozen )

            ent:SetVelocity(ent:GetVelocity()*-1)
            ent:SetMoveType(pl:KeyDown(IN_ATTACK2) and MOVETYPE_NOCLIP or MOVETYPE_WALK)
            
            timer.Simple(0.001, function()
                if pl:KeyDown(IN_ATTACK2) and !isFrozen then

                    if pl:query( "ulx freeze" ) then
                        ulx.freeze(pl, {ent}, false)
                        if ent.frozen then ent.phrozen = true end
                    end

                elseif pl:query("ulx unfreeze") and isFrozen then

                    if pl:KeyDown(IN_ATTACK2) and pl:query( "ulx freeze" ) then
                        physgun_freeze(pl, ent, true)
                        timer.Simple(0.001, function() physgun_freeze(pl, ent, false) end)
                    else
                        ulx.freeze(pl, {ent}, true)
                        if not ent.frozen then ent.phrozen = nil end
                    end

                end
            end)

        else
            ent:SetMoveType(MOVETYPE_WALK)
        end
    end
end)

hook.Add("DoPlayerDeath", "Wasied:AdminSystem:RefundSystem", function(ply)
    if !IsValid(ply) then return end

    if WasiedAdminSystem.CheckStaff(ply) && ply:GetNWInt("AdminSystem:AdminMode") == 1 then
        WasiedAdminSystem.UpdateAdminMod(ply)
    end

    local save = {}
    if WasiedAdminSystem.Config.RefundWeapons then
        save.weapons = {}
        for k,v in pairs(ply:GetWeapons()) do
            table.insert(save.weapons, v:GetClass())
        end
    end -- get a table with all the weapons
    if WasiedAdminSystem.Config.RefundMoney then save.money = ply:getDarkRPVar("money") or 0 end
    if WasiedAdminSystem.Config.RefundPM then save.pm = ply:GetModel() end
    if WasiedAdminSystem.Config.RefundJob then save.job = ply:Team() end

    if save then
        net.Start("AdminSystem:RefundMenu:SendToAdmins")
            net.WriteBool(true)
            net.WriteEntity(ply)
            net.WriteTable(save)
        net.Send(WasiedAdminSystem.AdminTable())
    end

end)
