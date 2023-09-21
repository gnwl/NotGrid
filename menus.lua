local L = AceLibrary("AceLocale-2.2"):new("NotGrid")

--------------------
-- Unit Drop Down --
--------------------

-- So moreover I'm just going to create a frame that looks like a menu
function NotGrid:DoDropDown()
	self:InitializeMenu()
	self:InitializeSlider()
	self:InitializeEditBox()
	self:InitializePositionBox()
end

local menuarray = {
	--flavortext, booleantoggle, currvalueforslider, currecntvalueforeditbox, currvalueforcolor
	{text = L["Config Mode"],
	toggle = "configmode",
	},

	{text = "",},

	{text = L["Position"],
	position = {
		xkey = "containeroffx",
		ykey = "containeroffy",
		},
	},

	{text = "",},

	{text = L["Unit Width"], 
	slider = {
		key = "unitwidth",
		minval = 1,
		maxval = 100,
		},
	},
	{text = L["Unit Height"], 
	slider = {
		key = "unitheight",
		minval = 1,
		maxval = 100,
		},
	},
	{text = L["Unit Border"], 
	slider = {
		key = "unitborder",
		minval = 1,
		maxval = 20,
		},
	color = {
			key = "unitbordercolor",
		},
	},
	{text = L["Border Artwork"],
	toggle = "borderartwork",
	},
	{text = L["Unit Padding"], 
	slider = {
		key = "unitpadding",
		minval = -20,
		maxval = 20,
		},
	},
	{text = L["Font"],
	editbox = {
		key = "unitfont",
		},
	},
	{text = L["Texture"],
	editbox = {
		key = "unithealthbartexture",
		},
	},
	{text = L["Background"], -- (Toggle for Class)
	color = {
			key = "unitbgcolor",
		},
	},
	{text = L["Name Size"],
	slider = {
		key = "unitnamehealthtextsize",
		minval = 1,
		maxval = 20,
		},
	},
	{text = L["Name Length"],
	slider = {
		key = "namelength",
		minval = 1,
		maxval = 12,
		},
	},
	{text = L["Name Position"],
	position = {
		xkey = "unitnamehealthoffx",
		ykey = "unitnamehealthoffy",
		},
	},
	{text = L["Name Color"], -- (Toggle for Class)
	toggle = "colorunitnamehealthbyclass",
	color = {
			key = "unitnamehealthtextcolor",
		},
	tooltip = L["Toggle for class color."],
	},
	{text = L["Health Color"], -- (Toggle for Class)
	toggle = "colorunithealthbarbyclass",
	color = {
			key = "unithealthbarcolor",
		},
	tooltip = L["Toggle for class color."],
	},
	{text = L["Health Background"], -- (Toggle for Class)
	editbox = {
		key = "unithealthbarbgtexture",
		},
	toggle = "colorunithealthbarbgbyclass",
	color = {
			key = "unithealthbarbgcolor",
		},
	tooltip = L["Toggle for class color."],
	},
	{text = L["Health Orientation"],
	slider = {
		key = "unithealthorientation",
		minval = 1,
		maxval = 2,
		},
	},
	{text = L["Health Threshold"],
	slider = {
		key = "healththreshhold",
		minval = 1,
		maxval = 100,
		},
	tooltip = L["Health percentage before name is replaced with health deficit."],
	},

	{text = "",},

	{text = L["Show Power Bar"],
	toggle = "showpowerbar",
	},
	{text = L["Power Background"],
	toggle = "colorpowerbarbgbytype",
	tooltip = L["Toggle for power color."],
	color = {
			key = "unitpowerbarbgcolor",
		},
	},
	{text = L["Power Position"],
	slider = {
		key = "powerposition",
		minval = 1,
		maxval = 4,
		},
	},
	{text = L["Power Size"],
	slider = {
		key = "powersize",
		minval = 1,
		maxval = 50,
		},
	},


	{text = "",},

	-- Icons --

	{text = L["Icon Size"],
	slider = {
		key = "unittrackingiconsize",
		minval = 1,
		maxval = 30,
		},
	},
	{text = L["Top Left Icon"],
	editbox = {
		key = "trackingicon1",
		},
	color = {
		key = "trackingicon1color",
		},
	},
	{text = L["Top Icon"],
	editbox = {
		key = "trackingicon2",
		},
	color = {
		key = "trackingicon2color",
		},
	},
	{text = L["Top Right Icon"],
	editbox = {
		key = "trackingicon3",
		},
	color = {
		key = "trackingicon3color",
		},
	},
	{text = L["Right Icon"],
	editbox = {
		key = "trackingicon4",
		},
	color = {
		key = "trackingicon4color",
		},
	},
	{text = L["Bottom Right Icon"],
	editbox = {
		key = "trackingicon5",
		},
	color = {
		key = "trackingicon5color",
		},
	},
	{text = L["Bottom Icon"],
	editbox = {
		key = "trackingicon6",
		},
	color = {
		key = "trackingicon6color",
		},
	},
	{text = L["Bottom Left Icon"],
	editbox = {
		key = "trackingicon7",
		},
	color = {
		key = "trackingicon7color",
		},
	},
	{text = L["Left Icon"],
	editbox = {
		key = "trackingicon8",
		},
	color = {
		key = "trackingicon8color",
		},
	},
	-- end of icons --
	{text = "",},

	{text = L["Healcomm Bar"],
	toggle = "showhealcommbar",
	color = {
			key = "unithealcommbarcolor",
		},
	},
	{text = L["Healcomm Text"],
	toggle = "showhealcommtext",
	slider = {
		key = "unithealcommtextsize",
		minval = 1,
		maxval = 20,
		},
	color = {
			key = "unithealcommtextcolor",
		},
	},
	{text = L["Healcomm Text Position"],
	position = {
		xkey = "unithealcommtextoffx",
		ykey = "unithealcommtextoffy",
		},
	},

	{text = "",},

	{text = L["Highlight Target"],
	toggle = "tracktarget",
	color = {
			key = "targetcolor",
		},
	},

	{text = L["Aggro Warning"],
	toggle = "trackaggro",
	color = {
			key = "aggrowarningcolor",
		},
	},

	{text = L["Mana Warning"],
	toggle = "trackmana",
	slider = {
		key = "manathreshhold",
		minval = 1,
		maxval = 100,
		},
	tooltip = L["Mana percentage before border color changes."],
	color = {
			key = "manawarningcolor",
		},
	},

	{text = "",},

	{text = L["Use Map Proximity"],
	toggle = "usemapdistances",
	},
	{text = L["Proximity Rate"],
	slider = {
		key = "proximityrate",
		minval = 0.5,
		maxval = 5,
		stepvalue = 0.5,
		},
	tooltip = L["Amount of seconds between proximity checks."],
	},
	{text = L["Proximity Leeway"], 
	slider = {
		key = "proximityleeway",
		minval = 0,
		maxval = 30,
		},
	tooltip = L["proximityleeway_tooltip"],
	},

	{text = "",},

	{text = L["Smart Center"], 
	toggle = "smartcenter",
	tooltip = L["As your raid expands the frames stay centered on the original group placement. Currently only works for horizontal growth."],
	},
	{text = L["Growth Direction"], 
	slider = {
		key = "growthdirection",
		minval = 1,
		maxval = 8,
		},
	},

	{text = "",},

	{text = L["Show While Solo"], 
	toggle = "showwhilesolo",
	},
	{text = L["Show In Party"], 
	toggle = "showinparty",
	},
	{text = L["Show Party In Raid"], 
	toggle = "showpartyinraid",
	},
	{text = L["Show Pets"],
	toggle = "showpets",
	tooltip = L["Note: Prone to visual errors."],
	},
	{text = L["Custom Pet Color"],
	toggle = "usepetcolor",
	color = {
		key = "petcolor",
		},
	},
	{text = L["TBC Shaman Color"],
	toggle = "useshamancolor",
	},
	{text = L["Show Blizz Frames"], 
	toggle = "showblizzframes",
	},
	{text = L["Disable Tooltip In Combat"],
	toggle = "disablemouseoverincombat",
	},

	{text = "",},

	{text = L["Clique Hook"],
	toggle = "cliquehook",
	reloadui = true,
	tooltip = L["cliquehook_tooltip"],
	},
}


