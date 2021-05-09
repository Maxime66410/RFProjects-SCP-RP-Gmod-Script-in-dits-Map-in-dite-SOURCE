local i18n
do
  local _class_0
  local _base_0 = {
    __name = "i18n",
    setLanguage = function(self, lang, tbl)
      self.lang:Download("english", true)
      self.lang:SetActiveLanguage(lang)
      if (lang != "english" and !tbl) then
        self.lang:Download(lang, true)
      elseif tbl then
        self.lang:SetLocalLanguage(lang, tbl)
      end
    end,
    get = function(self, phrase, replacement, default)
      if replacement == nil then replacement = {}
      end
      local cache = self.lang:GetPhrase(phrase, replacement)
      if (cache and !istable(cache) and cache != "") then
        return cache
      end

      for i, v in pairs(replacement) do
        default = default:Replace(":" .. tostring(i) .. ":", v)
      end

      return default
    end,
    __type = function(self)
      return "XeninDS.i18n"end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.lang = XeninUI:Language("xenin_deathscreen")
      self.lang:SetURL("https://gitlab.com/sleeppyy/xenin-languages")
      self.lang:SetFolder("deathscreen")
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
  i18n = _class_0
end

XeninDS.i18n = i18n()
