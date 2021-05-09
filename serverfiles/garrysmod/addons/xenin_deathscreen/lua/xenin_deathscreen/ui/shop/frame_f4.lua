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

  self.Navbar = self:Add("XeninUI.Navbar")
  self.Navbar:Dock(TOP)
  self.Navbar:SetBody(self)
  self.Navbar:AddTab(i18n:get("shop.staticCards", nil, "Static cards"):upper(), "XeninDS.Shop.Category.Cards", cards)
  self.Navbar:AddTab(i18n:get("shop.animatedCards", nil, "Animated cards"):upper(), "XeninDS.Shop.Category.Cards", animatedCards)
  self.Navbar:SetActive(i18n:get("shop.staticCards", nil, "Static cards"):upper())
end

function PANEL:PerformLayout(w, h)
  self.Navbar:SetTall(56)
end

vgui.Register("XeninDS.Shop", PANEL)
