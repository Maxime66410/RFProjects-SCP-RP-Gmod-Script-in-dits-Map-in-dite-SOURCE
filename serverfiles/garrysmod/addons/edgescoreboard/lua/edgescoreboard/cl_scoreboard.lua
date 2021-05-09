-- Make colors easier to get.
local COLORS = EdgeScoreboard.Colors

-- Create a table for all the staff ranks.
local staffRanks = {}

-- Loop through EdgeScoreboard.Configuration.Usergroups to check what ranks are staff.
for k,v in pairs(EdgeScoreboard.Configuration.Usergroups) do

	-- Add the rank to the staffRanks table if the rank is staff.
	if v["IsStaff"] == true then
		table.insert(staffRanks,k)
	end

end

-- Create a timer to update information that don't need to be updated every frame.
timer.Create("EdgeScoreboard:UpdateData", 10, 0, function(  )
	hook.Run("EdgeScoreboard:UpdateDerma")
end)

--[[-------------------------------------------------------------------------
Create the boardPanel.
---------------------------------------------------------------------------]]

-- Get the rightData.
local boardData = EdgeScoreboard.boardData

-- Get the searchbarData.
local searchbarData = EdgeScoreboard.searchbarData

-- Create the scoreboard. (Has to be DFrame for DTextEntry to work)
local boardPanel = vgui.Create("DFrame")
boardPanel:SetTitle("")
boardPanel:ShowCloseButton(false)
boardPanel:SetSize(boardData.boardWidth - EdgeScoreboard.widthOffset, boardData.boardHeight - EdgeScoreboard.heightOffset)
boardPanel:Center()
boardPanel:SetVisible(false)
EdgeScoreboard.RegisterElement( "BoardPanel", boardPanel )

hook.Add("EdgeScoreboard:Load", "EdgeScoreboard:RemoveBoardPanel", function(  )
	if !IsValid(EdgeScoreboard.boardPanel) then return end
	EdgeScoreboard.boardPanel:Remove()
end)

EdgeScoreboard.boardPanel = boardPanel

-- Make the panel invisible.
boardPanel.Paint = function( ) end

-- Create a variable if the scoreboard needs an update on the next opening.
local needsUpdate = false

-- Create a table with all buttons used to toggle the scoreboard.
local toggleKeys = {}

-- Create a function to lookup the scoreboard-keys.
local function lookupScoreboardKeys()

	-- Reset toggleKeys.
	toggleKeys = {
		[KEY_TAB] = false
	}

	-- Get all keys that are used to toggle the scoreboard.
	for i = 1,161 do

		-- Check if the key is bound to +showscores.
		if input.LookupKeyBinding(i) == "+showscores" then

			-- Add the key.
			toggleKeys[i] = false

		end

	end

end

-- Disable the sandbox crosshair.
hook.Add("HUDShouldDraw","EdgeScoreboard:RemoveCrosshair",function( name )
	if name == "CHudCrosshair" and boardPanel:IsVisible() then return false end
end)

-- Create a var if the scoreboard can be hidden
local canHide = true

-- Create a Think function for the boardPanel.
boardPanel.Think = function(  )

	-- Loop through the toggleKeys.
	for k,v in pairs(toggleKeys) do

		-- Check if it's false.
		if v == false and !input.IsKeyDown(k) then

			-- Enable the key.
			toggleKeys[k] = true

		elseif v == true and input.IsKeyDown(k) and !canHide then

			-- Disable keyboard and mouse input.
			boardPanel:SetKeyboardInputEnabled(false)
			boardPanel:SetMouseInputEnabled(false)
			gui.EnableScreenClicker(false)

			-- Run EdgeScoreboard:Hide.
			hook.Run("EdgeScoreboard:Hide")

			-- Hide the scoreboard.
			boardPanel:SetVisible(false)

			-- Set canHide to true.
			canHide = true

		end

	end

end

--[[-------------------------------------------------------------------------
Create the Header.
---------------------------------------------------------------------------]]

-- Get the rightData.
local headerData = EdgeScoreboard.headerData

