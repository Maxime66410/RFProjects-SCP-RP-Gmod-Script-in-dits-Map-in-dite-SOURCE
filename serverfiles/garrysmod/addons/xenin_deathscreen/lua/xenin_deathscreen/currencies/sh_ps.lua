XeninDS.Currencies:set("sh_ps", {
  format = function(self, money)
    return string.Comma(money) .. " points"
  end,
  add = function(self, ply, money)
    if CLIENT then return end

    ply:SH_AddStandardPoints(money)
  end,
  get = function(self, ply)
    return ply:SH_GetStandardPoints()
  end,
  canAfford = function(self, ply, amount)
    return ply:SH_GetStandardPoints() >= amount
  end
})
