"
based on https://www.openprocessing.org/sketch/85954
"
Class {
	#name : #RSAlgoritmia,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'extent',
		'degs',
		'nRadius',
		'outRadius',
		'totalTweens',
		'inBetween',
		'circleNumber',
		'perlin',
		'models',
		'rand',
		'radii',
		'frameCount',
		'masterX',
		'masterY',
		'cos',
		'color',
		'border',
		'animation'
	],
	#category : #'Roassal3-Experimental-Animations'
}

{ #category : #update }
RSAlgoritmia >> cosInterpolateA: val1 withB: val2 at: amt [
	^ val1 interpolateTo: val2 at: (cos scale: (amt * Float pi) cos)
]

{ #category : #update }
RSAlgoritmia >> doInterpolateA: cOne withB: cTwo inT: beTwixt [
	^ (1 to: degs) collect: [ :j |
		(self
			cosInterpolateA: (cOne at: j)
			withB: (cTwo at: j)
			at: beTwixt) ]
]

{ #category : #update }
RSAlgoritmia >> doSimpleOutline: myCircle [
	| points polygon n |
	masterX := masterX + 3.
	border color: (Color
		h: (color scale: masterX)
		s: 1
		v: 0.7).
	points := (1 to: degs) collect: [:j |
		n := j degreesToRadians.
		n := n sin @ n cos.
		n * (myCircle at: j)
		].
	polygon := RSPolygon new
		noPaint;
		border: border;
		points: points;
		yourself.
	canvas add: (RSComposite new
		addShape: polygon;
		adjustToChildren;
		translateTo: (masterX @ masterY) - (extent / 2);
		rotateByDegrees: frameCount + 0.95125;
		yourself)
]

{ #category : #initialization }
RSAlgoritmia >> initialize [
	super initialize.
	"change this variables to get a different result"
	extent := 1200@600.
	degs := 360.
	nRadius := 1.300.
	outRadius := 321.
	totalTweens := 27.
	inBetween := 0.0.
	circleNumber := 1.
	perlin := NSPerlinNoise3 new octaves: 2.
	models := 199.
	rand := 3.

	radii := Array new: models.
	frameCount := 0.
	masterX := -300.
	masterY := extent y / 2.

	cos := NSScale linear
		domain: { 1. -1 }.
	color := NSScale linear
		domain: { extent x / -2. extent x / 2 };
		range: #(80 300).
	border := RSBorder new.

	"call again these methods if necessary "
	self initializeCircles.
	self initializeCanvas
]

{ #category : #initialization }
RSAlgoritmia >> initializeCanvas [

	canvas := RSCanvas new.
	canvas shouldClearBackground: false.
	animation := canvas newAnimation
		repeat;
		onStepDo: [:t | self step ]
]

{ #category : #initialization }
RSAlgoritmia >> initializeCircles [
	1 to: models do: [ :i | | zz |
		zz := rand atRandom.
		radii at: i put: (self newCircleX: zz y: zz -1 ) ]
]

{ #category : #initialization }
RSAlgoritmia >> newCircleX: nXstart y: nYstart [
	| n |
	^ (1 to: degs) collect: [ :i |
		n := i degreesToRadians.
		n := n sin @ n cos.
		n := n * nRadius + (nXstart @ nYstart).
		n := (perlin noise: n x and: n y).
		n := n * outRadius.
		n ]
]

{ #category : #'instance creation' }
RSAlgoritmia >> open [
	canvas open
		setLabel: 'Algoritmia';
		extent: extent
]

{ #category : #running }
RSAlgoritmia >> run01 [
	<script: 'self new run01'>
	self open
]

{ #category : #running }
RSAlgoritmia >> run02 [
	<script: 'self new run02'>
	perlin := NSPerlinNoise3 new octaves: 1.
	color := NSScale linear
		domain: { extent x / -2. extent x / 2 };
		range: #(150 80 ).
	self initializeCircles.
	self open
]

{ #category : #running }
RSAlgoritmia >> run03 [
	<script: 'self new run03'>
	nRadius := 3.
	self initializeCircles.
	outRadius := 200.
	totalTweens := 17.
	self open
]

{ #category : #update }
RSAlgoritmia >> step [
	frameCount := frameCount + 1.
	canvas shapes copy do: #remove.
	masterX > 1500 ifTrue: [
		masterX := -225.
		circleNumber := 5.
		inBetween := 0.
		animation stop ].

	(inBetween < totalTweens and: [ circleNumber + 1 < models ]) ifTrue: [
		| hybridCircle |
		hybridCircle := self
			doInterpolateA: (radii at: circleNumber)
			withB: (radii at: circleNumber + 1)
			inT: inBetween / totalTweens.
		self doSimpleOutline: hybridCircle.
		inBetween := inBetween + 1.
	] ifFalse: [
		circleNumber + 1 < models ifTrue: [
			circleNumber := circleNumber + 1.
			inBetween := 0.
		].
	]
]
