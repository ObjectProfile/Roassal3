"
I am an handy class to build legend in a visualization
"
Class {
	#name : #TSLegend,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'layout',
		'defaultLabel',
		'defaultTitle',
		'defaultCircle',
		'defaultBox',
		'location',
		'menuShape',
		'defaultBoldText',
		'legendBlock'
	],
	#category : #'Roassal3-Legend-Core'
}

{ #category : #hooks }
TSLegend >> basicRenderIn: aCanvas [
	| legend |
	legend := self legend.
	location move: legend on: aCanvas shapes.
	aCanvas addShape: legend.
]

{ #category : #'public - specific' }
TSLegend >> customText: anObject shape: aShape [
	| shape |
	"general propuse, you can add and define anything in aShape to be a legend"
	shape := aShape copy text: anObject asString.
	shapes add: shape.
	^ shape.
]

{ #category : #accessing }
TSLegend >> defaultBoldText [
	^ defaultBoldText ifNil: [ defaultBoldText := RSLabel new bold ].
]

{ #category : #accessing }
TSLegend >> defaultBox [
	^ defaultBox ifNil: [ defaultBox := RSBox new size: 15 ].
]

{ #category : #accessing }
TSLegend >> defaultCircle [
	^ defaultCircle ifNil: [ defaultCircle := RSEllipse new size: 15. ]
]

{ #category : #accessing }
TSLegend >> defaultLabel [
	^ defaultLabel ifNil: [ defaultLabel := RSLabel new ].
]

{ #category : #accessing }
TSLegend >> defaultLabel: aShape [
	defaultLabel := aShape
]

{ #category : #accessing }
TSLegend >> defaultTitle [
	^ defaultTitle ifNil: [ defaultTitle := RSLabel new fontSize: 20; bold ].
]

{ #category : #accessing }
TSLegend >> defaultTitle: aShape [
	defaultTitle := aShape
]

{ #category : #initialization }
TSLegend >> initialize [
	super initialize.
	self reset.
]

{ #category : #testing }
TSLegend >> isOnDemand [
	^ menuShape notNil
]

{ #category : #layout }
TSLegend >> layout [ 
	^ layout
]

{ #category : #accessing }
TSLegend >> legend [
	| legend |
	layout on: self shapes.
	legend := RSComposite new
		shapes: self shapes;
		yourself.
	legendBlock value: legend.
	^ legend
]

{ #category : #public }
TSLegend >> leyendDo: aBlock [
	legendBlock := aBlock
]

{ #category : #accessing }
TSLegend >> location [
	^ location
]

{ #category : #accessing }
TSLegend >> menuShape [
	^ menuShape
]

{ #category : #public }
TSLegend >> onDemand [
	^ self onDemand: 'Help'.
]

{ #category : #public }
TSLegend >> onDemand: text [
	^ menuShape := RSLabel new
		text: text;
		color: Color lightGray;
		@ (RSHighlightable new low: Color lightGray high: Color blue);
		yourself
]

{ #category : #'public - specific' }
TSLegend >> polymetricWidth: labelWidth height: labelHeight box: labelBox [
	"very very specific shape"
	| box s marker line g l1 l2 l3 line1 line2  |
	box := RSBox new
		size: 100.
	marker := RSShape triangle
		color: Color black;
		size: 5.
	line := RSLine new 
		marker: marker;
		yourself.
	g := RSGroup new.
	l1 := defaultLabel copy text: labelWidth.
	l2 := defaultLabel copy text: labelHeight.
	l3 := defaultLabel copy text: labelBox.
	l1 position: 0@70.
	l3 scaleBy: 90/ l3 width.
	l2 position: l2 width / 2 negated - 60 @ 0.
	line1 := line copy startPoint:  -50@60; endPoint: 50@60.
	line2 := line copy startPoint: -60@ -50; endPoint: -60@ 50.
	g addAll: {box. l1. l2. l3. line1. line2 }.
	s := RSComposite new
		shapes: g.
	self shapes add: s.
	

]

{ #category : #hooks }
TSLegend >> renderIn: aCanvas [
	self isOnDemand 
		ifTrue: [ self renderOnDemandIn: aCanvas ]
		ifFalse: [self basicRenderIn: aCanvas ].
	
]

{ #category : #hooks }
TSLegend >> renderOnDemandIn: aView [
	| i legendLabels update |
	menuShape isFixed: true.
	aView addShape: menuShape.
	i := RSAnimatedPopup new.
	i shapeBuilder: [ self legend ].
	menuShape @ i.
	legendLabels := nil.
	update := [ 
		TSHorizontalLineLayout on: legendLabels.
		RSLocation new
			inner; top; right;
			move: legendLabels 
				on: aView basicRectangle.
	].
	legendLabels := aView attributes 
		at: #legendLabels
		ifAbsentPut: [ 
			aView when: RSExtentChangedEvent do: update.
			RSGroup new: 5 ].
	legendLabels add: menuShape.
	update value.

	
]

{ #category : #initialization }
TSLegend >> reset [
	legendBlock := [ :l | l draggable ].
	shapes := RSGroup new.
	location := RSLocation new below.
	layout := TSLayoutBuilder new.
	layout vertical gapSize: 0.
	defaultBox := defaultCircle := defaultLabel := defaultTitle := nil.
	
		
	
]

{ #category : #utilities }
TSLegend >> shape: aShape withColor: color [
	| copy |
	copy := aShape copy.
	copy color: (color rsValue: copy).
	^ copy
]

{ #category : #public }
TSLegend >> text: aString [
	^ self customText: aString shape: self defaultLabel
]

{ #category : #public }
TSLegend >> text: aString description: desc [
	self defaultBoldText text: aString.
	^ self
		custom: desc
		shape: (self horizontalComposite: self defaultBoldText text: self defaultLabel)
]

{ #category : #public }
TSLegend >> text: aString withBoxColor: color [
	^ self text: aString withShape: (self shape: self defaultBox withColor: color).
]

{ #category : #public }
TSLegend >> text: aString withCircleColor: color [
	^ self text: aString withShape: (self shape: self defaultCircle withColor: color).
]

{ #category : #'public - specific' }
TSLegend >> text: aString withFadingRamp: ramp [
	| gradient s |
	"very specific shape"
	gradient := RSGradientPalette linearGradient: ramp.
	gradient start: -20@0; stop: 20@0.
	s := RSBox new
		extent: 40@20;
		paint: gradient;
		yourself.
	^ self text: aString withShape: s.
	
]

{ #category : #public }
TSLegend >> text: aString withShape: aShape [
	| text tshapes line l |
	text := self defaultLabel copy.
	text text: aString.
	tshapes := RSGroup with: aShape with: text.
	l := TSHorizontalLineLayout new center.
	l on: tshapes.
	line := RSComposite new
		shapes: tshapes;
		yourself.
	self shapes add: line.
	^ line
]

{ #category : #public }
TSLegend >> title: aString [
	^ self customText: aString shape: self defaultTitle
]
