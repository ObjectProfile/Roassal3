"
Based on https://es.wikipedia.org/wiki/Curva_de_Lissajous
"
Class {
	#name : #RSLissajous,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'nCircles',
		'color',
		'gap',
		'circleSize',
		'dotSize',
		'cell'
	],
	#category : #'Roassal3-Experimental-Animations'
}

{ #category : #building }
RSLissajous >> build [
	| rows columns |
	canvas color: Color black.
	rows := self createCirclesWith: [ :n | 0@n ].
	columns := self createCirclesWith: [ :n | n @ 0 ].

	rows do: [ :row |
		columns do: [ :column |
			self createAnimationFor: row and: column ] ]
]

{ #category : #animations }
RSLissajous >> createAnimationFor: row and: column [
	| col points combined e1 e2  p1 p2 delta dot |
	e1 := column shapes first.
	e2 := row shapes first.
	p1 := column shapes second.
	p2 := row shapes second.
	col := e1 borderColor mixed: 0.5 with: e2 borderColor.
	points := OrderedCollection new.
	delta := column position x @ row position y.
	combined := RSPolyline new
		controlPoints: points;
		color: col;
		yourself.
	dot := self createDot.
	dot size: dotSize /2.
	canvas add: combined.
	canvas add: dot.
	canvas newAnimation
		repeat;
		onStepDo: [ :t | | newPoint |
			newPoint := (p1 position x @ p2 position y) + delta.
			points add: newPoint.
			dot position: newPoint.
			combined controlPoints: points.
		]
]

{ #category : #shapes }
RSLissajous >> createBigCircleFor: aPoint [
	| group shape |
	group := RSGroup new.
	group add: (RSEllipse new
		model: aPoint;
		position: cell * aPoint;
		size: circleSize;
		noPaint;
		withBorder;
		borderColor: (color scale: aPoint x + aPoint y);
		yourself).
	shape := group asShape.
	self createLineAnimationFor: shape.
	^ shape
]

{ #category : #shapes }
RSLissajous >> createCirclesWith: aBlockClosure [
	| values shapes |
	values := (1 to: nCircles) collect: aBlockClosure.
	shapes := values collect: [ :p | self createBigCircleFor: p ].
	canvas addAll: shapes.
	^ shapes
]

{ #category : #animations }
RSLissajous >> createDot [
	^ RSEllipse new
		size: dotSize;
		color: Color white;
		withBorder;
		yourself
]

{ #category : #animations }
RSLissajous >> createLineAnimationFor: shape [
	| dot point index line |
	dot := self createDot.
	point := shape shapes first model.
	index := point x + point y.
	shape add: dot.
	line := self createLineFor: dot.
	canvas add: line.
	canvas newAnimation
		from: 450; to: 90;
		repeat;
		duration: (5 / index * 10) seconds;
		onStepDo: [ :t | | alpha position delta |
			alpha := t degreesToRadians.
			position :=  (alpha cos @ alpha sin negated) * (circleSize /2).
			dot position: position.
			delta := point x = 0
				ifTrue: [ cell * (nCircles + 0.5) @ position y ]
				ifFalse: [ position x @ (cell * (nCircles + 0.5) ) ].
			position := (point * cell) + delta.
			line startPoint: position.
			]
]

{ #category : #shapes }
RSLissajous >> createLineFor: dot [
	^ RSLine new
		dashed;
		color: Color white;
		from: 0@0;
		to: dot;
		width: 0.5;
		yourself
]

{ #category : #initialization }
RSLissajous >> initialize [
	super initialize.
	canvas := RSCanvas new.
	color := NSScale category20.
	nCircles := 7.

	gap := 10.
	circleSize := 50.
	dotSize := 10.
	cell := gap + circleSize
]

{ #category : #running }
RSLissajous >> run [
	<script: 'self new run'>
	self build.
	canvas open
		extent: 500@550;
		setLabel: 'Lissajous curves :V'.
	canvas zoomToFit
]
