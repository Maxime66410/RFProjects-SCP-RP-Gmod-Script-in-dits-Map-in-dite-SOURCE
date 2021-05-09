XeninDS.LevelSystem:set("el", {
  isInstalled = function()
    local meta = FindMetaTable("Player")

    return isfunction(meta.EL_playerRankDraw)
  end,
  getLevel = function(ply)
    return 1
  end,
  getString = function(ply, level)
    return ply:EL_playerRankDraw() or 0
  end
})