--variables for dynamic menu
local buttonheight = 16
local numdisplay = 30

--------------
-- Dropdown --
--------------

function NotGrid:InitializeMenu()
	local f = CreateFrame("Button","NotGridOptionsMenu",UIParent)
	f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 }})
	f:SetBackdropColor(0,0,0)
	f:SetWidth(190)
	f:SetHeight(buttonheight*(numdisplay+3)) -- +3 to offset it from the top
	f:SetPoint("CENTER",UIParent)
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton")
	f:EnableMouseWheel()
	f.offset = 0 -- for scrolling
	f.fs = f:CreateFontString('$parentTitle', "ARTWORK", "GameFontNormalLarge")
	f.fs:SetText(L["Scroll Me!"])
	f.fs:SetPoint("TOPLEFT",12,-12)
	--f.fs:SetTextColor(1,0.29,0.67,1)
	f:SetScript("OnMouseWheel", function()
		if f.offset >= 5 then
			--f.fs:Hide()
			f.fs:SetText("Not Grid")
		end
		self:ScrollHandler()
	end)
	f:SetScript("OnShow", function()
		self:ScrollHandler() -- have to run it onshow because all the positioning is done in this func
	end)
	f:SetScript("OnDragStart", function()
		NotGridOptionsMenu:StartMoving()
	end)
	f:SetScript("OnDragStop", function()
		this:StopMovingOrSizing()
	end)
	f:Hide()
	local fx = CreateFrame("Button","$parentXbutton",f,"UIPanelCloseButton")
	fx:SetPoint("TOPRIGHT",0,0)

	for key,val in menuarray do
		local fb = CreateFrame("Button", "$parentbutton"..key, f)
		fb:SetWidth(140)
		fb:SetHeight(buttonheight)
		--fb:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 }})
		--fb:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
		fb:SetHighlightTexture("Interface/Buttons/UI-Listbox-Highlight","ADD")
		--
		fb.fs = fb:CreateFontString('$parenttext', "ARTWORK", "GameFontHighlightSmall")
		fb.fs:SetText(val.text)
		fb.fs:SetPoint("LEFT",0,0)
		--
		--fb.text = val.text
		fb.toggle = val.toggle
		fb.slider = val.slider
		fb.editbox = val.editbox
		--fb.color = val.color
		fb.tooltip = val.tooltip
		fb.reloadui = val.reloadui
		fb.position = val.position
		--
		-- if fb.toggle, make a checkmark frame
		if val.toggle then
			fb.chk = CreateFrame("Frame","$parentCheckmark",fb)
			fb.chk:SetWidth(20)
			fb.chk:SetHeight(20)
			fb.chk.tex = fb.chk:CreateTexture()
			if NotGridOptions[fb.toggle] then
				fb.chk.tex:SetTexture("Interface/Buttons/UI-CheckBox-Check")
			else
				fb.chk.tex:SetTexture("Interface/Buttons/UI-CheckBox-Check-Disabled")
			end
			fb.chk.tex:SetAllPoints()
			fb.chk:SetPoint("RIGHT",fb,"LEFT",0,0)
		end
		if val.color then
			fb.clr = CreateFrame("Button","$parentButton",fb)
			fb.clr.color = val.color
			fb.clr:SetWidth(14)
			fb.clr:SetHeight(14)
			fb.clr:SetBackdrop({edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1})
			fb.clr:SetBackdropBorderColor(1,1,1,0.8)
			fb.clr.tex = fb.clr:CreateTexture("$parentTexture")
			fb.clr.tex:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch")
			fb.clr.tex:SetVertexColor(unpack(NotGridOptions[val.color.key]))
			fb.clr.tex:SetAllPoints()
			fb.clr:SetPoint("LEFT",fb,"RIGHT",0,0)
			fb.clr:SetScript("OnClick", function()
				--DEFAULT_CHAT_FRAME:AddMessage(NotGridOptions[this.color.key][1])
				self:ClickColor()
			end)
		end

		fb:SetScript("OnClick", function()
			if this.toggle then
				if NotGridOptions[this.toggle] == true then
					NotGridOptions[this.toggle] = false
					fb.chk.tex:SetTexture("Interface/Buttons/UI-CheckBox-Check-Disabled")
					if this.toggle == "borderartwork" then
						NotGrid.o.unitbordercolor = {0,0,0,0.8}
						NotGrid.o.unitpadding = 2
						NotGrid.o.unitborder = 2
					end
					NotGridOptionChange()
				else
					NotGridOptions[this.toggle] = true
					fb.chk.tex:SetTexture("Interface/Buttons/UI-CheckBox-Check")
					if this.toggle == "borderartwork" then
						NotGrid.o.unitbordercolor = {0.8,0.8,0.8,1}
						NotGrid.o.unitpadding = -10
						NotGrid.o.unitborder = 8
					end
					NotGridOptionChange()
				end
			end
			if this.reloadui then
				ReloadUI()
			end
		end)
		fb:SetScript("OnEnter", function()
			if this.slider and this.editbox then
				--show them both
			elseif this.editbox then
				NotGridMenuEditBox.key = this.editbox.key
				if type(NotGridOptions[this.editbox.key]) == "table" then -- for tracking icons
					NotGridMenuEditBox:SetText(table.concat(NotGridOptions[this.editbox.key],"/")) -- gfind and table.concat seem to have problems with | character so we use /
					NotGridMenuEditBox.istable = true
				else
					NotGridMenuEditBox:SetText(NotGridOptions[this.editbox.key])
					NotGridMenuEditBox.istable = false
				end
				NotGridMenuEditBoxContainer:ClearAllPoints()
				NotGridMenuEditBoxContainer:SetPoint("TOPRIGHT",this,"TOPLEFT",-20,0)
				NotGridMenuEditBoxContainer:Show()
				--make sure slider is hidden
				NotGridMenuSliderContainer:Hide()
				NotGridMenuPositionBoxContainer:Hide()
			elseif this.slider then
				NotGridMenuSlider.key = this.slider.key
				NotGridMenuSlider:SetMinMaxValues(this.slider.minval, this.slider.maxval)
				NotGridMenuSlider:SetValue(NotGridOptions[this.slider.key])
				NotGridMenuSlider.currval:SetText(NotGridOptions[this.slider.key])
				if this.slider.stepvalue then
					NotGridMenuSlider:SetValueStep(this.slider.stepvalue)
				else
					NotGridMenuSlider:SetValueStep(1)
				end
				if this.slider.tooltip then
					NotGridMenuSlider.tooltip = this.slider.tooltip
				end
				NotGridMenuSliderContainer:ClearAllPoints()
				NotGridMenuSliderContainer:SetPoint("TOPRIGHT",this,"TOPLEFT",-20,0)
				NotGridMenuSliderContainer:Show()
				--make sure editbox is hidden
				NotGridMenuEditBoxContainer:Hide()
				NotGridMenuPositionBoxContainer:Hide()
			elseif this.position then
				NotGridMenuPositionBoxLeftButton.key = this.position.xkey
				NotGridMenuPositionBoxRightButton.key = this.position.xkey
				NotGridMenuPositionBoxUpButton.key = this.position.ykey
				NotGridMenuPositionBoxDownButton.key = this.position.ykey
				NotGridMenuPositionBoxXeditbox.key = this.position.xkey
				NotGridMenuPositionBoxYeditbox.key = this.position.ykey
				NotGridMenuPositionBoxXeditbox:SetText(NotGridOptions[this.position.xkey])
				NotGridMenuPositionBoxYeditbox:SetText(NotGridOptions[this.position.ykey])
				NotGridMenuPositionBoxContainer:ClearAllPoints()
				NotGridMenuPositionBoxContainer:SetPoint("TOPRIGHT",this,"TOPLEFT",-20,0)
				NotGridMenuPositionBoxContainer:Show()
				--
				NotGridMenuSliderContainer:Hide()
				NotGridMenuEditBoxContainer:Hide()
			else
				NotGridMenuSliderContainer:Hide()
				NotGridMenuEditBoxContainer:Hide()
				NotGridMenuPositionBoxContainer:Hide()
			end
			if this.tooltip then
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
				GameTooltip:SetText(this.tooltip, nil, nil, nil, nil, 1)
			end
		end)
		fb:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
		if val.text == "" then
			fb:Disable()
		end
	end
