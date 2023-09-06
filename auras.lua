function NotGrid:UNIT_AURA(unitid)
	local o = self.o
	local f = self.UnitFrames[unitid]

	local bufftable = {} -- I only care about buffname for buffs -- reset every time
	local debufftable = {} -- spelltype only matters for debuffs -- could probably have these both in the same table

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
			if self:CheckAura(o["trackingicon"..i],bufftable,debufftable) then
				f:Show()
			else
				f:Hide()
			end
		end
	end
end

function NotGrid:CheckAura(str, bufftable, debufftable)
	if str then
		for text in string.gfind(str, "([^|]+)") do
			if bufftable[text] or debufftable[text] then
				return true
			end
		end
	end
end

--[[ Notes
	UNIT_AURA will trigger when a unit moves into render range and out of render range.
	When they're out of render range auras act wierd. Some auras can be seen some cannot. Sometimes they trigger a UNIT_AURA sometimes they do not.
	If someone reloadsui, relogs, or configs the unitframes they'd have to wait for a unit to trigger a UNIT_AURA event to update those auras. Or
look for them manually.
]]