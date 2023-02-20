"
I am just a demo
"
Class {
	#name : #RSXmasExample,
	#superclass : #Object,
	#category : #'Roassal3-Experimental-Xmas2019'
}

{ #category : #accessing }
RSXmasExample >> background [
	<script: 'self new background open'>
	| v extent px perlin r period length |
	v := RSCanvas new.
	r := Random new.
	extent := self currentWorld extent * 0.79.
	period := 0.001.
	length := 700.
	v shouldClearBackground: false.
	v color: Color black.
	px := 0.
	perlin := NSPerlinNoise3 new octaves: 3.

	v addAll: ((1 to: extent y /6) collect: [:n |
		RSPolyline new
			width: 0.5
		] ).
	v newAnimation
		loops: extent x;
		duration: 10 milliSeconds;
		when: RSAnimationLoopEvent do: [
			v edges do: [ :e | | x y n points m |
				x := px.
				y := extent y * r next.
				n := perlin noise: x * period and: y * period.
				e color: ((Color h: -210 + (n * 600) s: 1 l: 8 * n * n * n) alpha: 0.05).

				points := OrderedCollection new.
				points add: x@y.
				m := 0.
				[ m < length and:  [y >= 0 and: [ y <= extent y ] ]] whileTrue: [
					n := perlin noise: x * period and: y * period.
					x := x + (n * 15) cos.
					y := y + (n * 15) sin.
					points add: x@y.
					m := m + 1 ].
				e controlPoints: points.
				].
			v signalUpdate.
			px := px + 10
			].

	v when: RSExtentChangedEvent do: [ v camera
		zoomToFit: v extent
		rectangle: (Rectangle floatCenter:  extent / 2 extent: extent) ].

	^ v
]

{ #category : #accessing }
RSXmasExample >> icon [
	| c |
	c := RSComposite new.
	c add: (RSSVGPath new
		svgPath: 'M7623 4050 c-877 -133 -1562 -810 -1708 -1690 -22 -134 -30 -392 -16
-525 43 -401 197 -775 448 -1085 72 -89 243 -257 328 -321 276 -211 584 -344
940 -406 139 -23 480 -24 620 0 451 78 847 283 1150 598 599 621 743 1539 365
2314 -262 536 -761 937 -1340 1078 -244 60 -544 74 -787 37z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M7685 4335 c-125 -16 -256 -43 -365 -77 l-75 -24 -5 -108 c-3 -59 -4
-109 -2 -111 1 -1 42 10 90 25 376 118 818 118 1195 0 l87 -28 0 109 0 109
-27 11 c-16 6 -87 26 -159 44 -238 61 -500 78 -739 50z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M7857 5079 c-225 -32 -398 -267 -359 -489 12 -66 47 -150 79 -189 19
-23 20 -23 121 -12 131 14 323 14 452 0 118 -13 117 -13 160 75 150 316 -106
664 -453 615z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M2310 6914 c-14 -2 -65 -9 -115 -15 -88 -11 -280 -55 -360 -83 l-40
-14 -3 -106 c-2 -67 1 -106 8 -106 5 0 58 14 117 30 220 62 315 75 568 74 175
0 253 -4 325 -18 114 -21 236 -51 308 -76 l52 -18 0 109 0 109 -27 11 c-69 26
-208 62 -313 80 -109 20 -454 35 -520 23z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M2406 7649 c-219 -36 -386 -269 -349 -484 12 -68 47 -154 79 -193 20
-24 20 -24 118 -12 86 11 279 10 531 -3 l40 -2 39 76 c88 173 55 370 -83 502
-69 66 -121 94 -210 113 -73 15 -93 16 -165 3z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M5585 8409 c-726 -37 -1395 -488 -1711 -1154 -130 -274 -193 -546
-197 -847 -2 -145 -2 -147 -22 -134 -131 86 -186 118 -299 171 -286 137 -553
196 -882 196 -784 -1 -1484 -445 -1828 -1161 -303 -630 -252 -1392 132 -1980
563 -863 1671 -1171 2598 -720 697 338 1144 1058 1144 1841 0 54 2 99 3 99 2
0 42 -25 88 -55 350 -230 826 -351 1242 -317 360 30 681 138 971 329 491 321
813 829 900 1418 22 144 22 413 1 564 -137 979 -958 1718 -1945 1753 -41 2
-129 0 -195 -3z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M5455 8675 c-117 -16 -250 -45 -355 -77 l-75 -24 -3 -111 -3 -110
111 33 c204 62 326 79 580 79 254 0 376 -17 580 -79 l111 -33 -3 110 -3 111
-75 24 c-266 83 -594 112 -865 77z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M5615 9416 c-129 -31 -241 -122 -298 -243 -30 -64 -32 -75 -32 -178
0 -105 2 -114 33 -175 54 -108 44 -103 163 -89 99 11 443 7 529 -7 33 -5 37
-2 62 38 161 260 19 593 -280 657 -65 14 -112 13 -177 -3z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M2732 12573 c-144 -71 -81 -285 81 -274 142 9 175 209 47 273 -43 22
-85 22 -128 1z';
		yourself).
	c add: (RSSVGPath new
		svgPath: 'M2440 12600 l0 -200 -24 -15 c-39 -26 -59 -80 -53 -141 l5 -52 -41
-17 c-193 -77 -532 -199 -579 -208 -103 -19 -228 18 -331 97 -31 24 -49 32
-51 24 -73 -245 -180 -459 -267 -532 -69 -58 -127 -79 -229 -84 -69 -3 -110 0
-150 12 -29 9 -54 16 -55 16 -1 0 0 -42 3 -94 6 -121 -15 -219 -73 -334 -78
-156 -218 -294 -332 -328 -65 -20 -140 -17 -192 6 -53 24 -58 25 -39 3 91
-104 102 -313 29 -550 -65 -212 -76 -381 -36 -549 26 -114 65 -184 65 -120 0
44 68 163 122 210 118 107 339 163 516 132 91 -16 152 -42 218 -92 l44 -34 0
68 c0 267 218 549 477 617 54 14 231 22 264 11 8 -2 27 -7 44 -11 28 -6 29 -6
13 12 -8 10 -25 37 -37 61 -77 152 49 474 219 563 37 20 59 24 125 23 76 -1
103 -8 187 -52 4 -2 -13 26 -36 63 -49 74 -100 215 -117 326 -18 119 -7 308
25 399 14 41 26 76 26 77 0 9 230 103 253 103 4 0 7 -961 7 -2135 l0 -2135 45
0 45 0 0 1575 0 1575 68 0 c115 0 224 -37 296 -100 110 -97 187 -319 165 -478
-13 -93 -51 -151 -124 -190 l-30 -16 80 -8 c329 -31 586 -203 716 -481 61
-132 80 -300 46 -409 -8 -27 -14 -48 -13 -48 1 0 29 10 61 21 42 15 93 23 169
27 175 8 313 -26 501 -121 121 -62 235 -167 278 -258 28 -59 50 -169 40 -197
-13 -35 49 34 93 104 98 157 130 289 120 494 -3 74 -9 161 -13 194 l-6 59 49
-8 c162 -25 270 -23 499 9 197 28 501 19 644 -18 l49 -12 7 69 c14 148 74 272
185 387 157 163 364 250 592 250 84 0 201 -13 236 -25 16 -6 -40 -55 -112
-101 -25 -16 -46 -31 -45 -34 0 -3 27 -24 59 -47 164 -117 249 -329 237 -588
-5 -119 -31 -218 -73 -291 -34 -57 -124 -141 -181 -167 l-48 -22 90 -6 c248
-20 419 -133 532 -354 59 -116 131 -231 164 -261 19 -17 19 -50 19 -1556 l0
-1538 45 0 45 0 0 1490 c0 820 3 1490 6 1490 3 0 20 -11 37 -24 42 -31 128
-74 196 -97 30 -11 55 -19 56 -19 1 0 -14 32 -34 71 -30 60 -36 83 -39 158 -7
138 31 253 135 408 134 200 303 331 481 373 l52 12 -59 64 c-117 125 -167 282
-159 494 11 263 131 473 378 661 l33 25 -36 -4 c-58 -7 -135 25 -188 78 -89
89 -155 278 -147 420 9 149 100 279 247 353 l70 35 -62 7 c-214 23 -440 146
-569 309 l-41 51 52 7 c103 12 157 106 117 202 -36 86 -151 112 -225 50 -56
-47 -44 2 46 177 99 193 73 173 267 210 l99 19 41 -27 c98 -68 181 -172 255
-319 59 -120 81 -203 88 -331 l6 -112 29 44 c86 130 222 179 365 131 67 -22
190 -102 249 -161 60 -60 97 -141 97 -212 l0 -54 36 33 c142 133 326 195 496
168 212 -34 402 -150 486 -298 26 -45 39 -53 39 -24 0 42 62 146 123 205 76
75 150 120 262 159 187 64 344 41 467 -70 l41 -37 -7 43 c-16 103 -84 256
-158 357 -24 33 -89 101 -143 150 -254 230 -324 337 -325 495 l0 65 -28 -42
c-105 -158 -331 -171 -597 -34 -97 50 -229 182 -273 273 l-33 67 -59 -59 c-86
-86 -163 -122 -270 -128 -77 -4 -93 -1 -165 27 -92 35 -256 139 -362 229 l-72
61 -7 -32 c-22 -102 -125 -234 -217 -280 -46 -22 -247 -70 -592 -140 l-70 -14
-22 48 c-25 56 -57 80 -116 86 -83 10 -149 -42 -162 -127 -7 -43 -91 -220
-105 -220 -5 0 -10 18 -10 40 0 22 4 40 9 40 21 0 54 73 53 116 0 43 -33 114
-53 114 -5 0 -9 81 -9 190 l0 190 -45 0 -45 0 0 -174 0 -173 -31 -7 c-41 -8
-96 -67 -105 -111 -13 -72 30 -146 97 -166 l40 -12 -3 -120 -3 -120 -280 -73
c-338 -88 -395 -98 -492 -84 -60 8 -160 35 -171 45 -2 2 18 32 46 67 62 80
117 162 106 156 -5 -2 -39 -19 -76 -37 -115 -56 -253 -54 -400 5 -172 70 -332
203 -393 328 -38 77 -57 164 -48 223 l5 38 -36 -52 c-87 -126 -214 -183 -411
-183 -283 0 -541 137 -632 336 l-23 52 -88 -87 c-181 -179 -360 -226 -582
-152 -105 35 -244 106 -356 182 -40 27 -75 49 -78 49 -2 0 -10 -17 -16 -37
-26 -82 -86 -179 -150 -244 -104 -105 -122 -113 -587 -264 -112 -36 -207 -65
-213 -65 -5 0 -21 17 -34 38 -28 44 -78 72 -130 72 -41 0 -154 67 -221 130
-22 21 -50 41 -62 45 -23 6 -23 8 -23 201 l0 194 -45 0 -45 0 0 -200z m839
-730 c14 -10 37 -30 50 -44 l25 -26 -35 6 c-101 20 -409 126 -409 141 0 3 7
11 16 18 13 9 47 3 172 -32 85 -24 167 -52 181 -63z m-657 52 c144 -85 158
-94 168 -112 8 -15 4 -17 -38 -13 -157 14 -223 -184 -90 -268 40 -24 127 -22
156 4 10 9 21 17 23 17 13 0 -15 -154 -42 -235 -42 -126 -101 -225 -191 -319
l-77 -81 -1 528 c0 290 2 527 4 527 3 0 42 -22 88 -48z m5422 -121 c-10 -14
-29 -44 -43 -65 l-26 -40 -3 43 c-3 36 1 48 23 71 17 18 33 26 46 23 19 -5 19
-7 3 -32z m-164 -176 c0 -40 -5 -50 -54 -102 -30 -32 -56 -56 -59 -53 -12 12
34 123 64 159 19 22 37 40 42 40 4 1 7 -19 7 -44z m-3620 -333 c140 -68 238
-194 228 -294 -3 -30 -6 -33 -33 -31 -53 4 -167 68 -228 129 -53 53 -122 170
-142 241 l-6 22 53 -15 c29 -9 87 -32 128 -52z m2099 64 c-10 -9 -89 -46 -89
-41 0 6 72 44 84 45 5 0 7 -2 5 -4z m-1081 -126 c125 -21 249 -76 330 -146
l52 -46 0 -113 0 -113 -80 -76 c-181 -170 -398 -226 -564 -145 -22 10 -41 19
-42 19 -2 0 13 -23 32 -51 73 -108 88 -264 40 -414 -14 -44 -29 -85 -34 -92
-11 -18 -108 61 -171 139 -173 212 -229 488 -141 692 11 26 20 50 20 52 0 2
-33 4 -74 4 -84 0 -138 9 -134 21 2 5 41 41 87 79 100 83 233 152 346 179 90
22 235 27 333 11z m2133 -620 c26 -170 -8 -297 -118 -435 -20 -24 -25 -26 -40
-14 -73 61 -68 238 11 374 42 72 118 167 127 158 4 -4 13 -42 20 -83z';
		yourself).
	c adjustToChildren.
	c position: 0@0.
	c scaleBy: 1@ -1.
	^ c
]

{ #category : #accessing }
RSXmasExample >> myIcon [
	<script: 'self new myIcon open'>
	| canvas c r paint |
	canvas := RSCanvas new.
	canvas color: Color transparent.
	c := self icon.
	r := c encompassingRectangle.
	paint := (LinearGradientPaint fromArray: { 0-> 'white'. 1-> 'red' })
		start: r topRight;
		stop: r bottomRight.
	canvas add: c.
	c shapes do: [ :s | s paint: paint ].
	canvas camera zoomToFit: 400@400.
	canvas newAnimation
		duration: 30 seconds;
		scale: (NSScale linear
			domain: #(0 0.5 1);
			range: { 0@0. 0@ -1500. 0@0});
		on: c set: #position:.


	^ canvas
]

{ #category : #running }
RSXmasExample >> run [
	<script: 'self new run'>
	| full background tree icon title world |
	full := Morph new.
	full color: Color black.
	world := self currentWorld.
	background := self background createMorph.
	tree := self tree createMorph.
	icon := self myIcon createMorph.
	title := self title createMorph.
	"full addMorph: background."
	full addMorph: tree.
	full addMorph: icon.
	full addMorph: title.
	background extent: world extent * 0.8.
	tree extent: 500@500.
	tree position: 0@(background extent y - 500).

	icon extent: 500@400.
	icon position: (background extent x - 500)@0.
	title extent: 600@ 400.
	title position: (background extent / 2) - (title extent / 2).
	(full openInWindowLabeled: '2020') position: 100 asPoint
]

{ #category : #accessing }
RSXmasExample >> title [
	<script: 'self new title open'>
	| canvas title t2020 |
	canvas := RSCanvas new.
	canvas color: Color transparent.

	title := RSLabel new
		text: 'Happy New Year';
		"fontName: 'Brushcrazy DEMO';"
		color: Color white;
		fontSize: 50;
		yourself.
	t2020 := RSLabel new
		text: '2020!';
		"fontName: 'Brushcrazy DEMO';"
		color: Color white;
		fontSize: 100;
		yourself.
	canvas add: title.
	canvas add: t2020.
	canvas newAnimation repeat
		duration: 10 seconds;
		scale: (NSScale linear
			domain: #(0 0.5 1);
			range: { 0.8. 1. 0.8 } );
		onStepDo: [:t |
			title matrix
				loadIdentity
				scaleBy: t.
			t2020 matrix
				loadIdentity
				translation: 0@80;
				scaleBy: t.
			canvas signalUpdate ].


	^ canvas
]

{ #category : #running }
RSXmasExample >> tree [
	<script: 'self new tree open'>
	| canvas tree |
	canvas := RSCanvas new.
	canvas color: Color transparent.
	tree := RSXmasTree new.
	tree renderIn: canvas.
	canvas newAnimation repeat
		onStepDo: [ :t |
			tree swing.
			tree updateCanvas: canvas.
			canvas signalUpdate ].
	^ canvas
]
