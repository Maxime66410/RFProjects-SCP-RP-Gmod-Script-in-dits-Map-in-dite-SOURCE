util.AddNetworkString("XeninDS.Cards")
util.AddNetworkString("XeninDS.EquipCard")
util.AddNetworkString("XeninDS.PurchaseCard")
util.AddNetworkString("XeninDS.DeathCard")
util.AddNetworkString("XeninDS.OpenMenu")
util.AddNetworkString("XeninDS.Killfeed")
util.AddNetworkString("XeninDS.RequestSync")

local Base = XeninDS.NetworkBase

local Network
do
  local _class_0
  local _parent_0 = Base
  local _base_0 = {
    __name = "Network",
    __base = Base.__base,
    purchaseCard = function(self, ply)
      local id = net.ReadString()
      local card = XeninDS.Config:getCard(id)
      if (!card) then return end
      if (card.unpurchasable) then return end
      local controller = ply:XeninDeathscreen()
      if (controller:getCard(id)) then return end
      local currency = XeninDS.Currencies
      if card.currency then currency = currency.currencies[card.currency]end
      if (!currency:canAfford(ply, card.price)) then return end
      if (card.usergroupRestriction and !card.usergroupRestriction[ply:GetUserGroup()]) then return end
      if (card.levelRequirement and XeninDS.LevelSystem:getLevel(ply) < card.levelRequirement) then return end
      if (card.steamids and !card.steamids[ply:SteamID64()]) then return end

      currency:add(ply, -card.price)
      controller:addCard(id)
      controller:saveCard(id)
    end,
    equipCard = function(self, ply)
      local id = net.ReadString()
      local card = XeninDS.Config:getCard(id)
      if (!card) then return end
      local controller = ply:XeninDeathscreen()
      if (!controller:getCard(id)) then return end

      controller:equipCard(id)
      controller:saveEquippedCard()
    end,
    requestSync = function(self, ply)
      if (ply.__XeninDSHasRequestedSync) then return end
      ply.__XeninDSHasRequestedSync = true

      ply:XeninDeathscreen():load()
    end,
    sendCards = function(self, ply, data)
      self:send("XeninDS.Cards", ply, function(self)
        net.WriteTable(data)end)
    end,
    sendDeath = function(self, ply, data)
      self:send("XeninDS.DeathCard", ply, function(self)
        net.WriteTable(data)end)
    end,
    sendKillfeed = function(self, ply, data)
      self:send("XeninDS.Killfeed", ply, function(self)
        net.WriteTable(data)end)
    end,
    sendCard = function(self, ply, id)
      self:send("XeninDS.PurchaseCard", ply, function(self)
        net.WriteString(id)end)
    end,
    openMenu = function(self, ply)
      self:send("XeninDS.OpenMenu", ply, function(self) end)
    end,
    __type = function(self)
      return "XeninDS.Network"end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__index)
  _class_0 = setmetatable({
    __init = function(self)
      Network.__parent.__init(self)

      self:receiver("XeninDS.EquipCard", self.equipCard)
      self:receiver("XeninDS.PurchaseCard", self.purchaseCard)
      self:receiver("XeninDS.RequestSync", self.requestSync)
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
