local test = XeninUI.Units.Test("i18n"):setBeforeAll(function(self)
  self.i18n = XeninDS.i18n
end):setAfterAll(function(self)
  self.i18n = nil
end):addSpec("Be able to download the English version", function(self)
  return self.i18n.lang:Download("english", true)
end):addSpec("Download English, and check if phrase 'shop.staticCards' exist", function(self)
  local p = XeninUI.Promises.new()

  self.i18n.lang:Download("english", true):next(function(phrases)
    XeninUI.Units.Assert(phrases):isType("table")

    XeninUI.Units.Assert((((phrases and phrases.phrases) and phrases.phrases.shop) and phrases.phrases.shop.staticCards)):isType("string"):shouldEqual("Static cards")

    p:resolve()
  end, function(err)
    p:reject(err)
  end)

  return p
end):addSpec("Download another language, in this case German", function(self)
  local p = XeninUI.Promises.new()

  self.i18n.lang:Download("german", true):next(function(phrases)
    XeninUI.Units.Assert(phrases):isType("table")

    p:resolve()
  end, function(err)
    p:reject(err)
  end)

  return p
end):addSpec("Get phrase 'shop.staticCards'", function(self)
  XeninUI.Units.Assert(XeninDS.i18n:get("shop.staticCards")):isNotNil():isType("string")
end)


XeninDS:AddTest(test)
