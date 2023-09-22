local L = AceLibrary("AceLocale-2.2"):new("NotGrid")
NotGrid = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")
NotGridOptions = {} -- After the addon is fully initialized WoW will fill this up with its saved variables if any

function NotGrid:OnInitialize()
	self.HealComm = AceLibrary("HealComm-1.0")
	self.Banzai = AceLibrary("Banzai-1.0") -- only reports as having aggro if someone with this library is targetting the mob and reporting that the mob is targeting said unit
	self.Gratuity = AceLibrary("Gratuity-2.0") -- for aura handling
	self.RosterLib = AceLibrary("RosterLib-2.0")
	self.Compost = AceLibrary("Compost-2.0")
	self.UnitFrames = {}
	--
	self.IdenticalUnits = {} -- will hold pairs of party/player/raidids that are the same effective unit. For use with rosterlib & healcomm stuff
	--proximity stuff
	self.ProximityVars = {} -- will hold vars related to proximity handling. Mostly world map stuff
	self:GetFortyYardSpell() -- queries the player's action bars for a 40 yard spell to use in proximity checking
	self:GetMapSizes() -- populate ProximityVars with mapsizes of server
	--
	self:CreateFrames()
end

function NotGrid:OnEnable()
	self.o = NotGridOptions -- Need to wait for addon to be fully initialized and saved variables loaded before I set this
	self:SetDefaultOptions() -- if NotGridOptions is empty(no saved varoables) this will fill it up with defaults
	self:DoDropDown()
	self:ConfigUnitFrames()
	--proximity stuff
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED", "GetFortyYardSpell")
	for key in L.CombatEvents do
		self:RegisterEvent(key, "CombatEventHandle")
	end
	--
	if Clique and self.o.cliquehook then
		Clique.CastSpell = NotGrid.CastHandle -- lazyspell uses _ as a prefix to load last so it will hook into my hook.
	end
	--RosterLib
	self:RegisterEvent("RosterLib_RosterChanged")
	self:RegisterEvent("RosterLib_UnitChanged")
	--Banzai/Aggro
	self:RegisterEvent("Banzai_UnitGainedAggro","UNIT_BORDER") -- sends unitid to UNIT_BORDER
	self:RegisterEvent("Banzai_UnitLostAggro","UNIT_BORDER")
	--Healcomm
	self:RegisterEvent("HealComm_Healupdate","HealCommHandler")
	self:RegisterEvent("HealComm_Ressupdate","HealCommHandler")
	--Proximity
	self:RegisterEvent("NG_UNIT_PROXIMITY","UNIT_PROXIMITY")
	self:ScheduleRepeatingEvent("NG_UNIT_PROXIMITY", self.o.proximityrate)
end

function NotGrid:HealCommHandler(name) -- be nice if it sent us the unitid instead
	self:UNIT_MAIN(self.RosterLib:GetUnitIDFromName(name))
end

--------------------
-- Roster Changes -- So we can can handle auras and positioning in events of reloadui,config,or just new players joining raid and not sending UNIT_AURA events.
--------------------
--roster events fire for all sorts of frivilous(in our case) reasons creating unnecessary updates
--rosterlib cycles through units and makes sure something about them actually changed before sending the event. subgroup/rank/name/class etc
function NotGrid:RosterLib_RosterChanged(updatedUnits) -- handle identical raid/partypets?.. bad idea because they don't have unique names. they'll just remain bugged
	for _,val in updatedUnits do
		if not (val.unitid and string.find(val.unitid, "raidpet")) or not (val.oldunitid and string.find(val.oldunitid, "raidpet")) then --make sure we have a unit we care about before we bother doing anything
			if GetNumRaidMembers() > 0 then
				self.Compost:Reclaim(self.IdenticalUnits)
				self.IdenticalUnits = self.Compost:Acquire()
				local playername = UnitName("player")
				for i=1,40 do
					if UnitExists("raid"..i) then
						local raidid = "raid"..i
						local raidname = UnitName(raidid)
						if playername == raidname then
							self.IdenticalUnits[raidid] = "player"
							self.IdenticalUnits["player"] = raidid
						end
						for i=1,4 do
							if UnitExists("party"..i) then
								local partyid = "party"..i
								local partyname = UnitName(partyid)
								if partyname == raidname then
									self.IdenticalUnits[raidid] = partyid -- store them both as their own keys referencing eachother
									self.IdenticalUnits[partyid] = raidid
								end
							end
						end
					end
				end
			elseif next(self.IdenticalUnits) then -- if theres data in the table, but we're not in raid, then wipe the table
				self.Compost:Reclaim(self.IdenticalUnits)
				self.IdenticalUnits = self.Compost:Acquire()
			end
			self:PositionFrames()
			break
		end
	end
