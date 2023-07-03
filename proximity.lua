local L = AceLibrary("AceLocale-2.2"):new("NotGrid")

local spells40yd = { -- Macros are forced to have text associated with them so we can safely just check the textures as well as check against the presence of text. No need for Gratuity or Babble overhead. Though if they have an item in their bar that matches the texture then GG haha
	["PALADIN"] = {"Interface\\Icons\\Spell_Holy_FlashHeal", "Interface\\Icons\\Spell_Holy_HolyBolt"},
	["PRIEST"] = {"Interface\\Icons\\Spell_Holy_FlashHeal", "Interface\\Icons\\Spell_Holy_LesserHeal", "Interface\\Icons\\Spell_Holy_Heal", "Interface\\Icons\\Spell_Holy_GreaterHeal", "Interface\\Icons\\Spell_Holy_Renew"},
	["DRUID"] = {"Interface\\Icons\\Spell_Nature_HealingTouch", "Interface\\Icons\\Spell_Nature_ResistNature", "Interface\\Icons\\Spell_Nature_Rejuvenation"},
	["SHAMAN"] = {"Interface\\Icons\\Spell_Nature_MagicImmunity", "Interface\\Icons\\Spell_Nature_HealingWaveLesser", "Interface\\Icons\\Spell_Nature_HealingWaveGreater"},
}

local MapScales = {
	[0] = {[0] = {x = 29688.932932224,  y = 44537.340058402}}, -- World Map

	[-1] = { -- Battlegrounds
		[0] = {x=0.0000000001,y=0.0000000001}, -- dummy
		[L["Alterac Valley"]] = {x=0.00025277584791183,y=0.0003791834626879}, -- Alterac Valley
		[L["Arathi Basin"]] = {x=0.00060996413230886,y=0.00091460134301867}, -- Arathi Basin
		[L["Warsong Gulch"]] = {x=0.000934666820934484,y=0.0013986080884933}, -- Warsong Gulch
	},

	[1] = { -- Kalimdor
		[0] = {x = 24533.025279205, y = 36800.210572494}, -- No local Map
		[1] = {x=0.00018538534641226,y=0.00027837923594884}, -- Ashenvale
		[2] = {x=0.0002110515322004,y=0.00031666883400508}, -- Aszhara
		[3] = {x=0.00016346999577114,y=0.0002448782324791}, -- Darkshore
		[4] = {x=0.001011919762407,y=0.0015176417572158}, -- Darnassus
		[5] = {x=0.000238049243117769,y=0.00035701000264713}, -- Desolace
		[6] = {x=0.000202241752828887,y=0.00030311250260898},  -- Durotar
		[7] = {x=0.00020404585770198,y=0.00030594425542014}, -- Dustwallow Marsh
		[8] = {x=0.00018605589866638,y=0.00027919347797121}, -- Felwood
		[9] = {x=0.00015413335391453,y=0.00023112978254046}, -- Feralas
		[10] = {x=0.00046338992459433,y=0.00069469745670046}, -- Moonglade
		[11] = {x=0.00020824585642133,y=0.00031234536852155}, -- Mulgore
		[12] = {x=0.00076302673135485,y=0.0011450946331024}, -- Orgrimmar
		[13] = {x=0.00030702139650072,y=0.00046115900788988}, -- Silithus
		[14] = {x=0.0002192035317421,y=0.00032897400004523}, -- Stonetalon Mountains
		[15] = {x=0.00015519559383392,y=0.00023255497217178}, -- Tanaris
		[16] = {x=0.00021010743720191,y=0.00031522342136928}, -- Teldrassil
		[17] = {x=0.0001055257661002,y=0.00015825512153762}, -- Barrens
		[18] = {x=0.00024301665169852,y=0.00036516572747912}, -- Thousand Needles
		[19] = {x=0.00102553303755263,y=0.0015390366315842}, -- Thunderbluff
		[20] = {x=0.00028926772730691,y=0.0004336131470544}, -- Un'Goro Crater
		[21] = {x=0.0001503484589713,y=0.0002260080405644}, -- Winterspring
	},

	[2] = { -- Eastern Kingdoms
		[0] = {x = 27149.795290881, y = 40741.175327834}, -- No local Map
		[1] = {x=0.00038236060312816,y=0.00057270910058703}, -- Alterac Mountains
		[2] = {x=0.00029711957488741,y=0.00044587893145425}, -- Arathi Highlands
		[3] = {x=0.00043004538331713,y=0.00064518196242196}, -- Badlands
		[4] = {x=0.00031955327306475,y=0.00047930649348668}, -- Blasted Lands
		[5] = {x=0.00036544565643583,y=0.00054845426763807}, -- Burning Steppes
		[6] = {x=0.00042719074657985,y=0.00064268921102796}, -- Deadwind Pass
		[7] = {x=0.00021748670509883,y=0.00032613213573183}, -- Dun Morogh
		[8] = {x=0.00039665134889739,y=0.000594192317755393},-- Duskwood
		[9] = {x=0.00027669753347124,y=0.00041501436914716}, -- Eastern Plaguelands
		[10] = {x=0.00030816452843802,y=0.00046261719294957}, -- Elwynn Forest
		[11] = {x=0.00033472904137203,y=0.00050214784485953}, -- Hillsbrad Foothills
		[12] = {x=0.0013541845338685,y=0.0020301469734737}, -- Ironforge
		[13] = {x=0.00038827742849077,y=0.000582420040021079}, -- Loch Modan
		[14] = {x=0.00049317521708352,y=0.0007399320602417}, -- Redridge Mountains
		[15] = {x=0.00047916280371802,y=0.00071918751512255}, -- Searing Gorge
		[16] = {x=0.00025506743362975,y=0.00038200191089085}, -- Silverpine
		[17] = {x=0.00079576990434102,y=0.0011931381055287}, -- Stormwind
		[18] = {x=0.00016783603600093,y=0.00025128040994917}, -- Stranglethorn
		[19] = {x=0.00046689595494952,y=0.00070027368409293}, -- Swamp of Sorrows
		[20] = {x=0.0002777065549578,y=0.00041729531117848}, -- Hinterlands
		[21] = {x=0.00023638989244189,y=0.0003550010068076}, -- Tirisfal
		[22] = {x=0.0011167100497655,y=0.0016737942184721}, -- Undercity
		[23] = {x=0.00024908781051636,y=0.00037342309951782}, -- Western Plaguelands
		[24] = {x=0.00030591232436044,y=0.00045816733368805},-- Westfall
		[25] = {x=0.00025879591703415,y=0.00038863212934562}, -- Wetlands
	}
}



