
$ = undefined
debug = on
builddate = '###BUILD_DATE###'

get_server_lang = ->
	if location.href.match /heroeswm.ru/
		'ru'
	else if location.href.match /lordswm.com/
		'com'
	else if location.href.match /rus.heroeswm.com/
		'ru'
	else if location.href.match /heroeswm.com/
		'com'
	else
		'ru'

if get_server_lang() == 'com'
	text_ap = "AP"
	text_err = 'Logic error, plz contact script\'s developers team'
	text_hp = 'total HP'
	text_tp = 'talent points'
	text_unknown_art = 'Following arts not found in the database: %s. Please, refresh current page. If this problem still exists, try to update script or contact developer.'
	text_unknown_creature = 'Following creatures not found in the database: %s. Please, refresh current page. If this problem still exists, try to update script or contact developer.'
	textalt_craft = 'Craft'
	textalt_gold = 'Cost for one battle'
else
	text_ap = "ОА"
	text_err = 'Ошибка в скрипте, обратитесь к разработчику'
	text_hp = 'общее HP'
	text_tp = 'Очки навыков'
	text_unknown_art = "Следующие арты не найдены в базе: %s. Пожалуйста, обновите скрипт. Если проблема повторится, сообщите разработчику."
	text_unknown_creature = "Следующие существа не найдены в базе: %s. Пожалуйста, обновите скрипт. Если проблема повторится, сообщите разработчику."
	textalt_craft = 'Крафт'
	textalt_craft = 'Цена за бой'

g_army = []
g_perks = []
g_frac = false

obj_perk = false
obj_army = false
has_vitality = false

