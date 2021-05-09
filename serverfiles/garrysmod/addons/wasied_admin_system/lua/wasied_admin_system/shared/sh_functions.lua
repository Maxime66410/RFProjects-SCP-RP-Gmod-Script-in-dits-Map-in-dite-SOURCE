--[[ Shared functions ]]--
function WasiedAdminSystem.ULXorFAdmin()
    if string.upper(WasiedAdminSystem.Config.ULXorFAdmin) == "ULX" then
        if !ULib then Error("[Admin System] ULib n'a pas été détecté par le système ! Cela risque de ne pas fonctionner...") end
        return true
    elseif string.upper(WasiedAdminSystem.Config.ULXorFAdmin) == "FADMIN" then
        return false
    else
        Error("[Admin System] Le système de cloak défini dans la configuration de l'addon est invalide.")
    end
end

function WasiedAdminSystem.AdminLogging(victim, log)
    if !WasiedAdminSystem.Config.ShowStaffActions then return end

    for _,v in pairs(player.GetAll()) do
        if WasiedAdminSystem.Config.HighRanks[v:GetUserGroup()] then
            v:PrintMessage(HUD_PRINTTALK, "[Admin System Log] "..victim:Nick().." ("..victim:SteamID()..") "..log)
        end
    end

end

function WasiedAdminSystem.CheckStaff(ply)
    if !IsValid(ply) then return end

    if WasiedAdminSystem.Config.RanksAllowed[ply:GetUserGroup()] then return true end
    if ply:IsSuperAdmin() then return true end

    return false 
end