end

------------
-- Slider --
------------

function NotGrid:InitializeSlider()
	local f = CreateFrame("Frame","NotGridMenuSliderContainer",NotGridOptionsMenu) -- slider container
	f:SetWidth(160)
	f:SetHeight(50)
	f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 }})
	f:SetBackdropColor(0,0,0,1)
	--f:SetBackdropBorderColor(unpack(o.unitbordercolor))
	f:SetPoint("CENTER",UIParent,"CENTER",-100,0)
	f:Hide()

	f.s = CreateFrame('Slider', 'NotGridMenuSlider', f, 'OptionsSliderTemplate') -- its a child of the container frame
	f.s:SetPoint("CENTER",0,0)
	f.s:SetValueStep(1)

	f.s:SetScript("OnValueChanged", function()
		if GetMouseFocus() == this then -- only if the mouse/player is doing the adjustments. Otherwise it does adjustements when it shows/setminmax values etc..
			NotGridOptions[this.key] = arg1
			this.currval:SetText(arg1)
			NotGridOptionChange()
		end
		if this.key == "proximityrate" then
			NotGrid:CancelAllScheduledEvents() -- bit silly, but it will rarely be used
			NotGrid:ScheduleRepeatingEvent("NG_UNIT_PROXIMITY", NotGrid.o.proximityrate)
		end
	end)

	f.s.currval = f.s:CreateFontString('$parentcurrval', "ARTWORK", "GameFontHighlightSmall")
	f.s.currval:SetPoint("TOP",0,8)
	f.s.currval:SetText("50")
	f.s:SetScript("OnEnter", function()
		if this.tooltip then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			GameTooltip:SetText(this.tooltip, nil, nil, nil, nil, 1)
		end
	end)
	f.s:SetScript("OnHide", function()
		if this.tooltip then
			this.tooltip = nil
		end
	end)
