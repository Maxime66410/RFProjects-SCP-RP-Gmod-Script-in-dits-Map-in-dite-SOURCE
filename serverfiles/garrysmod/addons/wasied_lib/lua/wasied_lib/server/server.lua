--[[ Functions ]]--
function WasiedLib.Log(ply, str)
    if !ply:IsPlayer() then return end
    if !isstring(str) then return end

    local nick = ply:Nick()
    local steamid = ply:SteamID()

    ServerLog("[WasiedLogger] "..nick.." ("..steamid..") "..str.."\n")
end