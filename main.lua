Talismans = RegisterMod("Talismans", 1)

--core
require("lua.core.enums")

require("lua.items.Translations")

include("lua.items.spawn")

--passive
include("lua.items.passive.DragonTalisman.main")
include("lua.items.passive.OxTalisman.main")

--[[
local TalismanId = {
    RAT = Isaac.GetItemIdByName("the Rat Talisman"),
    OX = Isaac.GetItemIdByName("the Ox Talisman"),
    TIGER = Isaac.GetItemIdByName("the Tiger Talisman"),
    RABBIT = Isaac.GetItemIdByName("the Rabbit Talisman"),
    DRAGON = Isaac.GetItemIdByName("the Dragon Talisman"),
    SNAKE = Isaac.GetItemIdByName("the Snake Talisman"),
    HORSE = Isaac.GetItemIdByName("the Horse Talisman"),
    SHEEP = Isaac.GetItemIdByName("the Sheep Talisman"),
    MONKEY = Isaac.GetItemIdByName("the Monkey Talisman"),
    ROOSTER = Isaac.GetItemIdByName("the Rooster Talisman"),
    DOG = Isaac.GetItemIdByName("the Dog Talisman"),
    PIG = Isaac.GetItemIdByName("the Pig Talisman")
}

local HasTalisman = {
    RAT = false,
    OX = false,
    TIGER = false,
    RABBIT = false,
    DRAGON = false,
    SNAKE = false,
    HORSE = false,
    SHEEP = false,
    MONKEY = false,
    ROOSTER = false,
    DOG = false,
    PIG = false
}

--Update the inventory
local function UpdateTalismans(player) 
    HasTalisman.RAT = player:HasCollectible(TalismanId.RAT)
    HasTalisman.OX = player:HasCollectible(TalismanId.OX)
    HasTalisman.TIGER = player:HasCollectible(TalismanId.TIGER)
    HasTalisman.RABBIT = player:HasCollectible(TalismanId.RABBIT)
    HasTalisman.DRAGON = player:HasCollectible(TalismanId.DRAGON)
    HasTalisman.SNAKE = player:HasCollectible(TalismanId.SNAKE)
    HasTalisman.HORSE = player:HasCollectible(TalismanId.HORSE)
    HasTalisman.SHEEP = player:HasCollectible(TalismanId.SHEEP)
    HasTalisman.MONKEY = player:HasCollectible(TalismanId.MONKEY)
    HasTalisman.ROOSTER = player:HasCollectible(TalismanId.ROOSTER)
    HasTalisman.DOG = player:HasCollectible(TalismanId.DOG)
    HasTalisman.PIG = player:HasCollectible(TalismanId.PIG)
end
--when the run starts or continues
function Talismans:onPlayerInit(player)
    UpdateTalismans(player)
end
Talismans:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Talismans.onPlayerInit)


USAGE:

UpdateTalismans(player)


]]

