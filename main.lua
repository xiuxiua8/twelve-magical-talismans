local Talismans = RegisterMod("Talismans", 1)

--Talismans.COLLECTIBLE_ROOSTER_TALISMAN = Isaac.GetItemIdByName("the Rooster Talisman")

local TalismanId = {
    ROOSTER = Isaac.GetItemIdByName("the Rooster Talisman")
}

local HasTalisman = {
    ROOSTER = false
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
            --player:TryRemoveCollectible(TalismanId.ROOSTER)  -- 移除Rooster Talisman
            --player:AddFlight(EntityRef(player), 180)  -- 让玩家飞起来，持续时间为180帧
            for i, entity in pairs(Isaac.GetRoomEntities()) do
                if entity:IsVulnerableEnemy() and math.random(500) <= 7 then
                    entity:AddPoison(EntityRef(player), 100, 3.5)
                end
            end
        end
    end
end

Isaac.DebugString("Hello world!")
-- 将函数注册为MC_POST_UPDATE回调，这样它将在每一帧结束后被调用
Talismans:AddCallback(ModCallbacks.MC_POST_UPDATE, Talismans.RoosteronUpdate)