end

-------------
-- EditBox --
-------------

function NotGrid:InitializeEditBox()
	local f = CreateFrame("Frame", "NotGridMenuEditBoxContainer",NotGridOptionsMenu)
	f:SetWidth(350)
	f:SetHeight(50)
	f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 }})
	f:SetBackdropColor(0,0,0,1)
	--f:SetBackdropBorderColor(unpack(o.unitbordercolor))
	f:SetPoint("CENTER",UIParent,"CENTER",-100,0)
	f:Hide()

	f.e = CreateFrame("EditBox", "NotGridMenuEditBox", f, "InputBoxTemplate")
	f.e:SetFontObject("GameFontHighlight")
	f.e:SetWidth(320)
	f.e:SetHeight(40)
	f.e:SetAutoFocus(false)
	f.e:SetPoint("CENTER",0,0)
	f.e:SetText("hey")
	f.e:EnableKeyboard()
	f.e:SetScript("OnEnterPressed", function()
		this:ClearFocus()
		if this.istable then
			NotGridOptions[this.key] = {} -- should probably compost it but will rarely get called
			for text in string.gfind(this:GetText(), "([^/]+)") do -- There are issues with using | as a seperator, not sure why
				table.insert(NotGridOptions[this.key], text)
			end
		else
			NotGridOptions[this.key] = this:GetText()
		end
		NotGridOptionChange()
	end)
	f.e:SetScript("OnEscapePressed", function()
		this:ClearFocus()
		if this.istable then
			this:SetText(table.concat(NotGridOptions[this.key],"/"))
		else
			this:SetText(NotGridOptions[this.key])
		end
	end)
