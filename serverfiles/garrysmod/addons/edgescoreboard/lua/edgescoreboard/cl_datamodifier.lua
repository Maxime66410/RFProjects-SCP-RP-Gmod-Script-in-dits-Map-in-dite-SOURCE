-- Make colors easier to get.
local COLORS = EdgeScoreboard.Colors

-- Create the table used for the element.
local PANEL = {}

function PANEL:ValueUpdated() end

-- Create a function used to set the configID.
function PANEL:SetID(id, isGeneralCfg, defaultValue)

	-- Some vars.
	local value = ""
	local dataTable = {}

	-- Check if it is a general config.
	if isGeneralCfg then

		-- Set value
		value = EdgeScoreboard.GetConfigValue( id )

		-- Get the datatable.
		dataTable = EdgeScoreboard.ConfigValues.Config[id]

	else

		-- Set the value
		if defaultValue != nil then
			value = defaultValue
		else
			value = defaultValue != nil and defaultValue or EdgeScoreboard.ConfigValues.Usergroups[id].Default
		end

		-- Get the datatable.
		dataTable = EdgeScoreboard.ConfigValues.Usergroups[id]

	end

	-- Check what type the configValue is.
	if dataTable.TypeEnum == EDGESCOREBOARD_CONFIG_BOOL then

		self.interactElement = vgui.Create("DButton",self)
		self.interactElement:SetText("")
		self.interactElement.value = value
		self.interactElement:SetFont("EdgeScoreboard:Config_OptionButton")

		-- override self.interactElement:SetText
		self.interactElement.SetText = function( _, text )
			self.interactElement.value = tobool(text)
		end

		self.interactElement.GetValue = function(  )
			return self.interactElement.value
		end

		self.interactElement.DoClick = function(  )
			self.interactElement.value = !self.interactElement.value
			self.ValueUpdated(self.interactElement.value)
		end

		self.interactElement.PaintOver = function( s,w,h )

			--Draw the current status option in the middle.
			draw.SimpleText(self.interactElement.value == true and "Yes" or "No","EdgeScoreboard:Config_OptionButton",w / 2,h / 2,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		end

	elseif dataTable.TypeEnum == EDGESCOREBOARD_CONFIG_STRING then

		self.interactElement = vgui.Create("DTextEntry",self)
		self.interactElement:SetText(value)

		self.interactElement.OnChange = function(  )
			self.ValueUpdated(self.interactElement:GetValue())
		end

		self.interactElement.AllowInput = function( ... )

			if #self.interactElement:GetValue() >= dataTable.maxLength then
				return true
			end

		end

	elseif dataTable.TypeEnum == EDGESCOREBOARD_CONFIG_NUMBER then

		self.interactElement = vgui.Create("DNumberWang",self)
		self.interactElement:SetDecimals(0)
		self.interactElement:SetMinMax( dataTable.minNum, dataTable.maxNum )
		self.interactElement:SetText(value)
		self.interactElement:SetUpdateOnType(false)

		self.interactElement.OnValueChanged = function( _, val )
			self.ValueUpdated(val)
		end

		self.interactElement.OnFocusChanged = function(  )

			local elmValue = tonumber(self.interactElement:GetValue())

			if elmValue == nil then
				self.interactElement:SetText(dataTable.Default)
			elseif elmValue % 1 != 0 then
				self.interactElement:SetText(dataTable.Default)
			elseif elmValue > dataTable.maxNum then
				self.interactElement:SetText(dataTable.maxNum)
			elseif elmValue < dataTable.minNum then
				self.interactElement:SetText(dataTable.minNum)
			end

		end

	elseif dataTable.TypeEnum == EDGESCOREBOARD_CONFIG_TABLE then

		self.interactElement = vgui.Create("DComboBox",self)
		self.interactElement:SetText(value)
		self.interactElement:SetTextColor(Color(255,255,255,255))
		self.interactElement:SetSortItems(dataTable.SortItems)

		for k,v in pairs(dataTable.AllowedValues) do
			self.interactElement:AddChoice(v,v)
		end

		-- Override the DoClick function.
		self.interactElement.DoClick = function( ... )

			-- Check if the menu is open already.
			if self.interactElement:IsMenuOpen() then
				return self.interactElement:CloseMenu()
			end

			-- Open the menu.
			self.interactElement:OpenMenu()

			-- Set the paint function for the self.interactElement.Menu.
			EdgeScoreboard.SetEdgeTheme(self.interactElement.Menu)

			-- Get the buttons.
			for k,v in pairs(self.interactElement.Menu:GetChildren()[1]:GetChildren()) do

				-- Set the textcolor.
				v:SetTextColor(COLORS["White"])

				-- Set the icon..
				v:SetIcon("icon16/bricks.png")

			end

		end

		self.interactElement.OnSelect = function( _, _, value )
			self.ValueUpdated(value)
		end
	
	elseif dataTable.TypeEnum == EDGESCOREBOARD_CONFIG_COLOR then

		self.interactElement = vgui.Create("DButton",self)
		self.interactElement:SetText("")
		self.interactElement.value = value
		self.interactElement:SetFont("EdgeScoreboard:Config_OptionButton")

		-- override self.interactElement:SetText
		self.interactElement.SetText = function( _, color )

			self.interactElement.value = color

			if IsValid(self.interactElement.selectorElement) then
				self.interactElement.selectorElement:Remove()
			end

		end

		self.interactElement.GetValue = function(  )
			return self.interactElement.value
		end

		self.interactElement.DoClick = function(  )

			if IsValid(self.interactElement.selectorElement) then
				self.interactElement.selectorElement:Remove()
				return
			end

			self.ValueUpdated(self.interactElement.value)

			local xPos, yPos = gui.MousePos()
			yPos = math.min(yPos, ScrH() - 350)

			local colorSelectorPanel = vgui.Create("DPanel")
			colorSelectorPanel:SetSize(350, 350)
			colorSelectorPanel:SetPos(xPos, yPos)
			colorSelectorPanel:MakePopup()

			colorSelectorPanel:SetAlpha(0)
			colorSelectorPanel:AlphaTo(255, 0.2)

			self.interactElement.selectorElement = colorSelectorPanel

			local startTime = SysTime()

			EdgeScoreboard.SetEdgeTheme(colorSelectorPanel, false, false, function( s )
				Derma_DrawBackgroundBlur(colorSelectorPanel, startTime)
			end)

			colorSelectorPanel.ColorPallete = vgui.Create("DColorCombo", colorSelectorPanel)
			colorSelectorPanel.ColorPallete:SetPos(10, 10)
			colorSelectorPanel.ColorPallete:SetSize(330, 250)
			colorSelectorPanel.ColorPallete:SetColor(self.interactElement.value)

			colorSelectorPanel.ColorPallete.OnValueChanged = function( s, value )
				self.interactElement.value = value
				self.ValueUpdated(value)
			end

			local colorPreview = vgui.Create("DPanel", colorSelectorPanel)
			colorPreview:SetSize(160, 70)
			colorPreview:SetPos(10, 270)

			colorPreview.Paint = function( s, w, h )

				surface.SetDrawColor(colorSelectorPanel.ColorPallete:GetColor())
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(COLORS["White"])
				surface.DrawOutlinedRect(0, 0, w, h)

				draw.SimpleTextOutlined( "Preview", "EdgeScoreboard:ColorPalette",  w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, COLORS["Black"] )

			end

			local exitButton = vgui.Create("DButton", colorSelectorPanel)
			exitButton:SetSize(160, 70)
			exitButton:SetPos(180, 270)
			exitButton:SetText("")

			EdgeScoreboard.SetEdgeTheme(exitButton, true, false, function( s, w, h )
				draw.SimpleText("Finish", "EdgeScoreboard:ColorPalette", w / 2, h / 2, COLORS["White"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end)

			exitButton.DoClick = function(  )
				colorSelectorPanel:AlphaTo(0, 0.2, 0, function(  )
					self.interactElement.selectorElement:Remove()
				end)
			end

		end

		self.interactElement.OnRemove = function(  )
			if IsValid(self.interactElement.selectorElement) then self.interactElement.selectorElement:Remove() end
		end

		self.interactElement.PaintOver = function( s,w,h )

			--Draw the current status option in the middle.
			draw.SimpleText("Click to select color","EdgeScoreboard:Config_OptionButton",w / 2,h / 2,COLORS["White"],TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		end

	end

	self.GetValue = function(  )
		return self.interactElement:GetValue()
	end

	self.interactElement.ID = id
	self.interactElement:SetSize(self:GetWide(),self:GetTall())
	EdgeScoreboard.SetEdgeTheme(self.interactElement, true, true)

end

-- Register the derma element.
vgui.Register( "EdgeScoreboard:DataModifier", PANEL )