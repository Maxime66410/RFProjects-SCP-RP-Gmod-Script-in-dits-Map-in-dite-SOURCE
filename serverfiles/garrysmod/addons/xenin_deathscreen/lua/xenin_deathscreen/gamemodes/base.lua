XeninDS.Gamemodes:set("base", {
getTeamDetails = function(ply)
  return {
    text = team.GetName(ply:Team()) or "Unknown team",
    color = team.GetColor(ply:Team()) or Color(203, 203, 203)
  }
end
})
