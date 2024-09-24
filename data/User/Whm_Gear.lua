function user_job_setup()
    state.OffenseMode:options('Normal','Acc')
    state.CastingMode:options('Normal','Resistant','SIRD','DT')
    state.IdleMode:options('Normal','Refresh')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('None','DualWeapons','MeleeWeapons')
	state.WeaponskillMode:options('Normal','Fodder')

	gear.obi_cure_waist = "Austerity Belt +1"
	gear.obi_cure_back = "Alaunus's Cape"

	gear.obi_nuke_waist = "Sekhmet Corset"
	gear.obi_high_nuke_waist = "Yamabuki-no-Obi"
	gear.obi_nuke_back = "Toro Cape"

		-- Additional local binds
	send_command('bind ^` input /ma "Arise" <t>')
	send_command('bind !` input /ja "Penury" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind ^@!` gs c toggle AutoCaress')
	send_command('bind ^backspace input /ja "Sacrosanctity" <me>')
	send_command('bind @backspace input /ma "Aurora Storm" <me>')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	send_command('bind !backspace input /ja "Accession" <me>')
	send_command('bind != input /ja "Sublimation" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
	send_command('bind ^\\\\ input /ma "Protectra V" <me>')
	send_command('bind @\\\\ input /ma "Shellra V" <me>')
	send_command('bind !\\\\ input /ma "Reraise IV" <me>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

	-- Weapons sets
	sets.weapons.MeleeWeapons = {main="Yagrush",sub="Ammurapi Shield"}
	sets.weapons.DualWeapons = {main="Yagrush",sub="C. Palug Hammer"}
	
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
    -- FAST CAST, QUICK MAGIC
	--81/80
	sets.precast.FC = {
		main="Malignance Pole",
		sub="Clerisy Strap +1", --3
		ammo="Sapience Orb", --2
		head="Ebers Cap +3", --13
		neck="Cleric's Torque +2", --10
		ear1="Malignance Earring", --4
		ear2="Etiolation Earring", --1
		body="Inyanga Jubbah +2", --14
		hands="Fanatic Gloves", --7
		ring1="Defending Ring",
		ring2="Medada's Ring", --10
		back="Alaunus's Cape", --10
		legs="Ebers Pantaloons +3",
		feet="Regal Pumps +1", --5-7
	}

	--11/10
	sets.precast.QuickMagic = set_combine(sets.precast.FC, {
		ammo="Impatiens", --2
		ring1="Lebeche Ring", --2
		back="Perimede Cape", --4
		waist="Witful Belt", --3
	})

	sets.precast.Teleport = sets.precast.QuickMagic
	sets.precast.Raise = sets.precast.QuickMagic

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	-- loses 27% from head/body, 1% of overage
	-- replaces: 18% / 26%
	sets.precast.FC.Impact =  set_combine(sets.precast.FC, {
		main="C. Palug Hammer", -- 7%
		sub="Chanter's Shield", -- +0%
		head=empty,
		ear2="Loquacious Earring", -- +1%
		body="Twilight Cloak",
		ring1="Kishar Ring", -- 4%
		legs="Ayanmo Cosciales +2", -- 6%
	})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
		main="Daybreak",
		sub="Chanter's Shield",
	})

    -- JOB ABILITIES
    sets.precast.JA.Benediction = {body="Piety Bliaut +3"}

    -- WEAPON SKILLS
    sets.precast.WS = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

    sets.precast.WS.Dagan = {ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Moonshade Earring",
		body="Kaykaus Bliaut",hands="Regal Cuffs",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Aurist's Cape +1",waist="Fotia Belt",legs="Nyame Flanchard",feet="Theo. Duckbills +3"}

	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.MaxTP.Dagan = {ear1="Etiolation Earring",ear2="Evans Earring"}

    -- Midcast Sets

    sets.Kiting = {ring2="Shneddick Ring"}
    sets.latent_refresh = {}
	sets.latent_refresh_grip = {}
	sets.TPEat = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- CONSERVE MP: 62
	sets.ConserveMP = {
		head="Vanya Hood", --6
		ear1="Magnetic Earring", --5
		ear2="Mendicant's Earring", --2
		hands="Fanatic Gloves", --7
		ring1="Mephitas's Ring +1", --15
		back="Fi Follet Cape +1", --5
		waist="Shinjutsu-no-Obi +1", --15
		feet="Kaykaus Boots +1", --7
	}

	sets.midcast.Teleport = sets.ConserveMP

    sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.Raise = sets.midcast.FastRecast
	sets.midcast['Full Cure'] = sets.midcast.FastRecast

    -- Cure sets
	sets.midcast.Cure = {
		main="Raetic Rod +1",
		sub="Genmei Shield",
		ammo="Pemphredo Tathlum",
		head="Kaykaus Mitra +1",
		neck="Cleric's Torque +2",
		ear1="Glorious Earring",
		ear2="Magnetic Earring",
		body="Ebers Bliaut +3",
		hands="Theophany Mitts +3",
		ring1="Defending Ring",
		ring2="Gelatinous Ring +1",
		back="Alaunus's Cape",
		waist="Shinjutsu-no-obi +1",
		legs="Ebers Pantaloons +3",
		feet="Kaykaus Boots +1"
	}

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {
		waist="Hachirin-no-Obi",
	})
	sets.midcast.LightDayCure = sets.midcast.LightWeatherCure
	sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.LightWeatherCuraga = sets.midcast.LightWeatherCure
	sets.midcast.LightDayCuraga = sets.midcast.LightDayCure
	sets.midcast.MeleeCure = sets.midcast.Cure

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
		main="Yagrush",
		sub="Genmei Shield",
		legs="Ebers Pantaloons +3",
	})

	sets.midcast.Cursna = {
		main="Yagrush",
		sub="Thuellaic Ecu +1",
		ammo="Pemphredo Tathlum",
		head=gear.VanyaHood_HealingSkill,
		neck="Debilis Medallion",
		ear1="Meili Earring",
		ear2="Ebers Earring +1",
		body="Ebers Bliaut +3",
		hands="Fanatic Gloves",
		ring1="Haoma's Ring",
		ring2="Menelaus's Ring",
		back="Alaunus's Cape",
		waist="Bishop's Sash",
		legs="Theophany Pantaloons +3",
		feet="Vanya Clogs"
	}

	sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {
		neck="Cleric's Torque +2"
	})

	-- Duration +75%
	sets.midcast['Enhancing Magic'] = {
		main="Gada", --5%
		sub="Ammurapi Shield", --10%
		head=gear.TelchineCap_EnhancingDuration, --10%
		body=gear.TelchineChasuble_EnhancingDuration, --10%
		hands=gear.TelchineGloves_EnhancingDuration, --10%
		waist="Embla Sash", --10%
		legs=gear.TelchineBraconi_EnhancingDuration, --10%
		feet="Theophany Duckbills +3", --10%
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Nodens Gorget",
		ear2="Earthcry Earring",
		waist="Siegel Sash",
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod", --1
		head="Chironic Hat", --1
		hands="Regal Cuffs", --2
		waist="Emphatikos Rope", --1
	})

	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
		head="Inyanga Tiara +2",
		body="Piety Bliaut +3",
		hands="Ebers Mitts +3",
		legs="Theophany Pantaloons +3",
		feet="Bunzi's Sabots",
	})

	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Protectra = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Shellra = {ring2="Sheltered Ring"}

	sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'], {})

	sets.midcast.BarElement = {
		main="Beneficus",
		sub="Ammurapi Shield",
		head="Ebers Cap +3",
		neck="Incanter's Torque",
		body="Ebers Bliaut +3",
		hands="Ebers Mitts +3",
		back="Alaunus's Cape",
		waist="Embla Sash",
		legs="Piety Pantaloons +3",
		feet="Ebers Duckbills +3",
	}

	-- Duration net +25%
	sets.midcast.BarStatus = set_combine(sets.midcast['Enhancing Magic'], {
		neck="Sroda Necklace", --(-50%)
	})

	sets.midcast.Impact = {
		main="Daybreak",
		sub="Ammurapi
		Shield",ammo="Pemphredo Tathlum",
		head=empty,
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
		body="Twilight Cloak",
		--hands=gear.chironic_enfeeble_hands,
		ring1="Metamor. Ring +1",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		--back="Toro Cape",
		waist="Acuity Belt +1",
		legs="Chironic Hose",
		--feet=gear.chironic_nuke_feet,
	}

	-- Banish, Banishga, Holy
	sets.midcast['Divine Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Ghastly Tathlum +1",
		neck="Baetyl Pendant",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Cohort Cloak +1",
		hands="Bunzi's Gloves",
		ring1="Metamor. Ring +1",
		ring2="Freke Ring",
		back="Alaunus's Cape",
		waist="Eschan Stone",
		legs="Bunzi's Pants",
		feet="Bunzi's Sabots",
	}

	sets.midcast.Repose = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Hydrocera",
		head="Theophany Cap +3",
		neck="Jokushu Chain",
		ear1="Regal Earring",
		ear2="Ebers Earring +1", -- TODO +2
		body="Theophany Bliaut +3",
		hands="Piety Mitts +3",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Aurist's Cape +1",
		waist="Luminary Sash",
		legs="Theophany Pantaloons +3",
		feet="Theophany Duckbills +3",
	}
	sets.midcast.Flash = sets.midcast.Repose

	sets.midcast['Dark Magic'] = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Bunzi's Hat",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
		body="Inyanga Jubbah +2",
		--hands=gear.chironic_enfeeble_hands,
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Aurist's Cape +1",
		waist="Acuity Belt +1",
		legs="Chironic Hose",
		--feet=gear.chironic_nuke_feet,
	}

    sets.midcast.Drain = {
		main="Rubicundity",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Digni. Earring",
        body="Inyanga Jubbah +2",
		hands="Regal Cuffs",
		ring1="Evanescence Ring",
		ring2="Archon Ring",
        back="Aurist's Cape +1",
		waist="Fucho-no-obi",
		legs="Chironic Hose",
		feet="Theophany Duckbills +3",
	}
    sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {main="Daybreak",sub="Ammurapi Shield"})

	sets.midcast['Enfeebling Magic'] = {
		main="Yagrush",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Theophany Cap +3",
		neck="Erra Pendant",
		ear1="Regal Earring",
		ear2="Ebers Earring +1", -- *** +2
		body="Theophany Bliaut +3",
		hands="Regal Cuffs",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2="Kishar Ring",
		back="Aurist's Cape +1",
		waist="Obstinate Sash",
		legs="Chironic Hose",
		feet="Theophany Duckbills +3",
	}

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
		hands="Kaykaus Cuffs +1",
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
	})

	sets.midcast.Slow = set_combine(sets.midcast['Enfeebling Magic'], {
		ammo="Hydrocera",
		neck="Cleric's Torque +2",
		ring2="Metamorph Ring +1",
	})
	sets.midcast.Paralyze = sets.midcast.Slow

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = sets.midcast['Enfeebling Magic']
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = sets.midcast['Enfeebling Magic']

    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {})

	sets.MagicBurst = {}

	-- IDLE
	sets.idle = {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		neck="Warder's Charm +1",
		ear1="Eabani Earring",
		ear2="Etiolation Earring",
		body="Ebers Bliaut +3",
		hands="Bunzi's Gloves",
		ring1="Inyanga Ring",
		ring2="Shadow Ring",
		back="Alaunus's Cape",
		waist="Platinum Moogle Belt",
		legs="Ebers Pantaloons +3",
		feet="Ebers Duckbills +3",
	}

	sets.idle.Refresh = set_combine(sets.idle, {
		ammo="Homiliary",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		feet=gear.ChironicSlippers_Refresh,
	})

	sets.idle.Town = set_combine(sets.idle, {
		main="Yagrush",
	})

	sets.resting = set_combine(sets.idle.Refresh, {
		main="Chatoyant Staff",
		sub="Enki Grip",
		body="Ebers Bliaut +3",
		waist="Fucho-no-obi",
	})

	-- Defense sets
	sets.defense.PDT = {main="Mafic Cudgel",sub="Genmei Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Shadow Mantle",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Shadow Ring",ring2="Archon Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.defense.MEVA = {main="Daybreak",sub="Ammurapi Shield",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Purity Ring",ring2="Vengeful Ring",
		back="Aurist's Cape +1",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
	-- ENGAGED
    sets.engaged = {ammo="Staunch Tathlum +1",
        head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

    sets.engaged.Acc = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

	sets.engaged.DW = {ammo="Staunch Tathlum +1",
        head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}

    sets.engaged.DW.Acc = {ammo="Hasty Pinion +1",
        head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Telos Earring",ear2="Suppanomimi",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",Ring2="Ilabrat Ring",
        back="Moonlight Cape",waist="Shetal Stone",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}

    sets.buff['Divine Caress'] = {hands="Ebers Mitts +3",back="Mending Cape"}

	sets.HPDown = {head="Pixie Hairpin +1",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Zendik Robe",hands="Hieros Mittens",ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",waist="Carrier's Sash",legs="Shedir Seraweels",feet=""}

	sets.HPCure = {main="Queller Rod",sub="Ammurapi Shield",ammo="Pemphredo Tathlum",
		head="Nyame Helm",neck="Nodens Gorget",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Kunaji Ring",ring2="Meridian Ring",
		back="Alaunus's Cape",waist="Eschan Stone",legs="Ebers Pant. +1",feet="Kaykaus Boots"}

	sets.buff.Doom = {
		-- Override Gambanteinn in main slot if also doomed
		main="Yagrush",
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		ring1="Eshmun's Ring",
		ring2="Eshmun's Ring",
	}
	sets.precast.Item['Holy Water'] = {ring1="Blenmot's Ring +1"}
	sets.precast.Item['Hallowed Water'] = sets.precast.Item['Holy Water']

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 6)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 006')
end

autows_list = {['DualWeapons']='Realmrazer',['MeleeWeapons']='Realmrazer'}