ap_table =
	'2year_amul_lords':	2
	'3arrows':		5
	'3year_amul':	2
	'3year_art': 	3
	'4year_klever':	3
	a_mallet:       3
	amulet_of_luck: 2
	antiair_cape:   3
	antifire_cape:  3
	antimagic_cape: 5
	armor15:	8
	bafamulet15:	9
	barb_armor:     6
	barb_boots:     6
	barb_club:      7
	barb_helm:      4
	barb_shield:    6
	bfly:   5
	blacksword:	10
	blacksword1:   10
	bludgeon:	9
	boots13:	7
	boots15:	8
	boots2:	2
	bow14:	6
	bravery_medal:  2
	bril_pendant:   6
	bril_ring:      5
	bring14:	6
	broad_sword:    6
	brush_2011y:	15
	bunt_medal1:    11
	bunt_medal2:    6
	bunt_medal3:    4
	centaurbow:	5
	chain_coif:     2
	ciras:  4
	circ_ring:      4
	cloackwz15:	8
	composite_bow:	5
	d_spray:        4
	dagger: 1
	darkelfboots:   7
	darkelfciras:   7
	darkelfcloack: 6
	darkelfcloak:   6
	darkelfkaska:   6
	darkelfpendant: 9
	darkelfstaff:   10
	darkring:       5
	def_sword:      3
	defender_dagger:        2
	defender_shield:        3
	dem_amulet:     9
	dem_armor:      6
	dem_axe:        10
	dem_bootshields: 6
	dem_dmech:  6
	dem_dtopor:     11
	dem_helmet:     6
	dem_kosa:   9
	dem_shield:     6
	demwar1:        14
	demwar2:        11
	demwar3:        9
	demwar4:        7
	demwar5:        5
	demwar6:        4
	doubt_ring:     2
	dragon_shield:  5
	druid_amulet:	11
	druid_armor:	8
	druid_boots:	7
	druid_cloack:	8
	druid_staff:	11
	dubina:	11
	elfamulet:      9
	elfboots:       7
	elfbow: 8
	elfshirt:       7
	elfwar1:        13
	elfwar2:        11
	elfwar3:        8
	elfwar4:        7
	elfwar5:        6
	elfwar6:        4
	energy_scroll:  6
	ffstaff15:	11
	firsword15:	11
	flower_heart:   1
	flowers1:       1
	flowers2:       1
	flowers3:       4
	flowers4:	5
	flowers5:	5
	full_plate:     6
	gdubina:        7
	gm_3arrows: 5
	gm_abow:        6
	gm_amul:        5
	gm_arm: 5
	gm_defence:     5
	gm_hat: 4
	gm_kastet:      8
	gm_protect:     6
	gm_rring: 2
	gm_spdb:        2
	gm_sring:       2
	gm_sword:       8
	gmage_armor:	8
	gmage_boots:	7
	gmage_cloack:	8
	gmage_crown:	6
	gmage_scroll:	8
	gmage_staff:	11
	gnome_hammer:   2
	gnomearmor:		6
	gnomeboots:		5
	gnomehammer:	9
	gnomehelmet: 	5
	gnomem_amulet:	11
	gnomem_armor:	8
	gnomem_boots:	7
	gnomem_hammer:	10
	gnomem_helmet:	6
	gnomem_shield:	7
	gnomeshield:	6
	gnomewar1:		15
	gnomewar2:		12
	gnomewar3:		10
	gnomewar4:		8
	gnomewar5:		7
	gnomewar6:		6
	gnomewar7:		5
	gnomewar_splo:	8
	gnomewar_stoj:	8
	gnomewar_takt:	8
	goldciras:	4
	half_heart_m:   2
	half_heart_w:   2
	hauberk:        3
	hunter_amulet1: 3
	hunter_armor1:  3
	hunter_arrows1: 3
	hunter_boots:	1
	hunter_boots1:  1
	hunter_boots2:  2
	hunter_boots3:  2
	hunter_bow1:    2
	hunter_bow2:    3
	hunter_gloves1: 1
	hunter_hat1:    1
	hunter_helm:    2
	hunter_jacket1: 1
	hunter_mask1:   3
	hunter_pendant1:        1
	hunter_ring1:   2
	hunter_ring2: 3
	hunter_roga1:   2
	hunter_shield1: 2
	hunter_sword1:  1
	hunterboots:    1
	hunterdagger:   2
	hunterdsword: 4
	huntershield2:  3
	huntersword2:   4
	i_ring:	1
	knightarmor:	6
	knightboots:	5
	knighthelmet:	5
	knightshield:	6
	knightsword:	9
	knowledge_hat:  2
	koltsou:	6
	kopie:	9
	kwar1:	15
	kwar2:	12
	kwar3:	10
	kwar4:	8
	kwar5:	7
	kwar6:	6
	kwar7:	5
	kwar_splo:	8
	kwar_stoj:	8
	kwar_takt:	8
	large_shield:   6
	leather_helm:   1
	leather_shiled: 1
	leatherboots:	1
	leatherhat:	1
	leatherplate:	2
	lizard_armor:   2
	lizard_boots:   2
	lizard_helm:    2
	long_bow:       4
	mage_armor:     5
	mage_boots:     7
	mage_cape:      6
	mage_hat:       6
	mage_helm:      4
	mage_robe:      7
	mage_scroll:    8
	mage_staff:     11
	magewar1:       12
	magewar2:       9
	magewar3:       7
	magewar4:       5
	magewar5:       4
	magic_amulet:   7
	magring13:	6
	mart8_flowers1: 4
	mart8_ring1:    5
	mboots14:	8
	merc_armor:     6
	merc_boots:     6
	merc_dagger:    6
	merc_sword:     8
	mhelmetzh13:	6
	mif_hboots:		6
	mif_hhelmet:	5
	mif_lboots:     6
	mif_lhelmet:    5
	mif_light:      5
	mif_staff:      9
	mif_sword:      9
	miff_plate:		7
	mm_staff:		10
	mm_sword:		10
	mmmring16:	6
	mmzamulet13:	9
	mmzamulet16:	10
	molot_tan:	12
	molot_tan:     12
	myhelmet15:	7
	necr_amulet:    5
	necr_helm:      5
	necr_robe:      5
	necr_staff:     6
	necrwar1st:     14
	necrwar2st:     10
	necrwar3st:     6
	necrwar4st:     4
	necrwar5st:     2
	ny_bag: 3
	ny_beard:       2
	ny_bell:        5
	ny_candle:      4
	ny_cap: 4
	ny_dfur:        5
	ny_fir: 7
	ny_flaps:       3
	ny_fur: 5
	ny_furcap:      6
	ny_gloves:      3
	ny_horns:       3
	ny_icicle:      4
	ny_muff:        3
	ny_rat: 4
	ny_ring:        7
	ny_sbag:        5
	ny_sock:        4
	ny_staff:       4
	ny_star:        4
	ny_toy: 4
	paladin_armor:	8
	paladin_boots:	7
	paladin_bow:	8
	paladin_helmet:	6
	paladin_shield:	7
	paladin_sword:	11
	pika:   9
	power_pendant:  7
	power_sword:    8
	powercape:	4
	powerring:      4
	protazan:	2
	rashness_ring:  2
	requital_sword: 5
	ring_of_thief:  5
	robewz15:	8
	rog_demon:	10
	roses:  9
	round_shiled:   1
	ru_statue: 10
	s_shield:	2
	scoutcloack:	1
	sea_trident:    7
	sh_4arrows: 7
	sh_amulet2: 7
	sh_armor:   7
	sh_boots:   4
	sh_bow: 8
	sh_cloak:   8
	sh_helmet:  6
	sh_ring1:   6
	sh_ring2:   4
	sh_shield:  7
	sh_spear:   10
	sh_sword:   10
	shield13:	7
	shield16:	8
	shoe_of_initiative:     3
	shortbow:	1
	shpaga: 10
	slayersword:   11
	snowflake_1:    4
	snowflake_2:    6
	sor_staff:      8
	soul_cape:	2
	staff:  6
	staff2010: 1
	steel_blade:    2
	steel_boots:    4
	steel_helmet:   3
	sword5:    5
	tact1w1_wamulet:	10
	tact765_bow:	7
	tactaz_axe:	11
	tactcv1_armor:	9
	tactdff_shield:	8
	tacthapp_helmet:	8
	tactmag_staff:	10
	tactms1_mamulet:	10
	tactpow_cloack:	9
	tactsm0_dagger:	8
	tactspw_mring:	7
	tactwww_wring:	7
	tactzl4_boots:	9
	testring:       6
	thief_arb:      9
	thief_cape:     5
	thief_fastboots:        6
	thief_goodarmor:        6
	thief_ml_dagger:        7
	thief_msk:      5
	thief_neckl:    8
	thief_premiumring1:     8
	thief_premiumring2:     7
	thief_premiumring3:     6
	thief_unique_secretops: 3
	tl_medal1:	9
	tl_medal2:	4
	tl_medal3:	3
	topor_skelet:	7
	tunnel_kirka:   7
	v_1armor:	9
	ve_helm:	8
	venok:  2
	verb11_sword:	11
	verbboots:	9
	verve_ring:     2
	vrb_shild:     8
	warmor:	6
	warring13:	6
	warrior_pendant:        8
	warriorring:    5
	warthief_medal1:        7
	warthief_medal2:        6
	warthief_medal3:        5
	warthief_medal4:        4
	warthief_medal5:        3
	wboots:	6
	welfarmor:	6
	welfboots:	5
	welfbow:	6
	welfhelmet:	5
	welfshield:	6
	welfsword:	9
	whelmet:        6
	wiz_boots:	6
	wiz_cape:	7
	wiz_robe:	7
	wizard_cap:     2
	wolfjacket:     2
	wood_sword:     1
	wwwring16:	6
	wzzamulet13:	9
	wzzamulet16:	10
	xymhelmet15:	7
	zub:	10
	zxhelmet13:	6