end

----------------------
-- PositioningFrame --
----------------------

function NotGrid:InitializePositionBox()
	local f = CreateFrame("Frame", "NotGridMenuPositionBoxContainer",NotGridOptionsMenu)
	f:SetWidth(200)
	f:SetHeight(100)
	f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 }})
	f:SetBackdropColor(0,0,0,1)
	f:SetPoint("CENTER",UIParent,"CENTER",-100,0)
	f:Hide()

	f.upb = CreateFrame("Button", "NotGridMenuPositionBoxUpButton", f, "UIPanelButtonTemplate")
	f.upb:SetPoint("CENTER",0,30)
	f.upb:SetText("^")

	f.downb = CreateFrame("Button", "NotGridMenuPositionBoxDownButton", f, "UIPanelButtonTemplate")
	f.downb:SetPoint("CENTER",0,-30)
	f.downb:SetText("v")

	f.leftb = CreateFrame("Button", "NotGridMenuPositionBoxLeftButton", f, "UIPanelButtonTemplate")
	f.leftb:SetPoint("CENTER",-80,0)
	f.leftb:SetText("<")

	f.rightb = CreateFrame("Button", "NotGridMenuPositionBoxRightButton", f, "UIPanelButtonTemplate")
	f.rightb:SetPoint("CENTER",80,0)
	f.rightb:SetText(">")

	for k,v in {up = f.upb, down = f.downb, left = f.leftb, right = f.rightb} do
		v.direction = k
		v:SetWidth(20)
		v:SetHeight(20)
		v:SetScript("OnClick", function(self, button, down)
			if this.direction == "up" or this.direction == "right" then
				NotGridOptions[this.key] = NotGridOptions[this.key]+NotGrid:GetAdjustment()
			else
				NotGridOptions[this.key] = NotGridOptions[this.key]-NotGrid:GetAdjustment()
			end
			if this.direction == "up" or this.direction == "down" then
				NotGridMenuPositionBoxYeditbox:SetText(NotGridOptions[this.key])
			else
				NotGridMenuPositionBoxXeditbox:SetText(NotGridOptions[this.key])
			end
			NotGridOptionChange()
		end)
		v:SetScript("OnEnter", function()
			if this.direction == "down" then
				GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
			else
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
			end
			GameTooltip:SetText("Shift+Ctrl = 100\nShift = 10", nil, nil, nil, nil, 1)
		end)
		v:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)
	end

	f.ex = CreateFrame("EditBox", "NotGridMenuPositionBoxXeditbox", f, "InputBoxTemplate")
	f.ex:SetFontObject("GameFontHighlight")
	f.ex:SetWidth(50)
	f.ex:SetHeight(40)
	f.ex:SetAutoFocus(false)
	f.ex:SetPoint("CENTER",-30,0)
	f.ex:SetText("xx")
	f.ex:EnableKeyboard()
	f.ex:SetScript("OnEnterPressed", function()
		this:ClearFocus()
		NotGridOptions[this.key] = tonumber(this:GetText())
		NotGridOptions[NotGridMenuPositionBoxYeditbox.key] = tonumber(NotGridMenuPositionBoxYeditbox:GetText())
		NotGridOptionChange()
	end)
	f.ex:SetScript("OnEscapePressed", function()
		this:ClearFocus()
		this:SetText(NotGridOptions[this.key])
	end)

	f.ey = CreateFrame("EditBox", "NotGridMenuPositionBoxYeditbox", f, "InputBoxTemplate")
	f.ey:SetFontObject("GameFontHighlight")
	f.ey:SetWidth(50)
	f.ey:SetHeight(40)
	f.ey:SetAutoFocus(false)
	f.ey:SetPoint("CENTER",30,0)
	f.ey:SetText("yy")
	f.ey:EnableKeyboard()
	f.ey:SetScript("OnEnterPressed", function()
		this:ClearFocus()
		NotGridOptions[this.key] = tonumber(this:GetText())
		NotGridOptions[NotGridMenuPositionBoxXeditbox.key] = tonumber(NotGridMenuPositionBoxXeditbox:GetText())
		NotGridOptionChange()
	end)
	f.ey:SetScript("OnEscapePressed", function()
		this:ClearFocus()
		this:SetText(NotGridOptions[this.key])
	end)
