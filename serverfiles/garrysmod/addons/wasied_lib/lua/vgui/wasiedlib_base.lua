surface.CreateFont("Wasied_Frame_Font1", {
	font = "Arial",
	size = WasiedLib.RespX(40),
	weight = 500,
	antialias = true,
})
surface.CreateFont("Wasied_Frame_Font2", {
	font = "Pacifico",
	size = WasiedLib.RespX(60),
	weight = 500,
	antialias = true,
	extended = true,
})
surface.CreateFont("Wasied_Frame_Font3", {
	font = "Righteous",
	size = WasiedLib.RespX(15),
	weight = 200,
	antialias = true,
})

local PANEL = {}

function PANEL:Init()
    self:SetTitle("")
	self:MakePopup()
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	
	self.title = ""
end

function PANEL:SetRPos(x, y)
	self:SetPos(WasiedLib.RespX(x), WasiedLib.RespY(y))
end

function PANEL:SetRSize(x, y)
	self:SetSize(WasiedLib.RespX(x), WasiedLib.RespY(y))
end

function PANEL:SetLibTitle(str)
	self.title = str
end

function PANEL:CloseButton(bool)
	if isbool(bool) && bool then

		local closeButton = vgui.Create("DImageButton", self)
		closeButton:SetSize(WasiedLib.RespX(20), WasiedLib.RespY(20))
		closeButton:SetPos(self:GetWide()-closeButton:GetWide()-WasiedLib.RespX(5), WasiedLib.RespY(5))
		closeButton:SetText("")
		closeButton:SetImage("icon16/cross.png")
		closeButton.DoClick = function()
			if IsValid(self) then
				self:Remove()
			end
		end

	end
end

function PANEL:Paint(w, h)
	draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0, 250))
	
	surface.SetDrawColor(color_white)
	surface.DrawLine(WasiedLib.RespX(50), WasiedLib.RespY(65), w-WasiedLib.RespX(50), WasiedLib.RespY(65))
	
	draw.SimpleText(self.title, "Wasied_Frame_Font2", w/2, 0, color_white, 1, 3)
end

derma.DefineControl("WASIED_DFrame", "Wasied DFrame", PANEL, "DFrame")