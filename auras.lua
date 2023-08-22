function NotGrid:UNIT_AURA(unitid)
	local o = self.o
	local f = self.UnitFrames[unitid]

	if f and UnitExists(unitid) then
		--activate buffs -- loop through every buff and match them against every option, if I find a match then activate the frame
		local bi = 1
		while (UnitBuff(unitid,bi) ~= nil) do
			self.Gratuity:SetUnitBuff(unitid,bi)
			local buffname = self.Gratuity:GetLine(1)
			for i=1,8 do
				if self:CheckAura(o["trackingicon"..i], buffname) then
					self:SetIconFrame(f.healthbar["trackingicon"..i], buffname, nil, i)
				end
			end
			bi = bi + 1;
		end

		--activate debuffs -- same as above
		local di = 1
		while (UnitDebuff(unitid,di) ~= nil) do
			self.Gratuity:SetUnitDebuff(unitid,di)
			local debuffname = self.Gratuity:GetLine(1)
			local _, _, spelltype =  UnitDebuff(unitid,di) -- texture, applications, type
			for i=1,8 do
				if self:CheckAura(o["trackingicon"..i], debuffname) then
					self:SetIconFrame(f.healthbar["trackingicon"..i], debuffname, nil, i)
				elseif spelltype and self:CheckAura(o["trackingicon"..i], spelltype) then
					self:SetIconFrame(f.healthbar["trackingicon"..i], spelltype, spelltype, i)
				end
			end
			di = di + 1;
		end

		--clear buffs&debuffs -- loop through every option and match them against every buff, if its never found then clear the frame
		for i=1,8 do
			local fi = f.healthbar["trackingicon"..i]
			if fi.active then
				local found = false
				local bi = 1
				while (UnitBuff(unitid,bi) ~= nil) do
					self.Gratuity:SetUnitBuff(unitid,bi)
					local buffname = self.Gratuity:GetLine(1)
					if self:CheckAura(o["trackingicon"..i], buffname) then -- i can probably reduce this, but its workign for now
						found = true
					end
					bi = bi + 1;
				end
				local di = 1
				while (UnitDebuff(unitid,di) ~= nil) do
					self.Gratuity:SetUnitDebuff(unitid,di)
					local debuffname = self.Gratuity:GetLine(1)
					local _, _, spelltype =  UnitDebuff(unitid,di) -- texture, applications, type
					if self:CheckAura(o["trackingicon"..i], debuffname) or (spelltype and self:CheckAura(o["trackingicon"..i], spelltype)) then
						found = true
					end
					di = di + 1
				end
				if found == false then
					self:ClearIconFrame(fi)
				end
			end
		end
	end
end

function NotGrid:CheckAura(str, aura)
	if str and aura then
		for text in string.gfind(str, "([^|]+)") do
			if text == aura then
				return true
			end
		end
	end
end

function NotGrid:SetIconFrame(f, activeval, spelltype, i) -- don't need spelltype after we're just using user specified colors
	f:SetBackdropColor(unpack(self.o["trackingicon"..i.."color"]))
	f.active = activeval
	f:Show()
end

function NotGrid:ClearIconFrame(f)
	f.active = nil
	f:Hide()
end



--[[ Notes
	UNIT_AURA will trigger when a unit moves into render range and out of render range.
	When they're out of render range auras act wierd. Some auras can be seen some cannot. Sometimes they trigger a UNIT_AURA sometimes they do not.
	If someone reloadsui, relogs, or configs the unitframes they'd have to wait for a unit to trigger a UNIT_AURA event to update those auras. Or
look for them manually.
]]