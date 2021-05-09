-- Make colors easier to get.
local COLORS = EdgeScoreboard.Colors

--[[-------------------------------------------------------------------------
Element Handler
---------------------------------------------------------------------------]]

-- Create a table that will keep track of all elements.
EdgeScoreboard_RegistredElements = EdgeScoreboard_RegistredElements or {}

-- Create a function to register elements.
function EdgeScoreboard.RegisterElement( ID, element )

	-- Check if the element exist.
	if EdgeScoreboard_RegistredElements[ID] and IsValid(EdgeScoreboard_RegistredElements[ID]) then

		-- Remove the element.
		EdgeScoreboard_RegistredElements[ID]:Remove()

	end

	-- Register the derma element.
	EdgeScoreboard_RegistredElements[ID] = element

end

-- Create a hook for when EdgeScoreboard is reloaded.
hook.Add("EdgeScoreboard:Load","EdgeScoreboard:RemoveElements",function(  )

	-- Loop through all registred elements.
	for k,v in pairs(EdgeScoreboard_RegistredElements) do

		-- Make sure that the element is valid.
		if !IsValid(v) then continue end

		-- Remove the element.
		v:Remove()

		EdgeScoreboard_RegistredElements[k] = nil

	end

	-- Remove playerRows.
	for k,v in pairs(player.GetAll()) do

		-- CHeck if the row exist.
		if v.EdgeScoreboard_Row and !IsValid(EdgeScoreboard_Row) then
			v.EdgeScoreboard_Row:Remove()
		end

		-- Set v.EdgeScoreboard_Row to nil.
		v.EdgeScoreboard_Row = nil

	end

end)

--[[-------------------------------------------------------------------------
Utility Functions
---------------------------------------------------------------------------]]

local edgeWidth = 2

-- Create a function used to draw the edges.
function EdgeScoreboard.DrawEdges( x, y, width, height, edgeSize )

	--Draw the upper left corner.
	surface.DrawRect(x,y,edgeSize,edgeWidth)
	surface.DrawRect(x,y + edgeWidth,edgeWidth,edgeSize - edgeWidth)

	local XRight = x + width

	--Draw the upper right corner.
	surface.DrawRect(XRight - edgeSize,y,edgeSize,edgeWidth)
	surface.DrawRect(XRight - edgeWidth,y + edgeWidth,edgeWidth,edgeSize - edgeWidth)

	local YBottom = y + height

	--Draw the lower right corner.
	surface.DrawRect(XRight - edgeSize,YBottom - edgeWidth,edgeSize,edgeWidth)
	surface.DrawRect(XRight - edgeWidth,YBottom - edgeSize,edgeWidth,edgeSize - edgeWidth)

	--Draw the lower left corner.
	surface.DrawRect(x,YBottom - edgeWidth,edgeSize,edgeWidth)
	surface.DrawRect(x,YBottom - edgeSize,edgeWidth,edgeSize - edgeWidth)

end

--[[-------------------------------------------------------------------------
Help Functions
---------------------------------------------------------------------------]]

-- Create a function used to easily give an element the edge-theme.
function EdgeScoreboard.SetEdgeTheme( element, lightTheme, noCorners, addFunc )

	-- Make sure that addFunc is something.
	addFunc = addFunc or function(  ) end

	-- Make sure that lightTheme and NoCorners have values.
	lightTheme = lightTheme or false
	noCorners = noCorners or false

	-- Get the background color.
	local backgroundColor = lightTheme and COLORS["White_Button_Idle"] or COLORS["Black_Transparent"]

	-- Get the element name.
	local elmName = element:GetName()

	-- Check if the element is a button.
	if elmName == "DButton" or elmName == "DComboBox" then

		-- Set the paint function for the button.
		element.Paint = function( s, w, h )

			-- Draw the background.
			surface.SetDrawColor(s:IsEnabled() and s:IsHovered() and COLORS["White_Button_Hover"] or COLORS["White_Button_Idle"])
			surface.DrawRect(0,0,w,h)

			-- Paint anything additional if needed.
			addFunc(s, w, h)

			-- Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			if !noCorners then

				--Draw the corners.
				surface.SetDrawColor(COLORS["White_Corners"])
				EdgeScoreboard.DrawEdges(0,0,w,h, 8)

			end

		end

	elseif elmName == "DTextEntry" or elmName == "DNumberWang" then

		-- Set the paint function for the element.
		element.Paint = function( s, w, h )

			--Draw the background.
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0,0,w,h)

			-- Paint anything additional if needed.
			addFunc(s, w, h)

			--Draw the text.
			s:DrawTextEntryText(COLORS["White"], COLORS["DTextEntry_Highlight"], COLORS["White"])

			--Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			if !noCorners then

				--Draw the corners.
				surface.SetDrawColor(COLORS["White_Corners"])
				EdgeScoreboard.DrawEdges(0,0,w,h, 8)

			end

		end

	elseif elmName == "EdgeScoreboard:Graph" then

		-- Set the paintover function for the element.
		element.PaintOver = function( _, w, h )

			--Draw the background.
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0,0,w,h)

			-- Paint anything additional if needed.
			addFunc(s, w, h)

			--Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			if !noCorners then

				--Draw the corners.
				surface.SetDrawColor(COLORS["White_Corners"])
				EdgeScoreboard.DrawEdges(0,0,w,h, 8)

			end

		end

	elseif elmName == "DMenu" then

		-- Set the paint function for the element.
		element.Paint = function( _, w, h )

			--Draw the background.
			surface.SetDrawColor(COLORS["Dark_Gray"])
			surface.DrawRect(0,0,w,h)

			--Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

		end

	else

		-- Set the paint function for the element.
		element.Paint = function( _, w, h )

			--Draw the background.
			surface.SetDrawColor(backgroundColor)
			surface.DrawRect(0,0,w,h)

			-- Paint anything additional if needed.
			addFunc(s, w, h)

			--Draw the white outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(0,0,w,h)

			if !noCorners then

				--Draw the corners.
				surface.SetDrawColor(COLORS["White_Corners"])
				EdgeScoreboard.DrawEdges(0,0,w,h, 8)

			end

		end

	end

