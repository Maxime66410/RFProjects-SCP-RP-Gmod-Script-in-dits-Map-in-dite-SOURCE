XeninDS.Gamemodes:set("ttt", {
  match = {
    "terrortown",
    "ttt"
  },
  detect = function()
    local player = FindMetaTable("Player")

    return player.IsTraitor != nil
  end,
  getTeamDetails = function(ply)
    local cols = {
      [ROLE_TRAITOR] = XeninUI.Theme.Red,
      [ROLE_INNOCENT] = XeninUI.Theme.Green,
      [ROLE_DETECTIVE] = XeninUI.Theme.Blue
    }

    local str = ply:GetRoleString() or ""
    str = str:sub(1, 1):upper() .. str:sub(2)

    return {
      text = str,
      color = cols[ply:GetRole()] or color_white
    }
  end
})
