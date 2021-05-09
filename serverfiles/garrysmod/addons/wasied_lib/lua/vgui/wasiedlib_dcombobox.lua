surface.CreateFont("Wasied_DComboBox_font1", {
	font = "Righteous",
	size = WasiedLib.RespX(30),
	weight = 500,
	antialias = true,
	extended = true,
})
surface.CreateFont("Wasied_DComboBox_font2", {
	font = "Righteous",
	size = WasiedLib.RespX(20),
	weight = 500,
	antialias = true,
	extended = true,
})

local PANEL = {}

function PANEL:Init()
    self:SetValue("X")
end

function PANEL:SetRPos(x, y)
	self:SetPos(WasiedLib.RespX(x), WasiedLib.RespY(y))
end

function PANEL:SetRSize(x, y)
	self:SetSize(WasiedLib.RespX(x), WasiedLib.RespY(y))
end

function PANEL:Paint(w, h)

    if self:IsHovered() then
        surface.SetDrawColor(Color(255, 255, 255, 5))
        surface.DrawRect(0, 0, w, h)
    end

    surface.SetDrawColor(color_white)
    surface.DrawLine(0, 0, 0, 15)
    surface.DrawLine(0, 0, 30, 0)
    surface.DrawLine(w-1, h-1, w-1, h-15)
    surface.DrawLine(w-1, h-1, w-30, h-1)

    surface.DrawLine(w-30, 0, w, 0)
    surface.DrawLine(w-1, 0, w-1, 15)
    surface.DrawLine(0, h, 0, h-15)
    surface.DrawLine(0, h-1, 30, h-1)

end

derma.DefineControl("WASIED_DComboBox", "Wasied DComboBox", PANEL, "DComboBox")