--------------------
-- UNIT_PROXIMITY --
--------------------
function NotGrid:UNIT_PROXIMITY()
	for key,f in self.UnitFrames do
		local unitid = f.unit
		if UnitExists(unitid) and f:IsVisible() then
			local response = self:CheckProximity(unitid)
			if response == 1 then
				self:RangeToggle(f, 1)
			elseif response == 2 then
				self:RangeToggle(f, 2)
			else
				self:RangeToggle(f, 3)
			end
		end
	end
end


function NotGrid:RangeToggle(f, condition)
	if condition == 1 then
		f.lastseen = GetTime() -- this of course makes it sort of wrong when players are switching up Unitids on rapid join/leave of group
		f:SetAlpha(1)
	elseif condition == 2 then
		f:SetAlpha(self.o.ooralpha)
	elseif (f.lastseen and (GetTime() - f.lastseen) > self.o.proximityleeway) then -- if not confirmed to be out of range, toggle him as out of range only after the proximity leeway time
		f:SetAlpha(self.o.ooralpha)
	end
end

----------------
-- Main Check --
----------------

function NotGrid:CheckProximity(unitid) -- return 1=confirmed_true, 2=confirmed_false, and no_response/false/nil means we can't confirm either way
	if UnitExists(unitid) and UnitIsVisible(unitid) then
		--check these scenarios first even if the player has check with map toggled
		if UnitIsUnit(unitid, "player") then --unitisplayer, 0 yards
			return 1
		elseif CheckInteractDistance(unitid, 3) then -- duel range, 10 yards
			return 1
		elseif CheckInteractDistance(unitid, 2) then -- trade and inspect range (1 is the same as 2 with patch 1.12), 11.11 yards
			return 1
		elseif CheckInteractDistance(unitid, 4) then -- follow range, 28 yards
			return 1
		elseif SpellIsTargeting() then
			if SpellCanTargetUnit(unitid) then
				return 1
			else
				return 2
			end
		elseif UnitIsUnit(unitid, "target") and self.ProximityVars.spell40slot then
			if IsActionInRange(self.ProximityVars.spell40slot) == 1 then -- IsActionInRange returns the string "0" if not in range which is a boolean true, so I check for 1 instead
				return 1
			else
				return 2
			end
		end
		--if checking with map is toggled, AND the player is outside, AND we haven't returned an INRANGE confirmation yet, then start looking at the map for range
		if self.o.usemapdistances and (self.ProximityVars.instance == "none" or self.ProximityVars.instance == "pvp") and not WorldMapFrame:IsVisible() then
			local distance = self:GetWorldDistance(unitid)
			if distance and distance <= 40 then
				return 1
			else
				return 2
			end
		end
	end
