if !SERVER then return end

--[[ Networking ]]--
util.AddNetworkString("AdminSystem:Utils:ModifyVar")
util.AddNetworkString("AdminSystem:AdminMenu:Open")
util.AddNetworkString("AdminSystem:PlayerManag:Open")
util.AddNetworkString("AdminSystem:RefundMenu:Open")
util.AddNetworkString("AdminSystem:RefundMenu:SendToAdmins")
util.AddNetworkString("AdminSystem:RefundMenu:RefundThings")
util.AddNetworkString("AdminSystem:Tickets:Open")
util.AddNetworkString("AdminSystem:Tickets:SendTicket")
util.AddNetworkString("AdminSystem:Tickets:SendToAdmins")
util.AddNetworkString("AdminSystem:Tickets:AdminTaking")

net.Receive("AdminSystem:Utils:ModifyVar", function(_, ply)
    if !IsValid(ply) then return end
    if !ply:Alive() then return end

    local int = net.ReadInt(2)
    ply:SetNWInt("AdminSystem:AdminMode", int)
end)

net.Receive("AdminSystem:Tickets:SendTicket", function(_, ply)
    if !WasiedAdminSystem.Config.TicketEnabled then return end
    if !IsValid(ply) then return end

    local tbl = {}
    tbl.plys = net.ReadTable()
    tbl.sender = ply
    tbl.subject = net.ReadString()
    tbl.description = net.ReadString()

    net.Start("AdminSystem:Tickets:SendToAdmins")
        net.WriteBool(true)
        net.WriteTable(tbl)
    net.Send(WasiedAdminSystem.AdminTable(true))
    
end)

net.Receive("AdminSystem:Tickets:AdminTaking", function(_, ply)
    if !IsValid(ply) then return end

    local bool = net.ReadBool()
    local sender = net.ReadEntity()

    if !IsValid(sender) then return end

    net.Start("AdminSystem:Tickets:SendToAdmins")
        net.WriteBool(false) -- show or complete
        net.WriteBool(bool) -- delete ?
        net.WriteEntity(ply)
        net.WriteEntity(sender)
    net.Send(WasiedAdminSystem.AdminTable(true))

end)

net.Receive("AdminSystem:RefundMenu:RefundThings", function(_, ply)
    if !IsValid(ply) then return end

    local victim = net.ReadEntity()
    local refund = net.ReadTable()
    local weapon = refund.weapons
    local money = refund.money
    local job = refund.job
    local model = refund.PM

    if !IsValid(victim) then return end

    if weapon then
        for k,v in pairs(weapon) do
            victim:Give(v)
        end
        WasiedLib.Log(ply, "a remboursé les armes de "..victim:Nick().." (Admin System).")
    end

    if money then
        victim:setDarkRPVar("money", money)
        WasiedLib.Log(ply, "a remboursé l'argent de "..victim:Nick().." (Admin System).")
    end

    if job then
        victim:SetTeam(job)
        WasiedLib.Log(ply, "a remboursé le métier "..victim:Nick().." (Admin System).")
    end

    if model then
        victim:SetModel(model)
        WasiedLib.Log(ply, "a remboursé le modèle "..victim:Nick().." (Admin System).")
    end

    DarkRP.notify(victim, 0, 7, "Vous avez été remboursé par "..ply:Nick().." !")
    DarkRP.notify(ply, 0, 7, "Le remboursement a eu lieu avec succès !")
    WasiedAdminSystem.AdminLogging(ply, "a remboursé "..victim:Nick().." !")

    -- update for others admins
    net.Start("AdminSystem:RefundMenu:SendToAdmins")
        net.WriteBool(false)
        net.WriteEntity(victim)
    net.Send(WasiedAdminSystem.AdminTable())

end)