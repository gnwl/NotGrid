local L = AceLibrary("AceLocale-2.2"):new("NotGrid")

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, function
        copy = orig
    end
    return copy
end

local DefaultOptions = {
	["version"] = 1.132, -- will be the commit number from now on.
	["versionchecking"] = true,

	["unitwidth"] = 36,
	["unitheight"] = 36,
	["unitborder"] = 2,
	["unitpadding"] = 2,
	["unitbgcolor"] = {0,0,0,0.4},
	["unitbordercolor"] = {0,0,0,0.8},
	["unithealthorientation"] = 1,
	["unithealthbartexture"] = "Interface\\AddOns\\NotGrid\\media\\Striped",
	["unithealthbarcolor"] = {39/255,186/255,42/255,1},
	["unithealthbarbgcolor"] = {0,0,0,0.1},
	["unithealthbarbgtexture"] = "Interface\\Buttons\\WHITE8X8",
	["unitfont"] = "Fonts\\ARIALN.TTF",
	["unitnamehealthtextcolor"] = {1,1,1,1},
	["unitnamehealthtextsize"] = 12,
	["unithealcommbarcolor"] = {32/255,112/255,11/255,1},
	["unithealcommtextcolor"] = {39/255,186/255,42/255,1},
	["unithealcommtextsize"] = 10,
	["unithealcommtextoffx"] = 0,
	["unithealcommtextoffy"] = -10,
	["unittrackingiconsize"] = 6,
	["unittrackingiconborder"] = 1,
	["unittrackingiconbordercolor"] = {0,0,0,1},

	["showpowerbar"] = false,
	["powersize"] = 3, -- this will be width if the player chooses to make it Verical, or height if they make it Horizontal
	["powerposition"] = 3, -- 1=top,2=bottom,3=left,4=right
	["colorpowerbarbgbytype"] = false,
	["unitpowerbarbgcolor"] = {0,0,0,0.1},

	["trackingicon1"] = {"Rejuvenation","Regrowth","Renew",}, -- potentially be better to have the auraname/spelltype be the key, but that introduces other problems to work around
	["trackingicon1invert"] = false,
	["trackingicon1color"] = {0.37,0.83,0.38},
	["trackingicon2"] = {"",},
	["trackingicon2invert"] = false,
	["trackingicon2color"] = {0.20,0.60,1.00},
	["trackingicon3"] = {"Magic",},
	["trackingicon3invert"] = false,
	["trackingicon3color"] = {0.20,0.60,1.00},
	["trackingicon4"] = {"Poison",},
	["trackingicon4invert"] = false,
	["trackingicon4color"] = {0.00,0.60,0},
	["trackingicon5"] = {"Curse",},
	["trackingicon5invert"] = false,
	["trackingicon5color"] = {0.60,0.00,1.00},
	["trackingicon6"] = {"Disease",},
	["trackingicon6invert"] = false,
	["trackingicon6color"] = {0.60,0.40,0},
	["trackingicon7"] = {"Mortal Strike","Mortal Wound","Veil of Shadow","Curse of the Deadwood","Blood Fury","Wound Poison","Hex of Weakness",},
	["trackingicon7invert"] = false,
	["trackingicon7color"] = {0.80,0,0},
	["trackingicon8"] = {"",},
	["trackingicon8invert"] = false,
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

	["unitnamehealthoffx"] = 0,
	["unitnamehealthoffy"] = 0,


	["healththreshhold"] = 90,
	["manathreshhold"] = 20,
	["namelength"] = 3,

	["ooralpha"] = 0.5,

	["useproximity"] = true,
	["proximityrate"] = 1,
	["proximityleeway"] = 4,

	["colorunitnamehealthbyclass"] = true,
	["colorunithealthbarbyclass"] = true,
	["colorunithealthbarbgbyclass"] = false,
	["usetbcshamancolor"] = true,
	["usepetcolor"] = true,
	["petcolor"] = {1,0.74,0},


	["smartcenter"] = false,
	["showhealcommtext"] = true,
	["showhealcommbar"] = true,
	["usemapdistances"] = true,

	["showwhilesolo"] = true,
	["showinparty"] = true,
	["showpartyinraid"] = false,
	["showpets"] = false,
	["showblizzframes"] = true,

	["growthdirection"] = 1, -- 1: Group Left to Right, 2: Group Right to Left, 3: Group Top to Bottom, 4: Group Bottom to Top, 5: Unit Top to Bottom.. etc

	["cliquehook"] = false, -- keep default false to avoid confusion from new users

	["configmode"] = false,
	["disablemouseoverincombat"] = false,

	["borderartwork"] = false,

	["draggable"] = false,
	["showmenuhint"] = true,
}

