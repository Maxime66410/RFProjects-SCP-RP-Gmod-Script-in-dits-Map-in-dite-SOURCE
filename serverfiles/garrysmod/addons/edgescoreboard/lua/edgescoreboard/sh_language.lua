-- Create a table for the languages.
EdgeScoreboard.RegistredLanguages = {}

-- Create a function to register a new language.
function EdgeScoreboard.RegisterLanguage( tbl )

	-- Check so we have all the required arguments.
	if !tbl or !tbl.Name or !tbl.Author or !tbl.CompatibleVersion then
		ErrorNoHalt("Failed to register language. Missing language registration argument(s).\nRequired Arguments:\n	Name: Name of the language.\n	Author: Author of the language.\n	CompatibleVersion: Latest version that the language is compatible with.")
		return
	end

	-- Register the language.
	EdgeScoreboard.RegistredLanguages[tbl.Name] = tbl

	-- Return the language table.
	return EdgeScoreboard.RegistredLanguages[tbl.Name]

end

-- Create a function to add a new phrase to a language.
function EdgeScoreboard.AddPhrase( tbl, phraseID, phrase )

	-- Check if the phrase is nil.
	if phrase == nil then return end

	-- Check so we have all the required arguments.
	if !tbl or !phraseID then
		ErrorNoHalt("Failed to add phrase. Missing argument(s).\nRequired Arguments:\n	1: Language table from language registration.\n	2: An phraseID.\n	3: The phrase itself.")
		return
	end

	-- Add teh phrase to the language table.
	EdgeScoreboard.RegistredLanguages[tbl.Name][phraseID] = phrase

end

-- Create a function to get a language phrase.
function EdgeScoreboard.GetPhrase( phraseID )

	-- Get the current language.
	local curLang = EdgeScoreboard.GetConfigValue( "Language" )

	-- Check if the phrase exists.
	if !EdgeScoreboard.RegistredLanguages[curLang][phraseID] then
		curLang = "English"
	end

	-- Return the phrase.
	return EdgeScoreboard.RegistredLanguages[curLang][phraseID] or "[!!!] Missing Phrase [!!!]"

end

-- Load all languages.
local installedLanguages = file.Find("edgescoreboard/languages/*","LUA")

-- Loop through all languages that we found.
for k,v in pairs(installedLanguages) do

	-- Load the language.
	AddCSLuaFile("edgescoreboard/languages/" .. v)
	include("edgescoreboard/languages/" .. v)

end