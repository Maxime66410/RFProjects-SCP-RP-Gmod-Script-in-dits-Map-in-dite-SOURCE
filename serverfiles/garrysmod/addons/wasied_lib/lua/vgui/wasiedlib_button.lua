surface.CreateFont("Wasied_Button_Font1", {
	font = "Righteous",
	size = WasiedLib.RespX(30),
	weight = 500,
	antialias = true,
	extended = true,
})
surface.CreateFont("Wasied_Button_Font2", {
	font = "Righteous",
	size = WasiedLib.RespX(20),
	weight = 500,
	antialias = true,
	extended = true,
})

local PANEL = {}

function PANEL:Init()
    self:SetText("")

    self.text = ""
    self.textColor = Color(40, 255, 40)

    self.fontType = 0
end

function PANEL:SetRPos(x, y)
	self:SetPos(WasiedLib.RespX(x), WasiedLib.RespY(y))
end

function PANEL:SetRSize(x, y)
	self:SetSize(WasiedLib.RespX(x), WasiedLib.RespY(y))
end

function PANEL:GetLibText()
    return self.text
end

function PANEL:SetLibText(text, color, fontType)
    if IsColor(color) && isstring(text) then
        self.text = text
        self.textColor = color
        
        if isnumber(fontType) then
            self.fontType = fontType
        end
    end
end

function PANEL:DoClick()
    if IsValid(self) then
        surface.PlaySound("buttons/button14.wav")
    end
end

function PANEL:Paint(w, h)

    if self:IsHovered() then
        surface.SetDrawColor(Color(255, 255, 255, 5))
        surface.DrawRect(0, 0, w, h)
    end

    if self.fontType == 0 then
        draw.SimpleText(self.text, "Wasied_Button_Font1", w/2, h/2, self.textColor, 1, 1)

        surface.SetDrawColor(color_white)
        surface.DrawLine(0, 0, 0, 15)
        surface.DrawLine(0, 0, 30, 0)
        surface.DrawLine(w-1, h-1, w-1, h-15)
        surface.DrawLine(w-1, h-1, w-30, h-1)

        surface.DrawLine(w-30, 0, w, 0)
        surface.DrawLine(w-1, 0, w-1, 15)
        surface.DrawLine(0, h, 0, h-15)
        surface.DrawLine(0, h-1, 30, h-1)

    elseif self.fontType == 1 then

        draw.SimpleText(self.text, "Wasied_Button_Font2", w/2, h/2, self.textColor, 1, 1)
        
        surface.SetDrawColor(color_white)
        surface.DrawLine(0, 0, 0, 10)
        surface.DrawLine(0, 0, 20, 0)
        surface.DrawLine(w-1, h-1, w-1, h-10)
        surface.DrawLine(w-1, h-1, w-20, h-1)

        surface.DrawLine(w-20, 0, w, 0)
        surface.DrawLine(w-1, 0, w-1, 10)
        surface.DrawLine(0, h, 0, h-10)
        surface.DrawLine(0, h-1, 20, h-1)

    end
end

derma.DefineControl("WASIED_DButton", "Wasied DButton", PANEL, "DButton")