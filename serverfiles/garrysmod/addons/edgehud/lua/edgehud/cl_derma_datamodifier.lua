surface.CreateFont( "EdgeHUD:DataModifier:Boolean", {
	font = "roboto",
	weight = 500,
	size = ScrH() * 0.02,
} )

--Create the table used for the element.
local PANEL = {}

--Create a init function for the element.
function PANEL:Init()

	--Set the default size.
	self:SetSize( 150, 25 )

end

--PAint the element.
function PANEL:Paint( w, h )

	--Draw the background.
	surface.SetDrawColor(255,255,255,255)
	surface.DrawRect(0,0,w,h)

end

--Create a function used to set the configID.
function PANEL:SetID(id)

	--Define self.interactElement.
	self.interactElement = nil

	--Create the basic paint function.
	local function basicPaint( s, w, h )

		--Draw the background.
		surface.SetDrawColor(s:IsHovered() and Color(80,80,80,255) or Color(50,50,50,255))
		surface.DrawRect(0,0,w,h)

		--Draw the white outline.
		surface.SetDrawColor(200,200,200,255)
		surface.DrawOutlinedRect(0,0,w,h)

	end

	--Check what type the configValue is.
	if EdgeHUD.Configuration.ConfigOptions[id].TypeEnum == EDGEHUD_CONFIG_BOOL then

		self.interactElement = vgui.Create("DButton",self)
		self.interactElement:SetText("")
		self.interactElement.value = EdgeHUD.Configuration.GetConfigValue(id)

		self.interactElement.GetValue = function(  )
			return self.interactElement.value
		end

		self.interactElement.Paint = function( s, w, h )

			--Call the basic paint function.
			basicPaint( s,w, h )

			--Draw the current status option in the middle.
			draw.SimpleText(self.interactElement.value == true and "Yes" or "No","EdgeHUD:DataModifier:Boolean",w / 2,h / 2,Color(255,255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

		end

		self.interactElement.DoClick = function(  )
			self.interactElement.value = !self.interactElement.value
		end

	elseif EdgeHUD.Configuration.ConfigOptions[id].TypeEnum == EDGEHUD_CONFIG_STRING then

		self.interactElement = vgui.Create("DTextEntry",self)
		self.interactElement:SetText(EdgeHUD.Configuration.GetConfigValue(id))

		self.interactElement.AllowInput = function( ... )

			if #self.interactElement:GetValue() >= EdgeHUD.Configuration.ConfigOptions[id].maxLength then
				return true
			end

		end

		self.interactElement.Paint = function( s, w, h )

			--Call the basic paint function.
			basicPaint( s,w, h )

			--Draw the text.
			s:DrawTextEntryText(Color(255, 255, 255), Color(0, 0, 255), Color(255, 255, 255))

		end

	elseif EdgeHUD.Configuration.ConfigOptions[id].TypeEnum == EDGEHUD_CONFIG_NUMBER then

		self.interactElement = vgui.Create("DNumberWang",self)
		self.interactElement:SetDecimals(0)
		self.interactElement:SetMinMax( EdgeHUD.Configuration.ConfigOptions[id].minNum, EdgeHUD.Configuration.ConfigOptions[id].maxNum )
		self.interactElement:SetText(EdgeHUD.Configuration.GetConfigValue(id))
		self.interactElement:SetUpdateOnType(false)

		self.interactElement.OnFocusChanged = function(  )

			local value = tonumber(self.interactElement:GetValue())

			if value == nil then
				self.interactElement:SetText(EdgeHUD.Configuration.ConfigOptions[id].Default)
			elseif value % 1 != 0 then
				self.interactElement:SetText(EdgeHUD.Configuration.ConfigOptions[id].Default)
			elseif value > EdgeHUD.Configuration.ConfigOptions[id].maxNum then
				self.interactElement:SetText(EdgeHUD.Configuration.ConfigOptions[id].maxNum)
			elseif value < EdgeHUD.Configuration.ConfigOptions[id].minNum then
				self.interactElement:SetText(EdgeHUD.Configuration.ConfigOptions[id].minNum)
			end

		end

		self.interactElement.Paint = function( s, w, h )

			--Call the basic paint function.
			basicPaint( s,w, h )

			--Draw the text.
			s:DrawTextEntryText(Color(255, 255, 255), Color(0, 0, 255), Color(255, 255, 255))

		end

	elseif EdgeHUD.Configuration.ConfigOptions[id].TypeEnum == EDGEHUD_CONFIG_TABLE then

		self.interactElement = vgui.Create("DComboBox",self)
		self.interactElement:SetText(EdgeHUD.Configuration.GetConfigValue(id))
		self.interactElement:SetTextColor(Color(255,255,255,255))
		self.interactElement:SetSortItems(EdgeHUD.Configuration.ConfigOptions[id].SortItems)

		self.interactElement.Paint = basicPaint

		for k,v in pairs(EdgeHUD.Configuration.ConfigOptions[id].AllowedValues) do
			self.interactElement:AddChoice(v,v)
		end

	end

	self.interactElement.ID = id
	self.interactElement:SetSize(self:GetWide(),self:GetTall())

end

--Register the derma element.
vgui.Register( "EdgeHUD:DataModifier", PANEL, "Panel" )