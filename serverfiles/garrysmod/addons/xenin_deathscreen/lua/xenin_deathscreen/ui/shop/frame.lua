local PANEL = {}

local i18n = XeninDS.i18n
local filter = function(tbl, callback)
  local new = {}

  for i, v in pairs(tbl) do
    if (!callback(v, i)) then continue end

    new[i] = v
  end

  return new
end

function PANEL:Init()
  local cards = filter(XeninDS.Config.cards, function(v)
    return !v.animated end)
  local animatedCards = filter(XeninDS.Config.cards, function(v)
    return v.animated end)

  self.Sidebar = self:Add("XeninUI.SidebarV2")
  self.Sidebar:Dock(LEFT)
  self.Sidebar:SetBody(self)
  self.Sidebar:CreatePanel(i18n:get("shop.staticCards", nil, "Static cards"), nil, "XeninDS.Shop.Category.Cards", "eQg85qn", cards)
  self.Sidebar:CreatePanel(i18n:get("shop.animatedCards", nil, "Animated cards"), nil, "XeninDS.Shop.Category.Cards", "uInH5su", animatedCards)
  self.Sidebar:SetActive(1)
end

function PANEL:PerformLayout(w, h)
  local sw = 0
  for i, v in ipairs(self.Sidebar.Sidebar) do
    surface.SetFont("XeninUI.SidebarV2.Name")
    local nameTw = surface.GetTextSize(v.Name or "")
    surface.SetFont("XeninUI.SidebarV2.Desc")
    local descTw = surface.GetTextSize(v.Desc or "")

    local tw = math.max(nameTw, descTw) + 8
    if v.Icon then
      tw = tw + 68
    end

    sw = math.max(sw, tw)
  end

  self.Sidebar:SetWide(math.max(140, sw))
end

vgui.Register("XeninDS.Shop.Standalone", PANEL)

local PANEL = {}

function PANEL:Init()
  XeninDS.Shop = self

  local w = math.min(ScrW(), XeninUI.Frame.Width + 180)
  local h = math.min(ScrH(), XeninUI.Frame.Height + 80)
  self:SetSize(w, h)
  self:Center()
  self:MakePopup()

  self:SetTitle(XeninDS.Config:get("menu_title"))

  self.Panel = self:Add("XeninDS.Shop.Standalone")
  self.Panel:Dock(FILL)
end

vgui.Register("XeninDS.Shop.Frame", PANEL, "XeninUI.Frame")

function XeninDS:OpenShop()
  if IsValid(self.Shop) then
    self.Shop:Remove()
  end

  vgui.Create("XeninDS.Shop.Frame")
end
