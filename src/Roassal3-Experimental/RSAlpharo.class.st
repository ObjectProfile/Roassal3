"
TODO
"
Class {
	#name : #RSAlpharo,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'objects',
		'jarShape',
		'amebas',
		'perlin',
		'layout',
		'random',
		'redLine'
	],
	#category : #'Roassal3-Experimental-Alpharo'
}

{ #category : #hooks }
RSAlpharo >> addGravityAnimation [
	| box edges mock |
	box := RSBox new.
	edges := shapes collect: [ :s | RSLine new from: s; to: box ].
	layout length: 100.
	layout alpha: 0.005.
	layout addNodes: { box }.
	layout addLines: edges.
	mock := layout mockElementAt: box.
	mock isFixed: true.
	mock fixPosition: 0@0.
	self canvas newAnimation repeat onStepDo: [ | p |
		p := self canvas camera fromPixelToSpace: self mousePosition.
		mock fixPosition: p.
		box translateTo: p]
]

{ #category : #hooks }
RSAlpharo >> blinkRandomAmeba [
	| ameba |
	random next> 0.05 ifTrue: [ ^ self ].
	ameba := amebas atRandom.
	ameba isBlinking ifTrue: [ ^ self ].
	ameba blink
]

{ #category : #initialization }
RSAlpharo >> initialize [
	super initialize.
	perlin := NSPerlinNoise3 new octaves: 3.
	random := Random new
]

{ #category : #hooks }
RSAlpharo >> jar [
	^ jarShape ifNil: [ jarShape :=  RSSVGPath new
		svgPath: self jarPath;
		color: Color black;
		scaleBy: 0.1@ -0.1;
		position: 0@0;
		yourself ]
]

{ #category : #hooks }
RSAlpharo >> jarPath [
	^ 'M2165 4344 c-49 -2 -199 -11 -332 -19 -346 -22 -537 -49 -563 -80
-12 -15 -8 -193 5 -253 6 -26 2 -43 -16 -75 -30 -54 -31 -119 -3 -173 l22 -41
-34 -18 c-46 -25 -52 -50 -20 -84 l27 -28 -42 -12 c-49 -15 -95 -57 -105 -96
-10 -40 12 -99 50 -132 29 -27 32 -32 20 -48 -8 -10 -14 -34 -14 -53 0 -29 10
-44 61 -95 76 -77 93 -108 93 -177 0 -72 -19 -107 -114 -206 -80 -84 -122
-155 -140 -241 -7 -31 -10 -329 -8 -858 l3 -810 23 -47 c13 -26 50 -75 82
-109 44 -47 59 -71 63 -100 10 -74 73 -131 211 -188 296 -123 792 -191 1394
-191 657 0 1175 77 1453 216 105 52 159 108 159 163 0 11 17 35 37 53 67 59
104 102 131 153 l27 50 3 804 c2 520 -1 823 -8 860 -17 96 -65 176 -165 281
-107 110 -115 123 -115 185 0 61 21 99 91 165 49 46 59 61 59 88 0 18 -5 43
-11 54 -9 17 -6 25 19 52 40 42 52 68 52 112 0 30 -7 44 -40 76 -23 21 -47 38
-55 38 -22 0 -19 7 16 38 39 34 34 61 -15 87 l-34 18 21 40 c30 57 27 124 -8
183 -27 45 -27 48 -11 81 21 44 23 225 3 242 -35 28 -254 58 -607 82 -154 10
-1464 20 -1665 13z m344 -28 c-2 -2 -128 -9 -279 -15 -371 -16 -580 -35 -563
-52 27 -27 555 -49 1183 -49 635 0 1166 22 1193 49 17 17 -218 37 -593 51
-162 7 -297 14 -300 17 -7 8 485 -6 670 -18 220 -15 292 -31 264 -59 -73 -73
-1754 -94 -2323 -29 -102 12 -141 22 -141 39 0 17 40 28 146 40 143 16 756 38
743 26z m-899 -451 c241 -36 779 -65 1210 -65 456 0 1004 31 1284 71 76 11
141 17 144 14 3 -3 1 -5 -4 -5 -5 0 -42 -7 -82 -15 -529 -111 -1561 -138
-2257 -59 -162 18 -366 52 -420 70 -39 14 -39 14 -5 8 19 -2 78 -11 130 -19z
m12 -235 c292 -43 539 -55 1183 -55 609 0 774 6 1125 41 84 9 190 22 235 30
87 15 101 17 93 9 -21 -21 -451 -83 -743 -107 -216 -18 -1165 -18 -1365 0
-311 27 -687 85 -709 108 -3 4 8 4 24 0 17 -4 87 -16 157 -26z m-80 -129 c639
-120 2045 -117 2663 5 94 19 183 14 238 -12 42 -20 53 -46 38 -86 -27 -71
-230 -113 -663 -140 -278 -17 -1690 -16 -1973 1 -444 26 -634 67 -666 143 -22
53 24 92 127 107 68 11 91 9 236 -18z m-180 -246 c225 -48 613 -65 1464 -65
873 0 1247 17 1491 67 67 14 84 15 97 4 26 -22 19 -35 -44 -90 -71 -62 -114
-82 -246 -115 -623 -155 -1960 -155 -2587 0 -127 32 -190 62 -256 122 -48 44
-52 51 -42 71 14 25 27 26 123 6z m118 -246 c149 -44 434 -86 750 -111 220
-17 991 -17 1210 0 361 29 691 83 821 136 13 6 15 -3 16 -56 0 -90 20 -128
122 -226 107 -106 147 -175 162 -290 6 -49 9 -355 7 -832 l-3 -755 -23 -46
c-13 -26 -53 -75 -92 -112 -48 -44 -72 -74 -76 -96 -7 -34 -1 -31 -163 -71
-91 -23 -112 -21 -57 5 51 24 86 69 86 110 0 127 -298 234 -810 291 -192 21
-812 30 -1021 15 -457 -34 -823 -117 -939 -213 -99 -82 -53 -177 119 -244 l36
-14 -41 5 c-46 5 -197 48 -250 70 -35 14 -38 18 -49 68 -3 16 -32 57 -64 91
-105 113 -96 22 -99 910 -2 507 1 798 8 835 16 87 56 158 140 246 103 107 114
130 115 233 0 69 2 81 15 76 8 -3 44 -15 80 -25z m1910 -2119 c481 -43 810
-136 810 -228 0 -44 -104 -108 -249 -152 -260 -81 -1239 -124 -1801 -80 -293
24 -638 131 -681 212 -14 25 12 63 61 92 124 73 465 137 885 165 169 12 814 6
975 -9z'
]

{ #category : #hooks }
RSAlpharo >> mousePosition [
	^ amebas anyOne mousePosition
]

{ #category : #accessing }
RSAlpharo >> objects: aCollection [
	objects := aCollection
]

{ #category : #hooks }
RSAlpharo >> removeJar [
	| animation |
	jarShape ifNil: [ ^ self ].
	(jarShape hasProperty: #anime) ifTrue: [ ^ self ].
	animation := jarShape newAnimation
		duration: 1 second;
		from: jarShape color;
		to: Color transparent;
		on: jarShape set: #color:;
		when: RSAnimationEndEvent do: [ :evt |
			layout enclosingRectangle: jarShape canvas visibleRectangle.
			shapes do: [ :s | | p |
				p := s position.
				s matrix loadIdentity.
				s translateTo: p ].
			jarShape remove.
			jarShape := nil.
			self addGravityAnimation.
			  ];
		yourself.
	jarShape propertyAt: #anime put: animation
]

{ #category : #hooks }
RSAlpharo >> renderIn: aCanvas [
	aCanvas inspectorContext: RSEmptyContextInteraction new.
	amebas := objects collect: [ :obj |
		RSAmeba new
			model: obj;
			offset: random next;
			yourself ] as: RSGroup.
	shapes := amebas collect: #shape.

	self setupLayoutIn: aCanvas.
	self setAnimationsIn: aCanvas.
	aCanvas addAll: shapes.
	aCanvas add: self jar.
	aCanvas when: RSMouseClick send: #removeJar to: self
]

{ #category : #hooks }
RSAlpharo >> setAnimationsIn: aCanvas [
	"we create 3 different animations, then we can pause one animation with out affectin others"
	aCanvas newAnimation repeat
		onStepDo: [ layout step ].

	aCanvas newAnimation repeat
		onStepDo: [ amebas do: [:ameba | ameba update: perlin ] ].

	aCanvas newAnimation repeat
		onStepDo: [ self blinkRandomAmeba ].

	aCanvas newAnimation repeat
		onStepDo: [ self updateRedLine ]
]

{ #category : #hooks }
RSAlpharo >> setupLayoutIn: aCanvas [
	| jar |
	jar := self jar.
	shapes do: [ :s | s scaleBy: 0.4 ].
	RSGridLayout on: shapes.
	shapes translateTo: jar position.
	layout := RSRectangleForceLayout new
		enclosingRectangle: (Rectangle center: 0@50 extent: jar width * (0.5@ 0.4));
		charge: -400;
		gravity: 0.05;
		strength: 0.2;
		addNodes: shapes;
		alpha: 0.8;
		yourself
]

{ #category : #hooks }
RSAlpharo >> updateRedLine [
	| trace position |
	redLine ifNil: [
		redLine := RSComposite new.
		redLine isFixed: true.
		redLine propertyAt: #trace put: OrderedCollection new.
		self canvas add: redLine ].
	redLine children copy do: #remove.
	trace := redLine propertyAt: #trace.
	position := self mousePosition.
	trace add: position.
	trace size > 30 ifTrue: [ trace removeFirst ].
	1 to: trace size - 1 do: [ :i | | p1 p2 |
		p1 := trace at: i.
		p2 := trace at: i + 1.
		redLine add: (RSLine new
			startPoint: p1;
			endPoint: p2;
			color: (Color red alpha: i/trace size)  ) ]
]
