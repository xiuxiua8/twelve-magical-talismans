local Translations = {}

local translationsTable = {
    collectible = {},
    trinket = {}
}

function Translations:AddTranslation(item, id, name, description, language)
    if item ~= "collectible" and item ~= "trinket" then return end
    if not translationsTable[item][language] then
        translationsTable[item][language] = {}
    end
    if type(id) == "number" and type(name) == "string" and type(description) == "string" then
        translationsTable[item][language][id] = {name, description}
    end
end


--zh_cn
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_RAT, "鼠符咒", "赋予静物以动能", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_OX, "牛符咒", "强悍的肉体力量", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_TIGER, "虎符咒", "阴阳平衡", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_RABBIT, "兔符咒", "超高速", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_DRAGON, "龙符咒", "龙爆破", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_SNAKE, "蛇符咒", "隐形", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_HORSE, "马符咒", "驱散体内一切伤病", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_SHEEP, "羊符咒", "灵魂出窍", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_MONKEY, "猴符咒", "变身", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_ROOSTER, "鸡符咒", "无视重力进行飞行", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_DOG, "狗符咒", "长生不老", "zh")
Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_PIG, "猪符咒", "高热激光", "zh")
for i = 0, 5 do
    --Translations:AddTranslation("collectible", Talismans.Enums.CollectibleType.COLLECTIBLE_LUNCH_BOX - i, "Коробка с завтраком", "Переносной буфет", "ru")
end
--Translations:AddTranslation("trinket", Talismans.Enums.TrinketType.TRINKET_GAME_SQUID_TC, "Игровой кальмар", "Подтекающий приятель", "ru")

local function ShowTranslation(queue, translationTable)
    local translations = translationTable[Options.Language]
    if translations then
        local translation = translations[queue.ID]
        if translation then
            Game():GetHUD():ShowItemText(translation[1], translation[2])
        end
    end
end

---@param player EntityPlayer
function Translations:onUpdate(player)
	if player.Parent then return end
    local data = player:GetData()
    if data.queueNow == nil and player.QueuedItem.Item then
        data.queueNow = player.QueuedItem.Item
        if data.queueNow:IsCollectible() then
            ShowTranslation(data.queueNow, translationsTable.collectible)
        elseif data.queueNow:IsTrinket() then
            ShowTranslation(data.queueNow, translationsTable.trinket)
        end
    elseif data.queueNow ~= nil and player.QueuedItem.Item == nil then
        data.queueNow = nil
    end
end
Talismans:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, Translations.onUpdate)