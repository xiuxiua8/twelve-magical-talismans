local Talismans = RegisterMod("Talismans", 1)
local game = Game()

--Talismans.COLLECTIBLE_ROOSTER_TALISMAN = Isaac.GetItemIdByName("the Rooster Talisman")

local TalismanId = {
    ROOSTER = Isaac.GetItemIdByName("the Rooster Talisman"),
    OX = Isaac.GetItemIdByName("the Ox Talisman"),
    RABBIT = Isaac.GetItemIdByName("the Rabbit Talisman")
}

local HasTalisman = {
    ROOSTER = false,
    OX = false,
    RABBIT = false
}

local Bonus = {
    ROOSTER = true,
    OX = 5,
    RABBIT = 0.5
}


function Talismans:RoosteronUpdate()
    if Isaac.HasModData(Talismans) then
        Isaac.DebugString("Mod data exists for Talismans mod.")
    else
        Isaac.DebugString("Mod data does not exist for Talismans mod.")
    end
    
    -- Begining of run initializations
    if Game():GetFrameCount() == 1 then
        Isaac.DebugString("Rooster Talisman ID: " .. tostring(TalismanId.ROOSTER))
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.ROOSTER, Vector(320,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.OX, Vector(270,300), Vector(0,0), nil)
    end
        
    -- Rooster Talismans functionality
    --for playerNum = 1, Game():GetNumPlayer() do
    --for 1, player in ipairs(Isaac.GetPlayers()) do
    for playerNum = 1, 1 do
        local player = Game():GetPlayer(playerNum) 
        if player:HasCollectible(TalismanId.ROOSTER) then
            if not HasTalisman.ROOSTER then 
                player:AddSoulHearts(2)
                HasTalisman.ROOSTER = true
            end
            --player.CanFly = true
            for i, entity in pairs(Isaac.GetRoomEntities()) do
                if entity:IsVulnerableEnemy() and math.random(500) <= 7 then
                    entity:AddPoison(EntityRef(player), 100, 3.5)
                end
            end
        end
    end
end
-- 将函数注册为MC_POST_UPDATE回调，这样它将在每一帧结束后被调用
--Talismans:AddCallback(ModCallbacks.MC_POST_UPDATE, Talismans.RoosteronUpdate)



--Update the inventory
local function UpdateTalismans(player) 
    HasTalisman.ROOSTER = player:HasCollectible(TalismanId.ROOSTER)
    HasTalisman.OX = player:HasCollectible(TalismanId.OX)
    HasTalisman.RABBIT = player:HasCollectible(TalismanId.RABBIT)
end



--when the run starts or continues
function Talismans:onPlayerInit(player)
    UpdateTalismans(player)
end
Talismans:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Talismans.onPlayerInit)



--when passive effects should update
function Talismans:onUpdate(player)
    -- Begining of run initializations
    if game:GetFrameCount() == 1 then
        Isaac.DebugString("Rooster Talisman ID: " .. tostring(TalismanId.ROOSTER))
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.ROOSTER, Vector(320,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.OX, Vector(270,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.RABBIT, Vector(370,300), Vector(0,0), nil)
        if player:GetName() == "Isaac" then
            player:AddCollectible(TalismanId.OX, 0, true)
        end 
    end
    UpdateTalismans(player)
end

Talismans:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Talismans.onUpdate)



--When we update the cache
function Talismans:onCache(player,cacheFlag)
    if cacheFlag == CacheFlag.CACHE_DAMAGE then 
        if player:HasCollectible(TalismanId.OX)  then 
            player.Damage = player.Damage + Bonus.OX
        end
    end
    if cacheFlag == CacheFlag.CACHE_FLYING then
        if player:HasCollectible(TalismanId.ROOSTER) then 
            player.CanFly = Bonus.ROOSTER
        end
    end
    if cacheFlag == CacheFlag.CACHE_SPEED then 
        if player:HasCollectible(TalismanId.RABBIT)  then 
            player.MoveSpeed = player.MoveSpeed + Bonus.RABBIT
        end
    end
end

Talismans:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Talismans.onCache)