end

function NotGrid:RosterLib_UnitChanged(unitid, name, class, subgroup, rank, oldname, oldunitid, oldclass, uldsubgroup, oldrank)
	if unitid and self.UnitFrames[unitid] then
		self:UNIT_MAIN(unitid)
		self:UNIT_BORDER(unitid)
		self:UNIT_AURA(unitid)
		if self.IdenticalUnits[unitid] then
			self:UNIT_MAIN(self.IdenticalUnits[unitid])
			self:UNIT_BORDER(self.IdenticalUnits[unitid])
			self:UNIT_AURA(self.IdenticalUnits[unitid])
		end
	end
end

---------------
-- UNIT_MAIN -- Handles the healthbar, healthtext, healcommbar, healcommtext, ressurection, nametext, classcolor..
---------------

function NotGrid:UNIT_MAIN(unitid)
	local o = self.o
	local f = self.UnitFrames[unitid]
	if o.configmode then
		unitid = "player"
	end

	if f and UnitExists(unitid) then
		local name = UnitName(unitid)
		local shortname = string.sub(name, 1, o.namelength)
		local _,class = UnitClass(unitid)
		local powertype = UnitPowerType(unitid)
		local pcolor = ManaBarColor[powertype]
		local color = {}

		if o.configmode then
			local c = {"WARRIOR","PALADIN","HUNTER","ROGUE","PRIEST","SHAMAN","MAGE","WARLOCK","DRUID"}
			local id = string.sub(f.unit, -1)
			id = tonumber(id)
			if id == 0 then id = 1 end
			if id == 1 then
				pcolor = ManaBarColor[1]
			elseif id == 4 then
				pcolor = ManaBarColor[3]
			else
				pcolor = ManaBarColor[0]
			end
			class = c[id]
		end

		if f.pet and o.usepetcolor then
			color.r,color.g,color.b = unpack(o.petcolor)
		elseif class and class == "SHAMAN" and o.useshamancolor then
			color = {r=0.14,g=0.35,b=1}
		elseif class then
			color = RAID_CLASS_COLORS[class]
		else
			color = {r=1,g=0,b=1}
		end

		--update some stuff
		f.name = name
		--handle coloring text
		if o.colorunithealthbarbyclass then
			f.healthbar:SetStatusBarColor(color.r, color.g, color.b, o.unithealthbarcolor[4])
		end
		if o.colorunitnamehealthbyclass then
			f.namehealthtext:SetTextColor(color.r, color.g, color.b, o.unitnamehealthtextcolor[4])
		end
		if o.colorunithealthbarbgbyclass then
			f.healthbar.bgtex:SetVertexColor(color.r, color.g, color.b)
		end

		f.powerbar:SetStatusBarColor(pcolor.r, pcolor.g, pcolor.b)
		if o.colorpowerbarbgbytype then
			f.powerbar.bgtex:SetVertexColor(pcolor.r, pcolor.g, pcolor.b)
		end

		if UnitIsConnected(unitid) then
			local healamount, currhealth, maxhealth, deficit, healtext, currpower, maxpower
			if o.configmode then
				currhealth = UnitHealth(unitid)/2
				maxhealth = UnitHealthMax(unitid)
				deficit = maxhealth - currhealth
				currpower = UnitManaMax(unitid)/2
				maxpower = UnitManaMax(unitid)
				healamount = maxhealth/4
			else
				currhealth = UnitHealth(unitid)
				maxhealth = UnitHealthMax(unitid)
				deficit = maxhealth - currhealth
				currpower = UnitMana(unitid)
				maxpower = UnitManaMax(unitid)
				healamount = self.HealComm:getHeal(name)
			end

			if healamount > 999 then
				healtext = string.format("+%.1fk", healamount/1000.0)
			else
				healtext = string.format("+%d", healamount)
			end

			f.healthbar:SetMinMaxValues(0, maxhealth)
			f.healthbar:SetValue(currhealth)

			f.powerbar:SetMinMaxValues(0, maxpower)
			f.powerbar:SetValue(currpower)

			if UnitIsDead(unitid) then
				self:UnitHealthZero(f, L["Dead"], shortname)
			elseif UnitIsGhost(unitid) or (deficit >= maxhealth) then -- we can't detect unitisghost if he's not in range so we do the additional conditional. It won't false report for "dead" because that's checked first. Still a lot of false reports. In BGs.
				self:UnitHealthZero(f, L["Ghost"], shortname)
			elseif currhealth/maxhealth*100 <= self.o.healththreshhold then
				local deficittext
				if deficit > 999 then
					deficittext = string.format("-%.1fk", deficit/1000.0)
				else
					deficittext = string.format("-%d", deficit)
				end
				f.namehealthtext:SetText(deficittext)
			else
				f.namehealthtext:SetText(shortname)
			end

			if healamount > 0 then
				if o.showhealcommbar then
					self:SetIncHealFrame(f, healamount, currhealth, maxhealth)
				end
				if o.showhealcommtext then
					f.healcommtext:SetText(healtext)
					f.healcommtext:Show()
				end
			else
				f.incheal:SetBackdropColor(0,0,0,0) -- instead of hiding the frame, which is parent to healthtext&inchealtext, I set its opacity to 0
				f.healcommtext:Hide()
			end

			if self.HealComm:UnitisResurrecting(name) then
				f.incres:Show()
			else
				f.incres:Hide()
			end
		else
			self:UnitHealthZero(f, "Offline", shortname)
		end
	end
