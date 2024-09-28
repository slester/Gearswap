function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','FullAcc')
    state.HybridMode:options('Normal','DT')
	state.WeaponskillMode:options('Match','Proc')
	state.AutoBuffMode:options('Off','Auto','AutoMelee')
	state.CastingMode:options('Normal','Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal','PDT','MDT','DTHippo')
    state.PhysicalDefenseMode:options('PDT','NukeLock')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','Naegling','Crocea','EnspellOnly','DualClubs','DualAeolian')

	gear.stp_jse_back = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}}
	gear.nuke_jse_back = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.wsd_jse_back = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` input /ja "Accession" <me>')
	send_command('bind ^backspace input /ja "Saboteur" <me>')
	send_command('bind !backspace input /ja "Spontaneity" <t>')
	send_command('bind @backspace input /ja "Composure" <me>')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind != input /ja "Penury" <me>')
	send_command('bind @= input /ja "Parsimony" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise" <me>')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c weapons Default;gs c set unlockweapons false')
	send_command('bind ^q gs c set weapons enspellonly;gs c set unlockweapons true')
	send_command('bind !r gs c set skipprocweapons true;gs c reset weaponskillmode;gs c set weapons none')
	send_command('bind !q gs c set skipprocweapons false;gs c set weapons DualProcDaggers;gs c set weaponskillmode proc')
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}

	-- Fast cast sets for spells
	-- 80 cap, 38 from traits, 42 to cap
	sets.precast.FC = {
		main="Crocea Mors", -- 20
		sub="Ammurapi Shield",
		head="Atrophy Chapeau +3", -- 16
		ring2="Medada's Ring", -- 10
	}

	-- needs 12 to make up for lost from head/body
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		ammo="Sapience Orb", -- 2
		head=empty,
		body="Twilight Cloak",
		ear1="Malignance Earring", -- 4
		ear2="Lethargy Earring", -- 6
	})

	-- needs 16 to make up for lost from Crocea Mors
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Sapience Orb", -- 2
		ear1="Malignance Earring", -- 4
		ear2="Lethargy Earring", -- 6
		ring1="Kishar Ring", -- 4
	})
       
	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		neck="Caro Necklace", --neck="Rep. Plat. Medal",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Epaminondas's Ring",
		ring2="Shukuyu Ring",--ring2="Sroda Ring",
		back=gear.wsd_jse_back,
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Leth. Houseaux +3"
	}
		
	sets.precast.WS['Chant Du Cygne'] = {
		ammo="Yetshila +1",
		--head="Blistering Sallet +1",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		--ear2="Mache Earring +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Begrudging Ring",
		ring2="Ilabrat Ring",
		back=gear.wsd_jse_back,
		waist="Fotia Belt",
		--legs="Zoar Subligar +1",
		feet="Thereoid Greaves"
	}
	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant Du Cygne']

	sets.precast.WS['Sanguine Blade'] = {
		ammo="Sroda Tathlum",
		head="Leth. Chappel +3",
		neck="Baetyl Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Nyame Mail",
		hands="Leth. Ganth. +3",
		ring1="Archon Ring",
		ring2="Epaminondas's Ring",
		back=gear.wsd_jse_back,
		waist="Orpheus's Sash",
		legs="Nyame Flanchard",
		feet="Leth. Houseaux +3"
	}

	sets.precast.WS['Seraph Blade'] = {
		ammo="Sroda Tathlum",
		head="Leth. Chappel +3",
		neck="Baetyl Pendant",
		ear1="Regal Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Leth. Ganth. +3",
		ring1="Medada's Ring", --ring1="Weather. Ring +1",
		ring2="Epaminondas's Ring",
		back=gear.wsd_jse_back,
		waist="Orpheus's Sash",
		legs="Nyame Flanchard",
		feet="Leth. Houseaux +3"
	}

	sets.precast.WS['Aeolian Edge'] = {
		ammo="Sroda Tathlum",
		head="Leth. Chappel +3",
		neck="Sibyl Scarf",
		ear1="Regal Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Jhakri Cuffs +2",
		ring1="Medada's Ring",
		ring2="Epaminondas's Ring",
		back=gear.wsd_jse_back,
		waist="Orpheus's Sash",
		legs="Nyame Flanchard",
		feet="Leth. Houseaux +3"
	}
	sets.precast.WS['Red Lotus Blade'] = sets.precast.WS['Aeolian Edge']

	sets.precast.WS['Requiescat'] = {
		main="Sequence",
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck="Fotia Gorget",
		ear1="Regal Earring",
		ear2="Moonshade Earring",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		ring1="Metamor. Ring +1",
		ring2="Rufescent Ring",
		back=gear.wsd_jse_back,
		waist="Fotia Belt",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.chironic_treasure_feet})

	sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Kaykaus Mitra +1",
		neck="Incanter's Torque",
		ear1="Regal Earring",
		ear2={name="Odnowa Earring +1", priority=254},
		body="Kaykaus Bliaut +1",
		hands="Kaykaus Cuffs +1",
		ring1="Sirona's Ring",
		ring2={name="Gelatinous Ring +1", bag="wardrobe4"},
		back={name="Moonlight Cape", priority=255},
		waist="Luminary Sash",
		legs="Atrophy Tights +3",
		--feet="Kaykaus Boots +1"
	}
		
    sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
		back="Twilight Cape",
		waist="Hachirin-no-Obi",
	})
	sets.midcast.LightDayCure = sets.midcast.LightWeatherCure

	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna = {
		ammo="Impatiens",
		head="Vanya Hood", -- TODO verify augments
		neck="Debilis Medallion",
		ear1="Meili Earring",
		ear2="Beatific Earring",
		body="Viti. Tabard +3",
		hands="Hieros Mittens",
		ring1="Haoma's Ring",
		ring2="Menelaus's Ring",
		--back="Oretan. Cape +1",
		waist="Bishop's Sash",
		legs="Vanya Slops",
		feet="Vanya Clogs"
	}

	sets.midcast.StatusRemoval = sets.midcast.FastRecast

	sets.midcast['Enhancing Magic'] = {
		main="Colada",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Leth. Chappel +3",
		neck="Dls. Torque +2",
		ear1="Lethargy Earring",
		ear2="Odnowa Earring +1",
		body="Lethargy Sayon +3",
		hands="Atrophy Gloves +3",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Ghostfyre Cape",
		waist="Embla Sash",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

	sets.buff.ComposureOther = {
		head="Leth. Chappel +3",
		body="Lethargy Sayon +3",
		hands="Leth. Gantherots +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
	}
		
	--Red Mage enhancing sets are handled in a different way from most, layered on due to the way Composure works
	--Don't set combine a full set with these spells, they should layer on Enhancing Set > Composure (If Applicable) > Spell
	sets.EnhancingSkill = {
		main="Pukulatmuj +1",
		sub="Ammurapi Shield", -- TODO Forfend +1
		ammo="Staunch Tathlum +1",
		head="Befouled Crown",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Mimir Earring",
		body="Viti. Tabard +3",
		hands="Viti. Gloves +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Ghostfyre Cape",
		waist="Olympus Sash",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +3"
	}

	sets.midcast.Refresh = {
		main="Colada",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Amalric Coif +1",
		neck="Dls. Torque +2",
		ear1="Lethargy Earring", -- TODO +2
		ear2="Odnowa Earring +1",
		body="Atrophy Tabard +3",
		hands="Atrophy Gloves +3",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Ghostfyre Cape",
		waist="Embla Sash",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

	sets.midcast.Aquaveil = {
		head="Amalric Coif +1",
		hands="Regal Cuffs",
		waist="Emphatikos Rope",
		--legs="Shedir Seraweels",
	}
	--sets.midcast.BarElement = {legs="Shedir Seraweels"}
	sets.midcast.Temper = sets.EnhancingSkill
	sets.midcast.Enspell = sets.EnhancingSkill
	sets.midcast.BoostStat = {hands="Viti. Gloves +3"}
	sets.midcast.Stoneskin = {
		neck="Nodens Gorget",
		ear2="Earthcry Earring",
		waist="Siegel Sash",
		--legs="Shedir Seraweels",
	}
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}

	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}

	sets.midcast.Phalanx = {
		main="Sakpata's Sword",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		--head="Taeon Chapeau", -- TODO
		neck="Incanter's Torque",
		ear1="Mimir Earring",
		ear2="Lethargy Earring",
		body="Taeon Tabard",
		hands="Taeon Gloves",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Ghostfyre Cape",
		waist="Embla Sash",
		legs="Taeon Tights",
		feet="Taeon Boots"
	}

	sets.midcast['Phalanx II'] = {
		main="Colada",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Leth. Chappel +3",
		neck="Dls. Torque +2",
		ear1="Odnowa Earring +1",
		ear2="Leth. Earring +2",
		body="Lethargy Sayon +3",
		hands="Atrophy Gloves +3",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Ghostfyre Cape",
		waist="Embla Sash",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

	sets.midcast.Dia = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Leth. Chappel +3",
		neck="Dls. Torque +2",
		ear1="Snotra Earring",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		ring1="Kishar Ring",
		ring2="Weather. Ring +1",
		back="Sucellos's Cape",
		waist="Obstin. Sash",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}
	sets.midcast.Diaga = set_combine(sets.midcast.Dia, sets.TreasureHunter)

	sets.midcast.Bio = {
		main="Rubicundity",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Atrophy Chapeau +3",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Mani Earring", -- TODO
		body="Shango Robe",
		hands="Regal Cuffs",
		ring1="Evanescence Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Perimede Cape",
		waist="Acuity Belt +1",
		legs="Chironic Hose",
		feet="Vitiation Boots +3"
	}

	sets.midcast['Enfeebling Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck="Dls. Torque +2",
		ear1="Snotra Earring",
		ear2="Regal Earring",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		ring1="Metamor. Ring +1",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=gear.nuke_jse_back,
		waist="Luminary Sash",
		legs="Chironic Hose",
		feet="Vitiation Boots +3"
	}

	sets.midcast['Enfeebling Magic'].Resistant = {
		main="Daybreak",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Viti. Chapeau +3",
		neck="Dls. Torque +2",
		ear1="Snotra Earring",
		ear2="Regal Earring",
		body="Atrophy Tabard +3",
		hands="Leth. Ganth. +3",
		ring1="Metamor. Ring +1",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Aurist's Cape +1",
		waist="Obstin. Sash",
		legs="Chironic Hose",
		feet="Vitiation Boots +3"
	}

	sets.midcast.DurationOnlyEnfeebling = {
		range="Ullr",
		head="Leth. Chappel +3",
		neck="Dls. Torque +2",
		ear1="Snotra Earring",
		ear2="Malignance Earring",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		ring1="Kishar Ring",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Aurist's Cape +1",
		waist="Obstin. Sash",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

	sets.midcast.Silence = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Sleep = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Bind = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Break = sets.midcast.DurationOnlyEnfeebling
	sets.midcast.Inundation = sets.midcast.Dia

	sets.midcast.Dispel = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Frazzle II'] = sets.midcast['Enfeebling Magic'].Resistant
	sets.midcast['Distract II'] = sets.midcast['Enfeebling Magic'].Resistant

	sets.midcast['Frazzle III'] = {
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck="Dls. Torque +2",
		ear1="Malignance Earring",
		ear2="Snotra Earring",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back=gear.nuke_jse_back,
		waist="Obstin. Sash",
		legs="Leth. Fuseau +3",
		feet="Vitiation Boots +3"
	}
	sets.midcast['Distract III'] = sets.midcast['Frazzle III']

    sets.midcast['Elemental Magic'] = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head="Leth. Chappel +3",
		neck="Sibyl Scarf",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		ring1="Medada's Ring",
		ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,
		waist="Acuity Belt +1",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

	sets.MagicBurst = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		head="Ea Hat +1",
		neck="Sibyl Scarf",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Ea Houppe. +1",
		hands="Bunzi's Gloves",
		ring1="Medada's Ring",
		ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,
		waist="Acuity Belt +1",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

	sets.midcast.Impact = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		range="Ullr",
		neck="Dls. Torque +2",
		ear1="Malignance Earring",
		ear2="Snotra Earring",
		head=empty,
		body="Twilight Cloak",
		hands="Leth. Ganth. +3",
		ring1="Metamor. Ring +1",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Aurist's Cape +1",
		waist="Acuity Belt +1",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3"
	}

    sets.midcast.Drain = {
		main="Rubicundity",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
		ear1="Malignance Earring",
		ear2="Mani Earring",
		body="Atrophy Tabard +3",
		hands="Leth. Ganth. +3",
		ring1="Evanescence Ring",
		ring2="Archon Ring",
		back="Aurist's Cape +1",
		waist="Fucho-no-Obi",
		legs="Chironic Hose",
		feet="Vitiation Boots +3"
	}
	sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = sets.midcast['Enfeebling Magic'].Resistant

	sets.buff.Saboteur = {hands="Leth. Gantherots +3"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Idle sets
	sets.idle = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		neck="Warder's Charm +1",
		ear1="Eabani Earring",
		ear2="Odnowa Earring +1",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2="Purity Ring",
		back="Moonlight Cape",
		waist="Carrier's Sash",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots"
	}

	sets.Kiting = {ring2="Shneddick Ring"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.buff.Sublimation = {waist="Embla Sash"}
	sets.buff.DTSublimation = {waist="Embla Sash"}

	-- Weapons sets
	sets.weapons.Naegling = {main="Naegling",sub="Genmei Shield",range=empty}
	sets.weapons.Crocea = {main="Crocea Mors",sub="Genmei Shield",range=empty}
	sets.weapons.DualWeapons = {main="Naegling",sub="Machaera +2",range=empty}
	sets.weapons.EnspellOnly = {main="Qutrub Knife",sub="Esoteric Athame",range="Ullr"}
	sets.weapons.DualClubs = {main="Maxentius",sub="Thibron",range=empty}
	sets.weapons.DualAeolian = {main="Tauret",sub="Bunzi's Rod",range=empty}

	-- Engaged sets
	sets.engaged = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		neck="Anu Torque",
		ear1="Sherida Earring",
		ear2="Telos Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1={name="Chirich Ring +1", bag="wardrobe5"},
		ring2={name="Chirich Ring +1", bag="wardrobe6"},
		back="Sucellos's Cape",
		waist="Windbuffet Belt +1",
		legs="Malignance Tights",
		feet="Carmine Greaves +1", --feet="Malignance Boots"
	}
		
	sets.engaged.EnspellOnly = {
		head="Malignance Chapeau", --head="Umuthi Hat",
		neck="Dls. Torque +2",
		ear1="Suppanomimi",
		ear2="Digni. Earring", --ear2="Hollow Earring",
		body="Malignance Tabard",
		hands="Aya. Manopolas +2",
		ring1={name="Chirich Ring +1", bag="wardrobe5"},
		ring2={name="Chirich Ring +1", bag="wardrobe6"},
		back="Sucellos's Cape", -- TODO fix augments, ideally [DEX +20/Accuracy +30/Attack +20/Dual Wield +10]
		waist="Orpheus's Sash",
		legs="Malignance Tights",
		feet="Ayanmo Gambieras +2", --feet="Malignance Boots",
	}
end

autows_list = {
	['Naegling']='Savage Blade',
	['DualWeapons']='Savage Blade',
	['DualWeaponsAcc']='Savage Blade',
	['DualClubs']='Black Halo',
	['DualAeolian']='Aeolian Edge',
	['EnspellDW']='Sanguine Blade',
}