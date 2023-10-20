Extension { #name : 'AthensCairoPathBuilder' }

{ #category : '*Roassal' }
AthensCairoPathBuilder >> arcAround: aCenterPoint radius: aRadius startAngle: aStartAngle endAngle: anEndAngle [
	self
		arcCenterX: aCenterPoint x
		centerY: aCenterPoint y
		radius: aRadius
		startAngle: aStartAngle
		endAngle: anEndAngle
]

{ #category : '*Roassal' }
AthensCairoPathBuilder >> arcAround: aCenterPoint radius: aRadius startAngle: aStartAngle endAngle: anEndAngle cw: aBool [
	aBool ifTrue: [
		self
		arcNegativeCenterX: aCenterPoint x
		centerY: aCenterPoint y
		radius: aRadius
		startAngle: aStartAngle
		endAngle: anEndAngle ]
	ifFalse: [ self
		arcCenterX: aCenterPoint x
		centerY: aCenterPoint y
		radius: aRadius
		startAngle: aStartAngle
		endAngle: anEndAngle ]
]

{ #category : '*Roassal' }
AthensCairoPathBuilder >> arcCos: num [
	| temp |
	temp := num.
	num < -1.0 ifTrue: [ temp := -1.0 ].
	num > 1.0 ifTrue: [ temp := 1.0 ].

	^ temp arcCos
]

{ #category : '*Roassal' }
AthensCairoPathBuilder >> ellipticalArc2: radii xrot: rotationAxis large: largeFlag sweep: sweepFlag to: aPoint [

	"raddi Point, rotationAxis Number, largeFlag Number, sweepFlag Number, aPoint Point"
	"implentation based on the svg specification"
	| ep x0 y0 x y dx2 dy2 theta x1 y1 tcos tsin rx ry prx pry px1 py1 d sign coef cx1 cy1 sx2 sy2 cx cy ux uy vx vy n p angleStart angleExtent pi2 |
	self flag: 'Not yet for real elliptic arcs'.
	pi2 := Float pi * 2.
	(radii x = 0 or: [ radii y = 0 ]) ifTrue: [
		^ self lineTo: aPoint ].
	ep := self getCurrentPoint.
	x0 := ep x.
	y0 := ep y.
	x := aPoint x.
	y := aPoint y.
	dx2 := (x0 - x)/2.0.
	dy2 := (y0 - y)/2.0.
	theta := rotationAxis degreesToRadians.
	tcos := theta cos.
	tsin := theta sin.
	x1 := (tcos * dx2) + (tsin * dy2).
	y1 := (tsin negated* dx2) + (tcos * dy2).
	rx := radii x abs.
	ry := radii y abs.
	prx := rx * rx.
	pry := ry * ry.
	px1 := x1 * x1.
	py1 := y1 * y1.
	d := (px1 / prx) + (py1 / pry).
	d > 1 ifTrue: [
		rx := rx * d sqrt.
		ry := ry * d sqrt.
		prx := rx * rx.
		pry := ry * ry ].

	sign := largeFlag = sweepFlag ifTrue: [ -1 ] ifFalse: [ 1 ].
	coef := sign * (( (prx * pry) - (prx * py1) - (pry * px1) )/( (prx * py1) + (pry * px1) ) max: 0) sqrt.

	cx1 := coef * rx * y1 / ry.
	cy1 := coef * (ry * x1 / rx) negated.

	sx2 := (x0 + x)/2.
	sy2 := (y0 + y)/2.
	cx := sx2 + ((tcos * cx1) - (tsin * cy1)).
	cy := sy2 + ((tsin * cx1) + (tcos * cy1)).

	ux := (x1 - cx1)/rx.
	uy := (y1 - cy1)/ry.
	vx := (x1 + cx1) negated /rx.
	vy := (y1 + cy1) negated /ry.
	"Angle start"
	n := ((ux * ux) + (uy * uy)) sqrt.
	p := ux.
	sign := uy < 0 ifTrue: [ -1 ] ifFalse: [ 1 ].
	angleStart := sign * (self arcCos: p / n).
	"angle extent"
	n := (((ux * ux) + (uy * uy)) * ((vx * vx) + (vy * vy))) sqrt.
	p := (ux * vx) + (uy * vy).
	sign := ((ux * vy) - (uy * vx)) < 0 ifTrue: [ -1 ] ifFalse: [ 1 ].
	angleExtent := sign * (self arcCos: p / n).
	(sweepFlag = 0 and: [ angleExtent > 0]) ifTrue: [
		angleExtent := angleExtent - pi2.
	 ] ifFalse: [ (sweepFlag = 1 and: [ angleExtent < 0 ]) ifTrue: [
		angleExtent := angleExtent + pi2.
		 ] ].
	angleExtent := angleExtent % pi2.
	angleStart := angleStart % pi2.
	self
		arcAround: (cx asFloat)@ (cy asFloat)
		radius: rx asFloat
		startAngle: angleStart asFloat
		endAngle: angleExtent asFloat + angleStart
		cw: sweepFlag = 0
]
