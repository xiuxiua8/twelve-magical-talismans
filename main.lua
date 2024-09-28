Talismans = RegisterMod("Talismans", 1)

--core
include("lua.core.enums")

include("lua.items.spawn")

--passive
include("lua.items.passive.DragonTalisman.main")
include("lua.items.passive.OxTalisman.main")

--mod compatibility
include("lua.mod_compat.eid.eid")


include("lua.items.Translations")

--Isaac.DebugString("the options says the language is: ".. tostring(Options.Language))

--[[

]]

