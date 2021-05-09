local ORM
if SERVER then
  ORM = XeninUI.ORM.ORM
else
  local Temp
  do
    local _class_0
    local _base_0 = {
      __name = "Temp",
      __type = function(self)
        return "Temp"end
    }
    _base_0.__index = _base_0
    _class_0 = setmetatable({
      __init = function(self) end,
      __base = _base_0
    }, {
      __index = _base_0,
      __call = function(cls, ...)
        local _self_0 = setmetatable({}, _base_0)
        cls.__init(_self_0, ...)
        return _self_0
      end
    })
    Temp = _class_0
  end

  ORM = Temp
end

local __lauxi0 = XeninDS.Models
assert(__lauxi0 ~= nil, "cannot destructure nil value")
local Card, AnimatedCard = __lauxi0.Card, __lauxi0.AnimatedCard
local Container
do
  local _class_0
  local _parent_0 = ORM
  local _base_0 = {
    __name = "Container",
    __base = ORM.__base,
    loadCards = function(self, sid64)
      self:ensurePlayerExists(tostring(sid64))

      local settings = {}


      return XeninUI.Promises.all({
        self:orm("xenin_deathscreen_cards_settings"):select("setting", "value"):where("sid64", "=", sid64):run():next(function(result)
          if result == nil then result = {}
          end
          for i, v in ipairs(result) do
            settings[v.setting] = v.value
          end

          return self:orm("xenin_deathscreen_cards"):select("card_id"):where("sid64", "=", sid64):run()
        end):next(function(result)
          if result == nil then result = {}
          end
          for i, v in ipairs(result) do
            local card
            if v.animated then
              card = AnimatedCard(v.card_id):setSpeed(settings.animated_speed):setColor(settings.animated_color)
            else
              card = Card(v.card_id)
            end

            self.cards[tostring(sid64)][v.card_id] = card
          end
        end, function(err)
          print(err)end),

        self:orm("xenin_deathscreen_equipped"):select("card_id"):where("sid64", "=", sid64):run():next(function(result)
          if result == nil then result = {}
          end
          for i, v in ipairs(result) do
            self.equipped[tostring(sid64)] = v.card_id
          end
        end, function(err)
          print(err)end)
      })
    end,
    ensurePlayerExists = function(self, sid64)
      self.cards[sid64] = self.cards[sid64] or {}
    end,
    getEquipped = function(self, sid64)
      self:ensurePlayerExists(sid64)

      return self.equipped[sid64]
    end,
    setEquipped = function(self, sid64, id)
      self:ensurePlayerExists(sid64)

      self.equipped[sid64] = id

      return self
    end,
    saveEquipped = function(self, sid64, id)
      return self:orm("xenin_deathscreen_equipped"):delete():where("sid64", "=", sid64):run():next(function()
        return self:orm("xenin_deathscreen_equipped"):insert({
          sid64 = sid64,
          card_id = id
        }):run()
      end)
    end,
    saveCard = function(self, sid64, id)
      return self:orm("xenin_deathscreen_cards"):insert({
        sid64 = sid64,
        card_id = id
      }):run()
    end,
    getCard = function(self, sid64, id)
      self:ensurePlayerExists(sid64)

      return self.cards[sid64][id]
    end,
    addCard = function(self, sid64, id)
      self:ensurePlayerExists(sid64)
      local card = XeninDS.Config:getCard(id)
      self.cards[sid64][id] = card.animated and AnimatedCard(id) or Card(id)

      return self
    end,
    clear = function(self, sid64)
      self.cards[sid64] = nil
      self.equipped[sid64] = nil
      self.respawnTime[sid64] = nil
    end,
    __type = function(self)
      return "XeninDS.Models.Container"end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__index)
  _class_0 = setmetatable({
    __init = function(self)
      self.respawnTime = {}
      self.equipped = {}
      self.cards = {}
      Container.__parent.__init(self, "xenin_deathscreen/migrations/")

      if (CLIENT) then return end

      timer.Simple(1, function()
        hook.Run("XeninDS.LoadedORM")
      end)
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
  Container = _class_0
end

XeninDS.Models.Container = Container()

if (CLIENT) then return end
hook.Add("Xenin.ConfigLoaded", "XeninDS", function()
  XeninDS.Models.Container = Container()
end)
