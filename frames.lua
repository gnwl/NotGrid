---------------------
-- Creating Frames --
---------------------

function NotGrid:CreateFrames()
	self.Container = self:CreateContainerFrame()
	for i=1,40 do
		self.UnitFrames["raid"..i] = self:CreateUnitFrame("raid"..i,i)
	end
	for i=1,4 do
		self.UnitFrames["party"..i] = self:CreateUnitFrame("party"..i)
	end
	for i=1,4 do
		self.UnitFrames["partypet"..i] = self:CreateUnitFrame("partypet"..i)
	end
	self.UnitFrames["player"] = self:CreateUnitFrame("player")
	self.UnitFrames["pet"] = self:CreateUnitFrame("pet")
end

function NotGrid:CreateContainerFrame()
	local f = CreateFrame("Frame","NotGridContainer",UIParent)
	f:SetWidth(1)
	f:SetHeight(1)
	--f:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", tile = true, tileSize = 16, edgeSize = 10})
	f:SetMovable(true)
	f:SetPoint("CENTER",40,-40)
	return f
end

function NotGrid:CreateUnitFrame(unitid,raidindex)
	local f = CreateFrame("Button","$parent"..unitid,self.Container)
	f.unit = unitid
	f.lastseen = GetTime() -- we set this at creation, so we don't have to config frame as out of range alpha by default
	if raidindex then
		f.raidindex = raidindex -- :^)
	end
	if string.find(unitid,"pet") then
		f.pet = true -- so I have a boolean to check against
	end

	f.border = CreateFrame("Frame","$parentborder",f) -- make a seperate frame for the edgefile/border for better customization possibilities
	f.border.middleart = f.border:CreateTexture("NGArtworkMiddle", "ARTWORK")

	f.healthbar = CreateFrame("StatusBar","$parenthealthbar",f)
	f.healthbar.bgtex = f.healthbar:CreateTexture("$parentbgtex","BACKGROUND")

	f.powerbar = CreateFrame("StatusBar","$parenthealthbar",f)
	f.powerbar.bgtex = f.powerbar:CreateTexture("$parentbgtex","BACKGROUND")

	f.incres = CreateFrame("Frame","$parentresicon",f.healthbar)
	f.incres.bgtex = f.incres:CreateTexture("$parentbgtex","BACKGROUND")

	f.incheal = CreateFrame("Frame","$parenthealcommbar",f.healthbar) -- Was using a statusbar behind the health frame but when the frame's alpha is low this would be seen through it
	
	-- I was having problems with incheal covering up these fontstrings. My soluction is to parent them to the incheal, but set the relative point to the healthbar. And instead of hide/show the incheal I just lower/higher its color opacity
	f.namehealthtext = f.incheal:CreateFontString("$parentnamehealthtext", "OVERLAY")
	f.healcommtext = f.incheal:CreateFontString("$parenthealcommtext", "OVERLAY")

	for i=1,8 do
		f.healthbar["trackingicon"..i] = CreateFrame("Frame","$parenttrackingicon"..i,f.healthbar) -- easier to work with digits than topleft/topright/etc..
	end
	--scripts and stuff
	f:RegisterForClicks("LeftButtonDown", "RightButtonDown", "MiddleButtonDown", "Button4Down", "Button5Down") -- somehow I recall this not matterign?
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnClick", function()
		if Clique then
			if not Clique:OnClick(arg1, this.unit) then
				self:ClickHandle(arg1) -- if it failed to find anything in clique then we send it to the regular handler
			end
		else
			self:ClickHandle(arg1)
		end
	end)
	f:SetScript("OnEnter", function()
		if UnitAffectingCombat("player") and self.o.disablemouseoverincombat then
			return
		end

		UnitFrame_OnEnter() -- a blizzard function that handles the tooltip for the unit
	end)
	f:SetScript("OnLeave", function() 
		UnitFrame_OnLeave() -- blizz function that handles tooltip for units
	end)

	--we can split these up into their own relative frames & functions later
	--we have to respond to these to update names/classes etc on roster changes
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:RegisterEvent("PARTY_MEMBERS_CHANGED")
	f:RegisterEvent("RAID_ROSTER_UPDATE")
	f:RegisterEvent("UNIT_PET")
	--might as well
	f:RegisterEvent("UNIT_NAME_UPDATE")
	f:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	--healthbar
	f:RegisterEvent("UNIT_HEALTH")
	f:RegisterEvent("UNIT_MAXHEALTH")
	--manabar
	f:RegisterEvent("UNIT_MANA")
	f:RegisterEvent("UNIT_RAGE")
	f:RegisterEvent("UNIT_FOCUS")
	f:RegisterEvent("UNIT_ENERGY")
	f:RegisterEvent("UNIT_HAPPINESS")
	f:RegisterEvent("UNIT_MAXMANA")
	f:RegisterEvent("UNIT_MAXRAGE")
	f:RegisterEvent("UNIT_MAXFOCUS")
	f:RegisterEvent("UNIT_MAXENERGY")
	f:RegisterEvent("UNIT_MAXHAPPINESS")
	f:RegisterEvent("UNIT_DISPLAYPOWER")
	--aura
	f:RegisterEvent("UNIT_AURA")
	--used for highlight target feature
	f:RegisterEvent("PLAYER_TARGET_CHANGED")
	--banzai/healcomm are registered in core on enable

	f:SetScript("OnEvent", function()
		if arg1 and arg1 == this.unit then -- if an event has coniditions specific to a unit, then only specified unit will update
			if event == "UNIT_AURA" then
				self:UNIT_AURA(this.unit)
			else
				self:UNIT_MAIN(this.unit)
				self:UNIT_BORDER(this.unit)
			end
		elseif event == "PLAYER_TARGET_CHANGED" then -- all units will update their border
			self:UNIT_BORDER(this.unit)
		elseif not arg1 then -- no arg1, its a generic event like partymemberschanged and all units will update themselves
			self:UNIT_MAIN(this.unit)
			self:UNIT_BORDER(this.unit)
			self:UNIT_AURA(unitid)
		end
	end)

	return f
