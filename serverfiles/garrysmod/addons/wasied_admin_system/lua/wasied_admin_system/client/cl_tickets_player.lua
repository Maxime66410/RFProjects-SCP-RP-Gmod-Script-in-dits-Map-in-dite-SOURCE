if !CLIENT then return end

local AdminSystem_TicketTimer = 0
function WasiedAdminSystem.OpenTicketMenu()

	if !IsValid(LocalPlayer()) then return end
	if !LocalPlayer():Alive() then return end
	if !WasiedAdminSystem.Config.TicketEnabled then return end

	if WasiedAdminSystem.Config.AdminSystemEnabled && !WasiedAdminSystem.Config.TicketOnlyAdmin then
		local staffConnected = 0
		for k,v in pairs(player.GetAll()) do
			if IsValid(v) && WasiedAdminSystem.CheckStaff(v) && v:GetNWInt("AdminSystem:AdminMode") > 0 then
				staffConnected = staffConnected + 1
			end
		end

		if staffConnected == 0 then chat.AddText(Color(255, 40, 40), "[Admin System] Aucun administrateur n'est disponible, impossible de faire un ticket !") return end
	end

	local selectedPlayer = {}

	local basicFrame = vgui.Create("WASIED_DFrame")
	basicFrame:SetRSize(900, 500)
	basicFrame:Center()
	basicFrame:CloseButton(true)
	basicFrame:SetLibTitle(WasiedAdminSystem.Language.TicketMenuTitle.." de "..WasiedAdminSystem.Config.ServerName)
	function basicFrame:PaintOver(w, h)
		draw.SimpleText("Liste des joueurs", "Righteous20", WasiedLib.RespX(150), WasiedLib.RespX(75), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.SimpleText("Raison du ticket", "Righteous20", WasiedLib.RespX(315), WasiedLib.RespX(75), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText("Description du ticket", "Righteous20", WasiedLib.RespX(315), WasiedLib.RespX(165), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	--[[ PLAYER LIST ]]--
	local scrollPanel = vgui.Create("DScrollPanel", basicFrame)
	scrollPanel:SetSize(WasiedLib.RespX(250), WasiedLib.RespX(380))
	scrollPanel:SetPos(WasiedLib.RespX(25), WasiedLib.RespX(100))
	scrollPanel:GetVBar():SetHideButtons(true)
	scrollPanel.antiSpamActive = false
	function scrollPanel:Paint(w, h)
		surface.SetDrawColor(color_white)
		surface.DrawLine(w-1, 0, w-1, h)
	end
	local sbar = scrollPanel:GetVBar()
	function sbar:Paint(w, h)
	end
	function sbar.btnGrip:Paint(w, h)
	end

	for k,v in pairs(player.GetAll()) do
		if IsValid(v) then
			if v == LocalPlayer() then continue end

			local panel = scrollPanel:Add("DPanel")
			panel:SetSize(scrollPanel:GetWide(), WasiedLib.RespX(65))
			panel:Dock(TOP)
			panel:DockMargin(WasiedLib.RespX(5), WasiedLib.RespX(5), WasiedLib.RespX(10), WasiedLib.RespX(2))
			panel.clicked = false
			panel.hovered = false
			function panel:Paint(w, h)

				if panel.clicked or panel.hovered && #selectedPlayer < WasiedAdminSystem.Config.TicketMaxPlayers then
					draw.RoundedBox(5, 0, 0, w, h, Color(10, 110, 255))
				elseif #selectedPlayer >= WasiedAdminSystem.Config.TicketMaxPlayers then
					draw.RoundedBox(5, 0, 0, w, h, Color(20, 20, 20, 150))
				else
					draw.RoundedBox(5, 0, 0, w, h, Color(20, 50, 255, 250))
				end

				surface.SetDrawColor(color_white)
				surface.DrawRect(WasiedLib.RespX(4), WasiedLib.RespX(4), WasiedLib.RespX(57), WasiedLib.RespX(57))
			end

			local avatar = vgui.Create("AvatarImage", panel)
			avatar:SetSize(WasiedLib.RespX(55), WasiedLib.RespX(55))
			avatar:SetPos(WasiedLib.RespX(5), WasiedLib.RespX(5))
			avatar:SetPlayer(v, 128)

			local button = vgui.Create("DButton", panel)
			button:Dock(FILL)
			button:SetText("")
			function button:Paint(w, h)
				draw.SimpleText(v:Nick(), "Righteous20", WasiedLib.RespX(70), h/WasiedLib.RespX(2), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			function button:DoClick()
				if panel.clicked then
					panel.clicked = false
					if table.HasValue(selectedPlayer, v) then
						table.RemoveByValue(selectedPlayer, v)
					end
				elseif !panel.clicked && #selectedPlayer < WasiedAdminSystem.Config.TicketMaxPlayers then
					panel.clicked = true
					if !table.HasValue(selectedPlayer, v) then
						table.insert(selectedPlayer, v)
					end
				end
			end
			function button:OnCursorEntered()
				panel.hovered = true
			end
			function button:OnCursorExited()
				panel.hovered = false
			end

		end
	end

	--[[ REPORT PANEL ]]--
	local dboxcombo = vgui.Create("DComboBox", basicFrame)
	dboxcombo:SetSize(WasiedLib.RespX(550), WasiedLib.RespX(40))
	dboxcombo:SetPos(WasiedLib.RespX(300), WasiedLib.RespX(100))
	dboxcombo:SetValue(WasiedAdminSystem.Language.DefaultText)
	for _,val in pairs(WasiedAdminSystem.Config.TicketsReasons) do
		dboxcombo:AddChoice(val)
	end

	local descriptionEntry = vgui.Create("DTextEntry", basicFrame)
	descriptionEntry:SetSize(WasiedLib.RespX(550), WasiedLib.RespX(200))
	descriptionEntry:SetPos(WasiedLib.RespX(300), WasiedLib.RespX(190))
	descriptionEntry:SetMultiline(true)
	descriptionEntry:SetFont("Righteous25")

	local validButton = vgui.Create("WASIED_DButton", basicFrame)
	validButton:SetRSize(450, 65)
	validButton:SetRPos(350, 415)
	validButton:SetLibText("Envoyer", color_white)
	function validButton:DoClick()

		if AdminSystem_TicketTimer < CurTime() then

			local descriptionText = descriptionEntry:GetValue()
			local subjectText = dboxcombo:GetSelected()

			if string.len(descriptionText) > WasiedAdminSystem.Config.MinDescriptionLen && string.len(descriptionText) < 5000 && dboxcombo:GetValue() != WasiedAdminSystem.Language.DefaultText then
				
				net.Start("AdminSystem:Tickets:SendTicket")
					net.WriteTable(selectedPlayer)
					net.WriteString(subjectText)
					net.WriteString(descriptionText)
				net.SendToServer()

				chat.AddText(Color(40, 255, 40), "[Admin System] "..WasiedAdminSystem.Language.SuccessTicketMsg)
			
				AdminSystem_TicketTimer = CurTime() + WasiedAdminSystem.Config.TicketTimer

				basicFrame:Close()
			
			else
				chat.AddText(Color(255, 40, 40), "[Admin System] Veuillez remplir correctement votre ticket !")
			end
		
		else
			chat.AddText(Color(255, 40, 40), "[Admin System] Veuillez attendre avant d'envoyer un autre ticket !")
		end
	end

end
net.Receive("AdminSystem:Tickets:Open", WasiedAdminSystem.OpenTicketMenu)