"
this class is related to radar visualization
"
Class {
	#name : #RSKiviat,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'values',
		'axisNames',
		'radius',
		'shouldUseEllipse',
		'labelGapSize',
		'scales',
		'polygonShape',
		'palette',
		'shouldUsePolygonBorder',
		'shouldUseDots',
		'shouldUsePolygonFillColor',
		'labels',
		'axis',
		'backgroundShapes',
		'polygonShapes',
		'maxValue',
		'minValue'
	],
	#category : #'Roassal3-Chart-Radar'
}

{ #category : #accessing }
RSKiviat >> addRow: aList [
	values add: aList
]

{ #category : #adding }
RSKiviat >> addRows: aCollection [
	values addAll: aCollection
]

{ #category : #accessing }
RSKiviat >> axis [
	^ axis
]

{ #category : #accessing }
RSKiviat >> axisNames [
	^ axisNames
]

{ #category : #accessing }
RSKiviat >> axisNames: aCollection [
	axisNames := aCollection
]

{ #category : #accessing }
RSKiviat >> backgroundColor [
 ^ '#e5ebf6'
]

{ #category : #accessing }
RSKiviat >> backgroundShapes [
	^ backgroundShapes
]

{ #category : #accessing }
RSKiviat >> border [
	^ RSBorder new
		color: Color white;
		yourself
]

{ #category : #'accessing - computed' }
RSKiviat >> computePointsFor: aCollection [
	| delta current divisor |
	divisor := axisNames ifEmpty: [ 1 ] ifNotEmpty: [ axisNames size ].
	delta := Float twoPi / divisor.
	current := Float halfPi negated.
	^ aCollection collectWithIndex: [ :value :index | | indexScale point newRadius |
		indexScale := scales scale: index.
		newRadius := (indexScale scale: value).
		point := current cos @ current sin * newRadius.
		current := current + delta.
		point ]
]

{ #category : #private }
RSKiviat >> computeScaleFor: array [
	| min max |
	min := minValue
		ifNotNil: [ minValue 	]
		ifNil: [ (array ifEmpty: 0 ifNotEmpty: [ values first min ]) min: 0 ].
	max := maxValue
		ifNotNil: [ maxValue ]
		ifNil: [ array ifEmpty: 1 ifNotEmpty: [ values first max ] ].

	^ NSScale linear domain: { min. max }; range: { 0. radius }
]

{ #category : #private }
RSKiviat >> computeScales [
	scales := NSScale ordinal.
	values size = 1 ifTrue: [
		scales range: { self computeScaleFor: values first }
	] ifFalse: [
		scales range: (axisNames collectWithIndex: [ :each :index |
			| column |
			column := values collect: [ :array | array at: index ].
			self computeScaleFor: column.
			 ]).
	]
]

{ #category : #creation }
RSKiviat >> createAxisLine: name angle: angle [
	^ RSLine new
		endPoint: angle cos @ angle sin * radius;
		border: self border;
		yourself
]

{ #category : #creation }
RSKiviat >> createAxisName: aString [
	 ^ RSLabel new
		text: aString;
		yourself
]

{ #category : #creation }
RSKiviat >> createBorderFor: aRSPolygon [
	^ RSBorder new
		color: aRSPolygon color muchDarker;
		yourself
]

{ #category : #creation }
RSKiviat >> createEllipseFor: each [
	^ RSEllipse new
		noPaint;
		size: each*2;
		border: self border;
		yourself
]

{ #category : #creation }
RSKiviat >> createPolygonFor: each [
	^ RSPolygon new
		noPaint;
		points: (RSPolygon
			generateUnitNgonPoints: axisNames size
		 	rotation: 0)* each;
		border: self border;
		yourself
]

{ #category : #creation }
RSKiviat >> createShapePointFor: aPoint in: aRSPolygon [
	^ RSEllipse new
		color: aRSPolygon color muchDarker;
		position: aPoint;
		size: 10;
		yourself
]

{ #category : #creation }
RSKiviat >> createValuePolygon: array [
	| polygon points shapePoints |
	points := self computePointsFor: array.
	polygon := self polygonShape copy
		points: points;
		color: (palette scale: array);
		yourself.
	self shouldUsePolygonBorder
		ifTrue: [ polygon border: (self createBorderFor: polygon) ].

	self shouldUseDots ifTrue: [
		shapePoints := points collect: [:point | self createShapePointFor: point in: polygon ].
		shapePoints with: array do: [ :s :value | s model: value ].
		self shouldUsePolygonFillColor ifFalse: [ polygon noPaint ].
		^ ({ polygon }, shapePoints) asShape ].
	self shouldUsePolygonFillColor ifFalse: [ polygon noPaint ].
	^ polygon
]

{ #category : #'accessing - defaults' }
RSKiviat >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #defaults }
RSKiviat >> defaultPalette [
	^ NSScale ordinal range: (NSScale category20 range collect: [:color| color translucent ])
]

{ #category : #utilities }
RSKiviat >> fixLabelPosition: label angle: angle [
	| positions gap |
	label position: angle cos @ angle sin * radius.
	gap := self labelGapSize.
	positions := Dictionary newFromPairs:
		{ 0. 0.5@0.
		Float halfPi negated. 0@ -0.5.
		Float pi. -0.5@ 0.
		Float pi + Float halfPi. 0@ 0.5}.
	positions at: angle
		ifPresent: [:fix | label translateBy: label extent * fix+ (gap * fix sign) ]
		ifAbsent: [
			gap := angle cos @ angle sin * gap.
			(angle between: Float halfPi negated and: 0)
				ifTrue: [ ^ label translateBy: label baseRectangle bottomLeft negated+gap ].
			(angle between: 0 and: Float halfPi)
				ifTrue: [ ^ label translateBy: label baseRectangle topLeft negated+gap ].
			(angle between: Float halfPi and: Float pi)
				ifTrue: [ ^ label translateBy: label baseRectangle topRight negated+gap ].
			label translateBy: label baseRectangle bottomRight negated + gap ]
]

{ #category : #initialization }
RSKiviat >> initialize [
	super initialize.
	values := OrderedCollection new.
	polygonShape := RSPolygon new.
	self
		palette: self defaultPalette;
		radius: 200;
		labelGapSize: 5;
		noPolygonBorder;
		useEllipse;
		usePolygonFillColor;
		noDots
]

{ #category : #accessing }
RSKiviat >> labelGapSize [
	^ labelGapSize
]

{ #category : #accessing }
RSKiviat >> labelGapSize: aNumber [
	labelGapSize := aNumber
]

{ #category : #accessing }
RSKiviat >> labels [
	^ labels
]

{ #category : #accessing }
RSKiviat >> maxValue [
	^ maxValue
]

{ #category : #accessing }
RSKiviat >> maxValue: aNumber [
	maxValue := aNumber
]

{ #category : #accessing }
RSKiviat >> minValue [
	^ minValue
]

{ #category : #accessing }
RSKiviat >> minValue: aNumber [
	minValue := aNumber
]

{ #category : #public }
RSKiviat >> noDots [
	shouldUseDots := false
]

{ #category : #public }
RSKiviat >> noPolygonBorder [
	shouldUsePolygonBorder := false
]

{ #category : #public }
RSKiviat >> noPolygonFillColor [
	shouldUsePolygonFillColor := false
]

{ #category : #accessing }
RSKiviat >> palette [
	^ palette
]

{ #category : #accessing }
RSKiviat >> palette: aNSOrdinalScale [
	palette := aNSOrdinalScale
]

{ #category : #accessing }
RSKiviat >> polygonShape [
	^ polygonShape
]

{ #category : #accessing }
RSKiviat >> polygonShapes [
	^ polygonShapes
]

{ #category : #accessing }
RSKiviat >> radius [
	^ radius
]

{ #category : #accessing }
RSKiviat >> radius: aNumber [
	radius := aNumber
]

{ #category : #hooks }
RSKiviat >> renderAxisIn: aCanvas [
	| delta current deltaRadius divisor |
	divisor := axisNames ifEmpty: [ 1 ] ifNotEmpty: [ axisNames size ].
	delta := Float twoPi / divisor.
	current := Float halfPi negated.
	axis := RSGroup new.
	labels := axisNames collect: [ :name | | label |
		label := self createAxisName: name.
		self fixLabelPosition: label angle: current.
		axis add: (self createAxisLine: name angle: current).
		current := current + delta.
		label ].
	deltaRadius := self tickStep. "should we use nice label generator for ticks?"
	backgroundShapes := (deltaRadius to: radius by: deltaRadius)
		collect: [ :each | shouldUseEllipse
			ifTrue: [ self createEllipseFor: each ]
			ifFalse: [ self createPolygonFor: each ] ].

	aCanvas addAll: backgroundShapes.
	backgroundShapes last
		color: self backgroundColor; "should I draw rings insteadof one one ellipse"
		pushBack.
	aCanvas addAll: axis.
	aCanvas addAll: labels
]

{ #category : #hooks }
RSKiviat >> renderIn: aCanvas [
	self assert: values isNotEmpty description: 'Use addRow: first'.
	axisNames ifNil: [ axisNames := values first collectWithIndex: [ :val :i | i asString ] ].
	self assert: values first size = axisNames size description: 'can not be different'.
	self renderAxisIn: aCanvas.
	self renderValuesIn: aCanvas.
	shapes := backgroundShapes, axis, labels, polygonShapes
]

{ #category : #hooks }
RSKiviat >> renderValuesIn: aCanvas [
	self computeScales.
	polygonShapes := values collect: [ :array | self createValuePolygon: array ].
	aCanvas addAll: polygonShapes
]

{ #category : #testing }
RSKiviat >> shouldUseDots [
	^ shouldUseDots
]

{ #category : #testing }
RSKiviat >> shouldUseEllipse [
	^ shouldUseEllipse
]

{ #category : #testing }
RSKiviat >> shouldUsePolygonBorder [
	^ shouldUsePolygonBorder
]

{ #category : #testing }
RSKiviat >> shouldUsePolygonFillColor [
	^ shouldUsePolygonFillColor
]

{ #category : #'accessing - computed' }
RSKiviat >> tickStep [
	^ radius / 5
]

{ #category : #public }
RSKiviat >> useDots [
	shouldUseDots := true
]

{ #category : #public }
RSKiviat >> useEllipse [
	shouldUseEllipse := true
]

{ #category : #public }
RSKiviat >> usePolygon [
	shouldUseEllipse := false
]

{ #category : #public }
RSKiviat >> usePolygonBorder [
	shouldUsePolygonBorder := true
]

{ #category : #public }
RSKiviat >> usePolygonFillColor [
	shouldUsePolygonFillColor := true
]

{ #category : #accessing }
RSKiviat >> values [
	^ values
]
