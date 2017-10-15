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
["Name"] = true,
["Name Length"] = true,
["Health"] = true,
["Highlight Target"] = true,
["Aggro Warning"] = true,
["Mana Warning"] = true,
["Healcomm"] = true,
["Healcomm Text"] = true,
["Top Left Icon"] = true,
["Top Icon"] = true,
["Top Right Icon"] = true,
["Right Icon"] = true,
["Bottom Right Icon"] = true,
["Bottom Icon"] = true,
["Bottom Left Icon"] = true,
["Left Icon"] = true,
["Proximity Leeway"] = true,
["Use Map Proximity"] = true,
["Smart Center"] = true,
["Show While Solo"] = true,
["Show In Party"] = true,
["Show Party In Raid"] = true,
["Locked"] = true,

["Orientation"] = true,
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
["Name"] = "Имя по цвету класса",
["Name Length"] = "Длина имени",
["Health"] = "Здоровье по цвету класса",
["Highlight Target"] = "Выделение цели",
["Aggro Warning"] = "Предупреждение аггро",
["Mana Warning"] = "Предупреждение маны",
["Healcomm"] = "Входящее исцеление",
["Healcomm Text"] = "Текст входящего исцеления",
["Top Left Icon"] = "Иконка сверху слева",
["Top Icon"] = "Иконка сверху",
["Top Right Icon"] = "Иконка сверху справа",
["Right Icon"] = "Иконка справа",
["Bottom Right Icon"] = "Иконка снизу справа",
["Bottom Icon"] = "Иконка снизу",
["Bottom Left Icon"] = "Иконка снизу слева",
["Left Icon"] = "Иконка слева",
["Proximity Leeway"] = "Proximity Leeway", --
["Use Map Proximity"] = "Use Map Proximity", --
["Smart Center"] = "Smart Center", --
["Show While Solo"] = "Показать вне группы",
["Show In Party"] = "Показать в группе",
["Show Party In Raid"] = true,
["Locked"] = "Заблокировать",

["Orientation"] = "Ориентация",
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

["Show Power Bar"] = true,
["Power Position"] = true,
["Power Size"] = true,

["Config Mode"] = true,
["Background"] = true,

} end)