local game = Game()

local DRAGON = {
    DMG_MULT = 2, 
    SCALE = 1.3,
    BASE_CHANCE = 15,
    MAX_LUCK = 6
}


--when passive effects should update
function Talismans:DragononUpdate(player)
    if player:HasCollectible(Talismans.Enums.CollectibleType.COLLECTIBLE_DRAGON) then 
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