if EdgeScoreboard.GetConfigValue("Hide_Header") then

	-- Create the header.
	local headerPanel = vgui.Create("DPanel", boardPanel)
	headerPanel:SetSize(headerData.headerWidth,headerData.headerHeight)
	EdgeScoreboard.SetEdgeTheme( headerPanel, false, false, function( s, w, h )

		-- Draw the title.
		draw.SimpleText(EdgeScoreboard.GetConfigValue("ScoreboardTitle"),"EdgeScoreboard:HeaderTitle",w * 0.02,h * 0.12,COLORS["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
		draw.SimpleText(EdgeScoreboard.GetConfigValue("ScoreboardDesc"),"EdgeScoreboard:HeaderSubTitle",w * 0.02,h * 0.88,COLORS["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM)

	end )

end

--[[-------------------------------------------------------------------------
Create the right sidebar.
---------------------------------------------------------------------------]]

-- Get the rightData.
local rightData = EdgeScoreboard.rightData

if EdgeScoreboard.GetConfigValue("Hide_Rightbar") then

	-- Create the header.
	local rightsidePanel = vgui.Create("DPanel", boardPanel)
	rightsidePanel:SetSize(rightData.rightsideWidth, rightData.rightsideHeight)
	rightsidePanel:SetPos(boardData.boardWidth - rightData.rightsideWidth,0)
	EdgeScoreboard.SetEdgeTheme( rightsidePanel )

	-- Create a table for the information sections.
	local rightside_Sections = {
		{
			Name = EdgeScoreboard.GetPhrase("STATS_TITLE_SERVER"),
			Fields = {
				{ icon = Material("edgescoreboard/icon_players.png", "smooth"), prefix = EdgeScoreboard.GetPhrase("STATS_PREFIX_PLYCOUNT"), getData = function(  ) return #player.GetAll() end },
				{ icon = Material("edgescoreboard/icon_onlinestaff.png", "smooth"), prefix = EdgeScoreboard.GetPhrase("STATS_PREFIX_STAFF"), getData = function(  ) 

					-- Create a variable to keep track of how many staff members we have found.
					local staffMembers = 0

					-- Loop through all players.
					for k,v in pairs(player.GetAll()) do

						-- Check if the player is hidden.
						if EdgeScoreboard.GetFakeIdentity("Hidden", v) and !EdgeScoreboard.GetUsergroupConfigValue(LocalPlayer(),"FakeIdentity:SeeHidden") then continue end

						-- Get the usergroup of the player.
						local usergroup = EdgeScoreboard.GetFakeIdentity("Rank", v) or v:GetUserGroup()

						-- Check if the rank of the player is a staff.
						if table.HasValue(staffRanks, usergroup) then

							-- Add 1  to staffmembers
							staffMembers = staffMembers + 1

						end

					end

					-- Return staffMembers
					return staffMembers

				end },
				{ icon = Material("edgescoreboard/icon_time.png", "smooth"), prefix = EdgeScoreboard.GetPhrase("STATS_PREFIX_UPTIME"), getData = function(  ) return EdgeScoreboard.FormatTime(EdgeScoreboard.ServerUptime + RealTime() - EdgeScoreboard.UptimeOffset) end },
				{ icon = Material("edgescoreboard/icon_ping.png", "smooth"), prefix = EdgeScoreboard.GetPhrase("STATS_PREFIX_AVGPING"), getData = function(  )

					-- Create a variable for the pingSum.
					local pingSum = 0

					-- Loop through all players.
					for k,v in pairs(player.GetHumans()) do
						
						-- Add the current player's ping to the sum
						pingSum = pingSum + v:Ping()

					end

					-- Return the average ping by dividing the sum by the amount of players
					return math.Round(pingSum / #player.GetHumans())

				end },
			},
		},
		{
			Name = EdgeScoreboard.GetPhrase("STATS_TITLE_GAME"),
			Fields = {
				{ icon = Material("edgescoreboard/icon_playtime.png", "smooth"), prefix = EdgeScoreboard.GetPhrase("STATS_PREFIX_PLAYTIME"), getData = function(  ) return Utime and EdgeScoreboard.FormatTime(LocalPlayer():GetUTimeTotalTime(), true) or xAdmin and xAdmin.GetTotalTime and EdgeScoreboard.FormatTime(xAdmin.GetTotalTime(LocalPlayer()), true) or EdgeScoreboard.FormatTime(EdgeScoreboard.PlayTime + RealTime() - EdgeScoreboard.PlayTimeOffset, true) end },
				{ icon = Material("edgescoreboard/icon_time.png", "smooth"), prefix = EdgeScoreboard.GetPhrase("STATS_PREFIX_SESSION"), getData = function(  ) return EdgeScoreboard.FormatTime( RealTime() - EdgeScoreboard_GameUptime ) end },
				{ icon = Material("edgescoreboard/icon_ping.png", "smooth"), prefix = EdgeScoreboard.GetPhrase("STATS_PREFIX_PING"), getData = function(  ) return LocalPlayer():Ping() end },
			},
		}
	}

	-- Calculate the fieldSize.
	local rightside_FieldHeight = math.Round(rightData.rightsideHeight * 0.029)

	-- Calculate the fieldMargin.
	local rightside_FieldMargin = math.Round(rightData.rightsideHeight * 0.01)

	-- Calculate the sectionMargin.
	local rightside_SectionMargin = math.Round(rightData.rightsideHeight * 0.02)

	-- Calculate the sideMargin.
	local rightside_SideMargin = math.Round(EdgeScoreboard.elementMargin * 1.5)

	-- Calculate the panel maxwidth.
	local rightside_MaxWidth = rightData.rightsideWidth - rightside_SideMargin * 2

	-- Create a variable for the next position.
	local rightside_NextPos = EdgeScoreboard.elementMargin

	-- Create a variable for the titleHeight.
	local rightside_TitleHeight = math.Round(rightData.rightsideHeight * 0.035)

	-- Loop through the rightside_Sections.
	for k,v in pairs(rightside_Sections) do

		-- Create the title.
		local title = vgui.Create("DLabel",rightsidePanel)
		title:SetText(v.Name)
		title:SetTextColor(COLORS["White"])
		title:SetFont("EdgeScoreboard:RightSidebar_Title")
		title:SizeToContents()
		title:SetSize(rightside_MaxWidth, rightside_TitleHeight)
		title:SetPos(rightside_SideMargin,rightside_NextPos)

		-- Add the height of the title to the rightside_NextPos.
		rightside_NextPos = rightside_NextPos + title:GetTall()

		-- Loop through the fields.
		for k2,v2 in pairs(v.Fields) do

			-- Update the nextpos.
			rightside_NextPos = rightside_NextPos + rightside_FieldMargin

			-- Create the fieldPanel..
			local fieldPanel = vgui.Create("DPanel",rightsidePanel)
			fieldPanel:SetSize(rightside_MaxWidth,rightside_FieldHeight)
			fieldPanel:SetPos(rightside_SideMargin, rightside_NextPos)

			-- Create a var for the fielddata.
			fieldPanel.Data = v2.getData()

			-- Add the field into v.Fields.
			rightside_Sections[k].Fields[k2].Field = fieldPanel

			-- Paint the fieldPanel.
			fieldPanel.Paint = function( _, w, h )

				-- Draw the icon.
				surface.SetDrawColor(COLORS["White"])
				surface.SetMaterial(v2.icon)
				surface.DrawTexturedRect(0,0,rightside_FieldHeight,rightside_FieldHeight)

				-- Draw the data.
				draw.SimpleText(v2.prefix .. ": " .. fieldPanel.Data,"EdgeScoreboard:RightSidebar_Fields",rightside_FieldHeight * 1.3,h / 2,COLORS["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

			end

			-- Update the nextpos.
			rightside_NextPos = rightside_NextPos + rightside_FieldHeight

		end

		-- Update rightside_NextPos.
		rightside_NextPos = rightside_NextPos + rightside_SectionMargin

	end

	-- Calculate how big the graph-section will be.
	local rightside_GraphSectionHeight = math.Round(rightData.rightsideHeight - rightside_NextPos - EdgeScoreboard.elementMargin * 1.5)

	-- Calculate the size if the graphWidgets.
	local rightside_GraphWidgetWidth, rightside_GraphWidgetHeight = math.Round((rightside_MaxWidth - EdgeScoreboard.elementMargin) / 2), math.Round(rightside_GraphSectionHeight * 0.08)

	-- Calculate the size of the graph.
	local rightside_GraphHeight = math.Round((rightside_GraphSectionHeight - rightside_TitleHeight * 2 - rightside_GraphWidgetHeight * 3 - rightside_SectionMargin - EdgeScoreboard.elementMargin * 5) / 2)

	-- Calculate the subTitleMargin.
	local rightside_SubTitleMargin = rightData.rightsideWidth * 0.0225

	-- Create a var for the highest and lowest playercount recorded.
	local highestCount, lowestCount = 0, 9999

	-- Create a table for all the graphs.
	local rightside_Graphs = {
		{
			name = EdgeScoreboard.GetPhrase("STATS_TITLE_PLYCOUNT"),
			durution = EdgeScoreboard.GetPhrase("STATS_TITLE_PLYCOUNT_SUFFIX"),
			graphData = {
				{ID = EdgeScoreboard.GetPhrase("STATS_PLYCOUNT_LOWEST"), data = 0, getData = function(  ) return highestCount end, useHighest = false},
				{ID = EdgeScoreboard.GetPhrase("STATS_PLYCOUNT_HIGHEST"), data = 0, getData = function(  ) return highestCount end, useHighest = true},
				{ID = EdgeScoreboard.GetPhrase("STATS_PLYCOUNT_AVERAGE"), data = 0},
				{ID = EdgeScoreboard.GetPhrase("STATS_PLYCOUNT_CURRENT"), getData = function(  ) return #player.GetAll() end},
			},
			lineColor = Color(13,128,217,255),
			dotColor = Color(51,147,222,255),
			backgroundColor = Color(13,128,217,69),
			textColor = Color(128,191,255,255),
		}
	}

	-- Check what type the second graph is.
	if EdgeScoreboard.GetConfigValue("Graph02_Type") == "K/D" then

		table.insert(rightside_Graphs,{
			name = EdgeScoreboard.GetPhrase("STATS_TITLE_KD"),
			durution = EdgeScoreboard.GetPhrase("STATS_TITLE_KD_SUFFIX"),
			graphData = {
				{ID = EdgeScoreboard.GetPhrase("STATS_KD_KILLS"), getData = function(  ) return LocalPlayer():Frags() end},
				{ID = EdgeScoreboard.GetPhrase("STATS_KD_DEATHS"), getData = function(  ) return LocalPlayer():Deaths() end},
			},
			lineColor = Color(197,119,56,255),
			dotColor = Color(205,137,83,255),
			backgroundColor = Color(197,119,56,68),
			textColor = Color(227,164,113,255),
		})

	else

		local currentFPS = math.Round(1 / RealFrameTime())
		local averageFPS = math.Round(1 / RealFrameTime())
		local avgFPSData = {}

		timer.Create("EdgeScoreboard:AverageFPSCounter",30,0,function(  )

			if !system.HasFocus() then return end

			currentFPS = math.Round(1 / RealFrameTime())

			if #avgFPSData >= 15 then
				avgFPSData[1] = nil
				avgFPSData = table.ClearKeys(avgFPSData)
			end

			table.insert(avgFPSData,currentFPS)

			local avgFPSSum = 0

			for k,v in pairs(avgFPSData) do
				avgFPSSum = avgFPSSum + v
			end

			averageFPS = math.Round(avgFPSSum / #avgFPSData)

		end)

		hook.Add("EdgeScoreboard:UpdateDerma","EdgeScoreboard:UpdateCurrentFPS", function( )
			currentFPS = math.Round(1 / RealFrameTime())
		end)

		table.insert(rightside_Graphs,{
			name = EdgeScoreboard.GetPhrase("STATS_TITLE_FPS"),
			durution = EdgeScoreboard.GetPhrase("STATS_TITLE_FPS_SUFFIX"),
			graphData = {
				{ID = EdgeScoreboard.GetPhrase("STATS_FPS_KILLS"), getData = function(  ) return currentFPS end},
				{ID = EdgeScoreboard.GetPhrase("STATS_FPS_DEATHS"), getData = function(  ) return averageFPS end},
			},
			lineColor = Color(65,171,93,255),
			dotColor = Color(84,186,111,255),
			backgroundColor = Color(65,171,93,68),
			textColor = Color(107,201,132,255),
		})

	end

	for k,v in pairs(rightside_Graphs) do

		-- Draw the PlayerCount graph title.
		local graphTitle = vgui.Create("DLabel",rightsidePanel)
		graphTitle:SetText(v.name)
		graphTitle:SetFont("EdgeScoreboard:RightSidebar_Title")
		graphTitle:SetTextColor(COLORS["White"])
		graphTitle:SizeToContents()
		graphTitle:SetTall(rightside_TitleHeight)
		graphTitle:SetPos(rightside_SideMargin,rightside_NextPos)

		-- Create the graphSubTitle.
		local graphSubTitle = vgui.Create("DLabel",rightsidePanel)
		graphSubTitle:SetText(v.durution)
		graphSubTitle:SetFont("EdgeScoreboard:RightSidebar_SubTitle")
		graphSubTitle:SetTextColor(COLORS["White"])
		graphSubTitle:SizeToContents()
		graphSubTitle:SetPos(rightside_SideMargin + graphTitle:GetWide() + rightside_SubTitleMargin,rightside_NextPos + (rightside_TitleHeight - graphSubTitle:GetTall()))

		-- Update rightside_NextPos.
		rightside_NextPos = rightside_NextPos + rightside_FieldMargin + rightside_TitleHeight

		-- Create the graph.
		local graph = vgui.Create("EdgeScoreboard:Graph",rightsidePanel)
		graph:SetSize(rightside_MaxWidth,rightside_GraphHeight)
		graph:SetPos(rightside_SideMargin,rightside_NextPos)

		-- Set the stats.
		graph:SetStats({0,0,0,0,0,0,0,0,0,0,0,0}, 0.2, v.lineColor,v.dotColor,v.backgroundColor)

		-- Insert the graphPanel into rightside_Graphs.
		rightside_Graphs[k].graphElement = graph

		-- Update the rightside_NextPos.
		rightside_NextPos = rightside_NextPos + rightside_GraphHeight + rightside_FieldMargin

		-- Loop through the widgets.
		for k2,v2 in pairs(v.graphData) do

			-- Create a variable for the xpos.
			local xPos

			-- Create a variable for if there is another row.
			local anotherRow = false

			-- Calculate the x-pos.
			if k2 % 2 != 0 then

				-- Set the Xpos.
				xPos = rightside_SideMargin

			else

				-- Set the XPos.
				xPos = rightData.rightsideWidth - rightside_SideMargin - rightside_GraphWidgetWidth

				-- Check if there is another row.
				if v.graphData[k2 + 1] then

					-- Set anotherRow to true-
					anotherRow = true

				end

			end

			-- Create the widget.
			local widget = vgui.Create("DPanel",rightsidePanel)
			widget:SetSize(rightside_GraphWidgetWidth,rightside_GraphWidgetHeight)
			widget:SetPos(xPos,rightside_NextPos)

			EdgeScoreboard.SetEdgeTheme( widget, true, true, function( s, w, h )

				-- Create a var for the data.
				local data = v2.data or v2.getData()

				-- Check if we have a getData function and a data func.
				if v2.data and v2.getData then

					-- Check if we should use the lowest or the highest.
					if v2.useHighest then
						data = math.max(v2.data,v2.getData())
					else
						data = math.min(v2.data,v2.getData())
					end

				end

				-- Draw the text.
				draw.SimpleText(v2.ID,"EdgeScoreboard:RightSidebar_WidgetTitle",w / 2,h * 0.09,v.textColor,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
				draw.SimpleText(data,"EdgeScoreboard:RightSidebar_WidgetData",w / 2,h * 0.91,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)


			end )

			-- Check if there will be another row.
			if anotherRow then

				-- Update rightside_NextPos.
				rightside_NextPos = rightside_NextPos + rightside_FieldMargin + rightside_GraphWidgetHeight

			end

		end

		-- Update rightside_NextPos.
		rightside_NextPos = rightside_NextPos + rightside_GraphWidgetHeight + rightside_SectionMargin

	end

	local playerCountData = {0,0,0,0,0,0,0,0,0,0,0,0}

	local EDGESCOREBOARD_TABLE_MERGE = 1
	local EDGESCOREBOARD_TABLE_FRESH = 2

	-- Add a receiver for EdgeScoreboard:GraphData.
	net.Receive("EdgeScoreboard:GraphData",function(  )

		-- Read the data.
		local transferType = net.ReadUInt(2)
		local data = playerCountData

		-- Check how we should handle the data.
		if transferType == EDGESCOREBOARD_TABLE_MERGE then

			-- Remove the oldest value.
			data[1] = nil

			-- Clear the keys.
			data = table.ClearKeys(data)

			-- Merge the data with the current data.
			data = table.Merge(data, net.ReadTable())

		else

			-- Read the data.
			data = net.ReadTable()

		end

		playerCountData = data

		-- Get the graph.
		local graph = rightside_Graphs[1]

		-- Create a var for the highest and lowest value.
		local highestValue = 0
		local lowestValue = 9999
		local averageValue = 0

		-- Find the highest and lowest value in the graphdata.
		for k,v in pairs(data) do
			highestValue = math.max(highestValue,v)
			lowestValue = math.min(lowestValue,v)
			averageValue = averageValue + v
		end

		-- Divide averageValue by the dataCount.
		averageValue = math.Round(averageValue / #data)

		-- Calculate the maxHeight.
		local maxHeight = math.min(0.8,highestValue * 0.1)

		-- Set the data of the graph.
		graph.graphElement:SetStats(data,maxHeight,graph.lineColor,graph.dotColor,graph.backgroundColor)

		-- Set the stats below the graph.
		graph.graphData[1].data = lowestValue
		graph.graphData[2].data = highestValue
		graph.graphData[3].data = averageValue

	end)

	hook.Add("EdgeScoreboard:UpdateDerma", "EdgeScoreboard:UpdateLowHighCount", function(  )
		local playerCount = #player.GetAll()
		highestCount = math.max(highestCount,playerCount)
		lowestCount = math.min(lowestCount,playerCount)
	end)

	-- Check what type the second graph is.
	if EdgeScoreboard.GetConfigValue("Graph02_Type") == "K/D" then

		-- Remove EdgeScoreboard:FPSDataCollector and EdgeScoreboard:FPSDataManager
		timer.Remove("EdgeScoreboard:FPSDataManager")

		-- CHeck if we have KDData already
		if EdgeScoreboard_KDGraphData then

			-- Get the graph.
			local graph = rightside_Graphs[2]

			-- Update the graph if we had old data.
			graph.graphElement:SetStats(EdgeScoreboard_KDGraphData, 0.8, graph.lineColor, graph.dotColor, graph.backgroundColor)

		end

		-- Create a var for the KD.
		EdgeScoreboard_KDGraphData = EdgeScoreboard_KDGraphData or {0,0,0,0,0,0,0,0,0,0,0,0}

		-- Create a timer to update the KD.
		timer.Create("EdgeScoreboard:UpdateK/D",60 * 5,0,function(  )

			-- Get the graphData.
			local graph = rightside_Graphs[2]

			-- Remove the first value.
			EdgeScoreboard_KDGraphData[1] = nil

			-- Insert the new value.
			table.insert(EdgeScoreboard_KDGraphData,math.max(math.Round(LocalPlayer():Frags() / math.max(LocalPlayer():Deaths(),1),0),2))

			-- Clear the table keys.
			EdgeScoreboard_KDGraphData = table.ClearKeys(EdgeScoreboard_KDGraphData)

			-- Update the graph.
			graph.graphElement:SetStats(EdgeScoreboard_KDGraphData, 0.8, graph.lineColor, graph.dotColor, graph.backgroundColor)

		end)

	else

		-- Remove the EdgeScoreboard:UpdateK/D timer in case the config was changed.
		timer.Remove("EdgeScoreboard:UpdateK/D")

		-- CHeck if we have FPSData already
		if EdgeScoreboard_FPSGraphData then

			-- Get the graph.
			local graph = rightside_Graphs[2]

			-- Update the graph if we had old data.
			graph.graphElement:SetStats(EdgeScoreboard_FPSGraphData, 0.8, graph.lineColor, graph.dotColor, graph.backgroundColor)

		end

		-- Create a var for the KD.
		EdgeScoreboard_FPSGraphData = EdgeScoreboard_FPSGraphData or {0,0,0,0,0,0,0,0,0,0,0,0}

		-- Create a FPSSum
		local FPS_Sum = 0

		-- (total_Interval / collecton_Interval) has to be integer.
		local total_Interval = 60 * 2.5
		local collecton_Interval = 10

		local timerIndex = 0

		-- Create a FPS data collector.
		timer.Create("EdgeScoreboard:FPSDataManager",collecton_Interval,0,function(  )

			-- Append to timerIndex.
			timerIndex = timerIndex + 1

			--[[-------------------------------------------------------------------------
			Collection
			---------------------------------------------------------------------------]]

			FPS_Sum = FPS_Sum + 1 / RealFrameTime()

			--[[-------------------------------------------------------------------------
			Handler
			---------------------------------------------------------------------------]]

			-- Chekc if the graph should be updated.
			if timerIndex == total_Interval / collecton_Interval then

				-- Reset timerIndex
				timerIndex = 0

				-- Calculate the average fps.
				local avgFPS = math.Round(FPS_Sum / (total_Interval / collecton_Interval))

				-- Reset FPS_Sum.
				FPS_Sum = 0

				-- Get the graphData.
				local graph = rightside_Graphs[2]

				-- Remove the first value.
				EdgeScoreboard_FPSGraphData[1] = nil

				-- Insert the new value.
				table.insert(EdgeScoreboard_FPSGraphData,avgFPS)

				-- Clear the table keys.
				EdgeScoreboard_FPSGraphData = table.ClearKeys(EdgeScoreboard_FPSGraphData)

				-- Update the graph.
				graph.graphElement:SetStats(EdgeScoreboard_FPSGraphData, 0.8, graph.lineColor, graph.dotColor, graph.backgroundColor)

			end

		end)

	end

	-- Update the rightsideSections.
	hook.Add("EdgeScoreboard:UpdateDerma", "EdgeScoreboard:UpdateRightFields", function(  )

		-- Don't update when the panel is hidden.
		if !boardPanel:IsVisible() then return end

		-- Loop through rightside_Sections.
		for k,v in pairs(rightside_Sections) do

			-- loop through the fields.
			for k2,v2 in pairs(v.Fields) do

				if !IsValid(v2.Field) then return end

				-- Update the field.
				v2.Field.Data = v2.getData()

			end

		end

	end)

end

hook.Add("EdgeScoreboard:Load", "EdgeScoreboard:RemoveStatistics", function(  )

	hook.Remove("EdgeScoreboard:UpdateDerma", "EdgeScoreboard:UpdateRightFields")
	hook.Remove("EdgeScoreboard:UpdateDerma", "EdgeScoreboard:UpdateLowHighCount")
	hook.Remove("EdgeScoreboard:UpdateDerma","EdgeScoreboard:UpdateCurrentFPS")

	timer.Remove("EdgeScoreboard:AverageFPSCounter")
	timer.Remove("EdgeScoreboard:FPSDataManager")
	timer.Remove("EdgeScoreboard:UpdateK/D")

	net.Receive("EdgeScoreboard:GraphData", function(  ) end)

end)

--[[-------------------------------------------------------------------------
Create the list.
---------------------------------------------------------------------------]]

-- Create a variable for the active panel.
local activeListPanel

-- Get the listdata.
local listData = EdgeScoreboard.listData

-- Create the Dpanel.
local listPanel = vgui.Create("DPanel", boardPanel)
listPanel:SetSize(listData.listWidth, listData.listHeight)
listPanel:SetPos(EdgeScoreboard.GetConfigValue("Hide_Leftbar") and rightData.rightsideWidth + EdgeScoreboard.elementMargin or 0, (EdgeScoreboard.GetConfigValue("Hide_Header") and headerData.headerHeight + EdgeScoreboard.elementMargin or 0))
EdgeScoreboard.SetEdgeTheme( listPanel )

-- Create the ScrollPanel.
local list_ScrollPanel = vgui.Create("DScrollPanel",listPanel)
list_ScrollPanel:SetSize(listData.ScrollPanelWidth, listData.ScrollPanelHeight)
list_ScrollPanel:SetPos(listData.list_SideMargin,listData.list_SideMargin)

-- Set the activeListPanel ot the list_ScrollPanel.
activeListPanel = list_ScrollPanel

-- Make the ScrollPanel invisible.
list_ScrollPanel.Paint = function(  ) end

-- Get the listVBAR.
local list_VBar = list_ScrollPanel:GetVBar()

-- Remove the scrollbar.
list_VBar:SetWide(0)

-- Enable smooth scrolling.
list_VBar.AddScroll = function( _, scroll )

	-- Get the old scrollposition.
	local oldScroll = list_VBar:GetScroll()

	-- Animate to the new scrollposition instead of setting it directly.
	list_VBar:AnimateTo(oldScroll + scroll * 80, 0.3, 0, 0.5)

	-- Return if we have reached the bottom.
	return oldScroll != list_VBar:GetScroll()

end

-- Create a table of all teams IDs from their name as key.
local nameToIDTbl = {}

-- Create a table for the teamOrder.
local list_TeamOrder = {}

-- Create a table of all teams that have already been managed.
local addedTeams = {}

-- Create a table of all teams that should be hidden.
local hiddenTeams = {}

-- Fill up the nametoid table.
for k,v in pairs(team.GetAllTeams()) do
	nameToIDTbl[v.Name] = k
end

-- Get all teams that should be hidden-
for k,v in pairs(EdgeScoreboard.Configuration.HiddenTeams) do
	if !nameToIDTbl[v] then continue end
	hiddenTeams[nameToIDTbl[v]] = true
end

-- Check if categories has been disabled.
if EdgeScoreboard.CategoriesHidden then

	-- Add the hidden row.
	list_TeamOrder[1] = "_"

elseif engine.ActiveGamemode() == "terrortown" then

	-- Add all ordered teams.
	for k,v in pairs(EdgeScoreboard.Configuration.OrderedTeams) do

		-- Check so the team isnt managed already.
		if addedTeams[v] then continue end

		-- Set that this team has been managed.
		addedTeams[v] = true

		-- Add the team to the table.
		table.insert(list_TeamOrder,v)

	end

	TTTGroups = {
		LANG.GetTranslation("terrorists"),
		LANG.GetTranslation("sb_mia"),
		LANG.GetTranslation("sb_confirmed"),
		LANG.GetTranslation("spectators"),
		"Invalid",
	}

	-- Add all the other teams.
	for k,v in pairs(TTTGroups) do

		-- Check so the team isnt managed already.
		if addedTeams[v] then continue end

		-- Set that this team has been managed.
		addedTeams[v] = true

		-- Add the team to the table.
		table.insert(list_TeamOrder,v)

	end

elseif !EdgeScoreboard.CategoriesAsJobs then
	
	-- Add all ordered teams.
	for k,v in pairs(EdgeScoreboard.Configuration.OrderedTeams) do

		-- Check so the team isnt managed already.
		if addedTeams[v] then continue end

		-- Set that this team has been managed.
		addedTeams[v] = true

		-- Add the team to the table.
		table.insert(list_TeamOrder,v)

	end

	-- Loop through the rest of all teams.
	for k,v in pairs(DarkRP.getCategories()["jobs"]) do

		-- Check so the team isnt managed already.
		if addedTeams[v.name] then continue end

		-- Set that this team has been managed.
		addedTeams[v.name] = true

		-- Add the team to the table.
		table.insert(list_TeamOrder,v.name)

	end

	hook.Add("EdgeScoreboard:UpdateDerma", "EdgeScoreboard:AddMissingCategories", function(  )

		if EdgeScoreboard.CategoriesHidden or EdgeScoreboard.CategoriesAsJobs then return end

		-- Loop through the rest of all teams.
		for k,v in pairs(DarkRP.getCategories()["jobs"]) do

			-- Check so the team isnt managed already.
			if addedTeams[v.name] then continue end

			-- Set that this team has been managed.
			addedTeams[v.name] = true

			-- Add the team to the table.
			table.insert(list_TeamOrder,v.name)

		end

	end)

else

	-- Add all ordered teams.
	for k,v in pairs(EdgeScoreboard.Configuration.OrderedTeams) do

		-- Get the teamID.
		local teamID = nameToIDTbl[v]

		if !teamID then continue end

		-- Check so the team isnt managed already.
		if addedTeams[teamID] then continue end

		-- Set that this team has been managed.
		addedTeams[teamID] = true

		-- Add the team to the table.
		table.insert(list_TeamOrder,teamID)

	end

	-- Loop through the rest of all teams.
	for k,v in pairs(team.GetAllTeams()) do

		-- Check so the team isnt managed already.
		if addedTeams[k] then continue end

		-- Set that this team has been managed.
		addedTeams[k] = true

		-- Add the team to the table.
		table.insert(list_TeamOrder,k)

	end

	hook.Add("EdgeScoreboard:UpdateDerma", "EdgeScoreboard:AddMissingTeams", function(  )

		if EdgeScoreboard.CategoriesHidden then return end

		-- Loop through the rest of all teams.
		for k,v in pairs(team.GetAllTeams()) do

			-- Check so the team isnt managed already.
			if addedTeams[k] then continue end

			-- Set that this team has been managed.
			addedTeams[k] = true

			-- Add the team to the table.
			table.insert(list_TeamOrder,k)

		end

	end)

end

-- Create a table with all players.
EdgeScoreboard.SortedRows = EdgeScoreboard.SortedRows or {}

-- Loop through the categories
for k,v in pairs(EdgeScoreboard.SortedRows) do

	-- Loop through the rows in the category.
	for k2,v2 in pairs(v) do

		-- Reset v.EdgeScoreboard_Row.
		if v2 and v2.Player and IsValid(v2.Player) then
			v2.Player.EdgeScoreboard_Row = nil
		end

		-- Remove the row.
		v2:Remove()

		-- Set the value to nil.
		EdgeScoreboard.SortedRows[k][k2] = nil

	end

	-- Remove the category.
	EdgeScoreboard.SortedRows[k] = nil

end

-- Reset all players with a row.
for k,v in pairs(player.GetAll()) do

	-- Attempt to get the row.
	local row = v.EdgeScoreboard_Row

	-- Check if the player has an active row and that the row is valid.
	if IsValid(row) then

		-- Reset v.EdgeScoreboard_Row.
		if row and row.Player and IsValid(row.Player) then
			row.Player.EdgeScoreboard_Row = nil
		end

		-- Set the row to nil.
		v.EdgeScoreboard_Row = nil

		-- Remove the row.
		row:Remove()

	end

end

-- Create a table for all the active categories.
local list_ActiveCategories = {}

-- Create a function for updating the list.
local function updatePlayerList(  )

	-- Check if the panel is visible.
	if !boardPanel:IsVisible() then

		-- Set that the panel needs to be updated.
		needsUpdate = true

		-- Stop the code.
		return

	end

	-- Reset needsUpdate.
	needsUpdate = false

	-- Create a ZIndex counter.
	local zIndexCounter = 0

	-- Loop through the EdgeScoreboard.SortedRows.
	for k,v in pairs(list_TeamOrder) do

		-- Make sure we have someone in the current category.
		if !EdgeScoreboard.SortedRows[v] then continue end

		-- Get the categorypanel.
		local categoryPanel = list_ActiveCategories[v]

		-- Get the category color.
		local categoryColor = EdgeScoreboard.GetTeamColor(v)

		-- Check if we have a category panel
		if IsValid(categoryPanel) then

			-- Calculate the new height of the categoryPanel.
			categoryPanel.AutoSetHeight(table.Count(EdgeScoreboard.SortedRows[v]))
			categoryPanel:SetZPos(zIndexCounter)
			categoryPanel:Dock(TOP)
			categoryPanel:DockMargin(0,0,0,listData.SectionMargin)

			-- Update zIndexCounter.
			zIndexCounter = zIndexCounter + 1

		else

			-- Create a categoryPanel.
			categoryPanel = vgui.Create("DPanel",list_ScrollPanel)

			-- Create a onremove function for the categoryPanel.
			categoryPanel.OnRemove = function(  )

				-- Loop through its children.
				for k2,v2 in pairs(categoryPanel:GetChildren()) do

					-- Check if the element is a row.
					if v2:GetName() == "EdgeScoreboard:Row" then

						-- Change the parent of the row.
						v2:SetParent(list_ScrollPanel)

					end

				end

			end

			-- Insert the categoryPanel.
			list_ActiveCategories[v] = categoryPanel

			-- Create a function to automatically set the height of the panel.
			categoryPanel.AutoSetHeight = function( numPLayers )

				local tilteSize = EdgeScoreboard.CategoriesHidden and 0 or listData.TitleHeight + listData.TitleMargin

				-- Set and calculate the height.
				categoryPanel:SetTall(tilteSize + (listData.RowHeight + listData.RowMargin) * numPLayers - listData.RowMargin )

			end

			-- Set the size.
			categoryPanel:SetWide(listData.RowWidth)
			categoryPanel.AutoSetHeight(table.Count(EdgeScoreboard.SortedRows[v]))

			-- Dock the categoryPanel.
			categoryPanel:SetZPos(zIndexCounter)
			categoryPanel:Dock(TOP)
			categoryPanel:DockMargin(0,0,0,listData.SectionMargin)

			-- Update zIndexCounter.
			zIndexCounter = zIndexCounter + 1

			-- Remove the categoryPanel background.
			categoryPanel.Paint = function( ) end

			if !EdgeScoreboard.CategoriesHidden then

				-- Get the team name
				local teamName = (engine.ActiveGamemode() == "terrortown" or !EdgeScoreboard.CategoriesAsJobs) and v or team.GetName(v)

				-- Create the team title.
				local title = vgui.Create("DLabel",categoryPanel)
				title:SetFont("EdgeScoreboard:ListTeamTitle")
				title:SetText(teamName .. (EdgeScoreboard.teamSuffixes[teamName] != nil and EdgeScoreboard.teamSuffixes[teamName] or ""))
				title:SetTextColor(categoryColor)
				title:SizeToContents()
				title:SetHeight(listData.TitleHeight)
				title:DockMargin(0,0,0,listData.TitleMargin)
				title:Dock(TOP)

				-- Check if the category is clickable.
				if EdgeScoreboard.teamClickables[teamName] then

					-- Make the category clickable.
					title:SetMouseInputEnabled( true )
					title.DoClick = EdgeScoreboard.teamClickables[teamName]

					title.Think = function(  )

						if title:IsHovered() then
							title:SetCursor("hand")
						end

					end

				end

			end

		end

		-- Loop through the rows.
		for k2,v2 in pairs(EdgeScoreboard.SortedRows[v]) do

			-- Set the parent of the row to the category.
			v2:SetParent(categoryPanel)
			v2:Dock(TOP)
			v2:DockMargin(0,0,0,0)
			v2:DockMargin(0,0,0,listData.RowMargin)

		end

	end

end

-- Create a var for if the scoreboard needs an update.
EdgeScoreboard.needsUpdate = false

-- Create a function to reload the players.
function EdgeScoreboard.AddMissingPlayers(  )

	if !IsValid(EdgeScoreboard.boardPanel) then return end

	-- Loop through all players.
	for k,v in pairs(player.GetAll()) do

		-- Attempt to get the row.
		local row = v.EdgeScoreboard_Row

		-- Get the player team.
		local plyTeam = v:ESB_GetTeam(  )

		-- Create a var for invalid teams.
		local invalidTeam = false

		-- Make sure that the player's team is on the scoreboard.
		if !table.HasValue(list_TeamOrder, plyTeam) then
			invalidTeam = true
		end

		-- Check if the player has a row.
		if row and IsValid(row) then

			-- Make sure that the row has the right category.
			if row.rowCategory != plyTeam then

				-- Set needsUpdate to true.
				EdgeScoreboard.needsUpdate = true

				-- Make sure that there is a category under that team.
				if EdgeScoreboard.SortedRows[row.rowCategory] then

					-- Remove the row from the list.
					table.RemoveByValue(EdgeScoreboard.SortedRows[row.rowCategory], row)

					-- Clear the category keys.
					EdgeScoreboard.SortedRows[row.rowCategory] = table.ClearKeys(EdgeScoreboard.SortedRows[row.rowCategory])

					-- Check if the category is empty.
					if #EdgeScoreboard.SortedRows[row.rowCategory] == 0 then

						-- Remove the category.
						EdgeScoreboard.SortedRows[row.rowCategory] = nil

						-- Make sure that the categoryPanel exists.
						if list_ActiveCategories[row.rowCategory] then

							-- Remove the categoryPanel.
							list_ActiveCategories[row.rowCategory]:Remove()

						end

					end

				end

				-- Make sure that the new team is valid.
				if !invalidTeam then

					-- Make sure that the new category exists.
					EdgeScoreboard.SortedRows[plyTeam] = EdgeScoreboard.SortedRows[plyTeam] or {}

					-- Insert the row.
					table.insert(EdgeScoreboard.SortedRows[plyTeam],row)

					-- Update the rowCategory.
					row.rowCategory = plyTeam

					-- Update the color.
					row.rowColor = EdgeScoreboard.GetTeamColor(plyTeam)

				else

					-- Reset row.Player.EdgeScoreboard_Row
					row.Player.EdgeScoreboard_Row = nil

					-- Remove the row.
					row:Remove()

				end



			end

		else

			-- Don't create a row.
			if invalidTeam then continue end

			-- Check if the player should remain hidden.
			if (hiddenTeams[v:Team()] != nil and !EdgeScoreboard.GetUsergroupConfigValue(LocalPlayer(), "CanSeeHiddenTeams")) or v.EdgeScoreboard_HiddenBySearch == true or (EdgeScoreboard.GetFakeIdentity("Hidden", v) and !EdgeScoreboard.GetUsergroupConfigValue(LocalPlayer(),"FakeIdentity:SeeHidden")) then continue end

			-- Set needsUpdate to true.
			EdgeScoreboard.needsUpdate = true

			-- Create a row for the player.
			row = vgui.Create("EdgeScoreboard:Row")
			row:SetupPlayer(v)
			row:SetParent(list_ScrollPanel)

			local categoryName = v:ESB_GetTeam()

			-- Create a category for the player team.
			EdgeScoreboard.SortedRows[categoryName] = EdgeScoreboard.SortedRows[categoryName] or {}

			-- Insert the row.
			table.insert(EdgeScoreboard.SortedRows[categoryName],row)

		end

	end

	-- Check if we need to update the scoreboard.
	if EdgeScoreboard.needsUpdate then

		-- Update the scoreboard.
		updatePlayerList()

		-- Reset EdgeScoreboard.needsUpdate
		EdgeScoreboard.needsUpdate = false

	end

end

hook.Add("EdgeScoreboard:Load","Unload:Updater",function(  )
	timer.Remove("EdgeScoreboard:Updater")
end)

-- Create a hook for when a row is removed.
hook.Add("EdgeScoreboard:RowRemoved", "EdgeScoreboard:UpdateList", function( row )

	-- Get the plyTeam
	plyTeam = row.rowCategory

	-- Make sure that there is a category under that team.
	if !EdgeScoreboard.SortedRows[plyTeam] then return end

	-- Remove the row from the list.
	table.RemoveByValue(EdgeScoreboard.SortedRows[plyTeam], row)

	-- Clear the category keys.
	EdgeScoreboard.SortedRows[plyTeam] = table.ClearKeys(EdgeScoreboard.SortedRows[plyTeam])

	-- Check if the category is empty.
	if #EdgeScoreboard.SortedRows[plyTeam] == 0 then

		-- Remove the category.
		EdgeScoreboard.SortedRows[plyTeam] = nil

		-- Make sure that the categoryPanel exists.
		if list_ActiveCategories[plyTeam] then

			-- Remove the categoryPanel.
			list_ActiveCategories[plyTeam]:Remove()

		end

	end

	-- Update scoreboard.
	updatePlayerList()

end)

--[[-------------------------------------------------------------------------
Left sidebar + Searchbar
---------------------------------------------------------------------------]]

-- Get the leftData.
local leftData = EdgeScoreboard.leftData

if EdgeScoreboard.GetConfigValue("Hide_Leftbar") then

	--[[-------------------------------------------------------------------------
	Create the left sidebar.
	---------------------------------------------------------------------------]]

	-- Get the staff request addon.
	local staffRequestAddon = EdgeScoreboard.GetConfigValue("StaffRequestAddon")

	-- Give staffCommand a bigger scope.
	local staffCommand = ""

	local staffRequestPriority = {
		["ULX"] = { Order = 1, Workspace = ulx, Command = "ulx asay %M" },
		["FAdmin"] = { Order = 1, Workspace = FAdmin, Command = "fadmin adminhelp %M" },
		["xAdmin 2"] = { Order = 1, Workspace = xAdmin, Command = "say @%M" },
		["SAM"] = { Order = 1, Workspace = sam, Command = "say @%M" },

	}

	-- Check if the selected system exist.
	if staffRequestPriority[staffRequestAddon].Workspace then
		staffCommand = staffRequestPriority[staffRequestAddon].Command
	end

	-- Check if we have a staffcommand.
	if staffCommand == "" then

		-- Loop through staffRequestPriority.
		for k,v in SortedPairsByMemberValue(staffRequestPriority,"Order") do

			-- Check if this system exists.
			if v.Workspace then
				staffCommand = v.Command
				break
			end

		end

	end

	-- Create the header.
	local leftsidePanel = vgui.Create("DPanel", boardPanel)
	leftsidePanel:SetSize(leftData.leftsideWidth, leftData.leftsideHeight)
	leftsidePanel:SetPos(0, (EdgeScoreboard.GetConfigValue("Hide_Header") and headerData.headerHeight + EdgeScoreboard.elementMargin or 0) + searchbarData.searchbarHeight + EdgeScoreboard.elementMargin)
	EdgeScoreboard.SetEdgeTheme( leftsidePanel )

	-- Create a variable for the active tab.
	local activeTab = EdgeScoreboard.GetPhrase("SIDEBARLEFT_PLAYERS")

	-- Get the URLs.
	local scoreboardURLs = {
		["communityURL"] = EdgeScoreboard.GetConfigValue("CommunityURL"),
		["donationURL"] = EdgeScoreboard.GetConfigValue("DonationURL"),
		["workshopURL"] = EdgeScoreboard.GetConfigValue("WorkshopURL"),
	}

	-- Loop through all scoreboardURLs
	for k,v in pairs(scoreboardURLs) do

		-- Make sure the url starts with http:// or https://
		if string.lower(string.Left(v,8)) == "https://" then
			scoreboardURLs[k] = string.Replace(v, "https://", "http://")
		elseif string.lower(string.Left(v,7)) != "http://" then
			scoreboardURLs[k] = "http://" ..  v
		end

	end

	local HTMLPaintFunc = function( s,w,h )
		surface.SetDrawColor(255,255,255,255)
		surface.DrawRect(0, 0, w, h)
		surface.SetMaterial(Material("edgescoreboard/loading.png","smooth"))
		surface.DrawTexturedRectRotated(w / 2,h * 0.4,h * 0.3,h * 0.3,(CurTime() * -240) % 360)
		draw.SimpleText(EdgeScoreboard.GetPhrase("LOADING_WEBSITE"),"EdgeScoreboard:WebsiteLoadingText",w / 2,h * 0.65,Color(50,50,50,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
	end

	local HTMLPaintOverFunc = function( s, w, h )
		surface.SetDrawColor(COLORS["White_Outline"])
		surface.DrawOutlinedRect(0,0,w,h)
	end

	local createHTMLReturnButton = function( elm )

		-- Create a return to home button.
		elm.returnButton = vgui.Create("DButton",elm)
		elm.returnButton:SetSize(elm:GetWide() * 0.3,elm:GetTall() * 0.05)
		elm.returnButton:SetPos(elm:GetWide() / 2 - elm.returnButton:GetWide() / 2,elm:GetTall() * 0.92)
		elm.returnButton:SetText(EdgeScoreboard.GetPhrase("HOME_WEBSITE"))
		elm.returnButton:SetTextColor(COLORS["White"])
		elm.returnButton:SetFont("EdgeScoreboard:WebsiteButton")
		elm.returnButton.Paint = function ( s, w, h )

			-- Draw the background.
			surface.SetDrawColor(s:IsHovered() and Color(100,100,100,200) or Color(75,75,75,200))
			surface.DrawRect(0,0,w,h)

			-- Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			surface.SetDrawColor(COLORS["White_Corners"])
			EdgeScoreboard.DrawEdges(0,0,w,h,8)

		end

		elm.returnButton.DoClick = function (  )
			elm:OpenURL(elm.HomePage)
		end

		elm.returnButton.OnCursorEntered = EdgeScoreboard.ClickSound

	end

	local websiteHTML
	local donateHTML

	local needTimer = false

	if EdgeScoreboard.GetConfigValue( "CommunityURL_OpenType" ) == "Scoreboard Integration" then

		needTimer = true

		websiteHTML = vgui.Create("DHTML")
		websiteHTML:SetVisible(false)
		websiteHTML:SetSize(listData.ScrollPanelWidth, listData.ScrollPanelHeight)
		EdgeScoreboard.RegisterElement( "websiteHTML", websiteHTML )
		websiteHTML.LastActive = 0
		websiteHTML.IsLoaded = false
		websiteHTML.nextTabDisable = 0
		websiteHTML.HomePage = scoreboardURLs["communityURL"]
		websiteHTML.ConsoleMessage = function(  ) end

		websiteHTML.Paint = HTMLPaintFunc
		websiteHTML.PaintOver = HTMLPaintOverFunc

		websiteHTML.OnBeginLoadingDocument = function(  )
			websiteHTML:Call("document.onkeydown = function(k) {return k.keyCode != 9}")
		end

		createHTMLReturnButton( websiteHTML )

	end

	if EdgeScoreboard.GetConfigValue( "DonateURL_OpenType" ) == "Scoreboard Integration" then

		needTimer = true

		donateHTML = vgui.Create("DHTML")
		donateHTML:SetVisible(false)
		donateHTML:SetSize(listData.ScrollPanelWidth, listData.ScrollPanelHeight)
		EdgeScoreboard.RegisterElement( "donateHTML", donateHTML )
		donateHTML.LastActive = 0
		donateHTML.IsLoaded = false
		donateHTML.nextTabDisable = 0
		donateHTML.HomePage = scoreboardURLs["donationURL"]
		donateHTML.ConsoleMessage = function(  ) end

		donateHTML.Paint = HTMLPaintFunc
		donateHTML.PaintOver = HTMLPaintOverFunc

		donateHTML.OnBeginLoadingDocument = function(  )
			donateHTML:Call("document.onkeydown = function(k) {return k.keyCode != 9}")
		end

		createHTMLReturnButton( donateHTML )

	end

	local function unloadHTML(  )

		if IsValid(websiteHTML) then

			if websiteHTML:IsVisible() then
				websiteHTML.LastActive = CurTime() + 60 * 5
			end

			if websiteHTML.LastActive < CurTime() and websiteHTML.IsLoaded == true then
				websiteHTML:SetHTML("")
				websiteHTML.IsLoaded = false
			end

		end

		if IsValid(donateHTML) then

			if donateHTML:IsVisible() then
				donateHTML.LastActive = CurTime() + 60 * 5
			end

			if donateHTML.LastActive < CurTime() and donateHTML.IsLoaded == true then
				donateHTML:SetHTML("")
				donateHTML.IsLoaded = false
			end

		end

		if (!websiteHTML or !websiteHTML.IsLoaded) and (!donateHTML and !donateHTML.IsLoaded) then
			timer.Remove("EdgeScoreboard:UnloadHTML")
		end

	end

	local function openNewPanel( newPnlID )

		-- Make sure that the activeListPanel isn't list_scrollpanel
		if activeTab == newPnlID then return false end

		-- Set activeTab to Servers.
		activeTab = newPnlID

		-- Move out the active panel.
		activeListPanel:MoveTo(listData.listWidth, listData.list_SideMargin, 0.3, 0, -1, function( _, pnl )

			-- Set the positon to the left side of the listPanel.
			pnl:SetPos(-listData.listWidth, listData.list_SideMargin)

			if pnl != list_ScrollPanel then
				pnl:Remove()
			end

		end)

	end

	-- Create a table for all buttons on the left side.
	local leftside_buttons = {
		[EdgeScoreboard.GetPhrase("SIDEBARLEFT_PLAYERS")] = {
			enabled = true,
			order = 0,
			icon = Material("edgescoreboard/icon_playerlist.png", "smooth"),
			onClick = function(  )

				if openNewPanel( EdgeScoreboard.GetPhrase("SIDEBARLEFT_PLAYERS") ) == false then return end

				-- Update the activeListPanel.
				activeListPanel = list_ScrollPanel

				-- Move the panel inside.
				activeListPanel:MoveTo(listData.list_SideMargin, listData.list_SideMargin, 0.3)

			end,
			realClick = function(  )
				hook.Run("EdgeScoreboard:ClearSearch")
			end
		},
		[EdgeScoreboard.GetPhrase("SIDEBARLEFT_SERVERS")] = {
			enabled = EdgeScoreboard.GetConfigValue( "Sidebar_Servers" ),
			order = 1,
			icon = Material("edgescoreboard/icon_servers.png", "smooth"),
			onClick = function(  )

				if openNewPanel( EdgeScoreboard.GetPhrase("SIDEBARLEFT_SERVERS") ) == false then return end

				-- Update the active panel.
				activeListPanel = vgui.Create("EdgeScoreboard:ServerList",listPanel)
				activeListPanel:SetPos(-listData.listWidth, listData.list_SideMargin)

				-- Loop through all availableServers.
				for k,v in pairs(EdgeScoreboard.Configuration.Servers) do

					-- Add the server.
					activeListPanel:AddServer(k)

				end

				-- Move the panel inside.
				activeListPanel:MoveTo(listData.list_SideMargin, listData.list_SideMargin, 0.3)

			end
		},
		[EdgeScoreboard.GetPhrase("SIDEBARLEFT_WEBSITE")] = {
			enabled = EdgeScoreboard.GetConfigValue( "Sidebar_Website" ),
			order = 2,
			icon = Material("edgescoreboard/icon_website.png", "smooth"),
			onClick = function(  )

				if EdgeScoreboard.GetConfigValue( "CommunityURL_OpenType" ) == "Scoreboard Integration" then

					if !timer.Exists("EdgeScoreboard:UnloadHTML") then
						timer.Create("EdgeScoreboard:UnloadHTML", 60, 0, unloadHTML)
					end

					if openNewPanel( EdgeScoreboard.GetPhrase("SIDEBARLEFT_WEBSITE") ) == false then return end

					boardPanel:MakePopup()

					-- Update the active panel.
					activeListPanel = vgui.Create("DPanel",listPanel)
					activeListPanel:SetSize(listData.ScrollPanelWidth, listData.ScrollPanelHeight)
					activeListPanel:SetPos(-listData.listWidth, listData.list_SideMargin)
					activeListPanel:MoveTo(listData.list_SideMargin, listData.list_SideMargin, 0.3)
					activeListPanel.Paint = function(  )
						surface.SetDrawColor(0,0,0,255)
						surface.DrawRect(0,0,200,100)
					end

					-- Update the active panel.
					websiteHTML:SetParent(activeListPanel)
					websiteHTML:SetVisible(true)

					-- Cache this panel.
					local thisPanel = activeListPanel

					thisPanel.OnRemove = function (  )
						if !IsValid(websiteHTML) then return end
						if websiteHTML:GetParent() == thisPanel then
							websiteHTML:SetParent()
							websiteHTML:SetVisible(false)
						end
					end

					if websiteHTML.IsLoaded == false then
						websiteHTML:OpenURL(websiteHTML.HomePage)
						websiteHTML.IsLoaded = true
						websiteHTML.LastActive = CurTime() + 60 * 5
					end

				else

					-- Open the URL.
					gui.OpenURL(scoreboardURLs["communityURL"])

					-- Close the menu.
					GAMEMODE.ScoreboardHide( )

				end

			end,
			onRightClick = function(  )
				SetClipboardText(scoreboardURLs["communityURL"])
				EdgeScoreboard.Notify(EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("WEBSITE_URL_COPIED"))
			end
		},
		[EdgeScoreboard.GetPhrase("SIDEBARLEFT_DONATE")] = {
			enabled = EdgeScoreboard.GetConfigValue( "Sidebar_Donate" ),
			order = 3,
			icon = Material("edgescoreboard/icon_donate.png", "smooth"),
			onClick = function(  )

				if EdgeScoreboard.GetConfigValue( "DonateURL_OpenType" ) == "Scoreboard Integration" then

					if !timer.Exists("EdgeScoreboard:UnloadHTML") then
						timer.Create("EdgeScoreboard:UnloadHTML", 60, 0, unloadHTML)
					end

					if openNewPanel( EdgeScoreboard.GetPhrase("SIDEBARLEFT_DONATE") ) == false then return end

					boardPanel:MakePopup()

					-- Update the active panel.
					activeListPanel = vgui.Create("DPanel",listPanel)
					activeListPanel:SetSize(listData.ScrollPanelWidth, listData.ScrollPanelHeight)
					activeListPanel:SetPos(-listData.listWidth, listData.list_SideMargin)
					activeListPanel:MoveTo(listData.list_SideMargin, listData.list_SideMargin, 0.3)
					activeListPanel.Paint = function(  )
						surface.SetDrawColor(255,255,255,255)
						surface.DrawRect(0,0,200,100)
					end

					-- Update the active panel.
					donateHTML:SetParent(activeListPanel)
					donateHTML:SetVisible(true)

					-- Cache this panel.
					local thisPanel = activeListPanel

					thisPanel.OnRemove = function (  )
						if !IsValid(donateHTML) then return end
						if donateHTML:GetParent() == thisPanel then
							donateHTML:SetParent()
							donateHTML:SetVisible(false)
						end
					end

					if donateHTML.IsLoaded == false then
						donateHTML:OpenURL(donateHTML.HomePage)
						donateHTML.IsLoaded = true
						donateHTML.LastActive = CurTime() + 60 * 5
					end

				else

					-- Open the URL.
					gui.OpenURL(scoreboardURLs["donationURL"])

					-- Close the menu.
					GAMEMODE.ScoreboardHide( )

				end

			end,
			onRightClick = function(  )
				SetClipboardText(scoreboardURLs["donationURL"])
				EdgeScoreboard.Notify(EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("WEBSITE_URL_COPIED"))
			end
		},
		[EdgeScoreboard.GetPhrase("SIDEBARLEFT_UTILITIES")] = {
			enabled = EdgeScoreboard.GetConfigValue( "Sidebar_Utilities" ),
			order = 4,
			icon = Material("edgescoreboard/icon_utilities.png", "smooth"),
			onClick = function(  )

				if openNewPanel( EdgeScoreboard.GetPhrase("SIDEBARLEFT_UTILITIES") ) == false then return end

				-- Update the active panel.
				activeListPanel = vgui.Create("EdgeScoreboard:UtilitiesTab",listPanel)
				activeListPanel:SetPos(-listData.listWidth, listData.list_SideMargin)

				-- Move the panel inside.
				activeListPanel:MoveTo(listData.list_SideMargin, listData.list_SideMargin, 0.3)

			end
		},
		[EdgeScoreboard.GetPhrase("SIDEBARLEFT_WORKSHOP")] = {
			enabled = EdgeScoreboard.GetConfigValue( "Sidebar_Workshop" ),
			order = 5,
			icon = Material("edgescoreboard/icon_workshop.png", "smooth"),
			onClick = function(  )

				-- Open the URL.
				gui.OpenURL(scoreboardURLs["workshopURL"])

				-- Close the menu.
				GAMEMODE.ScoreboardHide( )

			end,
			onRightClick = function(  )
				SetClipboardText(scoreboardURLs["workshopURL"])
				EdgeScoreboard.Notify(EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("WEBSITE_URL_COPIED"))
			end
		},
		[EdgeScoreboard.GetPhrase("SIDEBARLEFT_REQUESTSTAFF")] = {
			enabled = EdgeScoreboard.GetConfigValue( "Sidebar_StaffRequest" ),
			order = 6,
			icon = Material("edgescoreboard/icon_support.png", "smooth"),
			onClick = function(  )

				if staffCommand == "" then

					if table.HasValue(staffRanks,LocalPlayer():GetUserGroup()) then
						EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("ADMINSYS_NOTSUPPORTED") )
					else
						EdgeScoreboard.Notify( EDGESCOREBOARD_NOTIFY_CHAT, EdgeScoreboard.GetPhrase("ADMINSYS_CANNOTDO") )
					end

					return
				end

				-- Check if the table contains %M
				if string.find(staffCommand, "%M") != nil then

					-- Open a derma text entry to send a message to staff.
					EdgeScoreboard.StringRequest( EdgeScoreboard.GetPhrase("REQUESTSTAFF_QUERY"), "", function( text )

						-- Make sure that the message isn't the default or empty.
						if text == "" then return end

						-- Get the cmd to run
						local cmd = string.Replace(staffCommand, "%M", text)

						-- Run the command
						RunConsoleCommand(unpack(string.Explode(" ", cmd)))

					end)

				else

					-- Run the console command straight away.
					RunConsoleCommand(unpack(string.Explode(" ", staffCommand)))

				end

				-- Close the menu.
				GAMEMODE.ScoreboardHide( )

			end
		},

	}

	-- Add a hook to enable the playerview on exist.
	hook.Add("EdgeScoreboard:Hide", "EdgeScoreboard:EnablePlayerView", function(  )

		-- Enable the playersView.
		leftside_buttons[EdgeScoreboard.GetPhrase("SIDEBARLEFT_PLAYERS")].onClick()

	end)

	-- Get the number if buttons.
	local leftside_BtnNum = table.Count(leftside_buttons)

	-- Calculate the buttonsize.
	local leftside_ButtonWidth, leftside_ButtonHeight = math.Round(leftData.leftsideWidth - EdgeScoreboard.elementMargin * 2), math.Round((leftData.leftsideHeight - EdgeScoreboard.elementMargin * (leftside_BtnNum + 1)) / leftside_BtnNum)

	-- Calculate the iconsize.
	local leftside_IconSize = EdgeScoreboard.GetConfigValue( "Hide_Header" ) and leftside_ButtonHeight * 0.4 or leftData.leftsideHeight * 0.0475
	local btnContentMargin = EdgeScoreboard.GetConfigValue( "Hide_Header" ) and leftside_ButtonHeight * 0.1 or leftside_ButtonHeight * 0.18

	-- Loop through the buttons table.
	for k,v in SortedPairsByMemberValue(leftside_buttons,"order") do

		-- Create the button.
		local button = vgui.Create("DButton",leftsidePanel)
		button:SetSize(leftside_ButtonWidth,leftside_ButtonHeight)
		button:DockMargin(EdgeScoreboard.elementMargin,EdgeScoreboard.elementMargin,EdgeScoreboard.elementMargin,0)
		button:Dock(TOP)
		button:SetText("")
		button:SetVisible(v.enabled)
		EdgeScoreboard.SetEdgeTheme( button, false, false, function( s, w, h )

			-- Draw the button icon.
			surface.SetDrawColor(COLORS["White"])
			surface.SetMaterial(v.icon)
			surface.DrawTexturedRect(leftside_ButtonWidth / 2 - leftside_IconSize / 2,btnContentMargin,leftside_IconSize,leftside_IconSize)

			-- Draw the button text.
			draw.SimpleText(k,"EdgeScoreboard:LeftSidebar_Button",w / 2,h - btnContentMargin,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_BOTTOM)

		end )

		-- Add a OnCursorEntered function for the button.
		button.OnCursorEntered = function(  )

			-- Play sound.
			EdgeScoreboard.ClickSound()

		end

		-- Set the DoClick function.
		button.DoClick = function(  )

			boardPanel:SetKeyboardInputEnabled(false)

			v.onClick()
			if v.realClick then v.realClick() end

		end

		-- Check if we have a rightclick function,
		if v.onRightClick then

			-- Set the rightclick function.
			button.DoRightClick = v.onRightClick

		end

	end

	--[[-------------------------------------------------------------------------
	Create the searchbar
	---------------------------------------------------------------------------]]

	-- Calculate the magnifying class size.
	local searchbar_IconSize = searchbarData.searchbarHeight * 0.45

	-- Calculate the icon-margin.
	local searchbar_IconMargin = searchbarData.searchbarHeight * 0.275

	-- Create a material for the mag-class.
	local MAT_Search = Material("edgescoreboard/icon_search.png","smooth")

	-- Create the header.
	local searchbarPanel = vgui.Create("DPanel", boardPanel)
	searchbarPanel:SetSize(searchbarData.searchbarWidth, searchbarData.searchbarHeight)
	searchbarPanel:SetPos(0, EdgeScoreboard.GetConfigValue("Hide_Header") and headerData.headerHeight + EdgeScoreboard.elementMargin or 0)
	EdgeScoreboard.SetEdgeTheme( searchbarPanel, false, false, function(  )

		-- Draw the magnifying glass.
		surface.SetDrawColor(COLORS["White"])
		surface.SetMaterial(MAT_Search)
		surface.DrawTexturedRect(searchbar_IconMargin,searchbar_IconMargin,searchbar_IconSize,searchbar_IconSize)

	end )

	-- Create the DTextEntry.
	local searchbar_TextEntry = vgui.Create("DTextEntry",searchbarPanel)
	searchbar_TextEntry:SetSize(searchbarData.searchbarWidth - searchbar_IconMargin * 2.5 - searchbar_IconSize,searchbarData.searchbarHeight * 0.7)
	searchbar_TextEntry:SetPos(searchbar_IconMargin * 1.5 + searchbar_IconSize,searchbarData.searchbarHeight * 0.15)
	searchbar_TextEntry:SetFont("EdgeScoreboard:SearchBar")
	searchbar_TextEntry.Paint = function( s, w, h )

		-- Check if the placeholder text should be drawn.
		if !s:IsEditing() and s:GetValue() == "" then

			-- Set the placeholder text.
			draw.SimpleText(EdgeScoreboard.GetPhrase("SIDEBARLEFT_SEARCHFIELD"),"EdgeScoreboard:SearchBar",2,h / 2,COLORS["White"],TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

		end

		--Draw the text.
		s:DrawTextEntryText(COLORS["White"], COLORS["DTextEntry_Highlight"], COLORS["White"])

	end

	-- Create a OnGetFocus function for the seachbar.
	searchbar_TextEntry.OnGetFocus = function(  )

		-- Set canhide to false.
		canHide = false

		boardPanel:MakePopup()

		-- Find all keys that can be used to close the scoreboard again.
		lookupScoreboardKeys()

		searchbar_TextEntry:SetTabbingDisabled(true)

		searchbar_TextEntry:RequestFocus()

		leftside_buttons[EdgeScoreboard.GetPhrase("SIDEBARLEFT_PLAYERS")].onClick()

	end

	-- Create a OnEnter function for the searchbar.
	searchbar_TextEntry.OnEnter = function(  )

		-- Disable tabbing.
		searchbar_TextEntry:SetTabbingDisabled(false)

		timer.Simple(0, function(  )
			if IsValid(searchbar_TextEntry) then
				searchbar_TextEntry:SetTabbingDisabled(true)
			end
		end)

		-- Remove the panel focus.
		TextEntryLoseFocus()

	end

	searchbar_TextEntry.OnChange = function(  )

		-- Move over to the players tab.
		leftside_buttons[EdgeScoreboard.GetPhrase("SIDEBARLEFT_PLAYERS")].onClick()

		-- Get the searchdata.
		local searchData = string.lower(searchbar_TextEntry:GetText())

		-- Create a table for all players that didn't match.
		local mismatchedPlayers = {}

		-- Loop through all players.
		for k,v in pairs(player.GetAll()) do

			-- Attempt to get the fake name and rank.
			local fakeName = EdgeScoreboard.GetFakeIdentity("Name", v)
			local fakeRank = EdgeScoreboard.GetFakeIdentity("Rank", v)

			-- Check if the player can see hidden players.
			if ((fakeName and EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "FakeIdentity:SeeOriginal" )) or !fakeName) and string.find(string.lower(v:Name()), searchData) != nil then
				continue
			end

			-- Check if the player can see hidden players.
			if ((fakeRank and EdgeScoreboard.GetUsergroupConfigValue( LocalPlayer(), "FakeIdentity:SeeOriginal" )) or !fakeRank) and string.find(string.lower(v:GetUserGroup()), searchData) != nil then
				continue
			end

			-- CHeck if the fake name/rank matches.
			if string.find(string.lower(tostring(fakeName)), searchData) != nil and fakeName != nil then continue end
			if string.find(string.lower(tostring(fakeRank)), searchData) != nil and fakeRank != nil then continue end

			-- Check if the team matches.
			if string.find(string.lower(team.GetName(v:Team())), searchData) != nil then continue end 

			-- Make sure the player isn't a bot.
			if !v:IsBot() then

				-- Check if the steamID matches.
				if string.match(string.upper(searchData),"^STEAM_%d:%d:%d+$") != nil and string.find(v:SteamID(), string.upper(searchData)) then continue end

				-- Check if the steamid64 matches.
				if string.Left(searchData, "76") != nil and string.find(v:SteamID64(), searchData) then continue end

			end

			-- Add the player to mismatchedPlayers.
			mismatchedPlayers[v] = true

		end

		if EdgeScoreboard.HidePlayersBySearch then
			EdgeScoreboard.HidePlayersBySearch(mismatchedPlayers)
		else
			EdgeScoreboard.AddMissingPlayers()
		end

	end

	hook.Add("EdgeScoreboard:ClearSearch","EdgeScoreboard:ClearSearch",function(  )
		if !IsValid(searchbar_TextEntry) then return end
		searchbar_TextEntry:SetText("")
		searchbar_TextEntry:OnEnter()
		searchbar_TextEntry:OnChange()
	end)

	-- Add a hook for when the scorebord is shown.
	hook.Add("EdgeScoreboard:Show","EdgeScoreboard:SetupSearch",function(  )
		if !IsValid(searchbar_TextEntry) then return end
		searchbar_TextEntry:SetTabbingDisabled(true)
	end)

	-- Add a hook for when the scoreboard is hidden.
	hook.Add("EdgeScoreboard:Hide","EdgeScoreboard:KillSearchFocus",function(  )

		if !IsValid(searchbar_TextEntry) then return end

		-- Reset the searchbar_TextEntry.
		searchbar_TextEntry:SetText("")

		searchbar_TextEntry:SetTabbingDisabled(false)

		-- Kill the textentry focus.
		TextEntryLoseFocus()

	end)

	function EdgeScoreboard.HidePlayersBySearch( plyTbl )

		-- Loop through all players.
		for k,v in pairs(player.GetAll()) do

			-- Check if the player should be hidden
			if plyTbl[v] then

				-- Set that they're hidden.
				v.EdgeScoreboard_HiddenBySearch = true

				-- Attempt to get the row from the player.
				local row = v.EdgeScoreboard_Row

				-- Check if the row is valid.
				if IsValid(row) then

					-- Simulate the row being removed.
					hook.Run("EdgeScoreboard:RowRemoved", row)

					-- Remove the row.
					row:Remove()

				end

			else

				-- Set v.EdgeScoreboard_HiddenBySearch to nil.
				v.EdgeScoreboard_HiddenBySearch = nil

			end

		end

		-- Add the missing players
		EdgeScoreboard.AddMissingPlayers()

	end

end

hook.Add("EdgeScoreboard:Load", "EdgeScoreboard:UnloadLeft", function(  )

	timer.Remove("EdgeScoreboard:UnloadHTML")
	hook.Remove("EdgeScoreboard:Hide", "EdgeScoreboard:EnablePlayerView")
	hook.Remove("EdgeScoreboard:ClearSearch","EdgeScoreboard:ClearSearch")
	hook.Remove("EdgeScoreboard:Show","EdgeScoreboard:SetupSearch")
	hook.Remove("EdgeScoreboard:Hide","EdgeScoreboard:KillSearchFocus")

end)

--[[-------------------------------------------------------------------------
Setup scoreboard functionality
---------------------------------------------------------------------------]]

-- Remove the FAdmin scoreboard hooks.
hook.Remove("ScoreboardShow", "FAdmin_scoreboard")
hook.Remove("ScoreboardHide", "FAdmin_scoreboard")

-- Create a var that holds the last screen resolution.
local lastHeight, lastWidth = ScrH(), ScrW()

local function showScoreboard( )

	if !EdgeScoreboard.FinishedLoading then return end

	-- Create a timer that updates the playerdata.
	timer.Create("EdgeScoreboard:Updater", 1, 0, EdgeScoreboard.AddMissingPlayers)

	-- Check if the height/width changed.
	if lastHeight != ScrH() or lastWidth != ScrW() then

		-- Reload the the addon.
		EdgeScoreboard.LoadAddon()

		return

	end

	-- Make the scoreboard visible.
	boardPanel:SetVisible(true)
	boardPanel:SetMouseInputEnabled(true)
	gui.EnableScreenClicker(true)

	-- Run EdgeScoreboard:Show.
	hook.Run("EdgeScoreboard:Show")
	hook.Run("EdgeScoreboard:UpdateDerma")

	-- Show all hidden players.
	if EdgeScoreboard.HidePlayersBySearch then
		EdgeScoreboard.HidePlayersBySearch({})
	else
		EdgeScoreboard.AddMissingPlayers()
	end

	-- Check if the panel needs an update.
	if needsUpdate then

		-- Loop through all categories.
		for k,v in pairs(EdgeScoreboard.SortedRows) do

			-- Loop through all rows.
			for k2,v2 in pairs(v) do

				-- Call the Think function of the row.
				v2:Think()

			end

		end

		-- Update the scoreboard.
		updatePlayerList()

	end

end

local function hideScoreboard( )

	-- Check if the scoreboard can be hidden.
	if canHide then

		boardPanel:SetKeyboardInputEnabled(false)
		boardPanel:SetMouseInputEnabled(false)
		gui.EnableScreenClicker(false)

		-- Run EdgeScoreboard:Hide.
		hook.Run("EdgeScoreboard:Hide")

		-- Hide the scorebaord.
		boardPanel:SetVisible(false)

		-- Create a timer that updates the playerdata.
		timer.Remove("EdgeScoreboard:Updater")

	end

end

-- Override the ScoreboardShow and ScoreboardHide hook.
GAMEMODE.ScoreboardShow = showScoreboard
GAMEMODE.ScoreboardHide = hideScoreboard

local function repairScoreboard( )

	timer.Simple(3,function(  )

		-- Remove the FAdmin scoreboard hooks.
		hook.Remove("ScoreboardShow", "FAdmin_scoreboard")
		hook.Remove("ScoreboardHide", "FAdmin_scoreboard")

		-- Override the ScoreboardShow and ScoreboardHide hook.
		GAMEMODE.ScoreboardShow = showScoreboard
		GAMEMODE.ScoreboardHide = hideScoreboard

	end)

end

hook.Add("OnGamemodeLoaded", "EdgeScoreboard:GamemodeReload", repairScoreboard)
hook.Add("DarkRPFinishedLoading", "EdgeScoreboard:ReloadOnDarkRPReload", repairScoreboard)

--[[-------------------------------------------------------------------------
Network receivers
---------------------------------------------------------------------------]]

-- Add a receiver for EdgeScoreboard:PlayerDeath.
net.Receive("EdgeScoreboard:PlayerDeath", function(  )

	-- Attempt to read the data.
	local victim = net.ReadEntity()
	local attacker = net.ReadEntity()

	-- Wait a second.
	timer.Simple(1, function( )

		-- Check if the victim is valid.
		if IsValid(victim) then

			-- Attempt to get the player's row.
			local row = victim.EdgeScoreboard_Row

			-- Make sure that the row is valid.
			if IsValid(row) then

				-- Get the deathField.
				local deathField = row.dataFields["DEATHS"]

				if deathField then

					-- Update the field.
					deathField.UpdateField()

				end

			end

		end

		-- Check if the attacker is valid.
		if IsValid(attacker) then

			-- Attempt to get the player's row.
			local row = attacker.EdgeScoreboard_Row

			-- Make sure that the row is valid.
			if IsValid(row) then

				-- Get the killsField.
				local killsField = row.dataFields["KILLS"]

				if killsField then

					-- Update the field.
					killsField.UpdateField()

				end

			end

		end

	end)

end)