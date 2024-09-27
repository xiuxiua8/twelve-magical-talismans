local Talismans = RegisterMod("Talismans", 1)
local game = Game()

--Talismans.COLLECTIBLE_ROOSTER_TALISMAN = Isaac.GetItemIdByName("the Rooster Talisman")

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

local Bonus = {
    ROOSTER = true,
    OX = 5,
    RABBIT = 0.5
}

local DRAGON = {
    DMG_MULT = 2, 
    SCALE = 1.3,
    BASE_CHANCE = 15,
    MAX_LUCK = 6
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


function Talismans:spawnTalismans(player)
    if game:GetFrameCount() == 1 then
        Isaac.DebugString("Rooster Talisman ID: " .. tostring(TalismanId.ROOSTER))
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.RAT, Vector(170,250), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.OX, Vector(220,250), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.TIGER, Vector(270,250), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.RABBIT, Vector(370,250), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.DRAGON, Vector(420,250), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.SNAKE, Vector(470,250), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.HORSE, Vector(170,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.SHEEP, Vector(220,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.MONKEY, Vector(270,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.ROOSTER, Vector(370,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.DOG, Vector(420,300), Vector(0,0), nil)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, TalismanId.PIG, Vector(470,300), Vector(0,0), nil)
        if player:GetName() == "Isaac" then
            player:AddCollectible(TalismanId.OX, 0, true)
        end 
    end
end

--when passive effects should update
function Talismans:onUpdate(player)
    if Isaac.HasModData(Talismans) then
        Isaac.DebugString("Mod data exists for Talismans mod.")
    else
        Isaac.DebugString("Mod data does not exist for Talismans mod.")
    end
    -- Begining of run initializations
    Talismans.spawnTalismans(player)
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


--when passive effects should update
function Talismans:DragononUpdate(player)
    if player:HasCollectible(TalismanId.DRAGON) then 
        for _, entity in pairs(Isaac.GetRoomEntities()) do 
            if entity.Type == EntityType.ENTITY_TEAR then 
                local TearData = entity:GetData()
                local Tear = entity:ToTear()
                if TearData.DragonType == nil then
                    --Initialize tear
                    local roll = math.random(100)
                    
                    if roll <= ((100 - DRAGON.BASE_CHANCE) * player.Luck / DRAGON.MAX_LUCK) + DRAGON.BASE_CHANCE then
                        --DRAGON tear
                        TearData.DragonType = math.random(3)
                        if TearData.DragonType == 1 then
                            -- Death's touch
                            Tear:ChangeVariant(TearVariant.FIST)
                            Tear.TearFlags = TearFlags.TEAR_LASER
                            Tear.CollisionDamage = Tear.CollisionDamage * DRAGON.DMG_MULT
                            Tear:SetSize(Tear.Size * DRAGON.SCALE, Vector(1,1), 8)
                            Tear.SpriteScale = Tear.SpriteScale * DRAGON.SCALE
                        elseif TearData.DragonType == 2 then
                            -- Holy Light
                            Tear.TearFlags = TearFlags.TEAR_LIGHT_FROM_HEAVEN
                        elseif TearData.DragonType == 3 then
                            -- Gamorrah
                            Tear:ChangeVariant(TearVariant.NAIL)
                        end
                    else
                        -- Normal Tear
                        TearData.DragonType = 0
                    end
                else
                    if TearData.DragonType == 3 and Tear:CollidesWithGrid() then 
                        local room = game:GetRoom()
                        local Grid = room:GetGridEntityFromPos(Tear.Position)
                        if Grid ~= nil then
                            Grid:Destroy(false)
                        else 
                            Isaac.DebugString("Invalid Grid Entity to destroy!")
                        end
                    end
                end
            end
        end
    end
end

Talismans:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Talismans.DragononUpdate)

