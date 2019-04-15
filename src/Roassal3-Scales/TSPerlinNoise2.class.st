"
Based on Ken Perlin
"
Class {
	#name : #TSPerlinNoise2,
	#superclass : #TSObject,
	#instVars : [
		'p'
	],
	#category : #'Roassal3-Scales-Noises'
}

{ #category : #public }
TSPerlinNoise2 >> fade: t [
	^ t * t * t * (t * (t * 6 - 15) + 10 )
]

{ #category : #public }
TSPerlinNoise2 >> grad: hash x: x y: y z: z [
	| h u v |
	h := hash & 15.
	u := h < 8
		ifTrue: [ x ]
		ifFalse: [ y ].
	v := h < 4
		ifTrue: [ y ]
		ifFalse: [ ((h = 12) or: [ h = 14 ])
				ifTrue: [ x ]
				ifFalse: [ z ] ].
	^ (h & 1 = 0
		ifTrue: [ u ]
		ifFalse: [ u negated ])
		+
			((h & 2) = 0
				ifTrue: [ v ]
				ifFalse: [ v negated ])
]

{ #category : #initialization }
TSPerlinNoise2 >> initialize [
	| permutation |
	super initialize.
	p := Dictionary new.
	permutation :=#(151 160 137 91 90 15 131 13 201 95 96 53 194 233 7 225 140 36 103 30 69 142 8 99 37 240 21 10 23 190 6 148 247 120 234 75 0 26 197 62 94 252 219 203 117 35 11 32 57 177 33 88 237 149 56 87 174 20 125 136 171 168 68 175 74 165 71 134 139 48 27 166 77 146 158 231 83 111 229 122 60 211 133 230 220 105 92 41 55 46 245 40 244 102 143 54 65 25 63 161 1 216 80 73 209 76 132 187 208 89 18 169 200 196 135 130 116 188 159 86 164 100 109 198 173 186 3 64 52 217 226 250 124 123 5 202 38 147 118 126 255 82 85 212 207 206 59 227 47 16 58 17 182 189 28 42 223 183 170 213 119 248 152 2 44 154 163 70 221 153 101 155 167 43 172 9 129 22 39 253 19 98 108 110 79 113 224 232 178 185 112 104 218 246 97 228 251 34 242 193 238 210 144 12 191 179 162 241 81 51 145 235 249 14 239 107 49 192 214 31 181 199 106 157 184 84 204 176 115 121 50 45 127 4 150 254 138 236 205 93 222 114 67 29 24 72 243 141 128 195 78 66 215 61 156 180).
	0 to: 255 do: [ :i |
		p at: 256 + i put: (p at: i put: (permutation at: i + 1) ) ]
]

{ #category : #public }
TSPerlinNoise2 >> lerp: t a: a b: b [
	^ t * (b - a) + a
]

{ #category : #public }
TSPerlinNoise2 >> noise: xin [
	^ self noise: xin y: 0 z: 0
]

{ #category : #public }
TSPerlinNoise2 >> noise: xin and: yin [
	^ self noise: xin y: yin z: 0
]

{ #category : #public }
TSPerlinNoise2 >> noise: xin y: yin z: zin [
	"(TSPerlinNoise2 new noise: 3.14 y: 42 z: 7) >>> 0.13691995878400012"
	| x0 y0 z0 x y z u v w a aa ab b ba bb |
	x0 := xin floor & 255.
	y0 := yin floor & 255.
	z0 := zin floor & 255.
	x := xin - xin floor.
	y := yin - yin floor.
	z := zin - zin floor.
	u := self fade: x.
	v := self fade: y.
	w := self fade: z.
	a := (p at: x0)+y0.
	aa := (p at: a)+z0.
	ab := (p at: a+1)+z0.
	b := (p at: x0+1)+y0.
	ba := (p at: b) + z0.
	bb := (p at: b+1) + z0.
	"result will cover the range [-1,1]"
	^ self lerp: w 
		a: (self lerp: v
			a: (self lerp: u 
				a: (self grad: (p at: aa) x: x 	y: y z: z)
				b: (self grad: (p at: ba) x: x-1	y: y z: z) )  
			b: (self lerp: u
				a: (self grad: (p at: ab) x: x 	y: y-1 z: z)
				b: (self grad: (p at: bb) x: x-1	y: y-1 z: z) ) )
		b: (self lerp: v
			a: (self lerp: u 
				a: (self grad: (p at: aa+1) x: x 	y: y z: z-1)
				b: (self grad: (p at: ba+1) x: x-1	y: y z: z-1) )  
			b: (self lerp: u
				a: (self grad: (p at: ab+1) x: x 	y: y-1 z: z-1)
				b: (self grad: (p at: bb+1) x: x-1	y: y-1 z: z-1) ) )
]

{ #category : #public }
TSPerlinNoise2 >> snoise: xin and: yin [
	"range #(0 1)"
	^((self noise: xin and: yin) + 1)/2
]
