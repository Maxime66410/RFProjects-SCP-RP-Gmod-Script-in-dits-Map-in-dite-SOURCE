XeninDS.LevelSystem:set("vrondakis", {
  isInstalled = function()
    return istable(LevelSystemConfiguration)
  end,
  getLevel = function(ply)
    return ply:getDarkRPVar("level")
  end
})
