if !CLIENT then return end

--[[ Create fonts ]]--
local function RespFont(font) return font/1920*ScrW() end
for i=1, 100 do
	surface.CreateFont("Righteous"..i, {
		font = "Righteous",
		extended = false,
		size = RespFont(i),
		weight = 600,
	})
end

--[[ Admin Menu ]]--
function WasiedAdminSystem.OpenAdminMenu()

	if !WasiedAdminSystem.Config.AdminMenuEnabled then return end
	if !IsValid(LocalPlayer()) then return end
	if !LocalPlayer():Alive() then return end
	if !WasiedAdminSystem.CheckStaff(LocalPlayer()) then return end

	local basicFrame = vgui.Create("WASIED_DFrame")
	basicFrame:SetRSize(1100, 600)
	basicFrame:Center()
	basicFrame:CloseButton(true)
	basicFrame:SetLibTitle(WasiedAdminSystem.Language.AdminMenuTitle.." de "..WasiedAdminSystem.Config.ServerName)

	--[[1]]--
	local adminColor = color_white
	if LocalPlayer():GetNWInt("AdminSystem:AdminMode") == 1 then adminColor = Color(40, 255, 40) else adminColor = Color(255, 40, 40) end

	local setAdminModButton = vgui.Create("WASIED_DButton", basicFrame)
	setAdminModButton:SetRPos(100, 100)
	setAdminModButton:SetRSize(250, 50)
	setAdminModButton:SetLibText("Mode administratif", adminColor)
	setAdminModButton.countdown = 0
	setAdminModButton.DoClick = function(self)

		if self.countdown < CurTime() then

			if LocalPlayer():GetNWInt("AdminSystem:AdminMode") == 1 then
				self:SetLibText("Mode administratif", Color(255, 40, 40))

				net.Start("AdminSystem:Utils:ModifyVar")
					net.WriteInt(0, 2)
				net.SendToServer()

			elseif LocalPlayer():GetNWInt("AdminSystem:AdminMode") == 0 then
				self:SetLibText("Mode administratif", Color(40, 255, 40))
				
				net.Start("AdminSystem:Utils:ModifyVar")
					net.WriteInt(1, 2)
				net.SendToServer()

			end

			self.countdown = CurTime() + 3
		end
	end

	local warnButton = vgui.Create("WASIED_DButton", basicFrame)
	warnButton:SetRPos(425, 100)
	warnButton:SetRSize(250, 50)
	warnButton:SetLibText("Menu des warns", color_white)
	warnButton.countdown = 0
	warnButton.DoClick = function(self)
		if self.countdown < CurTime() then

			RunConsoleCommand("say", WasiedAdminSystem.Config.WarnsCommand)

			if IsValid(basicFrame) then
				basicFrame:Remove()
			end

			self.countdown = CurTime() + 3
		end
	end

	local warnButton = vgui.Create("WASIED_DButton", basicFrame)
	warnButton:SetRPos(750, 100)
	warnButton:SetRSize(250, 50)
	warnButton:SetLibText("Menu des sanctions", color_white)
	warnButton.countdown = 0
	warnButton.DoClick = function(self)
		if self.countdown < CurTime() then

			if WasiedAdminSystem then
				WasiedAdminSystem.OpenManagmentMenu()
			end

			if IsValid(basicFrame) then
				basicFrame:Remove()
			end

			self.countdown = CurTime() + 3
		end
	end

	--[[2]]--
	local logsButton = vgui.Create("WASIED_DButton", basicFrame)
	logsButton:SetRPos(100, 200)
	logsButton:SetRSize(250, 50)
	logsButton:SetLibText("Ouvrir les logs", color_white)
	logsButton.countdown = 0
	logsButton.DoClick = function(self)

		if self.countdown < CurTime() then

			RunConsoleCommand("say", WasiedAdminSystem.Config.LogsCommand)

			if IsValid(basicFrame) then
				basicFrame:Remove()
			end
		
			self.countdown = CurTime() + 3
		end
	end

	local ulxButton = vgui.Create("WASIED_DButton", basicFrame)
	ulxButton:SetRPos(425, 200)
	ulxButton:SetRSize(250, 50)
	ulxButton:SetLibText("Ouvrir ULX", color_white)  
	ulxButton.countdown = 0
	ulxButton.DoClick = function(self)
		if self.countdown < CurTime() then

			RunConsoleCommand("say", "!menu")

			if IsValid(basicFrame) then
				basicFrame:Remove()
			end

			self.countdown = CurTime() + 3
		end
	end

	local ticketMenuButton = vgui.Create("WASIED_DButton", basicFrame)
	ticketMenuButton:SetRPos(750, 200)
	ticketMenuButton:SetRSize(250, 50)
	ticketMenuButton:SetLibText("Menu des tickets", color_white)
	ticketMenuButton.countdown = 0
	ticketMenuButton.DoClick = function(self)
		if self.countdown < CurTime() then

			if WasiedAdminSystem then
				WasiedAdminSystem.OpenTicketMenu()
			end

			if IsValid(basicFrame) then
				basicFrame:Remove()
			end

			self.countdown = CurTime() + 3
		end
	end
	
	local refundMenu = vgui.Create("WASIED_DButton", basicFrame)
	refundMenu:SetRPos(100, 300)
	refundMenu:SetRSize(250, 50)
	refundMenu:SetLibText("Menu remboursement", color_white)
	refundMenu.countdown = 0
	refundMenu.DoClick = function(self)
		if self.countdown < CurTime() then

			if WasiedAdminSystem then
				WasiedAdminSystem.OpenRefundMenu()
			end

			if IsValid(basicFrame) then
				basicFrame:Remove()
			end

			self.countdown = CurTime() + 3
		end
	end

	--[[ Connected Staff ]]--
	local staffConnected = 0
	for k,v in pairs(player.GetAll()) do
		if IsValid(v) && WasiedAdminSystem.CheckStaff(v) then
			staffConnected = staffConnected + 1
		end
	end

	local staffConnectedLabel = vgui.Create("DLabel", basicFrame)
	staffConnectedLabel:SetSize(WasiedLib.RespX(180), WasiedLib.RespY(60))
	staffConnectedLabel:SetPos(basicFrame:GetWide()-staffConnectedLabel:GetWide(), basicFrame:GetTall()-staffConnectedLabel:GetTall())
	staffConnectedLabel:SetText("")
	function staffConnectedLabel:Paint(w, h)
		draw.SimpleText("Staff connectés : "..staffConnected, "Righteous20", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end

end
net.Receive("AdminSystem:AdminMenu:Open", WasiedAdminSystem.OpenAdminMenu)