end

-- Create a function to ask a question.
function EdgeScoreboard.DermaQuery( subtitle, buttons)

	-- Create an argsTable.
	local argsTable = {}

	-- Loop through buttons.
	for k,v in pairs(buttons) do

		table.insert(argsTable,v[2] or k == 1 and EdgeScoreboard.GetPhrase("DERMAQUERY_CONFIRM") or EdgeScoreboard.GetPhrase("DERMAQUERY_CANCEL"))
		table.insert(argsTable, v[1])

	end

	-- Insert cancel if there is only 1 key.
	if #buttons == 1 then
		table.insert(argsTable,EdgeScoreboard.GetPhrase("DERMAQUERY_CANCEL"))
	end

	--Create a Derma_Query-Window.
	local Window = Derma_Query(subtitle,"",unpack(argsTable))

	-- Get the startTime.
	local startTime = SysTime()

	--Paint the window.
	EdgeScoreboard.SetEdgeTheme( Window, false, false, function(  )
		Derma_DrawBackgroundBlur( Window, startTime )
	end )

	--Get the buttons.
	local Buttons = Window:GetChildren()[6]:GetChildren()

	for i = 1,#Buttons do

		local curButton = Buttons[i]

		curButton:SetTextColor(Color(255,255,255))

		EdgeScoreboard.SetEdgeTheme( curButton, true, true )

		curButton.OnCursorEntered = EdgeScoreboard.ClickSound

	end

end

-- Create a function to create a stringrequest.
function EdgeScoreboard.StringRequest( subtitle, default, confirmFunc, cancelFunc)

	-- Make sure we got all functions.
	confirmFunc = confirmFunc or function( ) end
	cancelFunc = cancelFunc or function( ) end

	-- Create a Derma_StringRequest-Window.
	local Window = Derma_StringRequest("",subtitle,default,confirmFunc,cancelFunc,EdgeScoreboard.GetPhrase("DERMAQUERY_CONFIRM"), EdgeScoreboard.GetPhrase("DERMAQUERY_CANCEL"))

	-- Get the startTime.
	local startTime = SysTime()

	EdgeScoreboard.SetEdgeTheme( Window, false, false, function(  )
		Derma_DrawBackgroundBlur( Window, startTime )
	end )

	-- Get the window's children.
	local WindowChildren = Window:GetChildren()

	EdgeScoreboard.SetEdgeTheme( WindowChildren[5]:GetChildren()[2], true, true )

	-- Disable tabbing.
	WindowChildren[5]:GetChildren()[2]:SetTabbingDisabled(true)

	-- Get the buttons.
	local Buttons = WindowChildren[6]:GetChildren()

	for i = 1,2 do

		local curButton = Buttons[i]

		curButton:SetTextColor(Color(255,255,255))

		EdgeScoreboard.SetEdgeTheme( curButton, true, true )

		curButton.OnCursorEntered = EdgeScoreboard.ClickSound

	end

	-- Return the Window.
	return Window

end

-- Create a function to show a message.
function EdgeScoreboard.ShowMessage( message )

	-- Create a new derma_message-window.
	local Window = Derma_Message(message,"", EdgeScoreboard.GetPhrase("DERMAQUERY_AFFIRM"))

	-- Get the startTime.
	local startTime = SysTime()

	EdgeScoreboard.SetEdgeTheme( Window, false, false, function(  )
		Derma_DrawBackgroundBlur( Window, startTime )
	end )

	-- Get the OK_Button of the Window.
	local OK_Button = Window:GetChildren()[6]:GetChildren()[1]

	-- Paint the button.
	EdgeScoreboard.SetEdgeTheme( OK_Button, true, true )

	-- Change the textcolor of the button.
	OK_Button:SetTextColor(COLORS["White"])

	OK_Button.OnCursorEntered = EdgeScoreboard.ClickSound

	-- Return the window.
	return Window

end