Hashtable = require './hashtable'

N = 10100100
AGE = [10001000, 10001100]
ages = new Int32Array N
wealth = new Float64Array N

for i in [0...N]
 r = Math.random()
 ages[i] = AGE[0] + Math.floor r * (AGE[1] - AGE[0])
 wealth[i] = 10 * Math.random()

console.log 'initialized'

wealthHashtable = new Hashtable reserved: 3
console.time 'Hashtable'
for i in [0...N]
 n = ages[i]
 wealthHashtable.set n, (wealthHashtable.get n) + wealth[i]
console.timeEnd 'Hashtable'

wealthObject = {}
console.time 'Object'
for i in [0...N]
 n = ages[i]
 wealthObject[n] ?= 0
 wealthObject[n] += wealth[i]
console.timeEnd 'Object'

console.time 'json'
json = wealthHashtable.toJSON()
console.timeEnd 'json'

for k, v of wealthObject
 if 1e-2 < Math.abs json[k] - v
  console.error 'mismatch json', k, json[k], v
for k, v of json
 if 1e-2 < Math.abs wealthObject[k] - v
  console.error 'mismatch', wealthObject[k], v

