if !CLIENT then return end

net.Receive("AdminSystem:Tickets:SendToAdmins", function()

	--[[ VARIABLES ]]--
	local drawTicket = net.ReadBool()
	
	if drawTicket then

		local tbl = net.ReadTable()
		local sender, plys, subject, description = tbl.sender, tbl.plys, tbl.subject, tbl.description
		local TicketSideColor = Color(255, 40, 40)
		local plyNick = sender:Nick()
		local plysname = {}

		--[[ If multiple players reported ]]--
		if istable(plys) && #plys > 0 then
			for k,v in pairs(plys) do
				table.insert(plysname, v:Nick())
			end
		end
	
		if !IsValid(LocalPlayer().ticketScrollPanel) then
			LocalPlayer().ticketScrollPanel = vgui.Create("DScrollPanel")
			LocalPlayer().ticketScrollPanel:SetPos(WasiedLib.RespX(10), WasiedLib.RespY(100))
			LocalPlayer().ticketScrollPanel:SetSize(WasiedLib.RespX(400), ScrH()-WasiedLib.RespY(175))
			LocalPlayer().ticketScrollPanel:GetVBar():SetHideButtons(true)
			LocalPlayer().ticketScrollPanel.Paint = function() end
			
			local sbar = LocalPlayer().ticketScrollPanel:GetVBar()
			function sbar:Paint() end
			function sbar.btnGrip:Paint() end
		end

		-- Play a sound
		surface.PlaySound("buttons/blip1.wav")

		-- Replace by the newest if one already exists
		if IsValid(sender.ticketPanel) then sender.ticketPanel:Remove() end

		-- Create a panel for a player
		sender.ticketPanel = LocalPlayer().ticketScrollPanel:Add("DPanel")
		sender.ticketPanel:SetSize(LocalPlayer().ticketScrollPanel:GetWide(), WasiedLib.RespY(155))
		sender.ticketPanel:Dock(TOP)
		sender.ticketPanel:DockMargin(WasiedLib.RespX(5), WasiedLib.RespY(5), WasiedLib.RespX(5), WasiedLib.RespY(10))
		sender.ticketPanel:SlideDown(0.5)
		sender.ticketPanel.time = CurTime() + 1
		sender.ticketPanel.expire = WasiedAdminSystem.Config.DeleteTicketTime
		sender.ticketPanel.block = false
		sender.ticketPanel.isTaken = false
		sender.ticketPanel.TicketOwner = "N/A"
		sender.ticketPanel.Paint = function(self, w, h)
		
			if !IsValid(sender) then self:Remove() return end

			draw.RoundedBox(5, 0, 0, w, h, Color(20, 20, 20, 245))

			if self.isTaken then
				draw.RoundedBoxEx(2, 0, 0, w, WasiedLib.RespY(3), Color(40, 255, 40), true, true, false, false)
				draw.RoundedBoxEx(2, 0, h-WasiedLib.RespY(3), w, WasiedLib.RespY(3), Color(40, 255, 40), true, true, false, false)
				draw.SimpleText("Géré par "..self.TicketOwner, "Righteous15", w-WasiedLib.RespX(10), WasiedLib.RespY(10), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
			else
				draw.RoundedBoxEx(2, 0, 0, w, WasiedLib.RespY(3), Color(255, 40, 40), true, true, false, false)
				draw.RoundedBoxEx(2, 0, h-WasiedLib.RespY(3), w, WasiedLib.RespY(3), Color(255, 40, 40), true, true, false, false)
			end

			draw.SimpleText(sender:Nick(), "Righteous25", WasiedLib.RespX(10), WasiedLib.RespY(5), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText(subject, "Righteous18", WasiedLib.RespX(10), WasiedLib.RespY(30), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			
			if !self.block then
				if self.time <= CurTime() && self.expire > 0 then
					self.time = CurTime() + 1
					self.expire = self.expire - 1
				end
				
				if self.expire > 0 && self.expire <= 10 then
					draw.SimpleText(self.expire.."s", "Righteous18", w-WasiedLib.RespX(10), WasiedLib.RespY(8), Color(255, 40, 40), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
				elseif self.expire > 10 then
					draw.SimpleText(self.expire.."s", "Righteous18", w-WasiedLib.RespX(10), WasiedLib.RespY(8), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
				elseif self.expire <= 0 then
					if IsValid(self) then
						self:Remove()
					end
				end
			end

			surface.SetDrawColor(Color(255, 255, 255, 5))
			surface.DrawRect(WasiedLib.RespX(10), WasiedLib.RespY(50), WasiedLib.RespX(255), WasiedLib.RespY(75))

			if istable(plysname) && #plysname > 0 then
				draw.SimpleText("Cible(s) : "..table.concat(plysname, ", "), "Righteous18", WasiedLib.RespX(10), WasiedLib.RespY(150), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			else
				draw.SimpleText("Aucun joueur spécifié", "Righteous18", WasiedLib.RespX(10), WasiedLib.RespY(150), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			end

		end

		local descriptionLabel = vgui.Create("RichText", sender.ticketPanel)
		descriptionLabel:SetSize(WasiedLib.RespX(245), WasiedLib.RespY(65))
		descriptionLabel:SetPos(WasiedLib.RespX(15), WasiedLib.RespY(55))
		descriptionLabel:InsertColorChange(255, 255, 255, 255)
		descriptionLabel:AppendText(description)
		descriptionLabel:SetContentAlignment(7)
		function descriptionLabel:PerformLayout(w, h)
			self:SetFontInternal("Righteous18")
		end

		local takeButton = vgui.Create("WASIED_DButton", sender.ticketPanel)
		takeButton:SetRSize(100, 30)
		takeButton:SetRPos(275, 30)
		takeButton:SetLibText("Prendre", color_white, 1)
		takeButton.DoClick = function(self)
			
			if !self:GetParent().isTaken then
				net.Start("AdminSystem:Tickets:AdminTaking")
					net.WriteBool(false) -- should delete ?
					net.WriteEntity(sender)
				net.SendToServer()
			else
				if self:GetParent().TicketOwner == LocalPlayer():Nick() then
					net.Start("AdminSystem:Tickets:AdminTaking")
						net.WriteBool(true) -- should delete ?
						net.WriteEntity(sender)
					net.SendToServer()
				end
			end

		end
		takeButton.Think = function(self)
			if self:GetParent().isTaken then
				if self:GetParent().TicketOwner == LocalPlayer():Nick() then
					self:SetLibText("Terminer", color_white, 1)
				else
					self:SetLibText("En cours...", color_white, 1)
				end
			end
		end

		local gotoButton = vgui.Create("WASIED_DButton", sender.ticketPanel)
		gotoButton:SetRSize(100, 30)
		gotoButton:SetRPos(275, 65)
		gotoButton:SetLibText("Rejoindre", color_white, 1)
		gotoButton.DoClick = function(s)

			if WasiedAdminSystem.ULXorFAdmin() then
				LocalPlayer():ConCommand("ulx goto $"..sender:SteamID())
			else
				RunConsoleCommand("_FAdmin", "Goto", sender:UserID())
			end

			chat.AddText(Color(40, 255, 40), "[Admin System] Vous vous êtes téléporté à "..plyNick.." !")
		end

		local tpButton = vgui.Create("WASIED_DButton", sender.ticketPanel)
		tpButton:SetRSize(100, 30)
		tpButton:SetRPos(275, 100)
		tpButton:SetLibText("Téléporter", color_white, 1)
		tpButton.DoClick = function(s)

			if WasiedAdminSystem.ULXorFAdmin() then
				LocalPlayer():ConCommand("ulx teleport $"..sender:SteamID())
			else
				RunConsoleCommand("_FAdmin", "Teleport", sender:UserID())
			end

			chat.AddText(Color(40, 255, 40), "[Admin System] Vous avez téléporté "..plyNick.." !")
		end

		local closeTicket = vgui.Create("DImageButton", sender.ticketPanel)
		closeTicket:SetSize(WasiedLib.RespX(15), WasiedLib.RespY(15))
		closeTicket:SetPos(WasiedLib.RespX(370), WasiedLib.RespY(135))
		closeTicket:SetText("")
		closeTicket:SetImage("icon16/cross.png")
		closeTicket.DoClick = function(s)
			if IsValid(sender.ticketPanel) then
				sender.ticketPanel:Remove()
			end
		end
	
	else
		
		local shouldDelete = net.ReadBool()
		local bestAdmin = net.ReadEntity()
		local sender = net.ReadEntity()

		if IsValid(sender.ticketPanel) then
			if shouldDelete then
				sender.ticketPanel:Remove()
			else
				sender.ticketPanel.isTaken = true
				sender.ticketPanel.block = true
				sender.ticketPanel.TicketOwner = bestAdmin:Nick()
			end
		end

	end

end)