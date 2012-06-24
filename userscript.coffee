
#$ = undefined
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

ls_addkey = 'hwm_plinfo_enchancer|'
getValue = (key, def) ->
	return def unless localStorage?
	try
		item = localStorage.getItem(ls_addkey+key)
		return item ? def
	catch err
		return def

setValue = (key, def) ->
	return unless localStorage?
	try
		item = localStorage.setItem(ls_addkey+key, def)

removeValue = (key) ->
	return unless localStorage?
	try
		item = localStorage.removeItem(ls_addkey+key)

get_art_info = (art) ->
	if ap_table[art]?
		ap_table[art]
	else
		ret = getValue('ap_'+art, "")
		ret = ret.split(',')
		ret.map (x)->Number(x)

get_army_info = (army) ->
	if army_table[army]?
		army_table[army]
	else
		ret = getValue('army_'+army, "")
		ret = ret.split(',')
		ret.map (x)->Number(x)

make_ap = ->
	left_td = undefined
	arts_td = undefined

	$('img').each ->
		if @.src.indexOf('/i/s_initiative.gif') != -1 && !left_td?
			left_td = @.parentNode.parentNode.parentNode
			left_td = undefined if $(left_td).find('img').length < 7
		else if (@.src.match(/\/i\/transport\/\d\.jpg/))
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
				if Number(@.parentNode.getAttribute("colspan")) == 5
					sum_cr = 0
					if m2 = @.childNodes[0].title.match /\[(([A-Z]\d{1,2})+)\]/
						for ii in m2[0].match(/\d{1,2}/g)
							sum_cr += Number(ii)
						unknown_cost = true

					[ap, cost] = get_art_info(m[1])
					ap = 0 unless ap
					cost = 0 unless cost
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
					[ap, cost] = get_art_info(m[1])
					ap = 0 unless ap
					cost = 0 unless cost
					if ap
						sum_ap += ap
					else
						unknown_art[m[1]] = true

					if (cost == 0) then unknown_cost = true
					sum_cost += cost

	# adding
	image = """data:image/png;base64,
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
U5ErkJggg=="""
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
		newtr.find('b').after(' (<a href="javascript:alert(\''+hint+'\');" title="'+hint+'">?</a>)')
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
	try
		log('!!', arguments)
		curr = String(Math.floor((new Date()).getTime()/1000))
		log '1'
		prevup = getValue('upd_'+type+'_'+obj, '0')
		log '2'
		return if (Math.abs(curr-prevup) < 60*60*24)
		log '3'
		setValue('upd_'+type+'_'+obj, curr)
		log '4'
		if (getValue('upd_'+type+'_'+obj, '0') != curr)
			log 'didnt write!'
			return
		log '5'
		xhr = new XMLHttpRequest()
		log '6'
		xhr.open('GET', "http://upd.kocharin.ru/update_plinfo.pl?type=#{escape(type)}&obj=#{escape(obj)}&v=#{version()}", true)
		log '7'
		xhr.onreadystatechange = ->
			log(arguments)
			try
				return unless xmlhttp.readyState == 4
				return unless xmlhttp.status == 200
				alert(xmlhttp.responseText)
				result = JSON.parse(response.responseText)
				if result.status == 'ok'
					removeValue("upd_#{type}_#{obj}")
					setValue("#{type}_#{obj}", result.reply.join(','))
		xhr.send()
	catch err
		log(err)

do main = ->
	make_ap()
	loop_objects()
	make_tp()
	make_ath()

#$ = unsafeWindow['jQuery']
#if $?.version
#	main()
#else
#	script = document.createElement('script')
#	script.src = 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'
#	document.getElementsByTagName('head')[0].appendChild(script)
#	script.addEventListener('load', ->
#		$ = unsafeWindow['jQuery']
#		$.noConflict()
#		main()
#	, false)

