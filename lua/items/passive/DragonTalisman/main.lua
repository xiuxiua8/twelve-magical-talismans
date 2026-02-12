local game = Game()

local DRAGON = {
    BASE_CHANCE = 15,
    MAX_LUCK = 6,
    FIRE_DMG_MULT = 1.5,
    FIRE_SCALE = 1.2,
    EXPLOSION_DAMAGE = 40,
    BURN_COLOR = Color(1, 0.5, 0, 1, 0.3, 0, 0)
}

function Talismans:DragonOnUpdate(player)
    if not player:HasCollectible(Talismans.Enums.CollectibleType.COLLECTIBLE_DRAGON) then
        return
    end

    for _, entity in pairs(Isaac.GetRoomEntities()) do
        if entity.Type == EntityType.ENTITY_TEAR then
            local tear = entity:ToTear()
            local data = tear:GetData()

            if data.DragonFireball == nil then
                local roll = math.random(100)
                local chance = ((100 - DRAGON.BASE_CHANCE) * player.Luck / DRAGON.MAX_LUCK) + DRAGON.BASE_CHANCE

                if roll <= chance then
                    data.DragonFireball = true
                    tear:ChangeVariant(TearVariant.FIRE)
                    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BURN
                    tear.CollisionDamage = tear.CollisionDamage * DRAGON.FIRE_DMG_MULT
                    tear:SetSize(tear.Size * DRAGON.FIRE_SCALE, Vector(1, 1), 8)
                    tear.SpriteScale = tear.SpriteScale * DRAGON.FIRE_SCALE
                    tear.Color = DRAGON.BURN_COLOR
                else
                    data.DragonFireball = false
                end
            end

            if data.DragonFireball and not data.DragonExploded then
                -- Explode on grid collision (obstacles/walls)
                if tear:CollidesWithGrid() then
                    data.DragonExploded = true
                    Isaac.Explode(tear.Position, tear.SpawnerEntity, DRAGON.EXPLOSION_DAMAGE)
                    tear:Remove()
                -- Explode when tear dies (range expired, etc.)
                elseif tear:IsDead() then
                    data.DragonExploded = true
                    Isaac.Explode(tear.Position, tear.SpawnerEntity, DRAGON.EXPLOSION_DAMAGE)
                end
            end
        end
    end
end

Talismans:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Talismans.DragonOnUpdate)

-- Explode on entity collision
function Talismans:DragonTearCollision(tear, collider, low)
    local data = tear:GetData()
    if data.DragonFireball and not data.DragonExploded then
        data.DragonExploded = true
        Isaac.Explode(tear.Position, tear.SpawnerEntity, DRAGON.EXPLOSION_DAMAGE)
    end
end

Talismans:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, Talismans.DragonTearCollision)

