local L = AceLibrary("AceLocale-2.2"):new("NotGrid")

L:RegisterTranslations("enUS", function() return {
["Dead"] = true,
["Ghost"] = true,
["Scroll Me!"] = true,

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
["Health Orientation"] = true,
["Show Blizz Frames"] = true,
["Growth Direction"] = true,
["Show Power Bar"] = true,
["Power Position"] = true,
["Power Size"] = true,
["Config Mode"] = true,
["Background"] = true,
["Show Pets"] = true,
["Custom Pet Color"] = true,
["TBC Shaman Color"] = true,
["Proximity Rate"] = true,
["Health Background"] = true,
["Clique Hook"] = true,
["Power Background"] = true,
["Position"] = true,
["Border Artwork"] = true,
["Name Position"] = true,
["Healcomm Text Position"] = true,
["Version Checking"] = true,
["Draggable"] = true,

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

--------------
-- Tooltips --
--------------

["pet_tooltip"] = "Note: Prone to visual errors.",
["classcolor_tooltip"] = "Toggle for class color.",
["smartcenter_tooltip"] = "As your group expands the frames stay horizontally centered on the original group placement.",
["healththreshold_tooltip"] = "Health percentage before name is replaced with health deficit.",
["manathreshhold_tooltip"] = "Mana percentage before border color changes.",
["proximityleeway_tooltip"] = "Amount of seconds to be considered \"In Range\" after a positive confirmation.",
["proximityrate_tooltip"] = "Amount of seconds between proximity checks.",
["cliquehook_tooltip"] = "Hooks the Clique spellcast function to use NG instead for proximity checking beyond 28 yards within instances. Toggling will reload UI.",
["powercolor_tooltip"] = "Toggle for power color.",
["position_tooltip"] = "Shift+Ctrl = 100\nShift = 10",
["draggable_tooltip"] = "Note: Possible client crash bug\n           Smart Center disabled",
["icon_tooltip"] = "Toggle to invert icon display.",


} end)

L:RegisterTranslations("ruRU", function() return {
["Dead"] = "Мертв",
["Ghost"] = "Призрак",
["Scroll Me!"] = "Прокрути меня!",

["Unit Width"] = "Ширина окон",
["Unit Height"] = "Высота окон",
["Unit Border"] = "Граница окон",
["Unit Padding"] = "Интервал окон",
["Font"] = "Шрифт",
["Texture"] = "Текстура",
["Name Color"] = "Цвет имени",
["Name Size"] = "Размер имени",
["Name Length"] = "Длина имени",
["Health Color"] = "Цвет здоровья",
["Health Threshold"] = "Порог здоровья",
["Highlight Target"] = "Выделение цели",
["Aggro Warning"] = "Предупреждение аггро",
["Mana Warning"] = "Предупреждение маны",
["Healcomm Bar"] = "Полоса входящего исцеления",
["Healcomm Text"] = "Текст входящего исцеления",
["Top Left Icon"] = "Значек сверху слева",
["Top Icon"] = "Значек сверху",
["Top Right Icon"] = "Значек сверху справа",
["Right Icon"] = "Значек справа",
["Bottom Right Icon"] = "Значек снизу справа",
["Bottom Icon"] = "Значек снизу",
["Bottom Left Icon"] = "Значек снизу слева",
["Left Icon"] = "Значек слева",
["Icon Size"] = "Размер значка",
["Proximity Leeway"] = "Proximity Leeway", --
["Use Map Proximity"] = "Использовать карту приближения",
["Smart Center"] = "Умный центр",
["Show While Solo"] = "Показать вне группы",
["Show In Party"] = "Показать в группе",
["Show Party In Raid"] = "Показать группы в рейде",
["Disable Tooltip In Combat"] = "Отключить всплывающую подсказку в бою",
["Health Orientation"] = "Ориентация здоровья",
["Show Blizz Frames"] = "Показать окна Blizzard",
["Growth Direction"] = "Направление роста",
["Show Power Bar"] = "Показать полосу силы",
["Power Position"] = "Положение полосы силы",
["Power Size"] = "Размер полосы силы",
["Config Mode"] = "Режим настройки",
["Background"] = "Задний фон",
["Show Pets"] = "Показать питомцев",
["Custom Pet Color"] = "Пользовательский цвет питомца",
["TBC Shaman Color"] = "Пользовательский цвет шамана - TBC",
["Proximity Rate"] = "Коэффициент близости",
["Health Background"] = "Фон здоровья",
["Clique Hook"] = "Захват Clique",
["Power Background"] = "Фон полосы силы",
["Position"] = "Положение",
["Border Artwork"] = "Рисунок границ",
["Name Position"] = "Положение имени",
["Healcomm Text Position"] = "Положение текста Healcomm",
["Version Checking"] = "Проверка версии",
["Draggable"] = "Перетаскиваемый",

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

--------------
-- Tooltips --
--------------

["pet_tooltip"] = "Примечание: подвержен визуальным ошибкам.",
["classcolor_tooltip"] = "Вкл.\\Выкл. цвет класса",
["smartcenter_tooltip"] = "По мере расширения группы рамки остаются горизонтально по центру исходного расположения группы.",
["healththreshold_tooltip"] = "Процент здоровья перед именем заменяется дефицитом здоровья.",
["manathreshhold_tooltip"] = "Процент маны до изменения цвета бордюра.",
["proximityleeway_tooltip"] = "Количество секунд, которое будет учитывать \"в пределах досягаемости\" после положительного заклинания или подтверждения боевого журнала.",
["proximityrate_tooltip"] = "Количество секунд между проверками близости.",
["cliquehook_tooltip"] = "Захват функции произнесения заклинаний Clique, чтобы вместо этого использовать NG для проверки близости за пределами 28 ярдов внутри подземелий. Переключение приведет к перезагрузке пользовательского интерфейса.",
["powercolor_tooltip"] = "Переключить цвет полос силы.",
["position_tooltip"] = "Shift+Ctrl = 100\nShift = 10",
["draggable_tooltip"] = "Примечание. Возможен сбой клиента.\n           Умный центр отключен",
["icon_tooltip"] = "Переключить, чтобы инвертировать отображение значков.",

} end)
