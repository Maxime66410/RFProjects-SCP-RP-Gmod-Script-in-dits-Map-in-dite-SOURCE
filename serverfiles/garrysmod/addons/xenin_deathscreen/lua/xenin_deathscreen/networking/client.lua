local Base = XeninDS.NetworkBase

local Network
do
  local _class_0
  local _parent_0 = Base
  local _base_0 = {
    __name = "Network",
    __base = Base.__base,
    cards = function(self, ply)
      local data = net.ReadTable()

      ply:XeninDeathscreen():set({
        cards = data.cards,
        equipped = data.equipped
      })
    end,
    deathCard = function(self, ply)
      local data = net.ReadTable()
      ply.LastDeathscreenData = data

      XeninDS:Deathscreen(data)
    end,
    purchasedCard = function(self, ply)
      local id = net.ReadString()
      local ds = ply:XeninDeathscreen()
      ds:addCard(id)
    end,
    openMenu = function(self, ply)
      XeninDS:OpenShop()
    end,
    killfeed = function(self, ply)
      local data = net.ReadTable()
      ply.LastKillfeedData = data
      local ds = ply:XeninDeathscreen()
      ds:getKillfeed():addToQueue(data)
    end,
    equipCard = function(self, id)
      self:send("XeninDS.EquipCard", function(self)
        net.WriteString(id)end)
    end,
    purchaseCard = function(self, id)
      self:send("XeninDS.PurchaseCard", function(self)
        net.WriteString(id)end)
    end,
    requestSync = function(self)
      self:send("XeninDS.RequestSync", function(self) end)
    end,
    __type = function(self)
      return "XeninDS.Network"end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__index)
  _class_0 = setmetatable({
    __init = function(self)
      Network.__parent.__init(self)

      self:receiver("XeninDS.Cards", self.cards)
      self:receiver("XeninDS.DeathCard", self.deathCard)
      self:receiver("XeninDS.PurchaseCard", self.purchasedCard)
      self:receiver("XeninDS.OpenMenu", self.openMenu)
      self:receiver("XeninDS.Killfeed", self.killfeed)
    end,
    __base = _base_0,
    __parent = _parent_0
  }, {
    __index = function(cls, parent)
      local val = rawget(_base_0, parent)
      if val == nil then local _parent = rawget(cls, "__parent")
        if _parent then return _parent[parent]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  if _parent_0.__inherited then _parent_0.__inherited(_parent_0, _class_0)
  end
  Network = _class_0
end

XeninDS.Network = Network()

hook.Add("HUDPaint", "XeninDS.Load", function()
  XeninDS.Network:requestSync()

  hook.Remove("HUDPaint", "XeninDS.Load")
end)
