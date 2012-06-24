#!/usr/bin/env coffee

require 'hotswap'
tables = require('../tables')
url = require 'url'
require('fleetutils/repl')((ctx) -> )
logger = require('fleetutils').logger

require('http').createServer((req, res) ->
	qs = url.parse(req.url, true).query
	type = qs.type
	what = qs.obj
	send = (status, rr) ->
		res.writeHead(status, {
			'Content-Type': 'application/json'
			'Access-Control-Allow-Origin': '*'
		})
		res.end(JSON.stringify(rr))
	logger.info({req:req}, 'incoming @{req.url}')

	if type is 'ap'
		if tables.ap_table[what]?
			send(200, {status:'ok', reply:tables.ap_table[what]})
		else
			send(202, {status:'nosuch'})
			logger.error({type, what}, 'no such art @{what}')
	else if type is 'army'
		if tables.army_table[what]?
			send(200, {status:'ok', reply:tables.army_table[what]})
		else
			send(202, {status:'nosuch'})
			logger.error({type, what}, 'no such army @{what}')
	else
		send(500, {error:':('})
).listen(3050, "127.0.0.1")

process.on 'uncaughtException', (err) ->
	console.log('Caught exception: ' + err)
	console.log(err.stack)