end

function NotGrid:UnitHealthZero(f, state, shortname)
	f.namehealthtext:SetText(shortname.."\n"..state)
	f.incheal:SetBackdropColor(0,0,0,0) -- instead of hiding the frame, which is parent to healthtext&inchealtext, I set its opacity to 0
	f.healthbar:SetMinMaxValues(0, 1)
	f.healthbar:SetValue(0)
	f.powerbar:SetMinMaxValues(0, 1)
	f.powerbar:SetValue(0)
	f.healcommtext:Hide()
end

function NotGrid:SetIncHealFrame(f, healamount, currhealth, maxhealth) -- well this was easier than I was expecting it to be
	local o = self.o
	if o.unithealthorientation == 1 then -- I could rewrite these so its less copy paste but leaving it for now
		local modifier = maxhealth/o.unitheight -- get the modifer to convert health amounts to pixels based on set height
		local healheight = healamount/modifier
		local currheight = currhealth/modifier
		local maxheight = o.unitheight-currheight
		if maxheight == 0 then return end -- if the max height would equal to be 0 then SetHeight() function won't work so I jsut stop this function now
		if healheight >= maxheight then healheight = maxheight end
		f.incheal:SetHeight(healheight)
		f.incheal:ClearAllPoints()
		f.incheal:SetPoint("BOTTOM",0,currheight)
	else
		local modifier = maxhealth/o.unitwidth
		local healwidth = healamount/modifier
		local currwidth = currhealth/modifier
		local maxwidth = o.unitwidth-currwidth
		if maxwidth == 0 then return end
		if healwidth >= maxwidth then healwidth = maxwidth end
		f.incheal:SetWidth(healwidth)
		f.incheal:ClearAllPoints()
		f.incheal:SetPoint("LEFT",currwidth,0)
	end
	local color = o.unithealcommbarcolor
	f.incheal:SetBackdropColor(color[1],color[2],color[3],color[4]) -- instead of hide/show I set opacity. Note that I can't use SetAlpha cause it will hide the child elements
end

---------------
-- UNIT_AURA --
---------------

function NotGrid:UNIT_AURA(unitid)
	local o = self.o
	local f = self.UnitFrames[unitid]

	local bufftable = self.Compost:Acquire() -- I only care about buffname for buffs -- reset every time
	local debufftable = self.Compost:Acquire() -- spelltype only matters for debuffs -- could probably have these both in the same table

	if f and UnitExists(unitid) then
		--get buff info -- loop through every buff and adds info to table
		local bi = 1
		while (UnitBuff(unitid,bi) ~= nil) do
			self.Gratuity:SetUnitBuff(unitid,bi)
			local buffname = self.Gratuity:GetLine(1)
			if buffname then
				bufftable[buffname] = true
			end
			bi = bi + 1;
		end

		--get debuff info -- same as above
		local di = 1
		while (UnitDebuff(unitid,di) ~= nil) do
			self.Gratuity:SetUnitDebuff(unitid,di)
			local debuffname = self.Gratuity:GetLine(1)
			local _, _, spelltype =  UnitDebuff(unitid,di) -- texture, applications, type
			if debuffname then
				debufftable[debuffname] = true
			end
			if spelltype then
				debufftable[spelltype] = true
			end
			di = di + 1;
		end

		for i=1,8 do
			local f = f.healthbar["trackingicon"..i]
			if self:CheckAura(i,bufftable,debufftable) then
				f:Show()
			else
				f:Hide()
			end
		end
	end
	self.Compost:Reclaim(bufftable)
	self.Compost:Reclaim(debufftable)
end