function NotGrid:SetDefaultOptions() -- this will run on initialization and make sure everything is set. We can also use it if we wipe the NotGridOptions table and want to load it up with defaults
	for key,value in DefaultOptions do
		if not NotGridOptions[key] and not (not NotGridOptions[key] and type(NotGridOptions[key]) == "boolean") then -- if this wasn't set from the saved variable load
			NotGridOptions[key] = value
		end
	end
	--if the current version is older than a commit that caused a config change, then set the affected configs back to default
	if NotGridOptions.version < 1.112 and type(NotGridOptions.trackingicon1) ~= "table" then -- means they're using old aura handling and we need strings to be tables
		for i=1,8 do
			NotGridOptions["trackingicon"..i] = DefaultOptions["trackingicon"..i]
		end
	end
	if NotGridOptions.version < 1.106 and NotGridOptions.containerpoint ~= "CENTER" then -- means they used the old drag positioning and it will be set relative to TOPLEFT
		NotGridOptions.containerpoint = DefaultOptions.containerpoint
		NotGridOptions.containeroffx = DefaultOptions.containeroffx
		NotGridOptions.containeroffy = DefaultOptions.containeroffy
	end
	if NotGridOptions.version < 1.104 and type(NotGridOptions.unithealthorientation) ~= "number" then -- means they used the old editbox config and it will be set as "VERTICAL"/"HORIZONTAL"
		NotGridOptions.unithealthorientation = DefaultOptions.unithealthorientation
	end
	NotGridOptions.version = DefaultOptions.version --update the version
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
		ReloadUI() -- we have to reloadui to make the config menu update as well
	elseif msg == "grid" then
		NotGrid.o.unithealthbartexture = "Interface\\AddOns\\NotGrid\\media\\GridGradient"
		NotGrid.o.unithealthbarbgtexture = "Interface\\AddOns\\NotGrid\\media\\GridGradient"
		NotGrid.o.unithealthbarcolor = {0,0,0,0.65}
		NotGrid.o.unithealthbarbgcolor = {0,0,0,1}
		NotGrid.o.colorunithealthbarbyclass = false
		NotGrid.o.colorunithealthbarbgbyclass = true
		ReloadUI()
	elseif type(msg) == "string" and string.find(msg, "^profile") then
		local _, args = string.match(msg, "^(profile)%s*(.*)")
		local action = "list"
		local profileName = nil

		if args and args ~= "" then
			local words = {}
			for word in string.gmatch(args, "%S+") do
				table.insert(words, word)
			end
			
			if words[1] then
				action = words[1]
				profileName = words[2]
			end
		end

		if action == "save" then
			if profileName then
				-- Validate that profiles table exists before saving
				if not NotGridProfiles then
					DEFAULT_CHAT_FRAME:AddMessage("NotGrid: Error - Profile system not initialized!")
					return
				end
				NotGridProfiles[profileName] = deepcopy(NotGrid.o)
				DEFAULT_CHAT_FRAME:AddMessage("NotGrid profile '" .. profileName .. "' saved.")
			else
				DEFAULT_CHAT_FRAME:AddMessage("Usage: /ng profile save <profilename>")
			end
		elseif action == "load" then
			if profileName then
				-- Validate that profiles table exists before loading
				if not NotGridProfiles then
					DEFAULT_CHAT_FRAME:AddMessage("NotGrid: Error - Profile system not initialized!")
					return
				end
				if NotGridProfiles[profileName] then
					for k in pairs(NotGrid.o) do NotGrid.o[k] = nil end
					for k, v in pairs(NotGridProfiles[profileName]) do NotGrid.o[k] = deepcopy(v) end
					NotGrid:SetDefaultOptions()
					ReloadUI()
					DEFAULT_CHAT_FRAME:AddMessage("NotGrid profile '" .. profileName .. "' loaded.")
				else
					DEFAULT_CHAT_FRAME:AddMessage("NotGrid profile '" .. profileName .. "' not found.")
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("Usage: /ng profile load <profilename>")
			end
		elseif action == "delete" then
			if profileName then
				-- Validate that profiles table exists before deleting
				if not NotGridProfiles then
					DEFAULT_CHAT_FRAME:AddMessage("NotGrid: Error - Profile system not initialized!")
					return
				end
				if NotGridProfiles[profileName] then
					NotGridProfiles[profileName] = nil
					DEFAULT_CHAT_FRAME:AddMessage("NotGrid profile '" .. profileName .. "' deleted.")
				else
					DEFAULT_CHAT_FRAME:AddMessage("NotGrid profile '" .. profileName .. "' not found.")
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("Usage: /ng profile delete <profilename>")
			end
		elseif action == "list" then
			-- Validate that profiles table exists before listing
			if not NotGridProfiles then
				DEFAULT_CHAT_FRAME:AddMessage("NotGrid: Error - Profile system not initialized!")
				return
			end
			local profileCount = 0
			local profileList = ""
			for name in pairs(NotGridProfiles) do
				if profileList ~= "" then profileList = profileList .. ", " end
				profileList = profileList .. name
				profileCount = profileCount + 1
			end
			if profileCount > 0 then
				DEFAULT_CHAT_FRAME:AddMessage("Available NotGrid profiles: " .. profileList)
			else
				DEFAULT_CHAT_FRAME:AddMessage("No NotGrid profiles saved.")
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("Invalid profile action. Usage: /ng profile [save|load|delete <profilename>] or /ng profile list")
		end
	else
		NotGridOptionsMenu:Show()
	end
end