end

-------------------------
-- Map Proximity Stuff --
-------------------------

function NotGrid:GetWorldDistance(unitid) -- I have no idea what goes on in this function, thanks Rhena/Renew/Astrolabe :^)
	local px, py, ux, uy, distance
	local v = self.ProximityVars
	SetMapToCurrentZone()
	px, py = GetPlayerMapPosition("player")
	ux, uy = GetPlayerMapPosition(unitid)

	if v.Zone ~= 0 and v.Continent ~= 0 and MapScales[v.Continent] and MapScales[v.Continent][v.Zone] then
		distance = sqrt(((px - ux)/MapScales[v.Continent][v.Zone].x)^2 + ((py - uy)/MapScales[v.Continent][v.Zone].y)^2)
	elseif MapScales[v.Continent] and MapScales[v.Continent][v.Zone] then
		local xDelta, yDelta;
		px, py = px*MapScales[v.Continent][v.Zone].x, py*MapScales[v.Continent][v.Zone].y
		ux, uy = ux*MapScales[v.Continent][v.Zone].x, uy*MapScales[v.Continent][v.Zone].y
		xDelta = (ux - px)
		yDelta = (uy - py)
		distance = sqrt(xDelta*xDelta + yDelta*yDelta)
	end
	
	return distance
end

function NotGrid:UpdateProximityMapVars()
	local v = self.ProximityVars
	SetMapToCurrentZone()
	_, v.instance = IsInInstance()
	v.Continent = GetCurrentMapContinent()
	v.Zone = GetCurrentMapZone()
	v.ZoneName = GetZoneText()
	if v.ZoneName == "Warsong Gulch" or v.ZoneName == "Arathi Basin" or v.ZoneName == "Alterac Valley" then
		v.Zone = v.ZoneName
	end
end

-------------------------
-- Combat Event Handle -- TODO: This doesn't recognize events such as "player suffers X damage from creatures spell" is that because I found it to be erronous previously? Or an oversight?
-------------------------

function NotGrid:CombatEventHandle()
	local combatlogrange = tonumber(GetCVar("CombatLogRangeFriendlyPlayers")) -- I'm going to inappropriately assume that if he's set this as non-default then he's also set all the others as the same(we can correct this easily in future versions)
	if combatlogrange <= 40 then
		local v = self.ProximityVars
		local capturestring = L.CombatEvents[event] -- "event" is the name of the event sent by the wow api
		local _, _, name = string.find(arg1, capturestring) -- arg1 gets sent by any combat event as the string you see in combat log, this will grab the name out of it using defined capture strings in localization.lua
		
		for _,f in self.UnitFrames do --look through unitframes for f.name?
			if (name and f.name) and (name == f.name) then
				self:RangeToggle(f, 1)
			end
		end
	end
end

-------------------------
-- 40 Yard Spell Stuff --
-------------------------

function NotGrid:GetFortyYardSpell()
	local v = self.ProximityVars
	local _, class = UnitClass("player")
	if spells40yd[class] then -- if player is of a class that has data in the table
		local textures = spells40yd[class]
		local indices = getn(spells40yd[class])
		for i = 1, 120 do -- for all possible action bar slots
			local ActionTexture = GetActionTexture(i)
			for j=1,indices do -- for as many textures are in the class table
				if ActionTexture == textures[j] and not GetActionText(i) then -- if we match a texture and there is no text with it(macros are forced to have text)
					v.spell40slot = i -- set it as our variable and return out of the function
					return
				end
			end
		end
	end
	v.spell40slot = nil -- set it as nil if it never found anything
