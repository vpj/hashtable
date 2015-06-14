Hashtable = require './hashtable'

N = 20000000
AGE = [1000000, 1000100]
ages = new Int32Array N
wealth = new Float64Array N
str = new Array N

for i in [0...N]
 ages[i] = AGE[0] + parseInt Math.random() * (AGE[1] - AGE[0])
 wealth[i] = Math.random()
 str = "#{ages[i]}"

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

