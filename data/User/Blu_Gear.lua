function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
    state.WeaponskillMode:options('Match','Normal','Acc')
    state.CastingMode:options('Normal','SIRD','Resistant')
    state.IdleMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.Weapons:options('Naegling','Nuking')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','MP','SuppaBrutal','DWEarrings','DWMax'}

	gear.stp_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10', 'Phys. dmg. taken-10%'}}
	gear.nuke_jse_back = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10', 'Phys. dmg. taken-10%'}}
	gear.wsd_jse_back = {name="Rosmerta's Cape",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%', 'Phys. dmg. taken-10%'}}

	autows = 'Expiacion'

	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind @` input /ja "Efflux" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Carcharian Verve" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons None;gs c update')
	send_command('bind @q gs c weapons MaccWeapons;gs c update')
	send_command('bind ^q gs c weapons Almace;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	select_default_macro_book()
end

function init_gear_sets()
	sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +2",feet="Hashi. Basmak +1"}
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +1"}
	sets.buff.Convergence = {head="Luh. Keffiyeh +3"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
	sets.buff.Enchainment = {}
	sets.buff.Efflux = {back=gear.da_jse_back,legs="Hashishin Tayt +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	sets.HPDown = {}
	sets.HPCure = {}

	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +3"}


	-- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	sets.Self_Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	sets.precast.Step = {}

	-- 68/80
	sets.precast.FC = {
		ammo="Sapience Orb", --2
		head="Carmine Mask +1", --14
		body="Luhlaza Jubbah +3", --9
		hands="Leyline Gloves", --8
		legs="Aya. Cosciales +2", --6
		feet="Carmine Greaves +1", --8
		neck="Voltsurge Torque", --4
		ear1="Loquacious Earring", --2
		ear2="Etiolation Earring", --1
		ring1="Kishar Ring", --4
		ring2="Medada's Ring", --10
		--back=gear.BLU_FC_Cape, --10
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Aurgelmir Orb +1",
		head="Nyame Helm",
		body="Assim. Jubbah +3",
		hands="Nyame Gauntlets",
		legs="Luhlaza Shalwar +3",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
		ring1="Epona's Ring",
		ring2="Epaminondas's Ring",
		back=gear.wsd_jse_back,
		waist="Fotia Belt",
	}

	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.AccMaxTP = {ear1="Regal Earring",ear2="Telos Earring"}

	-- Midcast Sets
	sets.midcast.FastRecast = {main="Vampirism",sub="Sakpata's Sword",ammo="Hasty Pinion +1",
		head="Carmine Mask +1",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Luhlaza Jubbah +3",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Carmine Greaves +1"}

	sets.midcast['Blue Magic'] = {}

	sets.midcast['Blue Magic'] = {
		ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +3",
		body="Assim. Jubbah +3",
		hands="Rawhide Gloves",
		legs="Hashishin Tayt +1",
		feet="Luhlaza Charuqs +3",
		neck="Mirage Stole +2",
		--ear1="Njordr Earring",
		ear2="Hashi. Earring +1",
		ring1={name="Stikini Ring +1", bag="wardrobe5"},
		ring2={name="Stikini Ring +1", bag="wardrobe6"},
		--back="Cornflower Cape",
	}

	sets.midcast['Blue Magic'].Physical = {
		ammo="Aurgelmir Orb +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Caro Necklace",
		ring1="Shukuyu Ring",
		ring2="Ilabrat Ring",
		back=gear.wsd_jse_back,
		waist="Sailfi Belt +1",
	}

	sets.midcast['Blue Magic'].Magical = {
		ammo="Pemphredo Tathlum",
		head="Amalric Coif +1",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Regal Earring",
		ring1="Shiva Ring +1",
		ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,
		waist="Orpheus's Sash",
	}

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1"})
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif +1",hands="Regal Cuffs",waist="Emphatikos Rope"})
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash"})

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.element.Light = {}

	sets.midcast['Blue Magic'].MagicAccuracy = {
		ammo="Pemphredo Tathlum",
		head="Assim. Keffiyeh +1",
		body="Amalric Doublet +1",
		hands="Malignance Gloves",
		legs="Assim. Shalwar +2",
		feet="Malignance Boots",
		--neck="Mirage Stole +2",
		ear1="Digni. Earring",
		ear2="Regal Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe3"},
		ring2={name="Stikini Ring +1", bag="wardrobe4"},
		back="Aurist's Cape +1",
		waist="Acuity Belt +1",
		--head="Volte Cap", hands=gear.Herc_TH_hands, feet="Volte Boots" -- TH Tag
	}

	sets.midcast['Blue Magic'].StunPhysical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
		ammo="Voluspa Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		--feet="Malignance Boots",
		--neck="Mirage Stole +2",
		--ear2="Mache Earring +1",
		back="Aurist's Cape +1",
		waist="Eschan Stone",
	})

	sets.midcast['Blue Magic'].StunMagical = sets.midcast['Blue Magic'].MagicAccuracy

	-- Other Specific Spells --

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +1"}

	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Luhlaza Keffiya +3",
		body="Assim. Jubbah +3",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		--feet="Malignance Boots",
		feet="Luhlaza Charuqs +3",
		neck="Loricate Torque +1",
		ear1="Eabani Earring",
		ear2="Genmei Earring",
		ring1={name="Stikini Ring +1", bag="wardrobe5"},
		ring2={name="Stikini Ring +1", bag="wardrobe6"},
		back="Moonlight Cape",
		waist="Plat. Mog. Belt",
	}

	-- Defense sets
	sets.defense.PDT = {main="Sakpata's Sword",sub="Genmei Shield",ammo="Staunch Tathlum +1",
				head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
				back="Shadow Mantle",waist="Flume Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
				head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		        body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
				back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

    sets.defense.MEVA = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum +1",
        head="Malignance Chapeau",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Malignance Tabard",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
        back=gear.nuke_jse_back,waist="Carrier's Sash",legs="Telchine Braconi",feet="Malignance Boots"}

	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {ring2="Shneddick Ring"}

    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt +1",ear1="Suppanomimi", ear2="Ethereal Earring"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket +1",waist="Reiki Yotai",legs="Carmine Cuisses +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Naegling = {main="Naegling",sub="Machaera +3"}
	sets.weapons.Nuking = {main="Sakpata's Sword", sub="Bunzi's Rod"}

	-- Engaged sets

	sets.engaged = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Dampening Tam",neck="Mirage Stole +2",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}

	sets.engaged.AM = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Dampening Tam",neck="Mirage Stole +2",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}


	sets.engaged.Acc = {main="Tizona",sub="Almace",ammo="Falcon Eye",
				head="Dampening Tam",neck="Mirage Stole +2",ear1="Cessance Earring",ear2="Telos Earring",
				body="Malignance Tabard",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Malignance Boots"}

	sets.engaged.Acc.AM = {main="Tizona",sub="Almace",ammo="Falcon Eye",
			    head="Dampening Tam",neck="Mirage Stole +2",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Malignance Tabard",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Ilabrat Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Malignance Boots"}

	sets.engaged.FullAcc = {main="Tizona",sub="Almace",ammo="Falcon Eye",
				head="Carmine Mask +1",neck="Mirage Stole +2",ear1="Mache Earring +1",ear2="Telos Earring",
				body="Assim. Jubbah +3",hands="Assim. Bazu. +3",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}

	sets.engaged.FullAcc.AM = {main="Tizona",sub="Almace",ammo="Falcon Eye",
			    head="Carmine Mask +1",neck="Mirage Stole +2",ear1="Mache Earring +1",ear2="Telos Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
			    back=gear.stp_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}

	sets.engaged.Fodder = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Dampening Tam",neck="Mirage Stole +2",ear1="Dedition Earring",ear2="Brutal Earring",
			    body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}

	sets.engaged.Fodder.AM = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Dampening Tam",neck="Mirage Stole +2",ear1="Dedition Earring",ear2="Telos Earring",
			    body="Adhemar Jacket +1",hands="Adhemar Wrist. +1",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Carmine Greaves +1"}

	sets.engaged.DT = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.DT.AM = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Acc.DT = {main="Tizona",sub="Almace",ammo="Falcon Eye",
			    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Ilabrat Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}
				
	sets.engaged.Acc.DT.AM = {main="Tizona",sub="Almace",ammo="Falcon Eye",
			    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Digni. Earring",ear2="Telos Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Ilabrat Ring",
			    back=gear.stp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.FullAcc.DT = {main="Tizona",sub="Almace",ammo="Falcon Eye",
			    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Mache Earring +1",ear2="Odr Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Ramuh Ring +1",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Fodder.DT = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.engaged.Fodder.DT.AM = {main="Tizona",sub="Almace",ammo="Aurgelmir Orb +1",
			    head="Malignance Chapeau",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Telos Earring",
			    body="Malignance Tabard",hands="Malignance Gloves",ring1="Defending Ring",ring2="Petrov Ring",
			    back=gear.stp_jse_back,waist="Reiki Yotai",legs="Malignance Tights",feet="Malignance Boots"}

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
	sets.MagicBurst = {body="Samnuha Coat",hands="Amalric Gages +1",legs="Assim. Shalwar +3",ring1="Mujin Band",ring2="Locus Ring"}
	sets.Phalanx_Received = {hands=gear.herculean_phalanx_hands,feet=gear.herculean_nuke_feet}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 2)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 2)
	else
		set_macro_page(6, 2)
	end
end

autows_list = {['Tizbron']='Expiacion',['Tizalmace']='Expiacion',['Almace']='Chant Du Cygne',['MeleeClubs']='Realmrazer',
     ['HybridWeapons']='Sanguine Blade',['Naegbron']='Savage Blade',['Naegmace']='Savage Blade'}