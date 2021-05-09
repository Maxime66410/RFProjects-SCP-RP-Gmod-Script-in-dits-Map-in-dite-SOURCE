local Card = XeninDS.Models.Card
local AnimatedCard = XeninDS.Models.AnimatedCard
local Network = XeninDS.Network

local Deck
do
  local _class_0
  local _base_0 = {
    __name = "Deck",
    load = function(self)
      self.container:loadCards(self.sid64):next(function()
        self:networkToPlayer()
      end, function(err)
        print(err)end)
    end,
    networkToPlayer = function(self, data)
      XeninDS.Network:sendCards(self.ply, {
        cards = {
        [self.sid64] = self:getCards() or {}
        },
        equipped = {
        [self.sid64] = self:getEquipped()
        }
      })
    end,
    set = function(self, tbl)
      for i, v in pairs(tbl) do
        self.container[i] = v
      end
    end,
    get = function(self, id)
      return self.container[id]
    end,
    getCards = function(self)
      return self.container.cards[self.sid64]
    end,
    getCard = function(self, id)
      return self.container:getCard(self.sid64, id)
    end,
    addCard = function(self, id, network)
      local card = XeninDS.Config:getCard(id)
      if (!card) then return end

      self.container:addCard(self.sid64, id)

      if (CLIENT and network) then
        XeninDS.Network:purchaseCard(id)
      end
    end,
    saveCard = function(self, id)
      local card = XeninDS.Config:getCard(id)
      if (!card) then return end

      self.container:saveCard(self.sid64, id)
    end,
    getAnimatedCards = function(self)
      return self.container.animatedCards[self.sid64]
    end,
    getAnimatedCard = function(self, id)
      return self.container:getCard(self.sid64, id, true)
    end,
    getEquipped = function(self)
      return self.container:getEquipped(self.sid64) or XeninDS.Config:get("card_default")
    end,
    equipCard = function(self, id, network)
      self.container:setEquipped(self.sid64, id)

      if (CLIENT and network) then
        XeninDS.Network:equipCard(id)
      end
    end,
    saveEquippedCard = function(self)
      if (CLIENT) then return end

      self.container:saveEquipped(self.sid64, self:getEquipped())
    end,
    setRespawnTime = function(self, time)
      self.container.respawnTime[self.sid64] = time
    end,
    getRespawnTime = function(self)
      return self.container.respawnTime[self.sid64]
    end,
    getContainer = function(self)
      return self.container
    end,
    getKillfeed = function(self)
      return self.killfeed
    end,
    __type = function(self)
      return "XeninDS.Controllers.Deck"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, ply)
      self.container = XeninDS.Models.Container
      self.killfeed = XeninDS.Models.Killfeed()
      self.ply = ply
      self.sid64 = ply:SteamID64()
    end,
    __base = _base_0
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  Deck = _class_0
end

XeninDS.Controllers.Deck = Deck

local PLY = FindMetaTable("Player")

function PLY:XeninDeathscreen()
  if (!self._XeninDeathscreen) then
    self._XeninDeathscreen = Deck(self)
  end

  return self._XeninDeathscreen
end

hook.Add("PlayerInitialSpawn", "XeninDS", function(ply)
  timer.Simple(3, function()
    if (!IsValid(ply)) then return end

    ply:XeninDeathscreen()
  end)
end)

hook.Add("PlayerDisconnected", "XeninDS.DamageCounter", function(ply)
  local sid64 = ply:SteamID64()
  if (!sid64) then return end

  if XeninDS.Models.Container then
    XeninDS.Models.Container:clear(sid64)
  end
end)