cost_table =
	# from wizardsvalley.ru,
	leatherhat: 14.58
	leather_helm: 22.70
	chain_coif: 43.18
	wizard_cap: 52.21
	knowledge_hat: 84.32
	steel_helmet: 59.91
	mage_helm: 126.03
	mif_lhelmet: 78.84
	mif_hhelmet: 94.51
	zxhelmet13: 95.96
	mhelmetzh13: 95.95
	myhelmet15: 98.95
	xymhelmet15: 99.24
	bravery_medal: 25.64
	amulet_of_luck: 42.04
	power_pendant: 129.28
	warrior_pendant: 168.90
	magic_amulet: 176.00
	wzzamulet13: 175.00
	mmzamulet13: 175.00
	bafamulet15: 174.84
	wzzamulet16: 177.58
	mmzamulet16: 177.56
	leather_shiled: 15.17
	leatherplate: 47.60
	hauberk: 66.76
	ciras: 73.45
	mif_light: 94.13
	mage_armor: 210.67
	full_plate: 129.55
	wiz_robe: 140.63
	miff_plate: 138.09
	armor15: 139.95
	robewz15: 139.90
	scoutcloack: 15.75
	shortbow: 17.85
	antiair_cape: 56.20
	long_bow: 133.11
	antimagic_cape: 75.17
	powercape: 240.50
	composite_bow: 157.66
	wiz_cape: 152.63
	bow14: 160.95
	cloackwz15: 155.45
	wood_sword: 20
	gnome_hammer: 20.00
	steel_blade: 23.00
	def_sword: 34.53
	requital_sword: 73.25
	staff: 86.85
	broad_sword: 90.24
	power_sword: 143.29
	sor_staff: 306.99
	mif_sword: 254.85
	mif_staff: 246.50
	mm_sword: 258.35
	mm_staff: 255.23
	firsword15: 265.54
	ffstaff15: 265.61
	s_shield: 18.67
	dagger: 34.40
	defender_shield: 32.25
	dragon_shield: 147.11
	large_shield: 152.29
	energy_scroll: 135.75
	shield13: 152.95
	shield16: 154.74
	leatherboots: 15.00
	hunter_boots: 33.73
	boots2: 30.80
	shoe_of_initiative: 68.16
	steel_boots: 96.21
	mif_lboots: 136.21
	mif_hboots: 124.95
	wiz_boots: 129.59
	boots13: 127.75
	mboots14: 132.52
	boots15: 128.64
	i_ring: 17.50
	verve_ring: 100.11
	doubt_ring: 180.53
	rashness_ring: 70.63
	circ_ring: 154.39
	powerring: 185.16
	warriorring: 201.88
	darkring: 176.18
	warring13: 180.25
	magring13: 180.13
	bring14: 181.90
	wwwring16: 181.83
	mmmring16: 181.76

