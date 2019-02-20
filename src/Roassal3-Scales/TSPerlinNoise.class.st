"
Based on http://webstaff.itn.liu.se/~stegu/simplexnoise/simplexnoise.pdf
"
Class {
	#name : #TSPerlinNoise,
	#superclass : #TSObject,
	#instVars : [
		'grad3',
		'perm'
	],
	#category : #'Roassal3-Scales'
}

{ #category : #private }
TSPerlinNoise >> dot: arr and: x and: y [
	^ (arr first * x) + (arr second * y)
]

{ #category : #accessing }
TSPerlinNoise >> grad3At: index [
	^ grad3 at: index + 1
]

{ #category : #initialization }
TSPerlinNoise >> initialize [
	| p |
	super initialize.
	grad3 := #( 
		#(1 1 0) 
		#(-1 1 0) 
		#(1 -1 0)
		#(-1 -1 0)
		#(1 0 1)
		#(-1 0 1)
		#(1 0 -1)
		#(-1 0 -1)
		#(0 1 1)
		#(0 -1 1)
		#(0 1 -1)
		#(0 -1 -1)).
		
	p := #(151 160 137 91 90 15 131 13 201 95 96 53 194 233 7 225 140 36 103 30 69 142 8 99 37 240 21 10 23 190 6 148 247 120 234 75 0 26 197 62 94 252 219 203 117 35 11 32 57 177 33 88 237 149 56 87 174 20 125 136 171 168 68 175 74 165 71 134 139 48 27 166 77 146 158 231 83 111 229 122 60 211 133 230 220 105 92 41 55 46 245 40 244 102 143 54 65 25 63 161 1 216 80 73 209 76 132 187 208 89 18 169 200 196 135 130 116 188 159 86 164 100 109 198 173 186 3 64 52 217 226 250 124 123 5 202 38 147 118 126 255 82 85 212 207 206 59 227 47 16 58 17 182 189 28 42 223 183 170 213 119 248 152 2 44 154 163 70 221 153 101 155 167 43 172 9 129 22 39 253 19 98 108 110 79 113 224 232 178 185 112 104 218 246 97 228 251 34 242 193 238 210 144 12 191 179 162 241 81 51 145 235 249 14 239 107 49 192 214 31 181 199 106 157 184 84 204 176 115 121 50 45 127 4 150 254 138 236 205 93 222 114 67 29 24 72 243 141 128 195 78 66 215 61 156 180).
	perm := Array new: 512.
	1 to: 256 do: [ :i | | v |
		v := p at: i.
		perm at: i put: v.
		perm at: i + 256 put: v ].
	
]

{ #category : #public }
TSPerlinNoise >> noise: xin and: yin [
	"all this proces explained in http://webstaff.itn.liu.se/~stegu/simplexnoise/simplexnoise.pdf"
	| f2 s i j g2 t xzero yzero x0 y0 i1 j1 x1 y1 x2 y2 ii jj gi0 gi1 gi2 t0 n0 t1 n1 t2 n2 |
	f2 := 0.5 * (3 sqrt - 1).
	s := (xin + yin) * f2.
	i := (xin + s) floor.
	j := (yin + s) floor.
	g2 := (3 - 3 sqrt) / 6.
	t := (i + j) * g2.
	xzero := i - t.
	yzero := j - t.
	x0 := xin - xzero.
	y0 := yin - yzero.
	x0 > y0 ifTrue: [ 
		i1 := 1.
		j1 := 0 ]
		ifFalse: [ 
		i1 := 0.
		j1 := 1 ].
	x1 := x0 - i1 + g2.
	y1 := y0 - j1 + g2.
	x2 := x0 - 1 + (2* g2).
	y2 := y0 - 1 + (2* g2).
	
	ii := i & 255.
	jj := j & 255.
	
	gi0 := (self permAt: ii + (self permAt: jj)) % 12.
	gi1 := (self permAt: ii + i1 + (self permAt: jj + j1)) % 12.
	gi2 := (self permAt: ii + 1 + (self permAt: jj + 1) ) % 12.
	
	t0 := 0.5 - (x0 * x0) - (y0 * y0).
	t0 < 0 ifTrue: [ n0 := 0 ] ifFalse: [ 
		t0 := t0 * t0.
		n0 := t0 * t0 * (self dot: (self grad3At: gi0) and: x0 and: y0 ) ].
	t1 := 0.5 - (x1*x1) - (y1 * y1).
	t1 < 0 ifTrue: [ n1 := 0 ] ifFalse: [ 
		t1 := t1 * t1.
		n1 := t1 * t1 * (self dot: (self grad3At: gi1) and: x1 and: y1 ) ].
	t2 := 0.5 - (x2 * x2) - (y2 * y2).
	t2 < 0 ifTrue: [ n2 := 0 ] ifFalse: [ 
		t2 := t2 * t2.
		n2 := t2 * t2 * (self dot: (self grad3At: gi2) and: x2 and: y2) ].
	^ 70.0 * (n0 + n1 + n2).
	



]

{ #category : #accessing }
TSPerlinNoise >> permAt: index [
	^ perm at: index + 1
]
