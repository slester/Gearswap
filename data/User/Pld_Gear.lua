function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','DDTank','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT_HP','PDT','PDT_Reraise')
    state.MagicalDefenseMode:options('MDT_HP','MDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA_HP','MEVA')
	state.IdleMode:options('Tank','Kiting','PDT','Block','MDT','Normal')
	state.Weapons:options('None','BurtgangAegis','SakpataPriwen','NaeglingBlurred','ClubPriwen')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10', 'Chance of successful block +5'}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind ^q gs c set IdleMode Kiting')
	send_command('bind !q gs c set IdleMode PDT')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------
    sets.Enmity = {
		ammo="Sapience Orb",
        head="Loess Barbuta +1",
		neck="Moonlight Necklace",
		ear1={ name = "Tuisto Earring", priority = 150},
		ear2={ name = "Odnowa Earring +1", priority = 110},
        body="Souveran Cuirass +1", -- TODO Obviation cuirass +1
		hands="Souveran Handschuhs +1", -- TODO	hands="Macabre Gaunt. +1",
		ring1="Vexer Ring +1",
		ring2="Apeile Ring +1",
        back=gear.enmity_jse_back,
		waist="Creed Baudrier",
		legs="Souveran Diechlings +1",
		feet="Chevalier's Sabatons +2", -- TODO: +3
	}

    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +1"}) -- +3
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {ammo="Paeapua",
		head="Nyame Helm",neck="Unmoving Collar +1",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Rev. Surcoat +1",hands="Cab. Gauntlets +1",ring1="Stikini Ring +1",ring2="Rufescent Ring",
		back=gear.enmity_jse_back,waist="Luminary Sash",legs="Nyame Flanchard",feet="Carmine Greaves +1"}
		
	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1"})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
    -- Fast cast sets for spells
	-- 59%
	sets.precast.FC = {
		ammo = "Sapience Orb", -- 2%
		head ={ name = "Carmine Mask +1", augments ={'Accuracy+20', 'Mag. Acc.+12', '"Fast Cast"+4',}}, -- 14%
		body ={ name = "Odyssean Chestplate", priority = 254}, -- 5%   TODO Rev Surcoat +3
		hands = "Leyline Gloves", -- 8%
		feet = "Chevalier Sabatons +2", -- 10%
		neck ={ name = "Unmoving Collar +1", priority = 200},
		ear1={ name = "Tuisto Earring", priority = 150},
		ear2={ name = "Odnowa Earring +1", priority = 110},
		ring1 = "Medada's Ring", -- +10%
		ring2 ={ name = "Gelatinous Ring +1", priority = 135},
		waist = "Audumbla Sash",
		back = gear.fastcast_jse_back, -- 10%
	}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	--sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",body="Jumalik Mail"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Aurgelmir Orb +1",
		head="Flam. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body=gear.valorous_wsd_body,hands=gear.odyssean_wsd_hands,ring1="Regal Ring",ring2="Rufescent Ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"}

    sets.precast.WS['Atonement'] = {
		ammo="Oshasha's Treatise",
        head="Nyame Helm",
		neck="Fotia Gorget",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
        body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Apeile Ring +1",
		ring2="Epaminondas's Ring",
        back=gear.enmity_jse_back,
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	--------------------------------------
	-- Midcast sets
	--------------------------------------
    sets.midcast.FastRecast = {}

	-- Spells that cast during battle should always be SIRD
    sets.midcast.Flash = {
		ammo = "Staunch Tathlum +1",
		head = "Souveran Schaller +1",
		neck = "Moonlight Necklace",
		ear1 = "Cryptic Earring",
		ear2 = "Odnowa Earring +1",
		body = "Souveran Cuirass +1",
		hands = "Souveran Handschuhs +1", 
		ring1 = "Defending Ring",
		ring2 = "Apeile Ring +1", -- TODO: R15
		back = gear.enmity_jse_back,
		waist = "Creed Baudrier",
		legs = "Chevalier's Cuisses +2",
		feet = "Chevalier's Sabatons +2"
	}

    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity, {})

    sets.midcast.Cure = {
		ammo = "Staunch Tathlum +1",
		head = "Souveran Schaller +1",
		neck = "Moonlight Necklace",
		ear1 = "Tuisto Earring",
		ear2 = "Cryptic Earring",
		body = "Souveran Cuirass +1",
		hands = "Souveran Handschuhs +1", 
		ring1 = "Defending Ring",
		ring2 = "Eihwaz Ring",
		back = gear.enmity_jse_back,
		waist = "Audumbla Sash",
		legs = "Souveran Diechlings +1",
		feet = "Chevalier's Sabatons +2" -- TODO +3
	}

    sets.midcast.Reprisal = {}

	sets.Self_Healing = {main="Deacon Sword",sub="Sacro Bulwark",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Sacro Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Souv. Cuirass +1",hands="Macabre Gaunt. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}
		
	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

	-- These buffs aren't used during battle, so they don't need SIRD
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {main="Sakpata's Sword",sub="Forfend +1",hands="Souv. Handsch. +1",back="Weard Mantle",legs="Sakpata's Cuisses",feet="Souveran Schuhs +1"})
	sets.Phalanx_Received = {main="Sakpata's Sword",hands="Souv. Handsch. +1",back="Weard Mantle",legs="Sakpata's Cuisses",feet="Souveran Schuhs +1"}

    -- Idle sets
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Chevalier's Armet +2", -- TODO: +3
		neck="Warder's Charm +1",
		ear1="Thureous Earring",
		ear2="Odnowa Earring +1",
		body="Sakpata's Plate",
		hands="Souveran Handschuhs +1",
		ring1="Moonlight Ring",
		ring2="Moonlight Ring",
		back=gear.enmity_jse_back,
		waist="Carrier's Sash",
		legs="Chevalier's Cuisses +2", -- TODO: +3
		feet="Souveran Schuhs +1"
	}
		

	sets.Kiting = {ring2="Shneddick Ring"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
	sets.passive.AbsorbMP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt +1",feet="Rev. Leggings +3"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.BurtgangAegis = {main="Burtgang", sub="Aegis"}
	sets.weapons.NaeglingBlurred = {main="Naegling", sub="Blurred Shield"}
	sets.weapons.SakpataPriwen = {main="Sakpata's Sword", sub="Priwen"}
	sets.weapons.ClubPriwen = {main="Mafic Cudgel", sub="Priwen"}

    sets.defense.Block = {main="Sakpata's Sword",sub="Ochain",ammo="Eluder's Sachet",
		head="Chev. Armet +1",neck="Diemer Gorget",ear1="Creed Earring",ear2="Thureous Earring",
		body="Sakpata's Breastplate",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Warden's Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Sakpata's Cuisses",feet="Souveran Schuhs +1"}
		
	sets.defense.PDT = {main="Sakpata's Sword",sub="Ochain",ammo="Eluder's Sachet",
		head="Sakpata's Helm",neck="Unmoving Collar +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
		body="Sakpata's Breastplate",hands="Sakpata's Gauntlets",ring1="Gelatinous Ring +1",ring2="Warden's Ring",
		back="Shadow Mantle",waist="Flume Belt +1",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
		
    sets.defense.PDT_HP = {main="Sakpata's Sword",sub="Ochain",ammo="Eluder's Sachet",
        head="Souv. Schaller +1",neck="Unmoving Collar +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Creed Baudrier",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}
		
	sets.defense.MDT = {main="Malignance Sword",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear2="Odnowa Earring +1",ear1="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Archon Ring",ring2="Shadow Ring",
		back=gear.fastcast_jse_back,waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
    sets.defense.MDT_HP = {main="Sakpata's Sword",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warder's Charm +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Carrier's Sash",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}

	sets.defense.MEVA = {main="Malignance Sword",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Purity Ring",ring2="Shadow Ring",
		back=gear.fastcast_jse_back,waist="Asklepian Belt",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		
    sets.defense.MEVA_HP = {main="Malignance Sword",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",neck="Warder's Charm +1",ear2="Odnowa Earring +1",ear1="Tuisto Earring",
        body="Sakpata's Plate",hands="Sakpata's Gauntlets",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Asklepian Belt",legs="Sakpata's Cuisses",feet="Sakpata's Leggings"}
		
    sets.defense.PDT_Reraise = set_combine(sets.defense.PDT_HP,{head="Twilight Helm",body="Twilight Mail"})
    sets.defense.MDT_Reraise = set_combine(sets.defense.MDT_HP,{head="Twilight Helm",body="Twilight Mail"})
		
	--------------------------------------
	-- Engaged sets
	--------------------------------------
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = {
		neck="Nicander's Necklace",
		waist="Gishdubar Sash",
		ring1="Eshmun's Ring",
		ring2="Eshmun's Ring",
	}
	sets.precast.Item['Holy Water'] = {ring1="Blenmot's Ring +1"}
	sets.precast.Item['Hallowed Water'] = sets.precast.Item['Holy Water']
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
end