end

function NotGrid:GetAdjustment(direction)
	local adjustment
	if IsShiftKeyDown() and IsControlKeyDown() then
		adjustment = 100
	elseif IsShiftKeyDown() then
		adjustment = 10
	else
		adjustment = 1
	end
	return adjustment
end

-----------------
-- color funcs --
-----------------

local workingcolorswatch -- need to set these for reasons
local workingcolorkey
function NotGrid:ClickColor()
	workingcolorswatch = this.tex
	workingcolorkey = this.color.key
	--DEFAULT_CHAT_FRAME:AddMessage(workingcolorkey.." "..workingcolorswatch:GetName())
	local r, g, b, a = unpack(NotGridOptions[workingcolorkey])
	ColorPickerFrame.previousValues = {r, g, b, a}
	ColorPickerFrame.func = self.ColorPickerHandler
	ColorPickerFrame.opacityFunc = self.ColorPickerHandler
	ColorPickerFrame.cancelFunc = NotGrid_SetColor -- breaks if sent though notgrid
	if a then
		ColorPickerFrame.opacity = 1-a
		ColorPickerFrame.hasOpacity = true -- opacity prob has own func
	else
		ColorPickerFrame.hasOpacity = false
	end
	ColorPickerFrame:SetColorRGB(r, g, b)
	ColorPickerFrame:Show()
	--frame:Hide()