army_table =
	# knight
	paesantani: [1, 4]
	conscriptani: [1, 6]
	archerani: [1, 7]
	marksmanani: [1, 10]
	footmanani: [1, 16]
	swordmanani: [1, 26]
	griffonani: [1, 30]
	impergriffinani: [1, 35]
	priestani: [1, 54]
	inquisitorani: [1, 80]
	knightani: [1, 90]
	paladinani: [1, 100]
	angelani: [1, 180]
	archangelani: [1, 220]
	# necro
	sceletonani: [2, 4]
	sceletonarcherani: [2, 4]
	zombieani: [2, 17]
	plaguezombieani: [2, 17]
	ghostani: [2, 8]
	spectreani: [2, 19]
	vampireani: [2, 30]
	vampirelordani: [2, 35]
	lichani: [2, 50]
	archlichani: [2, 55]
	wightani: [2, 95]
	wraithani: [2, 100]
	bonedragonani: [2, 150]
	spectraldragonani: [2, 160]
	# mage
	gremlinani: [3, 5]
	mastergremlinani: [3, 6]
	gargolyani: [3, 15]
	obsgargolyani: [3, 20]
	golemani: [3, 18]
	steelgolemani: [3, 24]
	mageani: [3, 18]
	archmageani: [3, 30]
	djinnani: [3, 40]
	djinn_sultanani: [3, 45]
	rakshasani: [3, 120]
	rakshasa_rajaani: [3, 140]
	colossusani: [3, 175]
	titanani: [3, 190]
	# sylvan
	ppani: [4, 5]
	spriteani: [4, 6]
	dancerani: [4, 12]
	bladedancerani: [4, 12]
	elfani: [4, 10]
	hunterelfani: [4, 14]
	dd_ani: [4, 34]
	ddeldani: [4, 38]
	unicornani: [4, 57]
	silverunicornani: [4, 77]
	entani: [4, 175]
	ancienentani: [4, 181]
	greendragonani: [4, 200]
	emeralddragonani: [4, 200]
	# barb
	goblinani: [5, 3]
	hobgoblinani: [5, 4]
	wolfriderani: [5, 10]
	hobwolfriderani: [5, 12]
	orcani: [5, 12]
	orcchiefani: [5, 18]
	ogreani: [5, 50]
	ogremagiani: [5, 65]
	rocani: [5, 55]
	thunderbirdani: [5, 65]
	cyclopani: [5, 85]
	cyclopkingani: [5, 95]
	behemothani: [5, 210]
	abehemothani: [5, 250]
	# dark
	scoutani: [6, 10]
	assasinani: [6, 14]
	maidenani: [6, 16]
	furyani: [6, 16]
	minotaurani: [6, 31]
	minotaurguard_ani: [6, 35]
	lizardriderani: [6, 40]
	grimriderani: [6, 50]
	hydraani: [6, 80]
	deephydraani: [6, 125]
	witchani: [6, 80]
	matriarchani: [6, 90]
	shadowdragonani: [6, 200]
	blackdragonani: [6, 240]
	# demon
	impani: [7, 4]
	familiarani: [7, 6]
	hdemonani: [7, 13]
	fdemonani: [7, 13]
	demondogani: [7, 15]
	cerberusani: [7, 15]
	succubani: [7, 20]
	succubusmani: [7, 30]
	nightmareani: [7, 50]
	stallionani: [7, 66]
	pitfiend_ani: [7, 110]
	pitlord_ani: [7, 120]
	devilani: [7, 166]
	archdevilani: [7, 199]
	# dwarf
	defenderani: [8, 7]
	shieldguardani: [8, 12]
	spearwielderani: [8, 10]
	skirmesherani: [8, 12]
	bearriderani: [8, 25]
	blackbearriderani: [8, 30]
	brawlerani: [8, 20]
	berserkerani: [8, 25]
	runepriestani: [8, 60]
	runepatriarchani: [8, 70]
	thaneani: [8, 100]
	thunderlordani: [8, 120]
	firedragonani: [8, 230]
	magmadragonani: [8, 280]

