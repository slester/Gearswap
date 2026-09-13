-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_job_setup()
	state.OffenseMode:options("Normal")
	state.CastingMode:options("Normal", "Resistant", "Proc", "OccultAcumen", "9k")
	state.IdleMode:options("Normal", "PDT")
	state.HybridMode:options("Normal", "PDT")
	state.Weapons:options("None", "Akademos", "Khatvanga")

	gear.nuke_jse_back =
		{ name = "Lugh's Cape", augments = { "INT+20", "Mag. Acc+20 /Mag. Dmg.+20", '"Mag.Atk.Bns."+10' } }

	-- Additional local binds
	send_command("bind ^` gs c cycle ElementalMode")
	send_command("bind !` gs c scholar power")
	send_command("bind @` gs c cycle MagicBurstMode")
	send_command("bind ^q gs c weapons Khatvanga;gs c set CastingMode OccultAcumen")
	send_command("bind !q gs c weapons default;gs c reset CastingMode")
	send_command("bind @f10 gs c cycle RecoverMode")
	send_command("bind @f8 gs c toggle AutoNukeMode")
	send_command("bind !pause gs c toggle AutoSubMode") --Automatically uses sublimation and Myrkr.
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command("bind !backspace gs c scholar speed")
	send_command("bind @backspace gs c scholar aoe")
	send_command('bind ^= input /ja "Dark Arts" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind ^\\\\ input /ma "Protect V" <t>')
	send_command('bind @\\\\ input /ma "Shell V" <t>')
	send_command('bind !\\\\ input /ma "Reraise III" <me>')

	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Precast sets to enhance JAs

	sets.precast.JA["Tabula Rasa"] = { legs = "Peda. Pants +1" }
	sets.precast.JA["Enlightenment"] = {} --body="Peda. Gown +1"

	-- WITH WRONG ARTS: +20% penalty and no grimoire bonuses
	-- RDM subjob: 15 + Gear: 68 = 83/80
	sets.precast.FC = {
		main = "Musa", -- 10
		sub = "Clerisy Strap +1", -- 3
		ammo = "Staunch Tathlum +1", -- SIRD-11%, DT-3%
		head = "Arbatel Bonnet +3", -- DT-10%
		neck = "Voltsurge Torque", -- 4
		ear1 = "Etiolation Earring", -- 1
		ear2 = "Malignance Earring", -- 4
		body = "Arbatel Gown +3", -- DT-13%
		hands = "Academic's Bracers +3", -- 8, TODO +4
		ring1 = "Defending Ring", -- DT-10%
		ring2 = "Medada's Ring", -- 10
		back = "Fi Follet Cape +1", -- 10, SIRD-5
		waist = "Embla Sash", -- 5
		legs = "Agwu's Slops", -- 7
		feet = "Amalric Nails +1", -- 6, SIRD-16
	}

	-- WITH CORRECT ARTS
	-- RDM subjob: 15 + Gear: 64 = 79/80
	-- Spellcasting Time same grimoire: -10% base + -26% = -36%
	-- so should only need 69 FC to cap using 0.2 = (1-FC)*(1-SCH)
	-- DT: -35%
	-- also want to make SIRD, DT priorities
	-- The maximum recast reduction allowed using Light Arts and Grimoire reduction gear is 90%
	-- Does not affect spells that are affected by Celerity/Alacrity/Accession/Manifestation
	sets.precast.FC.Arts = {
		main = "Musa", -- 10
		sub = "Clerisy Strap +1", -- 3
		ammo = "Sapience Orb", -- 2 OR ammo="Staunch Tathlum +1", -- SIRD-11%, DT-3%
		head = "Pedagogy Mortarboard +3", -- Grimoire: -13%
		neck = "Voltsurge Torque", -- 4
		ear1 = "Loquacious Earring", -- 2
		ear2 = "Malignance Earring", -- 4
		body = "Arbatel Gown +3", -- DT-13%
		hands = "Academic's Bracers +3", -- 8, TODO +4
		ring1 = "Defending Ring", -- DT-10%
		ring2 = "Medada's Ring", -- 10
		back = "Fi Follet Cape +1", -- 10, SIRD-5
		waist = "Embla Sash", -- 5
		legs = "Agwu's Slops", -- 7 --legs="Arbatel Pants +3", -- DT-12%
		feet = "Academic's Loafers +3", -- Grimoire: -13%, TODO +4
	}

	sets.precast.FC["Enhancing Magic"] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
	sets.precast.FC["Elemental Magic"] = set_combine(sets.precast.FC, {})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.Impact = set_combine(sets.precast.FC["Elemental Magic"], { head = empty, body = "Twilight Cloak" })
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, { main = "Daybreak", sub = "Genmei Shield" })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS["Myrkr"] = {
		ammo = "Ghastly Tathlum +1",
		head = "Pixie Hairpin +1",
		neck = "Sanctity Necklace",
		ear1 = "Evans Earring",
		ear2 = "Etiolation Earring",
		body = "Amalric Doublet +1",
		hands = "Regal Cuffs",
		ring1 = "Mephitas's Ring +1",
		ring2 = "Mephitas's Ring",
		back = "Aurist's Cape +1",
		waist = "Luminary Sash",
		legs = "Psycloth Lappas",
		feet = "Kaykaus Boots",
	}

	-- Midcast Sets
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Gear that converts elemental damage done to recover MP.
	--sets.RecoverMP = {body="Seidr Cotehardie"}

	-- Gear for specific elemental nukes.
	sets.element.Dark = { head = "Pixie Hairpin +1", ring2 = "Archon Ring" }
	sets.element.Light = { main = "Daybreak" }

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

	sets.midcast.Cure = {}
	sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.LightWeatherCure = set_combine(sets.midcast.Cure, {})
	sets.midcast.LightDayCure = set_combine(sets.midcast.Cure, {})

	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = { back = "Grapevine Cape", waist = "Gishdubar Sash", feet = "Inspirited Boots" }

	sets.midcast.Cursna = {}
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {})

	sets.midcast["Enhancing Magic"] = {}

	sets.midcast.Regen = set_combine(sets.midcast["Enhancing Magic"], { main = "Musa", sub = "Khonsu" })

	sets.midcast.Stoneskin = { -- +95
		neck = "Nodens Gorget", -- +30
		ear2 = "Earthcry Earring", -- +10
		waist = "Siegel Sash", -- +20
		legs = "Shedir Seraweels", -- +35
	}

	sets.midcast.Aquaveil = { --7
		main = "Vadose Rod", --1
		sub = "Genmei Shield",
		head = "Amalric Coif +1", --2
		hands = "Regal Cuffs", --2
		waist = "Emphatikos Rope", --1
		legs = "Shedir Seraweels", --1
	}

	sets.midcast.BarElement = set_combine(sets.precast.FC["Enhancing Magic"], { legs = "Shedir Seraweels" })

	sets.midcast.Storm = set_combine(sets.midcast["Enhancing Magic"], { feet = "Peda. Loafers +3" })

	sets.midcast.Protect = set_combine(sets.midcast["Enhancing Magic"], { ring2 = "Sheltered Ring" })
	sets.midcast.Protectra = sets.midcast.Protect
	sets.midcast.Shell = set_combine(sets.midcast["Enhancing Magic"], { ring2 = "Sheltered Ring" })
	sets.midcast.Shellra = sets.midcast.Shell

	-- Custom spell classes

	sets.midcast["Enfeebling Magic"] = {}

	sets.midcast["Enfeebling Magic"].Resistant = {}

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast["Enfeebling Magic"], {})
	sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast["Enfeebling Magic"], {})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast["Enfeebling Magic"], {})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast["Enfeebling Magic"].Resistant, {})

	sets.midcast.Dia = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)
	sets.midcast["Dia II"] = sets.midcast["Enfeebling Magic"]
	sets.midcast.Bio = set_combine(sets.midcast["Enfeebling Magic"], sets.TreasureHunter)
	sets.midcast["Bio II"] = sets.midcast["Enfeebling Magic"]

	sets.midcast["Divine Magic"] = set_combine(sets.midcast["Enfeebling Magic"], {})

	sets.midcast["Dark Magic"] = {
		main = "Rubicundity",
		sub = "Ammurapi Shield",
		ammo = "Staunch Tathlum +1",
		head = "Pixie Earring +1",
		neck = "Erra Pendant",
		--ear2="Mani Earring", -- TODO
		body = "Academic's Gown +3", -- TODO +4?
		hands = "Merlinic Dastanas", -- TODO double check augs
		ring1 = "Evanescence Ring",
		ring2 = "Archon Ring",
		back = "Bookworm's Cape",
		waist = "Fucho-no-Obi",
		legs = "Pedagogy Pants +3",
		feet = "Agwu's Pigaches",
	}

	sets.midcast.Kaustra = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		ammo = "Pemphredo Tathlum",
		head = "Pixie Earring +1",
		neck = "Argute Stole +2",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = "Agwu's Robe",
		hands = "Arbatel Bracers +3",
		ring1 = "Freke Ring",
		ring2 = "Archon Ring",
		back = "Lugh's Cape",
		waist = "Hachirin-no-Obi",
		legs = "Arbatel Pants +3",
		feet = "Arbatel Loafers +3",
	}
	sets.midcast.Kaustra.Resistant = {}

	sets.midcast.Drain = {}
	sets.midcast.Drain.Resistant = {}

	sets.midcast.Aspir = sets.midcast.Drain
	sets.midcast.Aspir.Resistant = sets.midcast.Drain.Resistant

	sets.midcast.Stun = {}
	sets.midcast.Stun.Resistant = {}

	-- Elemental Magic sets are default for handling low-tier nukes.
	sets.midcast["Elemental Magic"] = {
		main = "Bunzi's Rod",
		sub = "Ammurapi Shield",
		ammo = "Ghastly Tathlum +1",
		head = "Agwu's Cap",
		neck = "Argute Stole +2",
		ear1 = "Regal Earring",
		ear2 = "Malignance Earring",
		body = "Arbatel Gown +3",
		hands = "Arbatel Bracers +3",
		ring1 = "Freke Ring",
		ring2 = "Metamor. Ring +1",
		back = "Lugh's Cape",
		waist = "Hachirin-no-Obi",
		legs = "Arbatel Pants +3",
		feet = "Arbatel Loafers +3",
	}

	sets.midcast["Elemental Magic"].Resistant = set_combine(sets.midcast["Elemental Magic"], {})
	sets.midcast["Elemental Magic"]["9k"] = set_combine(sets.midcast["Elemental Magic"], {})
	sets.midcast["Elemental Magic"].Proc = set_combine(sets.midcast["Elemental Magic"], {})
	sets.midcast["Elemental Magic"].OccultAcumen = set_combine(sets.midcast["Elemental Magic"], {})

	-- Gear for Magic Burst mode.
	sets.MagicBurst = set_combine(sets.midcast["Elemental Magic"], {
		head = "Peda. M.Board +3",
		body = "Agwu's Robe",
		hands = "Agwu's Gages",
		legs = "Agwu's Slops",
		ring2 = "Mujin Band",
	})

	-- Custom refinements for certain nuke tiers
	sets.midcast["Elemental Magic"].HighTierNuke = {}
	sets.midcast["Elemental Magic"].HighTierNuke.Resistant = {}

	sets.midcast.Helix = set_combine(sets.midcast["Elemental Magic"], {
		head = "Agwu's Cap",
		body = "Agwu's Robe",
		hands = "Amalric Gages +1",
		waist = "Acuity Belt +1",
		legs = "Agwu's Slops",
		feet = "Amalric Nails +1",
	})
	sets.midcast.Helix.Resistant = set_combine(sets.midcast.Helix, {})
	sets.midcast.Helix.Proc = set_combine(sets.midcast.Helix, {})

	sets.HelixBurst = set_combine(sets.MagicBurst, {
		head = "Arbatel Bonnet +3",
		ear2 = "Arbatel Earring", -- +2?
	})
	sets.ResistantHelixBurst = {}

	sets.midcast.Impact = {
		head = empty,
		body = "Twilight Cloak",
	}
	sets.midcast.Impact.OccultAcumen =
		set_combine(sets.midcast["Elemental Magic"].OccultAcumen, { head = empty, body = "Twilight Cloak" })

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	-- DT -50
	-- MDT -3
	-- 9 Refresh
	sets.idle = {
		main = "Mpaca's Staff",
		sub = "Khonsu",
		ammo = "Homiliary",
		head = "Nyame Helm", -- 7
		neck = "Warder's Charm +1",
		ear1 = "Etiolation Earring",
		ear2 = "Hearty Earring",
		body = "Arbatel Gown +3", --13
		hands = "Nyame Gauntlets",
		ring1 = { name = "Stikini Ring +1", bag = "wardrobe3" },
		ring2 = { name = "Stikini Ring +1", bag = "wardrobe4" },
		back = "Moonlight Cape",
		waist = "Carrier's Sash",
		legs = "Agwu's Slops",
		feet = "Nyame Sollerets",
	}

	sets.Kiting = { ring2 = "Shneddick Ring" }
	sets.latent_refresh = { waist = "Fucho-no-obi" }

	-- Resting sets
	sets.resting = set_combine(sets.idle, {
		main = "Chatoyant Staff",
		sub = "Oneiros Grip",
	})

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff["Ebullience"] = { head = "Arbatel Bonnet +3" }
	sets.buff["Rapture"] = { head = "Arbatel Bonnet +3" }
	sets.buff["Perpetuance"] = { hands = "Arbatel Bracers +3" }
	sets.buff["Immanence"] = { hands = "Arbatel Bracers +3" }
	sets.buff["Penury"] = { legs = "Arbatel Pants +3" }
	sets.buff["Parsimony"] = { legs = "Arbatel Pants +3" }
	sets.buff["Celerity"] = { feet = "Peda. Loafers +3" }
	sets.buff["Alacrity"] = { feet = "Peda. Loafers +3" }
	sets.buff["Klimaform"] = { feet = "Arbatel Loafers +3" }

	sets.HPDown = {}
	sets.HPCure = {}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff["Light Arts"] = { legs = "Academic's Pants +3" } -- TODO +4
	sets.buff["Dark Arts"] = { body = "Academic's Gown +3" } -- TODO +4

	-- head/body/waist = 20 fewer DT; 19 DT recoverable
	sets.buff.Sublimation = {
		head = "Acad. Mortar. +3",
		body = "Peda. Gown +3",
		waist = "Embla Sash",
		-- ear1="Savant's Earring", -- 1 Sublimation, I have it in a slip, worth it?
		ring1 = "Defending Ring", -- 10 DT
		neck = "Loricate Torque +1", -- 6 DT
		ammo = "Staunch Tathlum +1", -- 3 DT
	}
	sets.buff.DTSublimation = { waist = "Embla Sash" }

	-- Weapons sets
	sets.weapons.Akademos = { main = "Akademos", sub = "Enki Strap" }
	sets.weapons.Musa = { main = "Musa", sub = "Enki Strap" }
end

-- Select default macro book on initial load or subjob change.
-- Default macro set/book
function select_default_macro_book()
	if player.sub_job == "RDM" then
		set_macro_page(1, 18)
	elseif player.sub_job == "BLM" then
		set_macro_page(1, 18)
	elseif player.sub_job == "WHM" then
		set_macro_page(1, 18)
	else
		set_macro_page(1, 18)
	end
end
