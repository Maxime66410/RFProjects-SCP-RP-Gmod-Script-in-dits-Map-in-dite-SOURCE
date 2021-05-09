local i18n = XeninDS.i18n

local DeathHandler
do
  local _class_0
  local _base_0 = {
    __name = "DeathHandler",
    networkDeath = function(self, ply, tbl)
      XeninDS.Network:sendDeath(ply, tbl)
    end,
    networkKillfeed = function(self, ply, tbl)
      XeninDS.Network:sendKillfeed(ply, tbl)
    end,
    processDeath = function(self, ply, inflictor, attacker)
      local tbl = {}
      tbl.respawnTime = XeninDS.Config:getRespawnTime(ply)

      ply:XeninDeathscreen():setRespawnTime(CurTime() + tbl.respawnTime)

      if (!IsValid(attacker) or attacker:IsWorld()) then
        tbl.tag = XENINDS_TAG_WORLD
        tbl.msg = i18n:get("card.phrases.world", nil, "The world certainly hurts")

        self:networkDeath(ply, tbl)

        return
      end

      if (IsValid(attacker) and attacker:IsPlayer() and ply == attacker) then
        tbl.tag = XENINDS_TAG_SUICIDE
        tbl.msg = i18n:get("card.phrases.suicide", nil, "Mistakes were made")

        self:networkDeath(ply, tbl)

        return
      end

      if (IsValid(attacker) and attacker:IsPlayer() and IsValid(ply) and ply:IsPlayer()) then
        local wep = inflictor
        wep = IsValid(wep) and !wep:IsPlayer() and wep or attacker:GetActiveWeapon() or NULL
        local ds = attacker:XeninDeathscreen()
        local dc = XeninDS.DamageCounter

        if XeninDS.Config:get("killfeed_enabled") then
          local killfeed = {}
          killfeed.ply = {
            object = ply,
            name = ply:Nick(),
            team = XeninDS.Gamemodes:getSubtitle(ply)
          }
          killfeed.tag = XENINDS_TAG_KILLFEED
          killfeed.level = XeninDS.LevelSystem:getLevel(ply)
          killfeed.card = ply:XeninDeathscreen():getEquipped()
          killfeed.animated = (XeninDS.Config:getCard(killfeed.card) and XeninDS.Config:getCard(killfeed.card).animated)
          killfeed.damage = dc:get(attacker, ply) or {}

          self:networkKillfeed(attacker, killfeed)
        end

        tbl.msg = i18n:get("card.phrases.player", nil, "You were killed")
        tbl.tag = XENINDS_TAG_PLAYER
        tbl.card = ds:getEquipped()
        tbl.ply = {
          object = attacker,
          name = attacker:Nick(),
          team = XeninDS.Gamemodes:getSubtitle(attacker)
        }
        tbl.hp = {
          current = math.max(0, attacker:Health()),

          max = math.max(attacker:Health(), attacker:GetMaxHealth())
        }
        tbl.ap = {
          current = attacker:Armor(),
          max = math.max(attacker:Armor(), 100)
        }
        tbl.damage = {
          attacker = dc:get(attacker, ply) or {},
          victim = dc:get(ply, attacker) or {}
        }
        tbl.level = XeninDS.LevelSystem:getLevel(attacker)
        tbl.wep = wep
        tbl.animated = (XeninDS.Config:getCard(tbl.card) and XeninDS.Config:getCard(tbl.card).animated)

        self:networkDeath(ply, tbl)

        return
      end
    end,
    deathThink = function(self, ply)
      return (ply:XeninDeathscreen():getRespawnTime() or 0) < CurTime()
    end,
    __type = function(self)
      return "XeninDS.DeathHandler"end
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
  DeathHandler = _class_0
end

XeninDS.DeathHandler = DeathHandler()

hook.Add("PlayerDeath", "XeninDS", function(...)
  if ((MedConfig and MedConfig.XeninDS)) then return end

  XeninDS.DeathHandler:processDeath(...)
end)
hook.Add("GMedic.Ragdoll", "XeninDS", function(...)
  XeninDS.DeathHandler:processDeath(...)end)
hook.Add("OnRagdolize", "XeninDS", function(...)
  XeninDS.DeathHandler:processDeath(...)end)

hook.Add("PlayerDeathThink", "XeninDS", function(ply)
  if (XeninDS.Config:get("respawn_timer_enabled")) then return end
  if (ply:IsBot()) then return end

  if (!XeninDS.DeathHandler:deathThink(ply)) then
    return false
  end
end)
