if EdgeHUD.Configuration.GetConfigValue( "TopRight" ) then

	--Create a variable for the local player.
	local ply = LocalPlayer()

	--Create a copy of the colors and vars table.
	local COLORS = table.Copy(EdgeHUD.Colors)
	local VARS = table.Copy(EdgeHUD.Vars)

	local screenWidth = ScrW()
	local screenHeight = ScrH()

	--Create a table where we store information about the widgets in the top right. (Except Agenda that is hardcoded)
	local detailWidgets = {
		{
			Title = EdgeHUD.GetPhrase("TOPRIGHT_LOCKDOWN_TITLE"),
			Color = Color(255,106,106),
			getData = function() return EdgeHUD.GetPhrase("TOPRIGHT_LOCKDOWN") end,
			shouldDraw = function() return GetGlobalBool("DarkRP_LockDown") end
		},
		{
			Title = EdgeHUD.GetPhrase("TOPRIGHT_WANTED_TITLE"),
			Color = Color(72,162,255),
			getData = function() return EdgeHUD.GetPhrase("TOPRIGHT_WANTED") end,
			shouldDraw = function() return ply:getDarkRPVar("wanted") == true end
		},
		{
			Title = EdgeHUD.GetPhrase("TOPRIGHT_ARRESTED_TITLE"),
			Color = Color(255,248,138),
			getData = function() return string.Replace(EdgeHUD.GetPhrase("TOPRIGHT_ARRESTED"), "%T", EdgeHUD.FormatTime(EdgeHUD.ArrestTime())) end,
			shouldDraw = function() return EdgeHUD.PlayerIsArrested() end
		},
	}

	--[[-------------------------------------------------------------------------
	Agenda
	---------------------------------------------------------------------------]]

	--Create a variable holding the agendaHeight.
	local agendaHeight = math.floor(screenHeight * 0.11)

	--Create the agendaPanel.
	local agendaPanel = vgui.Create("EdgeHUD:WidgetBox")
	agendaPanel:SetSize(VARS.toprightWidth,agendaHeight)
	agendaPanel:SetPos(screenWidth - VARS.ScreenMargin - VARS.toprightWidth - EdgeHUD.RightOffset, VARS.ScreenMargin + EdgeHUD.TopOffset)
	agendaPanel:SetVisible(false)

	--Register the derma element.
	EdgeHUD.RegisterDerma("InfoWidget_Agenda", agendaPanel)

	--Get the agendaTable.
	local agendaTable = ply:getAgendaTable()

	--Create the agendaTitle.
	local agendaTitle = vgui.Create("DLabel",agendaPanel)
	agendaTitle:SetFont("EdgeHUD:Medium")
	agendaTitle:SetTextColor(Color(72,162,255))
	agendaTitle:SetText(agendaTable and agendaTable.Title or "")
	agendaTitle:SizeToContents()
	agendaTitle:SetPos(VARS.ElementsMargin,VARS.ElementsMargin)

	--Create the agendatext.
	local agendaText = vgui.Create("RichText",agendaPanel)
	agendaText:SetSize(agendaPanel:GetWide() - VARS.ElementsMargin * 2,agendaPanel:GetTall() - agendaTitle:GetTall() - VARS.ElementsMargin * 2)
	agendaText:SetPos(VARS.ElementsMargin,VARS.ElementsMargin + agendaTitle:GetTall())
	agendaText:SetVerticalScrollbarEnabled(false)
	agendaText:InsertColorChange(255,255,255,255)
	agendaText.curAgenda = DarkRP.deLocalise(ply:getDarkRPVar("agenda") or "")

	if agendaText.curAgenda == "" then
		agendaText.curAgenda = EdgeHUD.GetPhrase("TOPRIGHT_AGENDAHELP")
	end

	agendaText:AppendText(agendaText.curAgenda)

	--Set the font.
	agendaText.PerformLayout = function(  )
		agendaText:SetFontInternal("EdgeHUD:Small_2")
	end

	--CReate a UpdateInfo function for the agendaPanel.
	agendaPanel.UpdateInfo = function(  )

		--Cache the agenda.
		local agenda = ply:getDarkRPVar("agenda") or ""
		local agendaTbl = ply:getAgendaTable()
		local title = agendaTbl and agendaTbl.Title or ""

		--Check if the agenda has been changed.
		if agendaText.curAgenda != agenda or agendaTitle:GetValue() != title then

			if agenda == "" then
				agenda = EdgeHUD.GetPhrase("TOPRIGHT_AGENDAHELP")
			end

			--Reset the agenda.
			agendaText:SetText("")

			--Update the agenda.
			agendaText:InsertColorChange(255,255,255,255)
			agendaText.curAgenda = agenda
			agendaText:AppendText(agenda)

			agendaTitle:SetText(title)
			agendaTitle:SizeToContents()
			agendaTitle:SetPos(VARS.ElementsMargin,VARS.ElementsMargin)

		end

	end

	--[[-------------------------------------------------------------------------
	Detail Widgets
	---------------------------------------------------------------------------]]

	--Create a var that holds the height of the detailWidgets.
	local detailWidgetsHeight = math.floor(screenHeight * 0.06)

	--Create a variable for the position of the elements.
	local detailsPos = VARS.ScreenMargin

	--Create a local table for the detailWidgetPanels.
	detailWidgetPanels = {}

	--Loop through detailWidgets.
	for i = 1,#detailWidgets do

		--Calculate the rest of the detailsPos.
		--detailsPos = detailsPos + (VARS.ElementsMargin + detailWidgetsHeight) * (i - 1)

		--Create a local var for the current widget.
		local curWidget = detailWidgets[i]

		--Create a WidgetBox.
		local Widget = vgui.Create("EdgeHUD:WidgetBox")
		Widget:SetSize(VARS.toprightWidth,detailWidgetsHeight)
		Widget:SetPos(screenWidth - VARS.ScreenMargin - VARS.toprightWidth - EdgeHUD.RightOffset, detailsPos + EdgeHUD.TopOffset)
		Widget:SetVisible(false)

		--Register the derma element.
		EdgeHUD.RegisterDerma("DetailWidget_" .. i, Widget)

		--Add the Widget into detailWidgetPanels.
		table.insert(detailWidgetPanels,Widget)

		--Create the widgetTitle.
		local widgetTitle = vgui.Create("DLabel",Widget)
		widgetTitle:SetFont("EdgeHUD:Medium")
		widgetTitle:SetTextColor(curWidget.Color)
		widgetTitle:SetText(DarkRP.deLocalise(curWidget.Title))
		widgetTitle:SizeToContents()
		widgetTitle:SetPos(Widget:GetWide() / 2 - widgetTitle:GetWide() / 2, VARS.ElementsMargin)

		--Create the widgetMessage.
		local widgetMessage = vgui.Create("DLabel",Widget)
		widgetMessage:SetFont("EdgeHUD:Small_2")
		widgetMessage:SetTextColor(COLORS["White"])
		widgetMessage.Text = DarkRP.deLocalise(curWidget.getData())
		widgetMessage:SetText(widgetMessage.Text)
		widgetMessage:SizeToContents()
		widgetMessage:SetPos(Widget:GetWide() / 2 - widgetMessage:GetWide() / 2, Widget:GetTall() - widgetMessage:GetTall() - VARS.ElementsMargin)

		--Create a updateInfo function to update the text.
		Widget.UpdateInfo = function(  )

			--Create a var for the new EdgeHUD.calcData.
			local newData = curWidget.getData()

			--Check if the data has changed.
			if widgetMessage.Text != newData then

				--Update the text, position, etc.
				widgetMessage.Text = newData
				widgetMessage:SetText(DarkRP.deLocalise(newData))
				widgetMessage:SizeToContents()
				widgetMessage:SetPos(Widget:GetWide() / 2 - widgetMessage:GetWide() / 2, Widget:GetTall() - widgetMessage:GetTall() - VARS.ElementsMargin)

			end

		end

	end

	--Create a timer to update the top right widgets.
	timer.Create("EdgeHUD:UpdateTopRight",1,0,function(  )

		--Make sure that the HUD is drawing.
		if EdgeHUD.shouldDraw == false then return end

		--[[-------------------------------------------------------------------------
		Agenda
		---------------------------------------------------------------------------]]

		--Cache the agenda.
		local agenda = ply:getDarkRPVar("agenda") or ""
		local agendaTbl = ply:getAgendaTable()

		local AlwaysShowAgenda = EdgeHUD.Configuration.GetConfigValue( "AlwaysShowAgenda" )

		if (AlwaysShowAgenda and agendaTbl) or (!AlwaysShowAgenda and agenda != "") then
			agendaPanel:SetVisible(true)
		elseif (AlwaysShowAgenda and !agendaTbl) or (!AlwaysShowAgenda and agenda == "") then
			agendaPanel:SetVisible(false)
		end

		--[[-------------------------------------------------------------------------
		DetailWidgets.
		---------------------------------------------------------------------------]]

		--Reset the detailspos.
		detailsPos = VARS.ScreenMargin

		--Check if the agenda is visible.
		if agendaPanel:IsVisible() then
			detailsPos = detailsPos + agendaHeight + VARS.ElementsMargin
		end

		--Loop through the detailWidgetPanels.
		for i = 1,#detailWidgetPanels do

			--Get the current widget.
			local curWidget = detailWidgetPanels[i]

			--Check if the widget should be drawn.
			if detailWidgets[i].shouldDraw() then
				curWidget:SetVisible(true)
			else
				curWidget:SetVisible(false)
				continue
			end

			--Set the panel position.
			curWidget:SetPos(screenWidth - VARS.ScreenMargin - VARS.toprightWidth - EdgeHUD.RightOffset, detailsPos + EdgeHUD.TopOffset)

			--Calculate the rest of the detailsPos.
			detailsPos = detailsPos + VARS.ElementsMargin + detailWidgetsHeight

		end

	end)

	hook.Add("EdgeHUD:AddonReload","EdgeHUD:Unload_DetailWidgets",function(  )
		timer.Remove("EdgeHUD:UpdateTopRight")
	end)

end