end


---------------------
--  Clique Helper  --
---------------------

function NotGrid:SpellCanTarget()
	for _,f in self.UnitFrames do
		local unitid = f.unit
		if UnitExists(unitid) and UnitIsVisible(unitid) and SpellIsTargeting() then -- mimick the checks of the main checker and then pass results directly to RangeToggle
			if SpellCanTargetUnit(unitid) then
				self:RangeToggle(f, 1)
			else
				self:RangeToggle(f, 2)
			end
		end
	end
end

--[[ Although I've done away with NotProximityLib I still want these notes to be around.
------------------------------------------------
-- Notes About Combat Log Messages
------------------------------------------------
None of the below can be used for accurate proximity assumptions. 
Here's why: Combat events are limited to the likes of "(%a+) hits". There's no "(%a+) gets hit". What does this mean? Lets look at a Ragnaros encounter for an example.

Player -- 0 yards
Ragnaros -- 40 yards
RaidMember -- 80 yards

When Ragnaros hits RaidMember, Player will get the combat message "Ragnaros hits RaidMember". That's great, our assumption is now that because we see "Ragnaros hits RaidMember" that we can capture the first name of such a string and determine that Ragnaros is in range. However, when RaidMember hits Ragnaros, Player will get the event "RaidMember hits Ragnaros". Because RaidMember hit a unit that was within 40 yards of Player, Player still gets the message "RaidMember hits Ragnaros", even though the RaidMember is 80 yards away.

And we're not getting any special arguments(in 1.12) sent along with these events telling us who is responsible for triggering said combat message. All we know is we got a CREATURE_HITS_PARTY_MEMBER and PARTY_MEMBER_HITS_CREATURE. There's no way to parse out whether one is further away than the other. Almost all combat messages are made useless by this fact.

These are all deprecated:
CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS = ".+ c?[rh]its (%a+) for .+",
CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS = ".+ c?[rh]its (%a+) for .+",
CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS = ".+ c?[rh]its (%a+) for .+",
CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE = {".+'s .+ c?[rh]its (%a+) for .+", ".+'s .+ was resisted by (%a+)%."},
CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE = {".+'s .+ c?[rh]its (%a+) for .+", ".+'s .+ was resisted by (%a+)%."},
CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE = {".+'s .+ c?[rh]its (%a+) for .+", ".+'s .+ was resisted by (%a+)%."},

CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE = ".+'s .+ c?[rh]its (%a+) for .+",
CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE = "(%a+) is afflicted by .+"

CHAT_MSG_COMBAT_PARTY_HITS = "(%a+) c?[rh]its .+",
CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS = "(%a+) c?[rh]its .+",

CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE = "%a+ suffers %d+ %a+ damage from (%a+)'s .+" -- For this I could still read it for "(%a+) is Afflicted by" but creatures aren't in the RosterLib so its pointless.

------------------------------------------------
-- Notes About IsActionInRange()
------------------------------------------------
So the premise was we'd recognize that any healing class will have a 40yd healing spell right from the start. We could then use this spell as a default check for 40 yards for the targetted unit (its how the action bar determines whether to color them red or not) but IsActionInRange only accepts the literal button as value, not the spellname. So there's a possibility we could itterate through a player's actionbars and stop at the first 40 yard range spell we see and use that as the default, and listen for action bar changes(if thats a thing) and modify if needed. But that seems excessive, and I think we'd need to make a full table listing every 40 yard range spell to check against.

Level 1 Spells:
pala: Holy Light (40 yd)
prie: Lesser Heal(40 yd)
drui: Healing Touch(40 yd)
sham: Healing Wave(40 yd)

IsSpellInRange() -- TBC
IsItemInRange() -- TBC
IsCurrentAction() -- Useless. If you're casting and a unit runs out of range it won't fail unit it reaches the end of cast.

------------------------------------------------
-- ISSUES/BUGS
------------------------------------------------
unitischarmed -- need to handle this and not set him out of range with certain conditions
]]