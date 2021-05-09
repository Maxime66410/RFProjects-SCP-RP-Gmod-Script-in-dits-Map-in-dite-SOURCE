local Counter
do
  local _class_0
  local _base_0 = {
    __name = "Counter",
    get = function(self, attacker, victim)
      return self.data[attacker] and self.data[attacker][victim]
    end,
    takeDamage = function(self, target, dmginfo)
      local victim = target:IsPlayer() and target
      local attacker = IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker()
      if (!victim or !attacker) then return end

      self.data[attacker] = self.data[attacker] or {}
      self.data[attacker][victim] = self.data[attacker][victim] or {}

      local old = self.data[attacker][victim]
      old.dmg = old.dmg or 0
      old.hits = old.hits or 0

      self.data[attacker][victim] = {
        dmg = old.dmg + math.Round(dmginfo:GetDamage()),
        hits = old.hits + 1,
        time = CurTime()
      }
    end,
    playerSpawn = function(self, ply)
      self.data[ply] = nil

      for i, v in pairs(self.data) do
        v[ply] = nil
      end
    end,
    resetCheck = function(self)
      for i, v in pairs(self.data) do
        if (!IsValid(i)) then continue end

        for vic, data in pairs(v) do
          if (!IsValid(vic)) then self.data[i][vic] = nil end

          if (data.time + 30 < CurTime()) then
            self.data[i][vic] = nil

            if (table.Count(self.data[i]) == 0) then
              self.data[i] = nil
            end
          end
        end
      end
    end,
    __type = function(self)
      return "XeninDS.DamageCounter"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.data = {}
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
  Counter = _class_0
end

XeninDS.DamageCounter = Counter()

hook.Add("EntityTakeDamage", "XeninDS.DamageCounter", function(...)
  XeninDS.DamageCounter:takeDamage(...)end)
hook.Add("PlayerSpawn", "XeninDS.DamageCounter", function(...)
  XeninDS.DamageCounter:playerSpawn(...)end)
timer.Create("XeninDS.DamageCounter", 1, 0, function()
  XeninDS.DamageCounter:resetCheck()end)