end

-------------------
-- Config Frames --
-------------------

function NotGrid:ConfigUnitFrames() -- this can get called on every setting change, instead of doing some wierd roundabout way. Hurray!
	local o = self.o
	for _,f in self.UnitFrames do
		--f:SetAlpha(self.o.ooralpha) -- we set lastseen at frame creation instead. doing it like this makes config mode weird, and would obstruct disabling prox checking
		local width, height
		if o.showpowerbar and o.powerposition <= 2 then -- factor in a modifier for the powerbar width/height
			width = o.unitwidth
			height = o.unitheight+o.powersize+1
		elseif o.showpowerbar and o.powerposition >= 3 then
			width = o.unitwidth+o.powersize+1
			height = o.unitheight
		else
			width = o.unitwidth
			height = o.unitheight
		end
		f:SetWidth(width)
		f:SetHeight(height)
		f:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8", tile = true, tileSize = 16})
		f:SetBackdropColor(unpack(o.unitbgcolor))

		if o.borderartwork then
			f.border:SetWidth(width+o.unitborder) -- the way edgefile works is it basically sits on the center of the edge of the frame and expands both inward and outward. So to compensate asthetically for that I ahve to increase the size of my frame double the desired width of the edgefile/border
			f.border:SetHeight(height+o.unitborder)
			f.border:SetBackdrop({edgeFile = "Interface\\AddOns\\NotGrid\\media\\borderartwork", edgeSize = 16})
		else
			f.border:SetWidth(width+o.unitborder*2) -- the way edgefile works is it basically sits on the center of the edge of the frame and expands both inward and outward. So to compensate asthetically for that I ahve to increase the size of my frame double the desired width of the edgefile/border
			f.border:SetHeight(height+o.unitborder*2)
			f.border:SetBackdrop({edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = o.unitborder})
		end
		f.border:SetBackdropBorderColor(unpack(o.unitbordercolor))
		f.border:SetPoint("CENTER",0,0)
		f.border:SetFrameLevel(f:GetFrameLevel() + 2)
		f.border.middleart:SetTexture("Interface/TargetingFrame/UI-TargetingFrame")
		if o.powerposition <= 2 then
			f.border.middleart:SetTexCoord((58/256)+(1/256/2), (82/256)+(1/256/2), (39/128)+(1/128/2), (44/128)+(1/128/2))
			f.border.middleart:SetVertexColor(unpack(o.unitbordercolor))
		else
			f.border.middleart:SetTexCoord((26/256)+(1/256/2), (32/256)+(1/256/2), (27/128)+(1/128/2), (34/128)+(1/128/2))
			f.border.middleart:SetVertexColor(unpack(o.unitbordercolor))
		end


		f.healthbar:SetWidth(o.unitwidth)
		f.healthbar:SetHeight(o.unitheight)
		if o.unithealthorientation == 1 then
			f.healthbar:SetOrientation("VERTICAL")
		else
			f.healthbar:SetOrientation("HORIZONTAL")
		end
		f.healthbar:SetStatusBarTexture(o.unithealthbartexture)
		f.healthbar:SetStatusBarColor(unpack(o.unithealthbarcolor))
		f.healthbar.bgtex:SetTexture(o.unithealthbarbgtexture)
		f.healthbar.bgtex:SetVertexColor(unpack(o.unithealthbarbgcolor))
		f.healthbar.bgtex:SetAllPoints()

		--position health and powerbar
		f.healthbar:ClearAllPoints()
		f.powerbar:ClearAllPoints()
		f.border.middleart:ClearAllPoints()
		if o.showpowerbar then
			if o.powerposition <= 2 then -- power on top
				if o.powerposition == 1 then
					f.healthbar:SetPoint("BOTTOM",0,0)
					f.powerbar:SetPoint("TOP",0,0)
					f.border.middleart:SetPoint("BOTTOM", f.powerbar, 0, -4)
				else
					f.healthbar:SetPoint("TOP",0,0)
					f.powerbar:SetPoint("BOTTOM",0,0)
					f.border.middleart:SetPoint("TOP", f.powerbar, 0, 4)
				end
				f.powerbar:SetWidth(o.unitwidth)
				f.powerbar:SetHeight(o.powersize)
				f.powerbar:SetOrientation("HORIZONTAL")
				f.border.middleart:SetWidth(width)
				f.border.middleart:SetHeight(6)
			elseif o.powerposition >= 3 then
				if o.powerposition == 3 then
					f.healthbar:SetPoint("LEFT",0,0)
					f.powerbar:SetPoint("RIGHT",0,0)
					f.border.middleart:SetPoint("LEFT", f.powerbar, -4, 0)
				else
					f.healthbar:SetPoint("RIGHT",0,0)
					f.powerbar:SetPoint("LEFT",0,0)
					f.border.middleart:SetPoint("RIGHT", f.powerbar, 4, 0)
				end
				f.powerbar:SetWidth(o.powersize)
				f.powerbar:SetHeight(o.unitheight)
				f.powerbar:SetOrientation("VERTICAL")
				f.border.middleart:SetWidth(6)
				f.border.middleart:SetHeight(height)
			end
			f.powerbar:Show()
			if o.borderartwork then
				f.border.middleart:Show()
			else
				f.border.middleart:Hide()
			end
		else
			f.healthbar:SetPoint("CENTER",0,0)
			f.powerbar:Hide()
			f.border.middleart:Hide()
		end
		f.powerbar:SetStatusBarTexture(o.unithealthbartexture)
		f.powerbar.bgtex:SetTexture(o.unithealthbartexture)
		f.powerbar.bgtex:SetVertexColor(unpack(o.unitpowerbarbgcolor))
		f.powerbar.bgtex:SetAllPoints()
		--f.powerbar:SetStatusBarColor(unpack(o.unithealthbarcolor))

		f.incres:SetWidth(o.unitheight) -- yep, so it stays square under most common sizes. Think of a mathematical way in the future
		f.incres:SetHeight(o.unitheight)
		f.incres:ClearAllPoints()
		f.incres:SetPoint("CENTER",0,0)
		f.incres.bgtex:SetTexture("Interface\\AddOns\\NotGrid\\media\\res")
		f.incres.bgtex:SetAllPoints()
		f.incres:Hide()

		f.incheal:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", tile = true, tileSize = 16, edgeSize = 1, insets = { left = 0, right = 0, top = 0, bottom = 0 }})
		f.incheal:SetBackdropColor(0,0,0,0)
		f.incheal:SetBackdropBorderColor(0,0,0,0) -- mostly just so its 0 opacity
		f.incheal:SetWidth(o.unitwidth)
		f.incheal:SetHeight(o.unitheight)

		for _,fsname in {"namehealthtext", "healcommtext"} do
			local fs = f[fsname]
			fs:SetShadowColor(0, 0, 0, 1.0)
			fs:SetShadowOffset(0.80, -0.80)
			fs:ClearAllPoints()
			if fsname == "namehealthtext" then
				if not o.colorunitnamehealthbyclass then
					fs:SetTextColor(unpack(o.unitnamehealthtextcolor))
				end
				fs:SetFont(o.unitfont, o.unitnamehealthtextsize)
				fs:SetPoint("CENTER",f.healthbar,"CENTER",o.unitnamehealthoffx,o.unitnamehealthoffy)
			elseif fsname == "healcommtext" then
				fs:SetTextColor(unpack(o.unithealcommtextcolor))
				fs:SetFont(o.unitfont, o.unithealcommtextsize)
				fs:SetPoint("CENTER",f.healthbar,"CENTER",o.unithealcommtextoffx,o.unithealcommtextoffy)
				if not o.showhealcommtext then
					fs:Hide()
				end
			end
		end
		for i,point in {"TOPLEFT", "TOP", "TOPRIGHT", "RIGHT", "BOTTOMRIGHT", "BOTTOM", "BOTTOMLEFT", "LEFT"} do
			local fi = f.healthbar["trackingicon"..i]
			fi:SetWidth(o.unittrackingiconsize)
			fi:SetHeight(o.unittrackingiconsize)
			fi:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", tile = true, tileSize = o.unittrackingiconsize, edgeSize = o.unittrackingiconborder})
			fi:SetBackdropBorderColor(o.unittrackingiconbordercolor)
			fi:ClearAllPoints()
			fi:SetPoint(point,0,0)
			fi:Hide()
		end
	end
