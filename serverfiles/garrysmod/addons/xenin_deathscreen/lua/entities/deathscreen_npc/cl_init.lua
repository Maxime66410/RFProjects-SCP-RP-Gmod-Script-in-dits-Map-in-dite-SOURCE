include("shared.lua")

function ENT:Draw()
  self:DrawModel()

  local ply = LocalPlayer()
  local pos = self:GetPos()
  local eyePos = ply:GetPos()
  local dist = pos:Distance(eyePos)
  local alpha = math.Clamp(2500 - dist * 2.7, 0, 255)

  if (alpha <= 0) then return end

  local angle = self:GetAngles()
  local eyeAngle = ply:EyeAngles()

  angle:RotateAroundAxis(angle:Forward(), 90)
  angle:RotateAroundAxis(angle:Right(), -90)

  local cfg = XeninDS.Config
  cam.Start3D2D(pos + self:GetUp() * 90, Angle(0, eyeAngle.y - 90, 90), 0.04)
  XeninUI:DrawNPCOverhead(self, {
    alpha = alpha,
    text = cfg:get("npc_title"),
    sin = true,
    textOffset = 0,
    color = cfg:get("npc_color")
  })
  cam.End3D2D()
end