function NotGrid:CheckAura(i, bufftable, debufftable)
	for _,text in self.o["trackingicon"..i] do
		if bufftable[text] or debufftable[text] then
			return true
		end
	end
end

-----------------
-- UNIT_BORDER --
-----------------

function NotGrid:UNIT_BORDER(unitid)
	local o = self.o
	local f = self.UnitFrames[unitid]
	if f and UnitExists(unitid) then
		local name = UnitName(unitid)
		local targetname = UnitName("Target") -- could get erronous with pets
		local currmana = UnitMana(unitid)
		local maxmana = UnitManaMax(unitid)
		if o.tracktarget and targetname and targetname == name then
			f.border:SetBackdropBorderColor(unpack(o.targetcolor))
			f.border.middleart:SetVertexColor(unpack(o.targetcolor))
		elseif o.trackaggro and self.Banzai:GetUnitAggroByUnitId(unitid) then
			f.border:SetBackdropBorderColor(unpack(o.aggrowarningcolor))
			f.border.middleart:SetVertexColor(unpack(o.aggrowarningcolor))
		elseif o.trackmana and UnitPowerType(unitid) == 0 and currmana/maxmana*100 < o.manathreshhold and not UnitIsDeadOrGhost(unitid) then
			f.border:SetBackdropBorderColor(unpack(o.manawarningcolor))
			f.border.middleart:SetVertexColor(unpack(o.manawarningcolor))
		else
			f.border:SetBackdropBorderColor(unpack(o.unitbordercolor))
			f.border.middleart:SetVertexColor(unpack(o.unitbordercolor))
		end
	end
end

-------------------
-- On Unit Click --
-------------------

function NotGrid:ClickHandle(button)
	if button == "RightButton" and SpellIsTargeting() then
		SpellStopTargeting()
		return
	end
	if button == "LeftButton" then
		if SpellIsTargeting() then
			SpellTargetUnit(this.unit)
		elseif CursorHasItem() then
			DropItemOnUnit(this.unit)
		else
			TargetUnit(this.unit)
		end
	else --Thanks Luna :^)
		local name = UnitName(this.unit)
		local id = string.sub(this.unit,5)
		local unit = this.unit
		local menuFrame = FriendsDropDown
		menuFrame.displayMode = "MENU"
		menuFrame.initialize = function() UnitPopup_ShowMenu(getglobal(UIDROPDOWNMENU_OPEN_MENU), "PARTY", unit, name, id) end
		ToggleDropDownMenu(1, nil, FriendsDropDown, "cursor")
	end
end

---------------------
-- Mousover Mimick --
---------------------

SLASH_NOTGRIDCAST1 = "/ngcast"
function SlashCmdList.NOTGRIDCAST(spell, editbox)
	local unitid = GetMouseFocus().unit
	if LazySpell and unitid then -- lazyspell will hook into my clique hook so we only need to apply it to ngcast
		if LazySpell.ValidateSpell then -- use convenient function from newer version
			spell = LazySpell:ValidateSpell(spell, unitid)
		else -- go through the original version
			local lsSpell,lsRank = LazySpell:ExtractSpell(spell)
			if NotGrid.HealComm.Spells[lsSpell] and lsRank == 1 then
				local lsRank = LazySpell:CalculateRank(lsSpell, unitid)
				spell = lsSpell.."(Rank "..lsRank..")"
			end
		end
	end
	NotGrid:CastHandle(spell,unitid)
end

---------------------
-- Spell Cast Hook --
---------------------

function NotGrid:CastHandle(spell, unitid)
	if unitid == "target" then -- prioritize healcomm functionality above proximity checks
		CastSpellByName(spell)
		if SpellIsTargeting() then
			SpellStopTargeting()
		end
		return
	end
	local LastTarget = UnitName("target") --used as boolean before using targetlasttarget
	ClearTarget()
	CastSpellByName(spell)
	NotGrid:SpellCanTarget() --check proximity on all roster members while the spell is queued up, have to specify NotGrid because it will be called by Clique if hooked
	if unitid and UnitExists(unitid) and SpellIsTargeting() and SpellCanTargetUnit(unitid) then -- then come back to our own func and see if they can cast on the unit they wanted to cast on
		SpellTargetUnit(unitid) -- if they can, cast on them
	elseif SpellCanTargetUnit("mouseover") then -- for casting outside unitframes .. does this affect clique in anyway?
		SpellTargetUnit("mouseover")
	end
	if SpellIsTargeting() then -- we queued up the spell but previous checks couldnt cast it on anyone
		SpellStopTargeting() -- stop targetting
	end
	if LastTarget then -- remember, use it as a boolean.
		TargetLastTarget() -- and finally, if they actually had an old target, then target it
	end
end
