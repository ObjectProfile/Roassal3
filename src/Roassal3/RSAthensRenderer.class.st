"
<keyClass>
Roassal uses Athens (and therefore Cairo) to performs the rendering. The rendering in Roassal is modularized in the class `RSAthensRenderer`. The connection between Roassal and Athens is expressed by the class `RSAthensRenderer`.

The class `RSAthensRenderer` is essentially a visitor for a `RSCanvas`. The renderer visits the canvas and ultimately calls the Athens primitives for each visited shapes.

If you wish to add a new rendering engine (to produce a PDF file or use an alternative low level graphic engine such as Moz2D), you need to subclass the class `RSRenderer`.

`RSAthensRenderer` visits the canvas and its contained shapes to draw it in a AthensSurface.

*Responsibility*: invoke the low level primitives offered by Athens to render the visual aspect of shapes.

*Collaborators*: `RSAthensMorph` is using the class `RSAthensRenderer` to ""draw"" a `RSCanvas` instance.

"
Class {
	#name : #RSAthensRenderer,
	#superclass : #RSRenderer,
	#instVars : [
		'builder',
		'matrix',
		'canvasRect',
		'showRectangles',
		'originMatrix'
	],
	#category : #'Roassal3-Rendering'
}

{ #category : #utilities }
RSAthensRenderer >> applyRadius: radius on: controlPoints from: start to: end [
	"based on https://riptutorial.com/html5-canvas/example/18766/render-a-rounded-polygon-"
	| cp p1 p2 p3 arc v1 len1 a1 v2 len2 a2 sinA sin90
	angle radDir drawDir halfAngle cRadius lenOut p a b len |
	cp := controlPoints.
	len := cp size.
	p1 := p2 := p3 := nil.
	arc := [
		v1 := p1 - p2.
		len1 := ((v1 x * v1 x) + (v1 y * v1 y)) sqrt.
		v1 := v1 / len1.
		a1 := v1 angle.

		v2 := p3 - p2.
		len2 := ((v2 x * v2 x) + (v2 y * v2 y)) sqrt.
		v2 := v2 / len2.
		a2 := v2 angle.

		sinA := (v1 x * v2 y) - (v1 y * v2 x).
		sin90 := (v1 x * v2 x) - (v1 y * v2 y negated).
		angle := sinA arcSin.
		radDir := 1.
		drawDir := false.

		sin90 < 0 ifTrue: [
			angle < 0 ifTrue: [
				angle := angle + Float pi ]
			ifFalse: [
				angle := angle - Float pi.
				radDir := -1.
				drawDir := true ] ]
		ifFalse: [
			angle >= 0 ifTrue: [
				radDir := -1.
				drawDir := true. ] ].
		halfAngle := angle / 2.
		sinA :=  halfAngle sin.
		lenOut := sinA = 0
			ifTrue: [ Float infinity ]
			ifFalse: [ (halfAngle cos * radius/ sinA) abs].
		cRadius := radius.
		lenOut > ((len1 / 2) min: (len2 / 2)) ifTrue: [
			lenOut := (len1 / 2) min: (len2 / 2).
			cRadius := (lenOut * halfAngle tan) abs.
			].
		p := p2 + (v2 * lenOut) + (v2 y negated@ v2 x * cRadius * radDir).
		a := a1 + (Float halfPi * radDir).
		b := a2 - (Float halfPi * radDir).
		(a closeTo: b) ifTrue: [ a := b ].
		builder
			arcAround: p
			radius: cRadius
			startAngle: a
			endAngle: b
			cw: drawDir. ].
	start to: end do: [ :i |
		p1 := cp at: (i)%len + 1.
		p2 := cp at: (i + 1)%len + 1.
		p3 := cp at: (i + 2)%len + 1.
		(p1 = p2 or: [p2 = p3]) ifFalse: [ arc value ] ]
]

{ #category : #utilities }
RSAthensRenderer >> arcCornerTangets: p0 p1: p1 r: r1 rc: rc cw: cw [
	| x01 y01 lo ox oy x1 y1 x2 y2 x3 y3 dx dy d2 r d D cx0 cy0 cx1 cy1 dx0 dy0 dx1 dy1 |
	x01 := p0 x - p1 x.
	y01 := p0 y - p1 y.
	lo := (cw ifTrue:[rc ] ifFalse: [ rc negated ]) / ((x01 * x01) + (y01*y01)) sqrt.
	ox := lo * y01.
	oy := lo negated * x01.
	x1 := p0 x + ox.
	y1 := p0 y + oy.
	x2 := p1 x + ox.
	y2 := p1 y + oy.
	x3 := (x1 + x2)/2.
	y3 := (y1 + y2)/2.
	dx := x2 - x1.
	dy := y2 - y1.
	d2 := (dx * dx) + (dy * dy).
	r := r1 - rc.
	D := (x1 * y2) - (x2 * y1).
	d := (dy < 0 ifTrue: [ -1 ] ifFalse: [ 1 ]) * (0 max: ((r*r *d2) - (D * D) ) ) sqrt.
	cx0 := ((D * dy) - (dx * d)) / d2.
	cy0 := ( (D negated * dx) - (dy * d) ) / d2.
	cx1 := ((D * dy) + (dx * d)) / d2.
	cy1 := ( (D negated * dx) + (dy * d) ) / d2.
	dx0 := cx0 - x3.
	dy0 := cy0 - y3.
	dx1 := cx1 - x3.
	dy1 := cy1 - y3.
	((dx0 * dx0) + (dy0 * dy0)) > ((dx1 * dx1) + (dy1 * dy1)) ifTrue: [
		cx0 := cx1.
		cy0 := cy1 ].
	^  (cx0 - ox)@ (cy0 - oy) negated -> ((cx0 * r1 / r)@(cy0 * r1/r) negated)
]

{ #category : #utilities }
RSAthensRenderer >> arcSweep: p1 and: p2 [
	^ ((p1 x - p2 x)* p1 y) - ((p1 y - p2 y) * p1 x) > 0
		ifTrue: [ 1 ]
		ifFalse: [ 0 ]
]

{ #category : #utilities }
RSAthensRenderer >> asin: x [
	^ x >= 1
	ifTrue: [ 1.5707963267948966 ]
	ifFalse: [ x <= -1
		ifTrue: [ -1.5707963267948966 ]
		ifFalse: [ x arcSin ] ]
]

{ #category : #'creating path' }
RSAthensRenderer >> buildBezierPath: bezier [
	| points |
	points := bezier controlPoints.
	points size = 2 ifTrue: [
		builder
			absolute;
			moveTo: points first;
			lineTo: points second.
		^ self ].
	points size = 3 ifTrue: [
		builder
			absolute;
			moveTo: points first;
			curveVia: points second
				to: points third.
		^ self ].
	points size = 4 ifTrue: [
		builder
			absolute;
			moveTo: points first;
			curveVia: points second
				and: points third
				to: points fourth  ]
]

{ #category : #'creating path' }
RSAthensRenderer >> buildBoxPath: box [
	self buildCornerBoxPath: box
]

{ #category : #'creating path' }
RSAthensRenderer >> buildCornerBoxPath: box [
	| c rectangle e w2 h2 tl tr bl br min |
	c := box cornerRadius.
	rectangle := box baseRectangle.
	e := rectangle extent.
	w2 := e x / 2.0.
	h2 := e y / 2.0.
	min := w2 min: h2.
	tl := (c topLeft min: min) max: 0.
	tr := (c topRight min: min) max: 0.
	bl := (c bottomLeft min: min) max: 0.
	br := (c bottomRight min: min) max: 0.

	builder
		absolute;
		moveTo: rectangle topLeft + (tl@0);
		lineTo: rectangle topRight - (tr@0);
		cwArcTo: rectangle topRight + (0@tr) angle: Float halfPi;
		lineTo: rectangle bottomRight- (0 @ br);
		cwArcTo: rectangle bottomRight - (br @ 0) angle: Float halfPi;
		lineTo: rectangle bottomLeft + (bl @ 0);
		cwArcTo: rectangle bottomLeft - (0@ bl) angle: Float halfPi;
		lineTo: rectangle topLeft + (0@ tl);
		cwArcTo: rectangle topLeft + (tl @0) angle: Float halfPi;
		closePath
]

{ #category : #'creating path' }
RSAthensRenderer >> buildEllipsePath: ellipse [
	| extent halfWidth halfHeight |
	extent := ellipse baseRectangle extent.
	halfWidth := extent x / 2 asFloat.
	halfHeight := extent y / 2 asFloat.

	builder
		absolute;
		moveTo: 0@0;
		relative;
		moveTo: halfWidth negated @ 0;
		curveVia: 0 @ (halfHeight negated * 0.55)
			and: (0.45 * halfWidth) @ halfHeight negated
			to: halfWidth @ halfHeight negated;
		curveVia: (halfWidth * 0.55) @ 0
			and: halfWidth @ (0.45 * halfHeight)
			to: halfWidth @ halfHeight;
		curveVia: 0 @ (halfHeight * 0.55)
			and: (0.45 * halfWidth negated) @ halfHeight
			to: halfWidth negated @ halfHeight;
		curveVia: (halfWidth negated * 0.55) @ 0
			and: halfWidth negated @ (halfHeight negated * 0.45)
			to: halfWidth negated @ halfHeight negated
]

{ #category : #'creating path' }
RSAthensRenderer >> buildLinePath: line [
	builder
		absolute;
		moveTo: line startPoint;
		lineTo: line endPoint
]

{ #category : #'creating path' }
RSAthensRenderer >> buildPolygonPath: polygon [
	| first radius cp |
	builder absolute.
	radius := polygon cornerRadii.
	cp := polygon points.
	[
	(radius ~= 0 and: [ cp size > 2 ]) ifTrue: [
		builder moveTo: (cp first + cp second) /2.
		self applyRadius: radius on: cp from: 0 to: cp size-1.
		^ self ].
	first := true.
	cp do: [ :point |
		first ifTrue: [
			first := false.
			builder moveTo: point ]
		ifFalse: [
			builder lineTo: point ] ].
	] ensure: [ builder closePath. ]
]

{ #category : #'creating path' }
RSAthensRenderer >> buildPolylinePath: line [
	| first cp radius |
	builder absolute.
	cp := line controlPoints.
	radius := line cornerRadii.
	(radius ~= 0 and: [ cp size > 2 ]) ifTrue: [
		builder moveTo: cp first.
		self applyRadius: radius on: cp from: 0 to: cp size - 3.
		builder lineTo: cp last.
		^ self ].
	first := true.
	cp do: [ :point |
		first ifTrue: [
			first := false.
			builder moveTo: point ]
		ifFalse: [
			builder lineTo: point ] ]
]

{ #category : #'creating path' }
RSAthensRenderer >> buildRingPath: ring [
	| aAngle bAngle xAngle i e center ap epsilon aAngle2 bAngle2
	rp da da0 da1 rc x1 x2 x3 x4 y1 y2 y3 y4 rc0 rc1 t41 t23  t14 t32 |
	epsilon := 1e-12.
	ap := (ring segmentSpacing / 2) degreesToRadians.
	aAngle := ring alphaAngle degreesToRadians.
	bAngle := ring betaAngle degreesToRadians.
	da := da0 := da1 := (aAngle - bAngle) abs.
	aAngle2 := aAngle.
	bAngle2 := bAngle.
	center := 0@0.
	i := ring innerRadius asFloat.
	e := ring externalRadius asFloat.
	e < i ifTrue: [ | r0 |
		r0 := i. i := e. e := r0. ].

	builder absolute.
	"is it a point? "
	e < epsilon ifTrue: [ ^ builder  moveTo: center ].

	"or is a circle? "
	da0 > (Float pi * 2 - epsilon) ifTrue: [
		builder
			moveTo: ((e * aAngle cos)@( e * aAngle sin negated)) + center ;
			arcAround: center radius: e startAngle: aAngle endAngle: bAngle.
		i > epsilon ifTrue: [
			builder
				moveTo: (i * (aAngle cos @ aAngle sin negated) )+ center ;
				arcAround: center radius: i startAngle: aAngle endAngle: bAngle ].
		builder close.
		^ self ].
	"circle part"
	xAngle := (aAngle + bAngle)/2.
	rp := ((i*i) + (e*e)) sqrt.
	"apply padding"
	rp > epsilon ifTrue: [ | p0 p1 |
		p0 := i isZero
			ifTrue: [ self asin: Float infinity ]
			ifFalse: [ self asin: (rp / i * ap sin) ].
		p1 := self asin: (rp / e * ap sin).
		da0 := da0 - (p0*2).
		da0 > epsilon
			ifTrue: [ aAngle2 := aAngle2 + p0. bAngle2 := bAngle - p0 ]
			ifFalse: [ aAngle2 := bAngle2 := (aAngle + bAngle)/2. ].
		da1 := da1 - (p1*2).
		da1 > epsilon
			ifTrue: [ aAngle := aAngle + p1. bAngle := bAngle - p1 ]
			ifFalse: [ aAngle := bAngle := xAngle ] ].
	x1 := e*aAngle cos.
	y1 := e*aAngle sin.
	x2 := e*bAngle cos.
	y2 := e*bAngle sin.
	x4 := i*aAngle2 cos.
	y4 := i*aAngle2 sin.
	x3 := i*bAngle2 cos.
	y3 := i*bAngle2 sin.

	"is it small circle part?"
	(aAngle - bAngle) abs < 0.001 ifTrue: [
		builder
			moveTo: (x3@y3) + center;
			close.
		^ self ].
	"apply corner radius"
	rc := ((i -e) abs /2) min: ring cornerRadii.
	rc0 := rc1 := rc.
	(da > epsilon and: [ rc > 0.001 ]) ifTrue: [
		da < Float pi ifTrue: [
			| oc ax ay bx by kc lc |
			oc := self geomPolygonIntersectC: x1@y1 d: x4@y4 a: x2@y2  b: x3@y3.
			ax := x1 - oc x.
			ay := y1 - oc y.
			bx := x2 - oc x.
			by := y2 - oc y.
			kc := 1 / (( ((ax*bx) + (ay*by)) /  ( ((ax*ax)+ (ay*ay)) sqrt * ( (bx*bx)+(by*by) ) sqrt ) ) arcCos / 2) sin.
			lc := ((oc x * oc x) + (oc y*oc y)) sqrt.
			rc0 := rc0 min: ((e - lc) / (kc + 1)).
			rc1 := rc1 min: ((i - lc) / (kc - 1)) ].

		t41 := self arcCornerTangets: x4@y4 p1: x1@y1 r: e rc: rc0 cw: true.
		t23 := self arcCornerTangets: x2@y2 p1: x3@y3 r: e rc: rc0 cw: true.
		builder moveTo: t41 key + center.
		rc0 == rc ifTrue: [
			builder
				ellipticalArc2: rc0@rc0
					xrot: 0
					large: 0
					sweep: 0
					to: t41 value + center;
				ellipticalArc2: e@e
					xrot: 0
					large: (self arcSweep: t41 value and: t23 value)
					sweep: 0
					to: t23 value + center;
				ellipticalArc2: rc0@rc0
					xrot: 0
					large: 0
					sweep: 0
					to: t23 key + center.
				 ]
		ifFalse: [
			builder
				ellipticalArc2: rc0@rc0
					xrot: 0
					large: 1
					sweep: 0
					to: t23 key + center ].

		(x4 isZero & y4 isZero) ifTrue: [
			builder lineTo: center. ]
		ifFalse: [
			t14 := self arcCornerTangets: x1@y1 p1: x4@y4 r: i rc: rc1 negated cw: true.
			t32 := self arcCornerTangets: x3@y3 p1: x2@y2 r: i rc: rc1 negated cw: true.
			builder lineTo: t32 key + center.
			(rc == rc1 and: [da0 > 0 ]) ifTrue: [
				builder
					ellipticalArc2: rc1@ rc1
						xrot: 0
						large: 0
						sweep: 0
						to: t32 value + center;
					ellipticalArc2: i@i
						xrot: 0
						large: (self arcSweep: t14 value and: t32 value)
						sweep: 1
						to: t14 value + center;
					ellipticalArc2: rc1@rc1
						xrot: 0
						large: 0
						sweep: 0
						to: t14 key + center
			] ifFalse: [
				builder
					ellipticalArc2: rc1@ rc1
						xrot: 0
						large: 0
						sweep: 0
						to: t14 key + center
		 ] ]
	] ifFalse: [ | l0 l1 |
		l1 := (bAngle - aAngle) abs <= Float pi ifTrue: [ 0 ] ifFalse: [ 1 ].
		l0 := (bAngle2 - aAngle2) abs <= Float pi ifTrue: [ 0 ] ifFalse: [ 1 ].

		builder
			moveTo: x1 @ y1 negated;
			ellipticalArc2: e@ e negated
		 		xrot: 0
				large: l1
				sweep: 0
				to: x2@y2 negated;
			lineTo: x3@y3 negated;
			ellipticalArc2: i@i negated
				xrot: 0
				large: l0
				sweep: 1
				to: x4@y4 negated.
	].
	builder close
]

{ #category : #accessing }
RSAthensRenderer >> builder [
	^ builder
]

{ #category : #utilities }
RSAthensRenderer >> createStrokePaintFor: border [
	| stroke style |
	stroke := (border paint asAthensPaintOn: athensCanvas) asStrokePaintOn: athensCanvas.
	stroke width: border width asFloat.
	style := border style.
	style ifNil: [ ^ stroke ].
	style dashArray
		ifNotNil: [ :a | stroke dashes: a offset: style dashOffset ].

	style capStyle
		ifNotNil: [:s | s value: stroke ].
	style joinStyle
		ifNotNil: [:s | s value: stroke ].
	^ stroke
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> drawPathLabel: label [
	| utf8String act f stroke |
	utf8String := label path.
	utf8String ifNil: [
		act := AthensCairoText new.
		utf8String := act convertTextUtf8: label text.
		label path: utf8String.
	 ].
	f := label cairoFont.

	athensCanvas newPath.
	f lock.
	athensCanvas
		setPathMatrix;
		setScaledFont: f.
	label paint ifNotNil: [
		(label paint asAthensPaintOn: athensCanvas)"
			setMatrix: athensCanvas paintTransform inverted;"
			loadOnCairoCanvas: athensCanvas. ].
	athensCanvas textPath: utf8String.
	label paint ifNotNil: [ athensCanvas fillPreserve ].
	label hasBorder ifTrue: [
		stroke := label border accept: self.
		stroke prepareForDrawingOn: athensCanvas.
		athensCanvas stroke.
	 ].
	f unlock
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> drawShadowRectangle: rect [
	| r |
	athensCanvas setPaint: (Color blue alpha: 0.1).
	r := rect origin asFloatPoint corner: rect corner asFloatPoint.
	athensCanvas drawShape: r
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> drawSimpleLabel: label [
	| font |
	(label paint isNil or: [ label cairoGlyphs isNil ]) ifTrue: [ ^ self ].

	"returns a CairoScaledFont"
	font := label cairoFont.
	font lock.

	athensCanvas
		setPathMatrix;
		setScaledFont: font.
	(label paint asAthensPaintOn: athensCanvas)
		loadOnCairoCanvas: athensCanvas.

	athensCanvas
		showGlyphs: label cairoGlyphs getHandle
		size: label cairoGlyphs size.

	font unlock
]

{ #category : #utilities }
RSAthensRenderer >> geomPolygonIntersectC: c d: d a: a b: b [

	| x1 x3 x21 x43 y1 y3 y21 y43 ua |
	x1 := c x.
	x3 := a x.
	x21 := d x - x1.
	x43 := b x - x3.
	y1 := c y.
	y3 := a y.
	y21 := d y - y1.
	y43 := b y - y3.
	ua := ((x43 *  (y1 - y3)) - (y43 * (x1 - x3))) / ((y43 * x21) - (x43 * y21 )).
	^ (x1 + (ua * x21))@
	(y1 +(ua * y21))
]

{ #category : #'creating path' }
RSAthensRenderer >> getOrCreatePathOf: shape [
	| path |
	path := shape path.
	path ifNotNil: [ ^ path ].
	athensCanvas setPathMatrix.
	path := athensCanvas
		createPath: [ :pathBuilder |
			builder := pathBuilder.
			shape buildPathOn: self ].
	builder := nil.
	shape path: path.
	^ path
]

{ #category : #paint }
RSAthensRenderer >> paintFor: shape form: form [
	form isForm ifFalse: [ ^ form ].

	^ CairoBackendCache soleInstance
		at: form
		ifAbsentPut: [
			| paint |
			paint := (AthensCairoPatternSurfacePaint
				createForSurface: (AthensCairoSurface
				fromForm: form)).
			paint origin: (form extent /2) negated asFloatPoint.
			paint ]
]

{ #category : #visiting }
RSAthensRenderer >> visitBorder: border [
	| stroke |
	stroke := self createStrokePaintFor: border.
	athensCanvas privatePaint: stroke.
	^ stroke
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> visitBorderIfNecessary: shape [
	shape hasBorder ifFalse: [ ^ self ].
	athensCanvas setShape: shape path.
	shape border accept: self.
	athensCanvas draw
]

{ #category : #visiting }
RSAthensRenderer >> visitBoundingShape: shape [
	self visitShapeIfNecessary: shape block: [
		| path paint |
		athensCanvas pathTransform loadAffineTransform: matrix.
		path := self getOrCreatePathOf: shape.
		paint := shape paintOn: self.
		paint ifNotNil: [
			athensCanvas
				setPaint: paint;
				drawShape: path ].
		self visitBorderIfNecessary: shape.
		self visitShadowRectangleIfNecessary: shape.
		self visitChildrenIfNecessary: shape.
	]
]

{ #category : #visiting }
RSAthensRenderer >> visitCamera: camera [
	camera setMatrix: matrix
]

{ #category : #visiting }
RSAthensRenderer >> visitCanvas: aRSCanvas [
	matrix := AthensAffineTransform new.
	originMatrix := matrix copy.
	canvasRect := aRSCanvas visibleRectangle.
	showRectangles := aRSCanvas shouldShowRectangles.
	athensCanvas fillRuleEvenOdd.
	athensCanvas setAA: aRSCanvas antialiasing.

	aRSCanvas camera accept: self.
	"aRSCanvas shapes accept: self."
	(aRSCanvas shapeCollection shapesAtRectangle: canvasRect) accept: self.

	"We display the elements that are _NOT_ subject to the camera"
	matrix loadIdentity.
	originMatrix loadIdentity.
	canvasRect := 0@0 extent: aRSCanvas extent.
	aRSCanvas fixedShapes accept: self
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> visitChildrenIfNecessary: shape [
	| draw |
	shape hasChildren ifFalse: [ ^ self ].
	draw := [ shape children accept: self ].
	shape clipChildren
		ifTrue: [ athensCanvas clipBy: shape path during: draw ]
		ifFalse: [ draw value ]
]

{ #category : #visiting }
RSAthensRenderer >> visitGroup: aRSGroup [
	aRSGroup do: [ :roassalShape | roassalShape accept: self ]
]

{ #category : #visiting }
RSAthensRenderer >> visitLabel: label [
	label hasText ifFalse: [ ^ self ].
	self visitShapeIfNecessary: label block: [
		| lbtranslation |
		lbtranslation := label textExtents translationPoint asFloatPoint.
		matrix translateBy: lbtranslation.
		athensCanvas pathTransform loadAffineTransform: matrix.
		label hasBorder
			ifTrue: [ self drawPathLabel: label ]
			ifFalse: [ self drawSimpleLabel: label ].

		self visitLabelDecoratorsIfNecessary: label.
		athensCanvas pathTransform translateBy: lbtranslation negated.
		self visitShadowRectangleIfNecessary: label
	]
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> visitLabelDecoratorsIfNecessary: label [
	| advance |
	(label isUnderlined or: [label isStruckOut]) ifFalse: [ ^ self ].

	athensCanvas setPaint: label paint.
	advance := (CairoFontMetricsProvider new
			font: label font;
			extentsOf: label text) x_advance.
	label isUnderlined
		ifTrue: [ athensCanvas drawShape: ((0 @ 1 extent: advance @ 1)) ].
	label isStruckOut ifFalse:  [ ^ self ].

	athensCanvas pathTransform
		translateBy: (0@ (label textHeight / 4)) negated asFloatPoint.
	athensCanvas drawShape: ((0 @ 1 extent: advance @ 1))
]

{ #category : #visiting }
RSAthensRenderer >> visitLine: line [
	| path paint |
	(line intersects: canvasRect) ifFalse: [ ^ self ].
	athensCanvas pathTransform loadAffineTransform: matrix .
	path := self getOrCreatePathOf: line.
	paint := line paintOn: self.

	paint ifNotNil: [
		athensCanvas
			setPaint: paint;
			drawShape: path ].
	self visitBorderIfNecessary: line.
	line markerShapesInPositionDo: [ :shape | shape accept: self ].
	self visitShadowRectLineIfNecessary: line
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> visitShadowRectLineIfNecessary: line [
	showRectangles ifFalse: [ ^ self ].
	self drawShadowRectangle: line encompassingRectangle
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> visitShadowRectangleIfNecessary: shape [
	showRectangles ifFalse: [ ^ self ].
	self drawShadowRectangle: shape baseRectangle
]

{ #category : #'visiting - helpers' }
RSAthensRenderer >> visitShapeIfNecessary: shape block: aBlock [
	matrix restoreAfter: [
		| shapeMatrix |
		shapeMatrix := shape matrix asFloatTransform.
		matrix multiplyBy: shapeMatrix.
		originMatrix restoreAfter: [
			| rect |
			originMatrix multiplyBy: shapeMatrix.
			rect := shape
				computeEncompassingRectangleFor: shape baseRectangle
				matrix: originMatrix.
			(rect intersects: canvasRect) ifFalse: [ ^ self ].
				aBlock value ].
	]
]