end

function NotGrid:ColorPickerHandler()
	local a = 1 - OpacitySliderFrame:GetValue()
	local r,g,b = ColorPickerFrame:GetColorRGB()
	if ColorPickerFrame.hasOpacity then
		NotGrid_SetColor({r,g,b,a}) -- why cant I reference self?
	else
		NotGrid_SetColor({r,g,b})
	end
end

function NotGrid_SetColor(vals) -- can be current vals or prevvals
	workingcolorswatch:SetVertexColor(unpack(vals))
	NotGridOptions[workingcolorkey] = vals -- table of colorvals
	NotGridOptionChange()
end

--------------------
-- Scroll Handler --
--------------------

function NotGrid:ScrollHandler() --arg1 is either -1 or 1 depending on scolling down or up
	if not arg1 then arg1 = 0 end
	local menucount = getn(menuarray)
	local offset = NotGridOptionsMenu.offset
	offset = offset-arg1
	if offset < 0 then offset = 0 end -- keep it from going below zero
	if offset > menucount-numdisplay then offset = menucount-numdisplay end -- keep it from going above count
	for key,_ in menuarray do
		local f = getglobal("NotGridOptionsMenubutton"..key)
		if (key > offset) and (key <= offset+numdisplay) then
			f:SetPoint("TOP","NotGridOptionsMenu","TOP",0,-buttonheight*(key+1-offset)) -- its offset by two spaces at the top
			f:Show()
		else
			f:Hide()
			if f.slider then NotGridMenuSliderContainer:Hide() end
			if f.editbox then NotGridMenuEditBoxContainer:Hide() end
		end
	end
	NotGridOptionsMenu.offset = offset -- record it into the frame variable for reference
end

-------------------------
-- Generic Config Loop --
-------------------------

function NotGridOptionChange()
	NotGrid:ConfigUnitFrames()
	NotGrid:RosterChange()
end