perk_table =
	1:
		knight_mark: 5
		attack: 9
		defense: 8
		luck: 10
		leadership: 7
		dark: 8
		light: 7
	2:
		necr_soul: 5
		defense: 11
		enlightenment: 9
		dark: 7
		summon: 8
		sorcery: 8
	3:
		magic_mirror: 7
		enlightenment: 9
		light: 10
		summon: 8
		destructive: 10
		sorcery: 7
	4:
		elf_shot: 7
		attack: 10
		defense: 9
		luck: 7
		leadership: 10
		enlightenment: 10
		light: 7
		summon: 9
	5:
		barb_skill: 7
		attack: 7
		defense: 9
		luck: 9
		leadership: 10
	6:
		dark_power: 7
		attack: 8
		luck: 9
		leadership: 10
		enlightenment: 10
		dark: 8
		destructive: 9
		sorcery: 7
	7:
		hellfire: 6
		attack: 7
		defense: 9
		luck: 10
		dark: 8
		destructive: 10
		sorcery: 8
	8:
		runeadv: 7
		defense: 9
		destructive: 11
		light: 8
		leadership: 9
		luck: 10

log = -> if debug
	console = (unsafeWindow ? window).console
	console.log.apply(console, arguments)
	GM_log(JSON.stringify(arguments))
log 'running!', builddate

error = ->
	log 'ERROR:', arguments

chksum = (seed, mod) ->
	len = seed.length
	chksum = 0
	while --len >= 0
		chksum = (chksum*6551+seed.charCodeAt(len))%60000
	chksum

version = ->
	chksum(builddate, 10000)

get_ap_info = (art) -> ap_table[art] ? Number(GM_getValue('plinfo_ap_'+art, 0))
get_army_info = (army) ->
	if army_table[army]?
		army_table[army]
	else
		ret = GM_getValue('plinfo_army_'+army, "")
		ret = ret.split(',') if ret? and ret != ""
		ret

