XeninDS.Currencies:set("ps2_premium", {
  format = function(self, money)
    return string.Comma(money) .. " premium points"
  end,
  add = function(self, ply, money)
    if (CLIENT) then return end

    ply:PS2_AddPremiumPoints(money)
  end,
  get = function(self, ply)
    return ply.PS2_Wallet.premiumPoints
  end,
  canAfford = function(self, ply, amount)
    return ply.PS2_Wallet.premiumPoints >= amount
  end
})
