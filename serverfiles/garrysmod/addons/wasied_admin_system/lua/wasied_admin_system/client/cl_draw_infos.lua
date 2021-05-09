if !CLIENT then return end

-- Draw informations
local contextIsOpen = WasiedAdminSystem.Config.ShowExtraInfos

hook.Add("HUDPaint", "Wasied:AdminSystem:HUDPaint", function()
	local ply = LocalPlayer()

    if ply:GetNWInt("AdminSystem:AdminMode") < 1 then return end

	if WasiedAdminSystem.Config.AdminSystemEnabled then
		draw.SimpleTextOutlined(WasiedAdminSystem.Language.ModeAdmin, "Righteous50", ScrW()/2, WasiedLib.RespY(5), Color(40, 255, 40), 1, 3, 1, color_black)
		draw.SimpleTextOutlined("- God -", "Righteous30", ScrW()/2, WasiedLib.RespY(50), Color(40, 255, 40), 1, 3, 1, color_black)
		
		if ply:GetMoveType() == MOVETYPE_NOCLIP then
			draw.SimpleTextOutlined("Noclip", "Righteous30", ScrW()/2-WasiedLib.RespX(50), WasiedLib.RespY(50), Color(40, 255, 40), 2, 3, 1, color_black)
		else
			draw.SimpleTextOutlined("Noclip", "Righteous30", ScrW()/2-WasiedLib.RespX(50), WasiedLib.RespY(50), Color(255, 40, 40), 2, 3, 1, color_black)
		end

		if ply:GetNoDraw() or ply:GetRenderMode() == RENDERMODE_TRANSALPHA then
			draw.SimpleTextOutlined("Cloak", "Righteous30", ScrW()/2+WasiedLib.RespX(50), WasiedLib.RespY(50), Color(40, 255, 40), 0, 3, 1, color_black)
		else
			draw.SimpleTextOutlined("Cloak", "Righteous30", ScrW()/2+WasiedLib.RespX(50), WasiedLib.RespY(50), Color(255, 40, 40), 0, 3, 1, color_black)
		end
	end

	if WasiedAdminSystem.Config.ShowBasicsInfos then

		for _,victim in pairs(player.GetAll()) do

			if victim == ply then continue end
			if !IsValid(victim) then continue end
			
			if !WasiedAdminSystem.Config.HighRanks[ply:GetUserGroup()] then
				if WasiedAdminSystem.Config.HighRanks[victim:GetUserGroup()] then continue end
			end

			local pos = victim:GetShootPos()
			if ply:GetPos():DistToSqr(pos) > WasiedAdminSystem.Config.DistToShow^2 then continue end

			pos.z = pos.z + 15
			pos = pos:ToScreen()
			if !pos.visible then continue end
			local x, y = pos.x+10, pos.y

			draw.SimpleTextOutlined("●", "Righteous22", x-10, y-20, team.GetColor(victim:Team()), 1, 1, 1, color_black)

			local plyNick = victim:Nick()
			local plyNickLen = string.len(plyNick)

			-- Name
			surface.SetDrawColor(Color(0, 0, 0, 130))
			surface.DrawRect(x-62, y-71, 50+plyNickLen*8, 20)

			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(Material("icon16/vcard.png"))
			surface.DrawTexturedRect(x-60, y-69, 16, 16)

			draw.SimpleTextOutlined(plyNick, "Righteous20", x-35, y-72, color_white, 0, 3, 1, color_black)

			-- Job
			local jobColor = team.GetColor(victim:Team())
			local jobName = team.GetName(victim:Team())
			local jobLen = string.len(jobName)

			surface.SetDrawColor(jobColor)
			surface.DrawRect(x-62, y-50, 50+jobLen*8, 20)

			surface.SetDrawColor(Color(255, 255, 255))
			surface.SetMaterial(Material("icon16/user_suit.png"))
			surface.DrawTexturedRect(x-60, y-48, 16, 16)

			draw.SimpleTextOutlined(jobName, "Righteous20", x-35, y-50, Color(255,255,255,200), 0, 3, 1, color_black)

			if contextIsOpen && ply:GetPos():DistToSqr(victim:GetShootPos()) < WasiedAdminSystem.Config.DistToShowExtra^2 then

				-- Money
				local money = victim:getDarkRPVar("money") or 0
				local moneyString = string.len(tostring(money))

				surface.SetDrawColor(Color(0, 204, 0, 90))
				surface.DrawRect(x-62, y-92, 58+moneyString*8, 20)

				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/money.png"))
				surface.DrawTexturedRect(x-60, y-90, 16, 16)

				draw.SimpleTextOutlined(money.."€", "Righteous20", x-35, y-93, Color(255,255,255), 0, 3, 1, color_black)

				-- Health
				local plyHealth = math.Clamp(victim:Health(), 0, 100)
				local plyHealthLen = string.len(tostring(plyHealth))

				surface.SetDrawColor(Color(255, 0, 0, 90))
				surface.DrawRect(x-62, y-114, 58+plyHealthLen*8, 20)

				surface.SetDrawColor(Color(255, 0, 0))
				surface.SetMaterial(Material("icon16/heart.png"))
				surface.DrawTexturedRect(x-60, y-112, 16, 16)

				draw.SimpleTextOutlined(victim:Health().."%", "Righteous20", x-35, y-114, Color(255,255,255,200), 0, 3, 1, color_black)

				-- Armor
				local plyArmor = math.Clamp(victim:Armor(), 0, 100)
				local plyArmorLen = string.len(tostring(plyArmor))

				surface.SetDrawColor(Color(50, 60, 255, 90))
				surface.DrawRect(x-62, y-136, 58+plyArmorLen*8, 20)
				
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/shield.png"))
				surface.DrawTexturedRect(x-60, y-134, 16, 16)

				draw.SimpleTextOutlined(victim:Armor().."%", "Righteous20", x-35, y-136, Color(255,255,255,200), 0, 3, 1, color_black)

				-- Hunger
				local plyHunger = victim:getDarkRPVar("Energy") or 0
				local plyHungerLen = string.len(tostring(plyHunger))

				surface.SetDrawColor(Color(255, 110, 0, 90))
				surface.DrawRect(x-62, y-158, 58+plyHungerLen*8, 20)
				
				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/cup.png"))
				surface.DrawTexturedRect(x-60, y-156, 16, 16)

				draw.SimpleTextOutlined(plyHunger.."%", "Righteous20", x-35, y-158, Color(255,255,255), 0, 3, 1, color_black)
				
				-- Rank
				local plyRank = victim:GetUserGroup()
				local plyRankLen = string.len(plyRank)

				surface.SetDrawColor(Color(255, 10, 0, 90))
				surface.DrawRect(x-62, y-178, 50+plyRankLen*8, 20)

				surface.SetDrawColor(Color(255, 255, 255))
				surface.SetMaterial(Material("icon16/key.png"))
				surface.DrawTexturedRect(x-60, y-176, 16, 16)

				draw.SimpleTextOutlined(plyRank, "Righteous20", x-35, y-179, Color(255,255,255), 0, 3, 1, color_black)

			end
		end
	end

	if WasiedAdminSystem.Config.ShowVehiclesInfos then
		for _,veh in pairs(ents.FindByClass("prop_vehicle_jeep")) do

			if !veh:IsVehicle() then continue end

			local pos = veh:GetPos()
			if ply:GetPos():DistToSqr(pos) > WasiedAdminSystem.Config.DistToShow^2 then continue end
			
			pos.z = pos.z + 75
			pos = pos:ToScreen()
			if !pos.visible then continue end
			local x, y = pos.x, pos.y

			local vName = veh:GetVehicleClass()
			if VC then vName = veh:VC_getName() end

			draw.SimpleTextOutlined("●", "Righteous22", x-10, y-20, Color(40, 40, 255), 1, 1, 1, color_black)
			draw.SimpleTextOutlined(vName, "Righteous20", x-15, y-40, color_white, 1, 1, 1, color_black)

		end
	end

end)

hook.Add("OnContextMenuOpen", "Wasied:AdminSystem:OpenContext", function()
	if !WasiedAdminSystem.Config.ShowExtraInfos then contextIsOpen = true end
end)

hook.Add("OnContextMenuClose", "Wasied:AdminSystem:CloseContext", function()
	if !WasiedAdminSystem.Config.ShowExtraInfos then contextIsOpen = false end
end)