make_ap = ->
	left_td = undefined
	arts_td = undefined

	$('img').each ->
		if @.src.indexOf('/i/s_initiative.gif') != -1 && !left_td?
			left_td = @.parentNode.parentNode.parentNode
			left_td = undefined if $(left_td).find('img').length < 7
		else if (@.src.match(/\/i\/book\d?\.jpg/))
			arts_td = @.parentNode.parentNode.parentNode

	return unless left_td? and arts_td?

	sum_ap = 0
	sum_craft = 0
	unknown_art = {}
	sum_cost = 0
	unknown_cost = false

	$('a').each ->
		if m = @.href.match /art_info\.php\?id=([^&]+)/
			if @.childNodes[0].tagName == 'TABLE'
			else if @.childNodes[0].src.indexOf("/mods/") != -1
				# craft
				#var m2 = allarts[i].childNodes[0].src.match(/\/\w(\d+)\.gif$/);
				#sum_ap += ap_table[m[1]] ? (ap_table[m[1]]*2*m2[1]/100) : 0;
			else
				if @.parentNode.getAttribute("colspan") == 5
					sum_cr = 0
					if m2 = @.childNodes[0].title.match /\[(([A-Z]\d{1,2})+)\]/
						for ii in m2[0].match(/\d{1,2}/g)
							sum_cr += Number(ii)
						unknown_cost = true

					ap = get_ap_info(m[1])
					cost = cost_table[m[1]] ? 0
					if (cost == 0) then unknown_cost = true
					sum_cost += cost

					if ap
						art_ap = ap
						art_ap += art_ap*2*sum_cr/100
						sum_ap += Math.floor(art_ap)
					else
						unknown_art[m[1]] = true
					sum_craft += sum_cr
				else if @.childNodes[0].src.indexOf("/transparent.gif") == -1
					ap = get_ap_info(m[1])
					if ap
						sum_ap += ap
					else
						unknown_art[m[1]] = true

					cost = cost_table[m[1]] ? 0
					if (cost == 0) then unknown_cost = true
					sum_cost += cost

	# adding
	image = 'data:image/png;base64,
iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAAXNSR0IArs4c6QAAAAZiS
0dEAK4AjgAyFSj9ggAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB9kBExItDLAXV1
wAAAAZdEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIEdJTVBXgQ4XAAAC0UlEQVQ4y32TTWh
UVxTHf+fe92ZMaWHcNAhJ6MI0hdhKkPqxsJ1WitgutELSRSU0WisiFBwDogsZQQKtya5Q
TRxMusxgWxdtCq3abnQlCsWIUmxLpAQ/NgEb3mTe+7vIe8kziBcO3HO/zvl/XCTxoqhWc
SvXAFu5ZukGZmbKkjQHWLuJV7aVODUzxzpECaOEaMMI3+6i5eQ4EUCQXZSkjzbbHox5jE
MfbqEd6AAKM3MkgMMAiEovM11+i/XAamAWwJEfju8wJoH3JF6LIp50tUH5TehdR89PV2U
bt/PS++t5BERJzIVqFQ9gKV7VvrSOyPHPvf/YN1xn3BDCGKuQCOIvRhRkcMcqPPaOqWbC
B/tH9CqAW+TFnC8yEHpsw9oUp1Cu1zibjFbowQgHTutTM1q+GbTNZmYOzADXTBhwxq35B
Y5mlVkmP8l49MYJxA3r6/MOLhcTzqUcSePH6QFWhwV2xwldE8fozFNnEGZKxmJnocjnty
brft8IuzC6JckBJAscc45L/UPc88bFZoOv8xbIxpnDnAw8//YP6W53fRGuNy7WBu03B+b
jhI/3nqYPYO+wdsViZwZluSnwRj8JlwHUq1iSGjGnBJs4d4QLtUG+lwgyF49VuFI7wo+A
jVbQaIU41URAjDk5RxNzwpwCTxQkYvf+4UUOAOp184UiB6KIOzlUMrDyu0nL37eZSbnPN
ODb87SRvbqySuj5S8KnHQlhVeEQ9rywcplV0zeZLQTE3i+VYuAgrdd/Zc/WbiYE/PEnG3
6+xo1n3JVXViKcrmMTv1D8qsaTRbXQZ2WKDyL+B5rp2bBotP5wlYeAQ8tFMeDsWUKJAHD
VMsGaEu+EITcxi9/ooNHZjl5vZ6GznRhsAfgdXKV3Eo+WvtiSeQ2wHTsoAolBDCYw5TlM
o+EcD/MPAebyfpmaouFgSOAwS39PphvziDmkR87xyZb7FPIcPQVNfGtqzJKB4wAAAABJR
U5ErkJggg=='
	newtr = $('
	<tr height="23">
		<td align="center">
			<img title="'+text_ap+'" src="'+image+'" width="16" height="16" />
		</td>
		<td align="center">
			<b>'+sum_ap+'</b>
		</td>
	</tr>')
	
	unknown_art_array = []
	for i of unknown_art
		unknown_art_array.push(i)
		update_unknown('ap', i)
	if unknown_art_array.length
		hint = text_unknown_art.replace('%s', unknown_art_array.join(', '))
		inner += ' (<a href="javascript:alert(\''+hint+'\');" title="'+hint+'">?</a>)'
	newtr.appendTo(left_td)

	# adding
	if sum_craft > 0
		newtr = $('
		<tr height="23">
			<td align="center">
				<img title="'+textalt_craft+'" src="/i/mod_common.gif" width="18" height="18" />
			</td>
			<td align="center">
				<b>'+sum_craft+'%</b>
			</td>
		</tr>')
		newtr.appendTo(left_td)

	if (sum_cost > 0)
		$('
		<tr height="23">
			<td align="center">
				<img title="'+textalt_gold+'" src="/i/gold.gif" width="24" height="24" />
			</td>
			<td align="center">
				<b>'+(Math.round(sum_cost) + (if unknown_cost then '+' else ''))+'</b>
			</td>
		</tr>').appendTo(left_td)

loop_objects = ->
	$('object').each ->
		movie =	fv = undefined
		$(@).find("param").each ->
			if @name == "movie"
				movie = @value
			else if @name == "FlashVars"
				fv = @value
		if movie? && fv?
			if movie.indexOf("showarmy.swf") != -1
				for j,idx in fv.split(/\^/) when idx != 0
					tt = j.split(/\|/)
					g_army.push(tt[0]+'|'+tt[1])
				obj_army = @
			else if movie.indexOf("showperks.swf") != -1
				g_perks.push false
				count = 0
				for j in fv.split(/\|/)
					count++
					if count%2==0 and j
						g_perks.push(j)
						if j == 'vitality'
							has_vitality = true
				obj_perk = @

	for a in g_army
		army_id = a.split(/\|/)[0]
		if army_id == 'empty' || army_id == ''
		else if army = get_army_info(army_id)
			if g_frac != false && g_frac != army[0] && army[0]
				g_frac = -1
			else if g_frac == -1
			else if g_frac == false
				g_frac = army[0]

make_tp = ->
	return if !g_frac || g_frac <= 0
	return if !obj_perk

	sum = 0
	currtree = false
	for cp in g_perks
		if cp == false
			currtree = false
		else
			cp = cp.replace(/\d+/, "")
			if perk_table[g_frac][cp]
				currtree = perk_table[g_frac][cp]
				sum += currtree
			else
				if currtree == false
					sum = -1
					break
				else
					sum += currtree

	newb = $('<b />')
	if sum == -1
		newb.html(text_err)
	else
		lvl = Math.ceil(sum / 5)+3
		lvl = 5 if (lvl < 5)
		newb.html(text_tp+': '+sum+' (= '+lvl+' lvl)')
	$(obj_perk).next().after(newb)

make_ath = ->
	return unless obj_army

	sum = 0
	unknown_creatures = []
	for _army in g_army
		[pic, count] = _army.split(/\|/)
		if !pic || pic == 'empty' || pic == '*english*'
		else if army = get_army_info(pic)
			if has_vitality
				sum += count * (army[1] + 2)
			else
				sum += count * army[1]
		else
			unknown_creatures[pic] = true

	if sum == -1
		inner = $('<div style="font-size:x-small" align="right">'+text_err+'</div>')
	else
		inner = $('<div style="font-size:x-small" align="right">'+text_hp+': '+sum+'</div>')
		unknown_array = []
		for i of unknown_creatures
			unknown_array.push(i)
			update_unknown('army', i)
		if unknown_array.length
			hint = text_unknown_creature.replace('%s', unknown_array.join(', '))
			inner.html(inner.html() + ' (<a href="javascript:alert(\''+hint+'\');" title="'+hint+'">?</a>)')
	$(obj_army).after(inner)

update_unknown = (type, obj) ->

main = ->
	log 111
	make_ap()
	log 222
	loop_objects()
	log 333
	make_tp()
	log 444
	make_ath()
	log 555

$ = unsafeWindow['jQuery']
if $?.version
	main()
else
	script = document.createElement('script')
	script.src = 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'
	document.getElementsByTagName('head')[0].appendChild(script)
	script.addEventListener('load', ->
		$ = unsafeWindow['jQuery']
		$.noConflict()
		main()
	, false)

