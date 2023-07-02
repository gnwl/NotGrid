local L = AceLibrary("AceLocale-2.2"):new("NotGrid")

L:RegisterTranslations("enUS", function() return {
["Dead"] = true,
["Ghost"] = true,
["Spirit of Redemption"] = true,
["%s of %s"] = true,
["Default Friendly"] = true,
["(Rank "] = true,

["Rejuvenation"] = true,
["Magic"] = true,
["Poison"] = true,
["Curse"] = true,
["Disease"] = true,
["Mortal Strike"] = true,

["Unit Width"] = true,
["Unit Height"] = true,
["Unit Border"] = true,
["Unit Padding"] = true,
["Font"] = true,
["Texture"] = true,
["Name Color"] = true,
["Name Size"] = true,
["Name Length"] = true,
["Health Color"] = true,
["Health Threshold"] = true,
["Highlight Target"] = true,
["Aggro Warning"] = true,
["Mana Warning"] = true,
["Healcomm Bar"] = true,
["Healcomm Text"] = true,
["Top Left Icon"] = true,
["Top Icon"] = true,
["Top Right Icon"] = true,
["Right Icon"] = true,
["Bottom Right Icon"] = true,
["Bottom Icon"] = true,
["Bottom Left Icon"] = true,
["Left Icon"] = true,
["Icon Size"] = true,
["Proximity Leeway"] = true,
["Use Map Proximity"] = true,
["Smart Center"] = true,
["Show While Solo"] = true,
["Show In Party"] = true,
["Show Party In Raid"] = true,
["Disable Tooltip In Combat"] = true,
["Locked"] = true,

["Health Orientation"] = true,
["Show Blizz Frames"] = true,
["Growth Direction"] = true,

["CombatEvents"] = {
	["CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS"] = "(%a+) gains %a.+", --%a on the last just to make sure its not a digit
	["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = "(%a+) is afflicted by .+",
	["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"] = "(%a+) gains %a.+",
	["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = "(%a+) is afflicted by .+",

	["CHAT_MSG_SPELL_PARTY_BUFF"] = "(%a+) begins .+", --I don't get this message for party members? Only friendly?
	["CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF"] = "(%a+) begins .+",
	["CHAT_MSG_SPELL_PARTY_DAMAGE"] = "(%a+) begins .+",
	["CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"] = "(%a+) begins .+",

	["CHAT_MSG_SPELL_AURA_GONE_PARTY"] = ".+ fades from (%a+)%.",
	["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = ".+ fades from (%a+)%.", -- will pick up hostile fades as well as freind, but I won't have them in rosterlib so whatevs

	["CHAT_MSG_SPELL_SELF_BUFF"] = "Your .+ heals (%a+) for .+"
},

["Alterac Valley"] = "Alterac Valley",
["Arathi Basin"] = "Arathi Basin",
["Warsong Gulch"] = "Warsong Gulch",

["Show Power Bar"] = true,
["Power Position"] = true,
["Power Size"] = true,

["Config Mode"] = true,

["Background"] = true,

["Scroll Me!"] = true,
["Show Pets"] = true,
["Custom Pet Color"] = true,
["TBC Shaman Color"] = true,

--------------
-- Tooltips --
--------------

["Note: Prone to visual errors."] = true,
["Toggle for class color."] = true,
["As your raid expands the frames stay centered on the original group placement. Currently only works for horizontal growth."] = true,
["Health percentage before name is replaced with health deficit."] = true,
["Mana percentage before border color changes."] = true,
["Amound of seconds to be considered \"In Range\" after a positive spell or combat log confirmation."] = true,

} end)

L:RegisterTranslations("ruRU", function() return {
["Dead"] = "Мертв",
["Ghost"] = "Призрак",
["Spirit of Redemption"] = "Дух воздаяния",
["%s of %s"] = "%s из %s",
["Default Friendly"] = "Дружелюбная",
["(Rank "] = "(Уровень ",

["Rejuvenation"] = "Омоложение",
["Magic"] = "Магия",
["Poison"] = "Яд",
["Curse"] = "Проклятье",
["Disease"] = "Болезнь",
["Mortal Strike"] = "Смертельный удар",

["Unit Width"] = "Ширина рамок",
["Unit Height"] = "Высота рамок",
["Unit Border"] = "Бордюр рамок",
["Unit Padding"] = "Интервал рамок",
["Font"] = "Шрифт",
["Texture"] = "Текстура",
["Name Color"] = true,
["Name Size"] = true,
["Name Length"] = "Длина имени",
["Health Color"] = true,
["Health Threshold"] = true,
["Highlight Target"] = "Выделение цели",
["Aggro Warning"] = "Предупреждение аггро",
["Mana Warning"] = "Предупреждение маны",
["Healcomm Bar"] = true,
["Healcomm Text"] = "Текст входящего исцеления",
["Top Left Icon"] = "Иконка сверху слева",
["Top Icon"] = "Иконка сверху",
["Top Right Icon"] = "Иконка сверху справа",
["Right Icon"] = "Иконка справа",
["Bottom Right Icon"] = "Иконка снизу справа",
["Bottom Icon"] = "Иконка снизу",
["Bottom Left Icon"] = "Иконка снизу слева",
["Left Icon"] = "Иконка слева",
["Icon Size"] = true,
["Proximity Leeway"] = "Proximity Leeway", --
["Use Map Proximity"] = "Use Map Proximity", --
["Smart Center"] = "Smart Center", --
["Show While Solo"] = "Показать вне группы",
["Show In Party"] = "Показать в группе",
["Show Party In Raid"] = "Показать группы в рейде",
["Disable Tooltip In Combat"] = true,
["Locked"] = "Заблокировать",

["Health Orientation"] = true,
["Show Blizz Frames"] = "Показать окна Blizzard",
["Growth Direction"] = "Направление роста",

["CombatEvents"] = {
	["CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS"] = "(%a+) получает эффект %a.+",
	["CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE"] = "(%a+) находится под воздействием эффекта .+",
	["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS"] = "(%a+) получает эффект %a.+",
	["CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE"] = "(%a+) находится под воздействием эффекта .+",
		
	["CHAT_MSG_SPELL_PARTY_BUFF"] = "(%a+) начинает .+",
	["CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF"] = "(%a+) начинает .+",
	["CHAT_MSG_SPELL_PARTY_DAMAGE"] = "(%a+) начинает .+",
	["CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE"] = "(%a+) начинает .+",
		
	["CHAT_MSG_SPELL_AURA_GONE_PARTY"] = "Действие эффекта \".+\", наложенного на (%a+), заканчивается%.",
	["CHAT_MSG_SPELL_AURA_GONE_OTHER"] = "Действие эффекта \".+\", наложенного на (%a+), заканчивается%.",
		
	["CHAT_MSG_SPELL_SELF_BUFF"] = "Ваше заклинание \".+\" исцеляет (%a+) на .+"
},

["Alterac Valley"] = "Альтеракская долина",
["Arathi Basin"] = "Низина Арати",
["Warsong Gulch"] = "Ущелье Песни Войны",

["Show Power Bar"] = "Показать Power Bar", -- Power bar ??
["Power Position"] = "Позиция Power Bar", -- 
["Power Size"] = "Размер Power Bar", --

["Config Mode"] = "Режим настройки",
["Background"] = "Задний фон",

["Scroll Me!"] = "Прокрути меня!",

["Show Pets"] = "Показать питомцев",
["Custom Pet Color"] = true,
["TBC Shaman Color"] = true,

--------------
-- Tooltips --
--------------

["Note: Prone to visual errors."] = "Примечание: подвержен визуальным ошибкам.",
["Toggle for class color."] = true,
["As your raid expands the frames stay centered on the original group placement. Currently only works for horizontal growth."] = true,
["Health percentage before name is replaced with health deficit."] = true,
["Mana percentage before border color changes."] = true,
["Amound of seconds to be considered \"In Range\" after a positive spell or combat log confirmation."] = true,

} end)
