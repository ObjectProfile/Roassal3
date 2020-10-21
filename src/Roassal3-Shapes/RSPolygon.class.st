"
Define a polygon shape, ready to be added to a Roassal canvas.

For example:
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

polygon := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: 'FFAE0B'.
polygon cornerRadii: 5.
		

polygon2 := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: Color red trans.
		
polygon2 rotateByDegrees: 90.
polygon2 translateBy: 0 @ -50.

c add: polygon.
c add: polygon2.

c
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSPolygon,
	#superclass : #RSBoundingShape,
	#instVars : [
		'points',
		'radius'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #utilities }
RSPolygon class >> fitPolygonToSquare: points [
	| maxx minx maxy miny sx sy x y |
	minx := maxx :=  points first x.
	miny := maxy :=  points first y.
	points do: [ :p | 
		minx := minx min: p x.
		miny := miny min: p y.
		maxx := maxx max: p x.
		maxy := maxy max: p y ].
	"stretch factors"
	sx := 2/(maxx - minx).
	sy := 2/(maxy - miny).
	points doWithIndex: [ :p :i|
		x := p x * sx.
		y := p y * sy.
		points at: i put: x@y.
		minx := minx min: x.
		miny := miny min: y.
		maxx := maxx max: x.
		maxy := maxy max: y ].
	miny < -1 ifTrue: [ 
		points doWithIndex: [ :p :i |
			points at: i put: p x @ ( p y - 1 - miny ) ] ].
	^ points.
]

{ #category : #utilities }
RSPolygon class >> generatePointsFitSquare: sides [
	| points |
	points := self generateUnitNgonPoints: sides rotation: 0.
	points := self fitPolygonToSquare: points.
	^ points
]

{ #category : #utilities }
RSPolygon class >> generateUnitNgonPoints: sides rotation: rotationAngle [
	
	^ self generateUnitNgonPoints: sides  rotation: rotationAngle
		angle: [ :a :i | a negated ] 
		radius: [ :a :i | 1 ]
]

{ #category : #utilities }
RSPolygon class >> generateUnitNgonPoints: sides rotation: rotationAngle angle: angleBloc radius: radiusBloc [
	"sides a Number
	rotation is a number in radians
	angle is a function of 2 args(current angle and index of angle) this return an angle
	radius is a function of 2 args (current angle and index of angle) this retunr a number "
	| increment startAngle points currentAngle currentRadius |
	increment := 1.0 / sides * 2 * Float pi.
	startAngle := sides even
		ifTrue: [ (Float pi / 2) + (increment / 2) ]
		ifFalse: [ Float pi / 2 ].
	startAngle := startAngle + rotationAngle.
	points := Array new: sides.
	0 to: sides - 1 do: [ :i | 
		currentAngle := i * increment + startAngle.
		currentAngle := angleBloc value: currentAngle value: i.
		currentRadius := radiusBloc value: currentAngle value: i.
		points at: i+1 put: (currentAngle cos @ currentAngle sin) * currentRadius ].
	^ points
]

{ #category : #visiting }
RSPolygon >> buildPathOn: visitor [
	visitor buildPolygonPath: self
]

{ #category : #private }
RSPolygon >> centerPoints [
	"Private method, should not be used externally"

	| r center |
	r := points 
		ifEmpty: [ 0@0 corner: 0@0 ]
		ifNotEmpty: [ Rectangle encompassing: points ].
	center := r floatCenter.
	points := points collect: [ :p | p - center ].
	^ r
]

{ #category : #accessing }
RSPolygon >> cornerRadii [ 
	"Return the corner radii, indicating how smooth the polygon corners shoulid be"
	^ radius ifNil: [ 0 ]
]

{ #category : #accessing }
RSPolygon >> cornerRadii: aNumber [
	"Set the corner radii. Has the effect to make corners smooth 
	For example:

c := RSCanvas new.

polygon := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: 'FFAE0B'.
polygon cornerRadii: 5.
		

polygon2 := RSPolygon new
		points: { 0 @ -50 . 50 @ 0 . -50 @ 0 };
		color: Color red trans.
		
polygon2 rotateByDegrees: 90.
polygon2 translateBy: 0 @ -50.

c add: polygon.
c add: polygon2.

c

	"
	radius := aNumber abs.
	self resetPath.
]

{ #category : #private }
RSPolygon >> extent: newExtent [
	| min max s extent |
	self hasPoints 
		ifFalse: [ ^ self ].
	extent := baseRectangle extent.
	extent = newExtent
		ifTrue: [ ^ self ].
	min := Float fmax asPoint.
	max := Float fmin asPoint.
	points do: [ :p | 
		min := min min: p.
		max := max max: p ].
	s := newExtent / (max - min).
	points := points collect: [ :p | p * s ].
	super extent: newExtent
]

{ #category : #geometry }
RSPolygon >> geometry [
	| rect e |
	rect := self encompassingRectangle.
	e := rect extent.
	e = (0@0) ifTrue: [ ^ rect floatCenter asGPoint ].
	^ GPolygon
		vertices: self points + self position
]

{ #category : #testing }
RSPolygon >> hasPoints [
	^ points notNil and: [ points isNotEmpty ]
]

{ #category : #testing }
RSPolygon >> includesPoint: aPoint [
	"Return true or false if a point is contained in the shape"
	| invertedPoint |
	invertedPoint := matrix rsInverseTransform: aPoint.
	^ (self baseRectangle containsPoint: invertedPoint)
		ifFalse: [ false ]
		ifTrue: [(AthensPolygonTester new 
			polygon: points) includesPoint: invertedPoint]
]

{ #category : #initialization }
RSPolygon >> initialize [
	super initialize.
	points := #().
]

{ #category : #accessing }
RSPolygon >> points [
	"Return the points defining the polygon"
	^ points
]

{ #category : #accessing }
RSPolygon >> points: anArray [
	"Set the points used to draw the polygon."
	| rec |
	self privatePoints: anArray.
	rec := self centerPoints.
	self translateTo: rec floatCenter.
	super extent: rec extent
]

{ #category : #private }
RSPolygon >> privatePoints: anArray [
	"Private method, should bot be used externally"
	points := anArray
]
