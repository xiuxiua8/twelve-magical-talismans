local Snake = {
    INVISIBILITY_DURATION = 150, -- 5秒 (30帧/秒)
    COOLDOWN_DURATION = 300,     -- 10秒冷却
    CONFUSION_DURATION = 150,    -- 敌人混乱持续时间
}

local PlayerData = {}

local function GetPlayerData(player)
    local playerHash = GetPtrHash(player)
    if not PlayerData[playerHash] then
        PlayerData[playerHash] = {
            isInvisible = false,
            invisibilityTimer = 0,
            cooldownTimer = 0,
        }
    end
    return PlayerData[playerHash]
end

-- 让房间内所有敌人混乱
local function ConfuseAllEnemies(player)
    local playerRef = EntityRef(player)
    for _, entity in pairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) then
            entity:AddConfusion(playerRef, Snake.CONFUSION_DURATION, false)
        end
    end
end

local function SetInvisible(player, invisible)
    local data = GetPlayerData(player)
    local sprite = player:GetSprite()

    if invisible then
        data.isInvisible = true
        data.invisibilityTimer = Snake.INVISIBILITY_DURATION

        -- 视觉效果：半透明
        player.Color = Color(1, 1, 1, 0.15, 0, 0, 0)

        -- 防止敌人锁定
        player:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)

        -- 让所有敌人混乱
        ConfuseAllEnemies(player)
    else
        data.isInvisible = false
        data.invisibilityTimer = 0
        data.cooldownTimer = Snake.COOLDOWN_DURATION

        -- 恢复可见
        player.Color = Color(1, 1, 1, 1, 0, 0, 0)

        -- 移除隐身标记
        player:ClearEntityFlags(EntityFlag.FLAG_NO_TARGET)
    end
end

local function IsActivationKeyPressed(player)
    local controllerIndex = player.ControllerIndex
    -- 键盘：左Ctrl / 手柄：RT（右扳机）- 都是 ACTION_DROP
    return Input.IsActionTriggered(ButtonAction.ACTION_DROP, controllerIndex)
end

function Talismans:SnakeOnUpdate(player)
    if not player:HasCollectible(Talismans.Enums.CollectibleType.COLLECTIBLE_SNAKE) then
        return
    end

    local data = GetPlayerData(player)

    if data.isInvisible then
        data.invisibilityTimer = data.invisibilityTimer - 1

        -- 持续保持半透明和FLAG_NO_TARGET
        player.Color = Color(1, 1, 1, 0.15, 0, 0, 0)
        if not player:HasEntityFlags(EntityFlag.FLAG_NO_TARGET) then
            player:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
        end

        -- 持续让新生成的敌人混乱
        if data.invisibilityTimer % 30 == 0 then
            ConfuseAllEnemies(player)
        end

        if data.invisibilityTimer <= 0 then
            SetInvisible(player, false)
        end
    end

    if data.cooldownTimer > 0 then
        data.cooldownTimer = data.cooldownTimer - 1
    end

    if IsActivationKeyPressed(player) then
        if not data.isInvisible and data.cooldownTimer <= 0 then
            SetInvisible(player, true)
        elseif data.isInvisible then
            SetInvisible(player, false)
        end
    end
end

Talismans:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Talismans.SnakeOnUpdate)

function Talismans:SnakeOnGameStart(isContinued)
    if not isContinued then
        PlayerData = {}
    end
end

Talismans:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Talismans.SnakeOnGameStart)
