-- Make colors easier to get.
local COLORS = EdgeScoreboard.Colors

-- Create some vars for the frame.
local frameWidth, frameHeight = math.Round(ScrH() * 0.85), math.Round(ScrH() * 0.55)
local sidebarWidth = math.Round(frameWidth * 0.2)

-- Create some vars for the global tab.
local optionMargin = frameHeight * 0.045

-- Create a function to show a option-example.
local function showOptionExample( imgID )

	local exampleImageFrame = vgui.Create("DFrame")
	exampleImageFrame:SetSize(ScrW(),ScrH())
	exampleImageFrame:MakePopup()
	exampleImageFrame:ShowCloseButton(false)
	exampleImageFrame.Paint = function( s, w, h )

		surface.SetDrawColor(50,50,50,255)
		surface.DrawRect(0,0,w,h)
		
		draw.SimpleText("Page is loading...","EdgeScoreboard:ExampleLoading",w / 2,h / 2,White,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

	end

	local HTMLPanel = vgui.Create("DHTML",exampleImageFrame)
	HTMLPanel:SetSize(exampleImageFrame:GetWide(),exampleImageFrame:GetTall())
	HTMLPanel:OpenURL("http://www.jompe.phy.sx/edgescoreboard/getExample.php?reqImage=" .. imgID)

	local closeBtnSize2 = exampleImageFrame:GetTall() * 0.1

	local closeHTMLButton = vgui.Create("DButton",HTMLPanel)
	closeHTMLButton:SetSize(closeBtnSize2,closeBtnSize2)
	closeHTMLButton:SetPos(exampleImageFrame:GetWide() - closeBtnSize2,0)
	closeHTMLButton:SetText("✖")
	closeHTMLButton:SetFont("EdgeScoreboard:ExampleExit")
	closeHTMLButton:SetTextColor(White)

	closeHTMLButton.Paint = function() end

	closeHTMLButton.Think = function (  )

		--Set the TextColor.
		closeHTMLButton:SetTextColor(closeHTMLButton:IsHovered() and COLORS["Gray"] or COLORS["White"])

	end

	closeHTMLButton.DoClick = function(  )
		exampleImageFrame:Remove()
	end

end

-- Create a function for creating the global tab.
local function createGlobalTab( parent )

	-- Create the panel.
	local panel = vgui.Create("DScrollPanel",parent)
	panel:SetSize(parent:GetWide() - EdgeScoreboard.elementMargin * 3, parent:GetTall() - EdgeScoreboard.elementMargin * 3)
	panel:SetPos(EdgeScoreboard.elementMargin * 1.5, EdgeScoreboard.elementMargin * 1.5)
	panel.Paint = function(  ) end

	panel.VBar:SetWide(0)

	-- Enable smooth scrolling.
	panel.VBar.AddScroll = function( _, scroll )

		-- Get the old scrollposition.
		local oldScroll = panel.VBar:GetScroll()

		-- Animate to the new scrollposition instead of setting it directly.
		panel.VBar:AnimateTo(oldScroll + scroll * 80, 0.2, 0, 0.5)

		-- Return if we have reached the bottom.
		return oldScroll != panel.VBar:GetScroll()

	end

	-- Create a table for all the datamodifiers.
	panel.DataModifiers = {}

	-- Loop through EdgeScoreboard.ConfigValues.Config.
	for k,v in SortedPairsByMemberValue(EdgeScoreboard.ConfigValues.Config,"Order",false) do

		--  Create the config panel.
		local optionPanel = vgui.Create("DPanel",panel)
		optionPanel:SetWide(panel:GetWide())
		optionPanel:Dock(TOP)
		optionPanel:DockMargin(0,0,0,optionMargin)

		-- Create a paint function for the optionPanel.
		optionPanel.Paint = function() end

		-- Create the title of the option
		local title = vgui.Create("DLabel",optionPanel)
		title:SetFont("EdgeScoreboard:Config_OptionTitle")
		title:SetText(v.Title)
		title:SetTextColor(COLORS["White"])
		title:SizeToContents()

		-- Create a desc of the option.
		local description = vgui.Create("DLabel",optionPanel)
		description:SetFont("EdgeScoreboard:Config_OptionDesc")
		description:SetText(v.Description)
		description:SetTextColor(COLORS["White"])
		description:SetWrap(true)
		description:SetPos(0, title:GetTall() + EdgeScoreboard.elementMargin)
		description:SetWide(optionPanel:GetWide())
		description:SetAutoStretchVertical(true)
		description:SetContentAlignment(7)

		-- Create the datamodifier.
		local dataModifier = vgui.Create("EdgeScoreboard:DataModifier",optionPanel)
		dataModifier:SetSize(optionPanel:GetWide() * 0.5,panel:GetTall() * 0.05)
		dataModifier:SetID(k,true)
		panel.DataModifiers[k] = dataModifier
		
		-- Create a var for the last DescHeight
		local lastDescHeight = 0

		-- Creae a actions button for each modifier.
		local actionsButton = vgui.Create("DButton",optionPanel)
		actionsButton:SetSize(dataModifier:GetTall(), dataModifier:GetTall())
		actionsButton:SetText("+")
		actionsButton:SetFont("EdgeScoreboard:Config_ActionButton")
		actionsButton:SetTextColor(COLORS["White"])
		EdgeScoreboard.SetEdgeTheme( actionsButton, true, true)

		-- Create the DoClick function for the actionsButton.
		actionsButton.DoClick = function(  )

			-- Create a new dermaPanel.
			local actionsMenu = DermaMenu(actionsButton)
			EdgeScoreboard.SetEdgeTheme(actionsMenu)

			-- Add an option to reset the config to default.
			local resetToDefault = actionsMenu:AddOption("Reset to default", function(  )
				dataModifier.interactElement:SetText(EdgeScoreboard.ConfigValues.Config[k].Default)
				dataModifier.ValueUpdated(EdgeScoreboard.ConfigValues.Config[k].Default)
			end)

			-- Set the icon.
			resetToDefault:SetIcon("icon16/database_refresh.png")
			resetToDefault:SetTextColor(COLORS["White"])

			if EdgeScoreboard.ConfigValues.Config[k].exampleImage then

				-- Add an option to reset the config to default.
				local showExample = actionsMenu:AddOption("Show example", function(  )
					showOptionExample( EdgeScoreboard.ConfigValues.Config[k].exampleImage )
				end)

				-- Set the icon.
				showExample:SetIcon("icon16/folder_camera.png")
				showExample:SetTextColor(COLORS["White"])

			end

			-- Open the menu.
			actionsMenu:Open()

		end

		-- description:GetTall takes 1-2 frames to update to the correct height due to SetAutoStretchVertical.
		-- I've discussed this issue in the GMod Coding Discord already and no one seem to know a fix for it.
		optionPanel.Think = function(  )

			-- Calculate the datamodifier xpos.
			local dataModYPos = title:GetTall() + description:GetTall() + EdgeScoreboard.elementMargin * 2

			--  Update the datamodifier position and optionpanel height.
			dataModifier:SetPos(0, dataModYPos)
			optionPanel:SetTall(dataModYPos +  dataModifier:GetTall())
			actionsButton:SetPos(dataModifier:GetWide() - 1, dataModYPos)

			-- Check if the lastDescHeight has stopped changing.
			if lastDescHeight == description:GetTall() then
				optionPanel.Think = function(  ) end
			end

			-- Update lastDescHeight.
			lastDescHeight = description:GetTall()

		end
		
	end

	-- Return the panel.
	return panel

end

-- Create some vars.
local usergroupsWidth = frameWidth * 0.6
local usergroupsHeight = frameHeight * 0.6

-- Create a function for creating the usergroups tab.
local function createUsergroupsTab( parent )

	-- Create the panel.
	local panel = vgui.Create("DPanel",parent)
	panel:SetSize(parent:GetWide() - EdgeScoreboard.elementMargin * 2, parent:GetTall() - EdgeScoreboard.elementMargin * 2)
	panel:SetPos(EdgeScoreboard.elementMargin, EdgeScoreboard.elementMargin)
	panel.Paint = function(  ) end

	panel.groupPanels = {}

	-- Create the listEditorPanel.
	local listEditorPanel = vgui.Create("DPanel",panel)
	listEditorPanel:SetSize(panel:GetWide(), panel:GetTall())
	listEditorPanel.Paint = function( s, w, h )
		draw.SimpleText("Usergroup Settings", "EdgeScoreboard:Config_OptionTitle", w / 2, h * 0.05, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	-- Create the usergroupsList.
	local usergroupsList = vgui.Create("DScrollPanel",listEditorPanel)
	usergroupsList:SetSize(usergroupsWidth, usergroupsHeight)
	usergroupsList:SetPos(listEditorPanel:GetWide() / 2 - usergroupsWidth / 2, listEditorPanel:GetTall() * 0.1)
	EdgeScoreboard.SetEdgeTheme( usergroupsList, true, false )

	usergroupsList.VBar:SetWide(0)

	-- Enable smooth scrolling.
	usergroupsList.VBar.AddScroll = function( _, scroll )

		-- Get the old scrollposition.
		local oldScroll = usergroupsList.VBar:GetScroll()

		-- Animate to the new scrollposition instead of setting it directly.
		usergroupsList.VBar:AnimateTo(oldScroll + scroll * 40, 0.2, 0, 0.5)

		-- Return if we have reached the bottom.
		return oldScroll != usergroupsList.VBar:GetScroll()

	end

	-- Create a list of the currently added usergroups.
	local addedGroups = {}

	-- Create a var if we are currently modifying a usergroup..
	local isModifying = false

	-- Create a function to add a new usergroup.
	local function addUserGroup( usergroup )

		addedGroups[usergroup] = true

		local groupPanel = vgui.Create("DPanel",usergroupsList)
		groupPanel:Dock(TOP)
		groupPanel:SetSize(usergroupsList:GetWide(), usergroupsList:GetTall() * 0.18)
		EdgeScoreboard.SetEdgeTheme( groupPanel, true, true)
		groupPanel.Group = usergroup

		-- Create a table for all the values.
		groupPanel.dataValues = {}

		-- Check if EdgeScoreboard.Configuration.Usergroups[usergroup] exists.
		if EdgeScoreboard.Configuration.Usergroups[usergroup] then
			groupPanel.dataValues = table.Copy(EdgeScoreboard.Configuration.Usergroups[usergroup])
		else
			for k,v in pairs(EdgeScoreboard.ConfigValues.Usergroups) do
				groupPanel.dataValues[k] = v.Default
			end
		end

		-- Create the groupTitle.
		local groupTitle = vgui.Create("DLabel",groupPanel)
		groupTitle:SetText(usergroup)
		groupTitle:SetTextColor(COLORS["White"])
		groupTitle:SetFont("EdgeScoreboard:Config_GroupTitle")
		groupTitle:SetPos(groupPanel:GetWide() * 0.025, groupPanel:GetTall() / 2 - groupTitle:GetTall() / 2)
		groupTitle:SizeToContents()
		groupTitle:SetWide(groupPanel:GetWide() * 0.5)

		-- Create the remove button.
		local removeButton = vgui.Create("DButton", groupPanel)
		removeButton:SetSize(groupPanel:GetWide() * 0.18, groupPanel:GetTall() * 0.6)
		removeButton:SetPos(groupPanel:GetWide() * 0.975 - removeButton:GetWide(), groupPanel:GetTall() / 2 - removeButton:GetTall() / 2)
		removeButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( removeButton, false, false, function( s, w, h )
			draw.SimpleText("Delete", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		removeButton.DoClick = function(  )
			EdgeScoreboard.DermaQuery( "Are you sure that you want to delete this usergroup from the configuration?", {{function(  )
				groupPanel:Remove()
				addedGroups[usergroup] = nil
			end}})
		end

		-- Create the modify button.
		local modifyButton = vgui.Create("DButton", groupPanel)
		modifyButton:SetSize(groupPanel:GetWide() * 0.18, groupPanel:GetTall() * 0.6)
		modifyButton:SetPos(groupPanel:GetWide() * 0.95 - modifyButton:GetWide() * 2, groupPanel:GetTall() / 2 - modifyButton:GetTall() / 2)
		modifyButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( modifyButton, false, false, function( s, w, h )
			draw.SimpleText("Modify", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		modifyButton.DoClick = function(  )

			-- Make sure we arent modiyfing another usergroup.
			if isModifying then return end

			-- Set ismodifying.
			isModifying = true

			-- Move out the listEditorPanel.
			listEditorPanel:MoveTo(-listEditorPanel:GetWide(), 0, 0.4)

			-- Create the listEditorPanel.
			local groupEditorPanel = vgui.Create("DScrollPanel",panel)
			groupEditorPanel:SetSize(panel:GetWide(), panel:GetTall())
			groupEditorPanel:SetPos(listEditorPanel:GetWide(), 0)
			groupEditorPanel:MoveTo(0, 0, 0.4)
			groupEditorPanel.Paint = function(  ) end
			groupEditorPanel.DataModifiers = {}

			groupEditorPanel.VBar:SetWide(0)

			-- Enable smooth scrolling.
			groupEditorPanel.VBar.AddScroll = function( _, scroll )

				-- Get the old scrollposition.
				local oldScroll = groupEditorPanel.VBar:GetScroll()

				-- Animate to the new scrollposition instead of setting it directly.
				groupEditorPanel.VBar:AnimateTo(oldScroll + scroll * 80, 0.2, 0, 0.5)

				-- Return if we have reached the bottom.
				return oldScroll != groupEditorPanel.VBar:GetScroll()

			end

			-- Create an editortitle.
			local editorTitle = vgui.Create("DLabel",groupEditorPanel)
			editorTitle:SetFont("EdgeScoreboard:Config_GroupEditorTitle")
			editorTitle:SetText("Editing Usergroup - " .. usergroup)
			editorTitle:SetTextColor(COLORS["White"])
			editorTitle:SizeToContents()
			editorTitle:Dock(TOP)

			-- Create a returnbutton.
			local returnButton = vgui.Create("DButton",groupEditorPanel)
			returnButton:SetTall(groupEditorPanel:GetTall() * 0.075)
			returnButton:Dock(TOP)
			returnButton:DockMargin(EdgeScoreboard.elementMargin * 0.5, groupEditorPanel:GetTall() * 0.025, groupEditorPanel:GetWide() * 0.8, 0)
			returnButton:SetText("Go Back")
			returnButton:SetTextColor(COLORS["White"])
			returnButton:SetFont("EdgeScoreboard:Config_GroupEditorTReturn")

			EdgeScoreboard.SetEdgeTheme( returnButton, true, false)

			returnButton.DoClick = function(  )

				groupEditorPanel:MoveTo(groupEditorPanel:GetWide(), 0, 0.4, 0, -1, function( _, pnl )

					-- Reset isModifying.
					isModifying = false

					-- Remove the panel.
					pnl:Remove()

				end)

				-- Set the groupPanel pos.
				listEditorPanel:SetPos(-listEditorPanel:GetWide(), 0)

				-- Animate the groupPanel.
				listEditorPanel:MoveTo(0, 0, 0.4)

			end

			-- Calculate the sidemargins.
			local sideMargins = (groupEditorPanel:GetWide() - editorTitle:GetWide()) / 2

			-- Set the editorTitle margins.
			editorTitle:DockMargin(EdgeScoreboard.elementMargin * 0.5, EdgeScoreboard.elementMargin * 0.5, 0, 0)

			-- Loop through EdgeScoreboard.ConfigValues.Config.
			for k,v in SortedPairsByMemberValue(EdgeScoreboard.ConfigValues.Usergroups,"Order",false) do

				--  Create the config panel.
				local optionPanel = vgui.Create("DPanel",groupEditorPanel)
				optionPanel:SetWide(groupEditorPanel:GetWide())
				optionPanel:Dock(TOP)
				optionPanel:DockMargin(EdgeScoreboard.elementMargin * 0.5,groupEditorPanel:GetTall() * 0.025,0,optionMargin)

				-- Create a paint function for the optionPanel.
				optionPanel.Paint = function() end

				-- Create the title of the option
				local title = vgui.Create("DLabel",optionPanel)
				title:SetFont("EdgeScoreboard:Config_OptionTitle")
				title:SetText(v.Title)
				title:SetTextColor(COLORS["White"])
				title:SizeToContents()

				-- Create a desc of the option.
				local description = vgui.Create("DLabel",optionPanel)
				description:SetFont("EdgeScoreboard:Config_OptionDesc")
				description:SetText(v.Description)
				description:SetTextColor(COLORS["White"])
				description:SetWrap(true)
				description:SetPos(0, title:GetTall() + EdgeScoreboard.elementMargin)
				description:SetWide(optionPanel:GetWide())
				description:SetAutoStretchVertical(true)
				description:SetContentAlignment(7)

				-- Create the datamodifier.
				local dataModifier = vgui.Create("EdgeScoreboard:DataModifier",optionPanel)
				dataModifier:SetSize(optionPanel:GetWide() * 0.5,groupEditorPanel:GetTall() * 0.05)
				dataModifier:SetID(k,false,groupPanel.dataValues[k])
				groupEditorPanel.DataModifiers[k] = dataModifier
				
				dataModifier.ValueUpdated = function( value )
					groupPanel.dataValues[k] = value
				end

				-- Create a var for the last DescHeight
				local lastDescHeight = 0

				-- Creae a actions button for each modifier.
				local actionsButton = vgui.Create("DButton",optionPanel)
				actionsButton:SetSize(dataModifier:GetTall(), dataModifier:GetTall())
				actionsButton:SetText("+")
				actionsButton:SetFont("EdgeScoreboard:Config_ActionButton")
				actionsButton:SetTextColor(COLORS["White"])
				EdgeScoreboard.SetEdgeTheme( actionsButton, true, true)

				-- Create the DoClick function for the actionsButton.
				actionsButton.DoClick = function(  )

					-- Create a new dermaPanel.
					local actionsMenu = DermaMenu(actionsButton)
					EdgeScoreboard.SetEdgeTheme(actionsMenu)

					-- Add an option to reset the config to default.
					local resetToDefault = actionsMenu:AddOption("Reset to default", function(  )
						dataModifier.interactElement:SetText(EdgeScoreboard.ConfigValues.Usergroups[k].Default)
						dataModifier.ValueUpdated(EdgeScoreboard.ConfigValues.Usergroups[k].Default)
					end)

					-- Set the icon.
					resetToDefault:SetIcon("icon16/database_refresh.png")
					resetToDefault:SetTextColor(COLORS["White"])

					-- Open the menu.
					actionsMenu:Open()

				end

				-- description:GetTall takes 1-2 frames to update to the correct height due to SetAutoStretchVertical.
				-- I've discussed this issue in the GMod Coding Discord already and no one seem to know a fix for it.
				optionPanel.Think = function(  )

					-- Calculate the datamodifier xpos.
					local dataModYPos = title:GetTall() + description:GetTall() + EdgeScoreboard.elementMargin * 2

					--  Update the datamodifier position and optionpanel height.
					dataModifier:SetPos(0, dataModYPos)
					optionPanel:SetTall(dataModYPos +  dataModifier:GetTall())
					actionsButton:SetPos(dataModifier:GetWide() - 1, dataModYPos)

					-- Check if the lastDescHeight has stopped changing.
					if lastDescHeight == description:GetTall() then
						optionPanel.Think = function(  ) end
					end

					-- Update lastDescHeight.
					lastDescHeight = description:GetTall()

				end
				
			end

		end

		return groupPanel

	end

	-- Loop through EdgeScoreboard.Configuration.Usergroups.
	for k,v in pairs(table.GetKeys(EdgeScoreboard.Configuration.Usergroups)) do

		-- Add the usergroup to the list.
		panel.groupPanels[v] = addUserGroup( v )

	end

	-- Create the add usergroup button.
	local addGroupButton = vgui.Create("DButton",listEditorPanel)
	addGroupButton:SetSize(listEditorPanel:GetWide() * 0.3, listEditorPanel:GetTall() * 0.1)
	addGroupButton:SetPos(listEditorPanel:GetWide() / 2 - addGroupButton:GetWide() / 2, listEditorPanel:GetTall() * 0.9 - addGroupButton:GetTall())
	addGroupButton:SetText("")
	EdgeScoreboard.SetEdgeTheme( addGroupButton, true, false, function( s, w, h )
		draw.SimpleText("Add Group","EdgeScoreboard:Config_AddGroup", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end )

	addGroupButton.DoClick = function(  )

		-- Create a new usergroup.
		EdgeScoreboard.StringRequest( "Enter the name of the rank that you would like to add (Case Sensitive).", "", function( text )
			if text == "" or string.find(text,"^%s+$") or addedGroups[text] == true then return end
			panel.groupPanels[text] = addUserGroup(string.Left(text, 30))
		end)


	end

	-- Return the panel.
	return panel

end

-- Create a function for creating the usergroups tab.
local function createTeamsTab( parent )

	-- Create the panel.
	local panel = vgui.Create("DPanel",parent)
	panel:SetSize(parent:GetWide() - EdgeScoreboard.elementMargin * 2, parent:GetTall() - EdgeScoreboard.elementMargin * 2)
	panel:SetPos(EdgeScoreboard.elementMargin, EdgeScoreboard.elementMargin)
	panel.Paint = function(  ) end

	panel.groupPanels = {}

	local columnWidth = usergroupsWidth / 2 - EdgeScoreboard.elementMargin / 2

	-- Create the listEditorPanel.
	local listEditorPanel = vgui.Create("DPanel",panel)
	listEditorPanel:SetSize(panel:GetWide(), panel:GetTall())
	listEditorPanel.Paint = function( s, w, h )
		draw.SimpleText("Hidden Teams", "EdgeScoreboard:Config_OptionTitle", w / 2 - columnWidth / 2, h * 0.05, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText("Team Order", "EdgeScoreboard:Config_OptionTitle", w / 2 + columnWidth / 2, h * 0.05, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	-- Create the hiddenTeamList.
	local hiddenTeamList = vgui.Create("DScrollPanel",listEditorPanel)
	hiddenTeamList:SetSize(columnWidth, usergroupsHeight)
	hiddenTeamList:SetPos(listEditorPanel:GetWide() / 2 - columnWidth - EdgeScoreboard.elementMargin / 2, listEditorPanel:GetTall() * 0.1)
	EdgeScoreboard.SetEdgeTheme( hiddenTeamList, true, false )

	hiddenTeamList.VBar:SetWide(0)

	-- Enable smooth scrolling.
	hiddenTeamList.VBar.AddScroll = function( _, scroll )

		-- Get the old scrollposition.
		local oldScroll = hiddenTeamList.VBar:GetScroll()

		-- Animate to the new scrollposition instead of setting it directly.
		hiddenTeamList.VBar:AnimateTo(oldScroll + scroll * 40, 0.2, 0, 0.5)

		-- Return if we have reached the bottom.
		return oldScroll != hiddenTeamList.VBar:GetScroll()

	end

	-- Create a list of the currently added usergroups.
	local hiddenTeams = {}

	-- Create a function to add a new team.
	local function addHiddenTeam(teamName)

		local teamPanel = vgui.Create("DPanel",hiddenTeamList)
		teamPanel:Dock(TOP)
		teamPanel:SetSize(hiddenTeamList:GetWide(), hiddenTeamList:GetTall() * 0.15)
		EdgeScoreboard.SetEdgeTheme( teamPanel, true, true)
		teamPanel.Team = teamName
		teamPanel.glowAlpha = 0

		teamPanel.PaintOver = function( s,w,h )
			surface.SetDrawColor(32, 136, 227, teamPanel.glowAlpha)
			surface.DrawRect(0, 0, w, h)
			teamPanel.glowAlpha = Lerp(FrameTime() * 3, teamPanel.glowAlpha, 0)
		end

		hiddenTeams[teamName] = teamPanel

		-- Create the teamTitle.
		local teamTitle = vgui.Create("DLabel",teamPanel)
		teamTitle:SetText(teamName)
		teamTitle:SetTextColor(COLORS["White"])
		teamTitle:SetFont("EdgeScoreboard:Config_GroupTitle")
		teamTitle:SetPos(teamPanel:GetWide() * 0.025, teamPanel:GetTall() / 2 - teamTitle:GetTall() / 2)
		teamTitle:SizeToContents()
		teamTitle:SetWide(teamPanel:GetWide() * 0.75)

		-- Create the remove button.
		local removeButton = vgui.Create("DButton", teamPanel)
		removeButton:SetSize(teamPanel:GetTall() * 0.6, teamPanel:GetTall() * 0.6)
		removeButton:SetPos(teamPanel:GetWide() * 0.975 - removeButton:GetWide(), teamPanel:GetTall() / 2 - removeButton:GetTall() / 2)
		removeButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( removeButton, false, false, function( s, w, h )
			draw.SimpleText("✖", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		removeButton.DoClick = function(  )
			teamPanel:Remove()
			hiddenTeams[teamName] = nil
		end

		return teamPanel

	end

	for k,v in pairs(EdgeScoreboard.Configuration.HiddenTeams) do
		addHiddenTeam(v)
	end

	-- Create the hiddenTeamList.
	local orderTeamList = vgui.Create("DScrollPanel",listEditorPanel)
	orderTeamList:SetSize(columnWidth, usergroupsHeight)
	orderTeamList:SetPos(listEditorPanel:GetWide() / 2 + EdgeScoreboard.elementMargin / 2, listEditorPanel:GetTall() * 0.1)
	EdgeScoreboard.SetEdgeTheme( orderTeamList, true, false )

	orderTeamList.VBar:SetWide(0)

	-- Enable smooth scrolling.
	orderTeamList.VBar.AddScroll = function( _, scroll )

		-- Get the old scrollposition.
		local oldScroll = orderTeamList.VBar:GetScroll()

		-- Animate to the new scrollposition instead of setting it directly.
		orderTeamList.VBar:AnimateTo(oldScroll + scroll * 40, 0.2, 0, 0.5)

		-- Return if we have reached the bottom.
		return oldScroll != orderTeamList.VBar:GetScroll()

	end

	-- Create a list of the currently added usergroups.
	local orderedTeamsZIndexes = {}
	local orderedTeams = {}

	-- Create a function to add a new team.
	local function addOrderedTeam(teamName)

		local teamPanel = vgui.Create("DPanel",orderTeamList)
		teamPanel:Dock(TOP)
		teamPanel:SetSize(orderTeamList:GetWide(), orderTeamList:GetTall() * 0.15)
		EdgeScoreboard.SetEdgeTheme( teamPanel, true, true)
		teamPanel.Team = teamName
		teamPanel.zIndex = table.Count(orderedTeamsZIndexes) + 1
		teamPanel:SetZPos(teamPanel.zIndex)
		teamPanel.glowAlpha = 0

		teamPanel.PaintOver = function( s,w,h )
			surface.SetDrawColor(32, 136, 227, teamPanel.glowAlpha)
			surface.DrawRect(0, 0, w, h)
			teamPanel.glowAlpha = Lerp(FrameTime() * 3, teamPanel.glowAlpha, 0)
		end

		orderedTeamsZIndexes[teamPanel.zIndex] = teamPanel
		orderedTeams[teamName] = teamPanel

		-- Create the teamTitle.
		local teamTitle = vgui.Create("DLabel",teamPanel)
		teamTitle:SetText(teamName)
		teamTitle:SetTextColor(COLORS["White"])
		teamTitle:SetFont("EdgeScoreboard:Config_GroupTitle")
		teamTitle:SetPos(teamPanel:GetWide() * 0.025, teamPanel:GetTall() / 2 - teamTitle:GetTall() / 2)
		teamTitle:SizeToContents()
		teamTitle:SetWide(teamPanel:GetWide() * 0.5)

		local downButton = vgui.Create("DButton", teamPanel)
		downButton:SetSize(teamPanel:GetTall() * 0.6, teamPanel:GetTall() * 0.6)
		downButton:SetPos(teamPanel:GetWide() * 0.975 - downButton:GetWide(), teamPanel:GetTall() / 2 - downButton:GetTall() / 2)
		downButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( downButton, false, false, function( s, w, h )
			draw.SimpleText("▼", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		downButton.DoClick = function(  )
			if teamPanel.zIndex == #orderedTeamsZIndexes then return end

			-- Get the panel below.
			local belowValue = table.Copy(orderedTeamsZIndexes)[teamPanel.zIndex + 1]

			-- Update the ZIndexes.
			teamPanel.zIndex = teamPanel.zIndex + 1
			belowValue.zIndex = belowValue.zIndex - 1

			-- Update the orders.
			orderedTeamsZIndexes[teamPanel.zIndex] = teamPanel
			orderedTeamsZIndexes[belowValue.zIndex] = belowValue

			-- Update the ZPos
			teamPanel:SetZPos(teamPanel.zIndex)
			belowValue:SetZPos(belowValue.zIndex)

			orderTeamList:ScrollToChild(teamPanel,0)

			teamPanel.glowAlpha = 50

		end

		-- Create the remove button.
		local upButton = vgui.Create("DButton", teamPanel)
		upButton:SetSize(teamPanel:GetTall() * 0.6, teamPanel:GetTall() * 0.6)
		upButton:SetPos(teamPanel:GetWide() * 0.95 - upButton:GetWide() * 2, teamPanel:GetTall() / 2 - upButton:GetTall() / 2)
		upButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( upButton, false, false, function( s, w, h )
			draw.SimpleText("▲", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		upButton.DoClick = function(  )

			if teamPanel.zIndex == 1 then return end

			-- Get the panel below.
			local aboveValue = table.Copy(orderedTeamsZIndexes)[teamPanel.zIndex - 1]

			-- Update the ZIndexes.
			teamPanel.zIndex = teamPanel.zIndex - 1
			aboveValue.zIndex = aboveValue.zIndex + 1

			-- Update the orders.
			orderedTeamsZIndexes[teamPanel.zIndex] = teamPanel
			orderedTeamsZIndexes[aboveValue.zIndex] = aboveValue

			-- Update the ZPos
			teamPanel:SetZPos(teamPanel.zIndex)
			aboveValue:SetZPos(aboveValue.zIndex)

			orderTeamList:ScrollToChild(teamPanel,0)

			teamPanel.glowAlpha = 50

		end

		-- Create the remove button.
		local removeButton = vgui.Create("DButton", teamPanel)
		removeButton:SetSize(teamPanel:GetTall() * 0.6, teamPanel:GetTall() * 0.6)
		removeButton:SetPos(teamPanel:GetWide() * 0.925 - downButton:GetWide() * 3, teamPanel:GetTall() / 2 - removeButton:GetTall() / 2)
		removeButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( removeButton, false, false, function( s, w, h )
			draw.SimpleText("✖", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		removeButton.DoClick = function(  )

			teamPanel:Remove()
			orderedTeamsZIndexes[teamPanel.zIndex] = nil
			orderedTeams[teamName] = nil
			orderedTeamsZIndexes =  table.ClearKeys(orderedTeamsZIndexes)

			for k,v in pairs(orderedTeamsZIndexes) do
				v.zIndex = k
				v:SetZPos(v.zIndex)
			end

		end

		return teamPanel

	end

	for k,v in pairs(EdgeScoreboard.Configuration.OrderedTeams) do
		addOrderedTeam(v)
	end

	-- Create the add team button.
	local addTeamButton = vgui.Create("DButton",listEditorPanel)
	addTeamButton:SetSize(listEditorPanel:GetWide() * 0.3, listEditorPanel:GetTall() * 0.1)
	addTeamButton:SetPos(listEditorPanel:GetWide() / 2 - addTeamButton:GetWide() / 2, listEditorPanel:GetTall() * 0.9 - addTeamButton:GetTall())
	addTeamButton:SetText("")
	EdgeScoreboard.SetEdgeTheme( addTeamButton, true, false, function( s, w, h )
		draw.SimpleText("Add Team","EdgeScoreboard:Config_AddGroup", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end )

	addTeamButton.DoClick = function(  )

		-- Create the menu.
		local menu = DermaMenu(addTeamButton)
		EdgeScoreboard.SetEdgeTheme(menu)

		-- Add the submenu for the hidden teams.
		local addHidden_sm, addHidden_option = menu:AddSubMenu( "Hide Team" )
		EdgeScoreboard.SetEdgeTheme(addHidden_sm)
		addHidden_option:SetIcon("icon16/group_delete.png")
		addHidden_option:SetTextColor(COLORS["White"])

		-- Add the submenu for the ordered teams.
		local addOrdered_sm, addOrdered_option = menu:AddSubMenu( "Order Team" )
		EdgeScoreboard.SetEdgeTheme(addOrdered_sm)
		addOrdered_option:SetIcon("icon16/group_gear.png")
		addOrdered_option:SetTextColor(COLORS["White"])

		-- Loop through hiddenTeams.
		for k,v in pairs(team.GetAllTeams()) do

			if hiddenTeams[v.Name] == nil then

				-- Add the team
				local option = addHidden_sm:AddOption(team.GetName(k), function(  )
					local panel = addHiddenTeam(v.Name)
					panel.glowAlpha = 50
					timer.Simple(0,function(  )
						if !IsValid(panel) or !IsValid(hiddenTeamList) then return end
						hiddenTeamList:ScrollToChild(panel)
					end)
				end)
				option:SetIcon("icon16/user.png")
				option:SetTextColor(COLORS["White"])

			end

			if orderedTeams[v.Name] == nil then

				local option = addOrdered_sm:AddOption(v.Name, function(  )
					local panel = addOrderedTeam(v.Name)
					panel.glowAlpha = 50
					timer.Simple(0,function(  )
						if !IsValid(panel) or !IsValid(orderTeamList) then return end
						orderTeamList:ScrollToChild(panel)
					end)
				end)
				option:SetIcon("icon16/user.png")
				option:SetTextColor(COLORS["White"])

			end

		end

		-- Check if we are on DarkRP.
		if DarkRP then

			-- Add the submenu for the ordered teams.
			local addOrderedCategory_sm, addOrderedCategory_option = menu:AddSubMenu( "Order DarkRP Category" )
			EdgeScoreboard.SetEdgeTheme(addOrderedCategory_sm)
			addOrderedCategory_option:SetIcon("icon16/group_gear.png")
			addOrderedCategory_option:SetTextColor(COLORS["White"])

			for k,v in pairs(DarkRP.getCategories()["jobs"]) do

				if orderedTeams[v.name] == nil then

					local option = addOrderedCategory_sm:AddOption(v.name, function(  )
						local panel = addOrderedTeam(v.name)
						panel.glowAlpha = 50
						timer.Simple(0,function(  )
							if !IsValid(panel) or !IsValid(orderTeamList) then return end
							orderTeamList:ScrollToChild(panel)
						end)
					end)
					option:SetIcon("icon16/group.png")
					option:SetTextColor(COLORS["White"])

				end

			end

		end

		-- Open the menu
		menu:Open()

	end

	-- Create a function to get the data.
	panel.GetData = function(  )

		local hidden = {}
		local ordered = {}

		for k,v in pairs(hiddenTeams) do
			table.insert(hidden, v.Team)
		end

		for k,v in pairs(orderedTeamsZIndexes) do
			table.insert(ordered, v.Team)
		end

		return hidden, ordered

	end

	-- Return the panel.
	return panel

end

-- Create a function for creating the usergroups tab.
local function createServersTab( parent )

	-- Create the panel.
	local panel = vgui.Create("DPanel",parent)
	panel:SetSize(parent:GetWide() - EdgeScoreboard.elementMargin * 2, parent:GetTall() - EdgeScoreboard.elementMargin * 2)
	panel:SetPos(EdgeScoreboard.elementMargin, EdgeScoreboard.elementMargin)
	panel.Paint = function(  ) end

	-- Create the listEditorPanel.
	local listEditorPanel = vgui.Create("DPanel",panel)
	listEditorPanel:SetSize(panel:GetWide(), panel:GetTall())
	listEditorPanel.Paint = function( s, w, h )
		draw.SimpleText("Server List", "EdgeScoreboard:Config_OptionTitle", w / 2, h * 0.05, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	-- Create the serversList.
	local serversList = vgui.Create("DScrollPanel",listEditorPanel)
	serversList:SetSize(usergroupsWidth, usergroupsHeight)
	serversList:SetPos(listEditorPanel:GetWide() / 2 - usergroupsWidth / 2, listEditorPanel:GetTall() * 0.1)
	EdgeScoreboard.SetEdgeTheme( serversList, true, false )

	serversList.VBar:SetWide(0)

	-- Enable smooth scrolling.
	serversList.VBar.AddScroll = function( _, scroll )

		-- Get the old scrollposition.
		local oldScroll = serversList.VBar:GetScroll()

		-- Animate to the new scrollposition instead of setting it directly.
		serversList.VBar:AnimateTo(oldScroll + scroll * 40, 0.2, 0, 0.5)

		-- Return if we have reached the bottom.
		return oldScroll != serversList.VBar:GetScroll()

	end

	-- Create a var if we are currently modifying a usergroup..
	local isModifying = false

	-- Create a list of the currently added servers.
	local orderedServersZIndexes = {}
	local addedServers = {}

	local serverFields = {
		{Title = "IP Address", Description = "The ip address used to connect to this server.", Default = "00.00.000.00"},
		{Title = "Address Port", Description = "The port used to connect to this IP address.", Default = "27015"},
		{Title = "Map", Description = "The map that is being played on this server.", Default = "gm_construct"},
		{Title = "Gamemode", Description = "The gamemode that is being played on this server.", Default = "DarkRP"},
		{Title = "Player Slots", Description = "The number of player slots that this server has.", Default = "32"},
	}

	-- Create a function to add a new usergroup.
	local function addServer( serverName )

		local serverPanel = vgui.Create("DPanel",serversList)
		serverPanel:Dock(TOP)
		serverPanel:SetSize(serversList:GetWide(), serversList:GetTall() * 0.18)
		EdgeScoreboard.SetEdgeTheme( serverPanel, true, true)
		serverPanel.ServerName = serverName
		serverPanel.zIndex = table.Count(orderedServersZIndexes) + 1
		serverPanel:SetZPos(serverPanel.zIndex)

		addedServers[serverName] = serverPanel
		orderedServersZIndexes[serverPanel.zIndex] = serverPanel

		-- Create a table for all the values.
		serverPanel.dataValues = {}

		-- Add the required values.
		for k,v in pairs(serverFields) do
			serverPanel.dataValues[v.Title] = v.Default
		end

		-- Create the serverTitle.
		local serverTitle = vgui.Create("DLabel",serverPanel)
		serverTitle:SetText(serverName)
		serverTitle:SetTextColor(COLORS["White"])
		serverTitle:SetFont("EdgeScoreboard:Config_GroupTitle")
		serverTitle:SetPos(serverPanel:GetWide() * 0.025, serverPanel:GetTall() / 2 - serverTitle:GetTall() / 2)
		serverTitle:SizeToContents()
		serverTitle:SetWide(serverPanel:GetWide() * 0.4)

		-- Create the remove button.
		local removeButton = vgui.Create("DButton", serverPanel)
		removeButton:SetSize(serverPanel:GetWide() * 0.18, serverPanel:GetTall() * 0.6)
		removeButton:SetPos(serverPanel:GetWide() * 0.975 - removeButton:GetWide(), serverPanel:GetTall() / 2 - removeButton:GetTall() / 2)
		removeButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( removeButton, false, false, function( s, w, h )
			draw.SimpleText("Delete", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		removeButton.DoClick = function(  )
			EdgeScoreboard.DermaQuery( "Are you sure that you want to delete this server from the configuration?", {{function(  )
				orderedServersZIndexes[serverPanel.zIndex] = nil
				addedServers[serverName] = nil
				orderedServersZIndexes = table.ClearKeys(orderedServersZIndexes)
				serverPanel:Remove()

				for k,v in pairs(orderedServersZIndexes) do
					v.zIndex = k
					v:SetZPos(v.zIndex)
				end

			end}})
		end

		-- Create the modify button.
		local modifyButton = vgui.Create("DButton", serverPanel)
		modifyButton:SetSize(serverPanel:GetWide() * 0.18, serverPanel:GetTall() * 0.6)
		modifyButton:SetPos(serverPanel:GetWide() * 0.95 - modifyButton:GetWide() * 2, serverPanel:GetTall() / 2 - modifyButton:GetTall() / 2)
		modifyButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( modifyButton, false, false, function( s, w, h )
			draw.SimpleText("Modify", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)

		modifyButton.DoClick = function(  )

			-- Make sure we arent modiyfing another serverName.
			if isModifying then return end

			-- Set ismodifying.
			isModifying = true

			-- Move out the listEditorPanel.
			listEditorPanel:MoveTo(-listEditorPanel:GetWide(), 0, 0.4)

			-- Create the listEditorPanel.
			local serverEditorPanel = vgui.Create("DScrollPanel",panel)
			serverEditorPanel:SetSize(panel:GetWide(), panel:GetTall())
			serverEditorPanel:SetPos(listEditorPanel:GetWide(), 0)
			serverEditorPanel:MoveTo(0, 0, 0.4)
			serverEditorPanel.Paint = function(  ) end
			serverEditorPanel.DataModifiers = {}

			serverEditorPanel.VBar:SetWide(0)

			-- Enable smooth scrolling.
			serverEditorPanel.VBar.AddScroll = function( _, scroll )

				-- Get the old scrollposition.
				local oldScroll = serverEditorPanel.VBar:GetScroll()

				-- Animate to the new scrollposition instead of setting it directly.
				serverEditorPanel.VBar:AnimateTo(oldScroll + scroll * 40, 0.2, 0, 0.5)

				-- Return if we have reached the bottom.
				return oldScroll != serverEditorPanel.VBar:GetScroll()

			end

			-- Create an editortitle.
			local editorTitle = vgui.Create("DLabel",serverEditorPanel)
			editorTitle:SetFont("EdgeScoreboard:Config_GroupEditorTitle")
			editorTitle:SetText("Editing Server - " .. serverName)
			editorTitle:SetTextColor(COLORS["White"])
			editorTitle:SizeToContents()
			editorTitle:Dock(TOP)

			-- Create a returnbutton.
			local returnButton = vgui.Create("DButton",serverEditorPanel)
			returnButton:SetTall(serverEditorPanel:GetTall() * 0.075)
			returnButton:Dock(TOP)
			returnButton:DockMargin(EdgeScoreboard.elementMargin * 0.5, serverEditorPanel:GetTall() * 0.025, serverEditorPanel:GetWide() * 0.8, 0)
			returnButton:SetText("Go Back")
			returnButton:SetTextColor(COLORS["White"])
			returnButton:SetFont("EdgeScoreboard:Config_GroupEditorTReturn")

			EdgeScoreboard.SetEdgeTheme( returnButton, true, false)

			returnButton.DoClick = function(  )

				serverEditorPanel:MoveTo(serverEditorPanel:GetWide(), 0, 0.4, 0, -1, function( _, pnl )

					-- Reset isModifying.
					isModifying = false

					-- Remove the panel.
					pnl:Remove()

				end)

				-- Set the serverPanel pos.
				listEditorPanel:SetPos(-listEditorPanel:GetWide(), 0)

				-- Animate the serverPanel.
				listEditorPanel:MoveTo(0, 0, 0.4)

			end

			-- Calculate the sidemargins.
			local sideMargins = (serverEditorPanel:GetWide() - editorTitle:GetWide()) / 2

			-- Set the editorTitle margins.
			editorTitle:DockMargin(EdgeScoreboard.elementMargin * 0.5, EdgeScoreboard.elementMargin * 0.5, 0, 0)

			-- Loop through EdgeScoreboard.ConfigValues.Config.
			for k,v in pairs(serverFields) do

				--  Create the config panel.
				local optionPanel = vgui.Create("DPanel",serverEditorPanel)
				optionPanel:SetWide(serverEditorPanel:GetWide())
				optionPanel:Dock(TOP)
				optionPanel:DockMargin(EdgeScoreboard.elementMargin * 0.5,serverEditorPanel:GetTall() * 0.025,0,optionMargin / 2)

				-- Create a paint function for the optionPanel.
				optionPanel.Paint = function() end

				-- Create the title of the option
				local title = vgui.Create("DLabel",optionPanel)
				title:SetFont("EdgeScoreboard:Config_OptionTitle")
				title:SetText(v.Title)
				title:SetTextColor(COLORS["White"])
				title:SizeToContents()

				-- Create a desc of the option.
				local description = vgui.Create("DLabel",optionPanel)
				description:SetFont("EdgeScoreboard:Config_OptionDesc")
				description:SetText(v.Description)
				description:SetTextColor(COLORS["White"])
				description:SizeToContents()
				description:SetPos(0, title:GetTall() + EdgeScoreboard.elementMargin)

				-- Create the datamodifier.
				local dataModifier = vgui.Create("DTextEntry",optionPanel)
				dataModifier:SetSize(optionPanel:GetWide() * 0.5,serverEditorPanel:GetTall() * 0.05)
				dataModifier:SetPos(0, title:GetTall() + description:GetTall() + EdgeScoreboard.elementMargin * 2)
				dataModifier:SetText(serverPanel.dataValues[v.Title])
				EdgeScoreboard.SetEdgeTheme(dataModifier, true, true)

				dataModifier.OnChange = function(  )
					serverPanel.dataValues[v.Title] = dataModifier:GetText()
				end
				
				optionPanel:SetTall(optionPanel:GetTall() + description:GetTall() + dataModifier:GetTall() + EdgeScoreboard.elementMargin * 2)

			end

		end

		local downButton = vgui.Create("DButton", serverPanel)
		downButton:SetSize(serverPanel:GetTall() * 0.6, serverPanel:GetTall() * 0.6)
		downButton:SetPos(serverPanel:GetWide() * 0.925 - modifyButton:GetWide() * 2 - downButton:GetWide(), serverPanel:GetTall() / 2 - downButton:GetTall() / 2)
		downButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( downButton, false, false, function( s, w, h )
			draw.SimpleText("▼", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		downButton.DoClick = function(  )

			if serverPanel.zIndex == #orderedServersZIndexes then return end

			-- Get the panel below.
			local belowValue = table.Copy(orderedServersZIndexes)[serverPanel.zIndex + 1]

			-- Update the ZIndexes.
			serverPanel.zIndex = serverPanel.zIndex + 1
			belowValue.zIndex = belowValue.zIndex - 1

			-- Update the orders.
			orderedServersZIndexes[serverPanel.zIndex] = serverPanel
			orderedServersZIndexes[belowValue.zIndex] = belowValue

			-- Update the ZPos
			serverPanel:SetZPos(serverPanel.zIndex)
			belowValue:SetZPos(belowValue.zIndex)

			serversList:ScrollToChild(serverPanel,0)

		end

		-- Create the remove button.
		local upButton = vgui.Create("DButton", serverPanel)
		upButton:SetSize(serverPanel:GetTall() * 0.6, serverPanel:GetTall() * 0.6)
		upButton:SetPos(serverPanel:GetWide() * 0.9 - modifyButton:GetWide() * 2 - downButton:GetWide() * 2, serverPanel:GetTall() / 2 - downButton:GetTall() / 2)
		upButton:SetText("")
		EdgeScoreboard.SetEdgeTheme( upButton, false, false, function( s, w, h )
			draw.SimpleText("▲", "EdgeScoreboard:Config_GroupButton", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end)
		upButton.DoClick = function(  )

			if serverPanel.zIndex == 1 then return end

			-- Get the panel below.
			local aboveValue = table.Copy(orderedServersZIndexes)[serverPanel.zIndex - 1]

			-- Update the ZIndexes.
			serverPanel.zIndex = serverPanel.zIndex - 1
			aboveValue.zIndex = aboveValue.zIndex + 1

			-- Update the orders.
			orderedServersZIndexes[serverPanel.zIndex] = serverPanel
			orderedServersZIndexes[aboveValue.zIndex] = aboveValue

			-- Update the ZPos
			serverPanel:SetZPos(serverPanel.zIndex)
			aboveValue:SetZPos(aboveValue.zIndex)

			serversList:ScrollToChild(serverPanel,0)

		end

		return serverPanel

	end

	-- Add servers.
	for k,v in pairs(EdgeScoreboard.Configuration.Servers) do

		local serverPanel = addServer( v.Name )

		serverPanel.dataValues["IP Address"] = v.Address
		serverPanel.dataValues["Address Port"] = v.Port
		serverPanel.dataValues["Map"] = v.Map
		serverPanel.dataValues["Gamemode"] = v.Gamemode
		serverPanel.dataValues["Player Slots"] = v.Slots

	end

	-- Create the add serverName button.
	local addServerButton = vgui.Create("DButton",listEditorPanel)
	addServerButton:SetSize(listEditorPanel:GetWide() * 0.3, listEditorPanel:GetTall() * 0.1)
	addServerButton:SetPos(listEditorPanel:GetWide() / 2 - addServerButton:GetWide() / 2, listEditorPanel:GetTall() * 0.9 - addServerButton:GetTall())
	addServerButton:SetText("")
	EdgeScoreboard.SetEdgeTheme( addServerButton, true, false, function( s, w, h )
		draw.SimpleText("Add Server","EdgeScoreboard:Config_AddGroup", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end )

	addServerButton.DoClick = function(  )

		-- Create a new serverName.
		EdgeScoreboard.StringRequest( "Enter the name of the server that you would like to add (Case Sensitive).", "DarkRP Server", function( text )
			if text == "" or string.find(text,"^%s+$") or addedServers[text] == true then return end
			addServer(string.Left(text, 45))
		end)

	end

	-- Create a function to get the data.
	panel.GetData = function(  )

		local servers = {}

		for k,v in pairs(orderedServersZIndexes) do
			table.insert(servers, {
				Name = v.ServerName,
				Address = v.dataValues["IP Address"],
				Port = v.dataValues["Address Port"],
				Map = v.dataValues["Map"],
				Gamemode = v.dataValues["Gamemode"],
				Slots = v.dataValues["Player Slots"],
			})
		end

		return servers

	end

	-- Return the panel.
	return panel

end

-- Create a function to open the configuration.
function EdgeScoreboard.OpenConfig(  )

	--Check so the player is the owner of the addon or has config access.
	if EdgeScoreboard.Owner != LocalPlayer():SteamID64() and !EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "ConfigurationAccess" ) then

		local allowedRanks = {}

		table.insert(allowedRanks, util.SteamIDFrom64(EdgeScoreboard.Owner))

		for k,v in pairs(EdgeScoreboard.Configuration.Usergroups) do
			if v["ConfigurationAccess"] then
				table.insert(allowedRanks, string.Left(k, 1) .. string.Right(k, #k - 1))
			end
		end

		local allowedText = table.concat(allowedRanks, ", ")

		EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_NOTI, "You have no access to the EdgeScoreboard configuration. (Access: " .. allowedText .. ")" )
		return
	end

	-- Create the window.
	local frame = vgui.Create("DFrame")
	frame:SetSize(frameWidth, frameHeight)
	frame:Center()
	frame:MakePopup()
	frame:SetTitle("")
	frame:ShowCloseButton(false)
	frame.Paint = function (  )end
	EdgeScoreboard.RegisterElement( "Config", frame )

	-- Create a var for the active tab.
	local activeTab

	-- Create the sidebar.
	local sidebar = vgui.Create("DPanel", frame)
	sidebar:SetSize(sidebarWidth,frame:GetTall())
	EdgeScoreboard.SetEdgeTheme( sidebar)

	-- Create the actionsarea.
	local actionsArea = vgui.Create("DPanel",frame)
	actionsArea:SetSize(frame:GetWide() - sidebarWidth - EdgeScoreboard.elementMargin,frame:GetTall())
	actionsArea:SetPos(frame:GetWide() - actionsArea:GetWide())
	EdgeScoreboard.SetEdgeTheme(actionsArea)

	-- Give local sidebarItems a bigger scope.
	local sidebarItems

	-- Create a function to save the config.
	local function saveConfig( )

		-- Create a table for the new config.
		local newConfig = {}

		-- Loop throufg sidebarItems[1].panel.DataModifiers
		for k,v in pairs(sidebarItems[1].panel.DataModifiers) do
			newConfig[k] = v:GetValue()
		end

		-- Create a table for the usergroups.
		local newUsergroups = {}

		-- Loop through the usergroups-elements
		for k,v in pairs(sidebarItems[2].panel.groupPanels) do

			-- Make sure the element is valid.
			if !IsValid(v) then continue end

			-- Create the table for the usergroup.
			newUsergroups[v.Group] = {}

			-- Loop through the data.
			for k2,v2 in pairs(v.dataValues) do

				-- Insert the value.
				newUsergroups[v.Group][k2] = v2

			end
			
		end

		-- Get the hidden and ordered teams.
		local hiddenTeams, orderedTeams = sidebarItems[3].panel.GetData()

		-- Check if the usergroup of the player has config access.
		if (!newUsergroups[LocalPlayer():GetUserGroup()] or newUsergroups[LocalPlayer():GetUserGroup()].ConfigurationAccess == false) and LocalPlayer():SteamID64() != EdgeScoreboard.Owner then

			-- Ask the user if the config should be saved.
			EdgeScoreboard.DermaQuery( "You have removed configuration access from your current usergroup. Are you sure you want to save the configuration?", {
				{ function(  )

					-- Start sending the message.
					net.Start("EdgeScoreboard:SendConfig")
						net.WriteTable({
							Config = newConfig,
							Usergroups = newUsergroups,
							Teams = {Hidden = hiddenTeams,Ordered = orderedTeams},
							Servers = sidebarItems[4].panel.GetData()
						})
					net.SendToServer()

					-- Remove the frame.
					frame:Remove()

				end, "Yes"}, 
				{ function(  ) end, "No"},
			})

		else

			-- Start sending the message.
			net.Start("EdgeScoreboard:SendConfig")
				net.WriteTable({
					Config = newConfig,
					Usergroups = newUsergroups,
					Teams = {Hidden = hiddenTeams,Ordered = orderedTeams},
					Servers = sidebarItems[4].panel.GetData()
				})
			net.SendToServer()

			-- Remove the frame.
			frame:Remove()

		end

	end

	-- Create a function to discard the cahnges
	local function discardConfig( )

		-- Tell the player that nothing was saved-
		EdgeScoreboard.Notify(EDGESCOREBOARD_NOTIFY_CHAT, "No changes were saved to the configuration.")

		-- Remove the frame.
		frame:Remove()

	end

	local actionButtons = {
		{Title = "Reset Config", Icon = "icon16/drive_error.png", DoClick = function(  )

			-- Generate 2 random numbers
			local num1, num2 = math.random(1,10), math.random(1,10)

			-- Math question.
			EdgeScoreboard.StringRequest( "Please enter the answer of " .. num1 .. " + " .. num2 .. " to reset the EdgeScoreboard configuration.", "", function( text )

				-- Make the text a number.
				text = tonumber(text)

				-- Check if the answer was correct.
				if !text or text != num1 + num2 then
					EdgeScoreboard.ShowMessage( "Please answer the math question correctly to reset the configuration." )
					return
				end

				-- Send an empty config.
				net.Start("EdgeScoreboard:ResetConfig")
				net.SendToServer()

				-- Close the configuration.
				frame:Remove()

			end)

		end},
		{Title = "Export Config", Icon = "icon16/disk_multiple.png", DoClick = function(  )

			-- Copy the config.
			SetClipboardText(util.TableToJSON(EdgeScoreboard.Configuration))

			-- Tell teh player.
			EdgeScoreboard.ShowMessage( "The current configuration has been copied to your clipboard." )

		end},
		{Title = "Import Config", Icon = "icon16/drive_go.png", DoClick = function(  )

			-- Math question.
			EdgeScoreboard.StringRequest( "Paste (Ctrl + v) the configuration that was copied when exporting the configuration.", "", function( text )

				-- Make the text a number.
				local configData = util.JSONToTable(text)

				-- Check if the answer was correct.
				if !configData or !configData.Config or !configData.Usergroups or !configData.Servers or !configData.HiddenTeams or !configData.OrderedTeams then
					EdgeScoreboard.ShowMessage( "Invalid configuration entered." )
					return
				end

				net.Start("EdgeScoreboard:SendConfig")
					net.WriteTable({
						Config = configData.Config,
						Usergroups = configData.Usergroups,
						Teams = {Hidden = configData.HiddenTeams,Ordered = configData.OrderedTeams},
						Servers = configData.Servers
					})
				net.SendToServer()

				-- Close the configuration.
				frame:Remove()

			end)

		end},
		{Title = "Leave Review", Icon = "icon16/award_star_gold_1.png", DoClick = function(  )
			gui.OpenURL("https://www.gmodstore.com/market/view/6526#add-review")
		end},
	}

	-- Create a table for the sidebarItems.
	sidebarItems = {
		{Title = "Global Settings", Description = "Here you can configure the addon to your liking.", createPanel = createGlobalTab},
		{Title = "Usergroups Settings", Description = "Here you can restrict certain ranks from some scoreboard actions.", createPanel = createUsergroupsTab},
		{Title = "Team Settings", Description = "Here you can hide teams from the scoreboard and choose how they should be sorted.", createPanel = createTeamsTab},
		{Title = "Server List", Description = "Here you can configure which servers should be visible in the servers tab.", createPanel = createServersTab},
		{Title = "Actions", onClick = function ( panel )

			-- Create the menu
			local actionsMenu = DermaMenu(panel)
			EdgeScoreboard.SetEdgeTheme(actionsMenu)

			-- Loop through the actionButtons.
			for k,v in pairs(actionButtons) do

				local option = actionsMenu:AddOption(v.Title, v.DoClick)
				option:SetIcon(v.Icon)
				option:SetTextColor(COLORS["White"])

			end

			-- Open the menu.
			actionsMenu:Open()

		end},
		{Title = "Exit", onClick = function (  )

			-- Ask the user if the config should be saved.
			EdgeScoreboard.DermaQuery( "Would you like to save the changes made to the configuration?", {
				{ saveConfig, "Save Changes"}, 
				{ discardConfig, "Discard Changes"},
				{ function(  ) end, "Cancel" }
			})

		end}
	}

	-- Calculate the buttonMargin.
	local buttonMargin = math.Round(sidebar:GetWide() * 0.05)

	-- Loop through sidebarItems.
	for k,v in pairs(sidebarItems) do

		-- Create a button for the item.
		local button = vgui.Create("DButton",sidebar)
		button:SetSize(math.floor(sidebar:GetWide() - buttonMargin * 2),sidebar:GetTall() * 0.075)
		button:Dock(TOP)
		button:SetText("")
		button:DockMargin(buttonMargin,buttonMargin,buttonMargin,0)
		EdgeScoreboard.SetEdgeTheme( button, true, false, function( s, w, h )

			draw.SimpleText(v.Title,"EdgeScoreboard:Config_Sidebar",w / 2,h / 2,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		end )

		-- Check if we are the last button
		if k >= #sidebarItems - 1 then
			button:SetZPos(-k)
			button:Dock(BOTTOM)
			button:DockMargin(buttonMargin,0,buttonMargin,buttonMargin)
		end

		-- Give the panel a bigger scopoe.
		local panel

		-- Make sure we have a button.createPanel
		if v.createPanel then

			-- Create the panel.
			panel = v.createPanel(actionsArea)
			panel:SetVisible(false)
			sidebarItems[k].panel = panel

			-- Check if we are the first tab.
			if k == 1 then
				activeTab = panel
				panel:SetVisible(true)
			end

		end

		-- Check if the button has a v.onClick
		if v.onClick then

			-- Assign the function.
			button.DoClick = function (  )
				v.onClick(button)
			end

		elseif v.createPanel then

			-- Move to its panel.
			button.DoClick = function(  )

				-- Check if we already is the activeTab.
				if activeTab == panel then return end

				-- Hide the old tab.
				activeTab:SetVisible(false)

				-- Set the new active tab and make it visible.
				activeTab = panel
				activeTab:SetVisible(true)

			end

		end

	end

end

-- Add a console command to open the configuration.
concommand.Add("edgescoreboard_config",EdgeScoreboard.OpenConfig)