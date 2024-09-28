local Bonus = {
    ROOSTER = true,
    OX = 5,
    RABBIT = 0.5
}
--When we update the cache
function Talismans:onCache(player,cacheFlag)
    if cacheFlag == CacheFlag.CACHE_DAMAGE then 
        if player:HasCollectible(Talismans.Enums.CollectibleType.COLLECTIBLE_OX)  then 
            player.Damage = player.Damage + Bonus.OX
        end
    end
    if cacheFlag == CacheFlag.CACHE_FLYING then
        if player:HasCollectible(Talismans.Enums.CollectibleType.COLLECTIBLE_ROOSTER) then 
            player.CanFly = Bonus.ROOSTER
        end
    end
    if cacheFlag == CacheFlag.CACHE_SPEED then 
        if player:HasCollectible(Talismans.Enums.CollectibleType.COLLECTIBLE_RABBIT)  then 
            player.MoveSpeed = player.MoveSpeed + Bonus.RABBIT
        end
    end
end

Talismans:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Talismans.onCache)