end

---------------------
-- Position Frames --
---------------------

function NotGrid:PositionFrames()
	local partycount = GetNumPartyMembers()
	local raidcount = GetNumRaidMembers()

	local SubGroupCounts = {0,0,0,0,0,0,0,0,0,0} -- reset it every time
	local TotalGroups = 0
	local TotalUnits = 0
	local o = self.o

	local powermodx = 0 -- so I can interject the width of the powerbar into the positioning calcs without doing a million more conditionals
	local powermody = 0
	if o.showpowerbar then
		if o.powerposition <= 2 then
			powermody = o.powersize+1
		else
			powermodx = o.powersize+1
		end
	end	

	--handle all the unitframes and subgroups
	for i=1,10 do -- 1-8 is raid, 9 is party, 10 is partypet
		for key,f in self.UnitFrames do
			if UnitExists(f.unit) or o.configmode then
				-- first get the subgroup
				local subgroup = nil
				if f.raidindex then -- if a frame with raid unitid
					if o.configmode then
						subgroup = (math.ceil(math.abs(f.raidindex/5))) -- doing it like this does mean it loops and calcs this 10 times for all the unitframes, though
					else
						_,_,subgroup = GetRaidRosterInfo(f.raidindex)
					end
				elseif (string.find(f.unit,"party%d") or (f.unit == "player")) and ((raidcount > 0 and o.showpartyinraid) or (raidcount == 0 and partycount > 0 and o.showinparty and not o.configmode) or (raidcount == 0 and partycount == 0 and o.showwhilesolo and not o.configmode) or (o.configmode and o.showpartyinraid)) then
					subgroup = 9
				elseif (string.find(f.unit,"partypet%d") or (f.unit == "pet")) and ((raidcount > 0 and o.showpartyinraid and o.showpets) or (raidcount == 0 and partycount > 0 and o.showinparty and o.showpets and not o.configmode) or (raidcount == 0 and partycount == 0 and o.showwhilesolo and o.showpets and not o.configmode) or (o.configmode and o.showpartyinraid and o.showpets)) then
					subgroup = 10
				else
					f:Hide() -- I won't set a subgroup so it will fail the next check, wont position, and won't get counted into subgroup/totalgroups
				end

				--then do all the positioning
				if subgroup == i then
					f:ClearAllPoints()
					if o.growthdirection == 1 then
						f:SetPoint("CENTER",(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)*TotalGroups,-(o.unitheight+powermody+o.unitborder*2+o.unitpadding)*SubGroupCounts[i])
					elseif o.growthdirection == 2 then
						f:SetPoint("CENTER",-(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)*TotalGroups,-(o.unitheight+powermody+o.unitborder*2+o.unitpadding)*SubGroupCounts[i]) -- i do subgroup -1 so group 1 will be 0 and be at 0 offset
					elseif o.growthdirection == 3 then
						f:SetPoint("CENTER",(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)*SubGroupCounts[i],-(o.unitheight+powermody+o.unitborder*2+o.unitpadding)*TotalGroups)
					elseif o.growthdirection == 4 then
						f:SetPoint("CENTER",(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)*SubGroupCounts[i],(o.unitheight+powermody+o.unitborder*2+o.unitpadding)*TotalGroups)
					elseif o.growthdirection == 5 then -- single top to bottom
						f:SetPoint("CENTER",0,-(o.unitheight+powermody+o.unitborder*2+o.unitpadding)*TotalUnits)
					elseif o.growthdirection == 6 then -- single bottom to top
						f:SetPoint("CENTER",0,(o.unitheight+powermody+o.unitborder*2+o.unitpadding)*TotalUnits)
					elseif o.growthdirection == 7 then -- single left to right
						f:SetPoint("CENTER",(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)*TotalUnits,0)
					elseif o.growthdirection == 8 then -- single right to left
						f:SetPoint("CENTER",-(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)*TotalUnits,0)
					end
					f:Show()
					TotalUnits = TotalUnits+1
					SubGroupCounts[i] = SubGroupCounts[i]+1
					--DEFAULT_CHAT_FRAME:AddMessage(f.unit .. " positioned")
				end
			else
				f:Hide()
			end
		end
		if SubGroupCounts[i] > 0 then
			TotalGroups = TotalGroups+1
		end
	end

	--handle the container frame
	self.Container:ClearAllPoints()
	if o.smartcenter == true and o.growthdirection == 1 then
			self.Container:SetPoint(o.containerpoint,o.containeroffx-(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)/2*(TotalGroups-1),o.containeroffy)
	elseif o.smartcenter == true and o.growthdirection == 2 then
			self.Container:SetPoint(o.containerpoint,o.containeroffx+(o.unitwidth+powermodx+o.unitborder*2+o.unitpadding)/2*(TotalGroups-1),o.containeroffy)
	else
		self.Container:SetPoint(o.containerpoint,o.containeroffx,o.containeroffy)
	end

	--handle the blizzframes
	for i=1,partycount do -- this isn't perfect because, for example, if partycount were at 0 it just wouldn't run and wouldn't hide any remaining frames. But blizz's code handles hiding it natively on member leave so I won't worry about it.
		if o.showblizzframes then
			getglobal("PartyMemberFrame"..i):Show();
		else
			getglobal("PartyMemberFrame"..i):Hide();
		end
	end

end
