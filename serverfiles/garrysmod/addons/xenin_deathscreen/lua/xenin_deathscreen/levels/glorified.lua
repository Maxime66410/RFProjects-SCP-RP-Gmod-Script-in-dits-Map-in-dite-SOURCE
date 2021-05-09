XeninDS.LevelSystem:set("glorified", {
  isInstalled = function()
    return istable(GlorifiedLeveling)
  end,
  getLevel = function(ply)
    return GlorifiedLeveling.GetPlayerLevel(ply)
  end
})
