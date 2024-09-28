local game = Game()

function Talismans:spawnTalismans(player)
    --Isaac.DebugString("rat Talisman ID: " .. tostring(TalismanId.RAT))
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_RAT, Vector(170,250), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_OX, Vector(220,250), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_TIGER, Vector(270,250), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_RABBIT, Vector(370,250), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_DRAGON, Vector(420,250), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_SNAKE, Vector(470,250), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_HORSE, Vector(170,300), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_SHEEP, Vector(220,300), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_MONKEY, Vector(270,300), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_ROOSTER, Vector(370,300), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_DOG, Vector(420,300), Vector(0,0), nil)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Talismans.Enums.CollectibleType.COLLECTIBLE_PIG, Vector(470,300), Vector(0,0), nil)
end

--when passive effects should update
function Talismans:onUpdate(player)
    if Isaac.HasModData(Talismans) then
        Isaac.DebugString("Mod data exists for Talismans mod.")
    else
        Isaac.DebugString("Mod data does not exist for Talismans mod.")
    end
    -- Begining of run initializations
    if game:GetFrameCount() == 1 then
        Talismans.spawnTalismans(player)
    end
end

Talismans:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Talismans.onUpdate)
