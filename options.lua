local L = AceLibrary("AceLocale-2.2"):new("NotGrid")

local DefaultOptions = {
	["version"] = 1, -- set this so I can check against it after saved variables are loaded and potentially tell the user to reset to defaults if things have changed too much
	["unitwidth"] = 36, -- for best results use a multiple of 5
	["unitheight"] = 36,
	["unitborder"] = 2,
	["unitpadding"] = 2,
	["unitbgcolor"] = {0,0,0,0.5}, -- you'll want to keep this at 0 opacity and use the healthbar bg as your bg.. except in the rewrite :^)
	["unitbordercolor"] = {0,0,0,0.8},
	["unithealthorientation"] = "VERTICAL",
	["unithealthbartexture"] = "Interface\\AddOns\\NotGrid\\media\\Striped",
	["unithealthbarcolor"] = {39/255,186/255,42/255},
	["unithealthbarbgcolor"] = {0,0,0,0.5},
	["unitfont"] = "Fonts\\ARIALN.TTF",
	["unitnamehealthtextcolor"] = {1,1,1},
	["unitnamehealthtextsize"] = 12,
	["unithealcommbarcolor"] = {32/255,112/255,11/255},
	["unithealcommtextcolor"] = {39/255,186/255,42/255},
	["unithealcommtextsize"] = 10,
	["unithealcommtextoffsety"] = 0,
	["unittrackingiconsize"] = 6,
	["unittrackingiconborder"] = 1,
	["unittrackingiconbordercolor"] = {0,0,0,1},

	["showpowerbar"] = false,
	["powersize"] = 10, -- this will be width if the player chooses to make it Verical, or height if they make it Horizontal
	["powerposition"] = 3, -- 1=top,2=bottom,3=left,4=right

	["trackingicon1"] = "Rejuvenation",
	["trackingicon1color"] = {0.37,0.83,0.38},
	["trackingicon2"] = "",
	["trackingicon2color"] = {0.20,0.60,1.00},
	["trackingicon3"] = "Magic",
	["trackingicon3color"] = {0.20,0.60,1.00},
	["trackingicon4"] = "Poison",
	["trackingicon4color"] = {0.00,0.60,0},
	["trackingicon5"] = "Curse",
	["trackingicon5color"] = {0.60,0.00,1.00},
	["trackingicon6"] = "Disease",
	["trackingicon6color"] = {0.60,0.40,0},
	["trackingicon7"] = "Mortal Strike|Mortal Wound|Veil of Shadow|Curse of the Deadwood|Blood Fury|Wound Poison|Hex of Weakness",
	["trackingicon7color"] = {0.80,0,0},
	["trackingicon8"] = "",
	["trackingicon8color"] = {0.20,0.60,1.00},

	["trackaggro"] = true,
	["aggrowarningcolor"] = {150/255,10/255,10/255,0.8},
	["trackmana"] = true,
	["manawarningcolor"] = {42/255,69/255,117/255,0.8},

	["tracktarget"] = false,
	["targetcolor"] = {1,1,1,0.8},

	["containerpoint"] = "CENTER",
	["containeroffx"] = 0,
	["containeroffy"] = 0,

	["healththreshhold"] = 90,
	["manathreshhold"] = 20,
	["namelength"] = 3,

	["ooralpha"] = 0.5,

	["proximityleeway"] = 2,

	["colorunitnamehealthbyclass"] = true,
	["colorunithealthbarbyclass"] = true,
	["colorunithealthbarbgbyclass"] = false, -- think I'm deprecating this?
	["smartcenter"] = false,
	["showhealcommtext"] = true,
	["usemapdistances"] = true,

	["showwhilesolo"] = true,
	["showinparty"] = true,
	["showpartyinraid"] = false,
	["showblizzframes"] = true,
	["locked"] = true,

	["growthdirection"] = 1, -- 1: Group Left to Right, 2: Group Right to Left, 3: Group Top to Bottom, 4: Group Bottom to Top, 5: Unit Top to Bottom.. etc

	["configmode"] = false,
}

function NotGrid:SetDefaultOptions() -- this will run on initialization and make sure everything is set. We can also use it if we wipe the NotGridOptions table and wnant to load it up with defaults
	for key,value in DefaultOptions do
		if not NotGridOptions[key] and not (not NotGridOptions[key] and type(NotGridOptions[key]) == "boolean") then -- if this wasn't set from the saved variable load
			NotGridOptions[key] = value
		end
	end
end

--------------------
-- Slash Commands --
--------------------

SLASH_NOTGRID1 = "/notgrid"
SLASH_NOTGRID2 =  "/ng"
function SlashCmdList.NOTGRID(msg, editbox)
	if msg == "reset" then
		for key,value in DefaultOptions do
			NotGridOptions[key] = value
		end
		NotGrid:ConfigUnitFrames()
		NotGrid:PositionFrames()
	else
		NotGridOptionsMenu:Show()
	end
end