"
I am an handy class to build legend in a visualization
"
Class {
	#name : #TSLegend,
	#superclass : #RSAbstractViewBuilder,
	#instVars : [
		'layout',
		'defaultLabel',
		'defaultTitle',
		'defaultCircle',
		'defaultBox',
		'location',
		'menuShape',
		'defaultBoldText'
	],
	#category : #'Roassal3-Legend-Core'
}

{ #category : #hooks }
TSLegend >> basicRenderIn: aView [ 
	| legend |
	legend := shape element.
	location move: legend on: aView elements.
	aView add: legend.
]

{ #category : #'public - composite' }
TSLegend >> composite: refShape text: textShape layout: aLayout [
	^ RSShapeBuilder composite shapes: [ :m| | targetShape g text |
		targetShape := refShape elementOn: m.
		text := textShape elementOn: m.
		g := TSGroup new.
		g add: targetShape; add: text.
		aLayout on: g.
		g ].
	
]

{ #category : #'public - specific' }
TSLegend >> custom: anObject shape: aShape [
	| element |
	"general propuse, you can add and define anything in aShape to be a legend"
	element := aShape elementOn: anObject.
	elements add: element.
	^ element.
]

{ #category : #accessing }
TSLegend >> defaultBoldText [
	^ defaultBoldText ifNil: [ defaultBoldText := RSShapeBuilder label 
		uniqueCommands; bold ].
]

{ #category : #accessing }
TSLegend >> defaultBox [
	^ defaultBox ifNil: [ defaultBox := RSShapeBuilder box 
		uniqueCommands;
		size: 15. ].
]

{ #category : #accessing }
TSLegend >> defaultCircle [
	^ defaultCircle ifNil: [ defaultCircle := RSShapeBuilder circle 
		uniqueCommands;
		size: 15. ]
]

{ #category : #accessing }
TSLegend >> defaultLabel [
	^ defaultLabel ifNil: [ defaultLabel := RSShapeBuilder label ].
]

{ #category : #accessing }
TSLegend >> defaultLabel: aShape [
	defaultLabel := aShape
]

{ #category : #accessing }
TSLegend >> defaultTitle [
	^ defaultTitle ifNil: [ defaultTitle := RSShapeBuilder label fontSize: 20; bold ].
]

{ #category : #accessing }
TSLegend >> defaultTitle: aShape [
	defaultTitle := aShape
]

{ #category : #'public - composite' }
TSLegend >> horizontalComposite: refShape text: textShape [ 
	^ self composite: refShape text: textShape layout: TSHorizontalLineLayout new center.
]

{ #category : #initialization }
TSLegend >> initialize [
	super initialize.
	self reset; initializeShape.
]

{ #category : #initialization }
TSLegend >> initializeShape [
	shape := RSShapeBuilder composite shapes: [ 
		layout on: elements.
		elements ];
		padding: 10;
		draggable.
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
TSLegend >> location [
	^ location
]

{ #category : #accessing }
TSLegend >> menuShape [
	^ menuShape
]

{ #category : #public }
TSLegend >> onDemand [
	self onDemand: 'Help'.
]

{ #category : #public }
TSLegend >> onDemand: text [
	menuShape := RSShapeBuilder label
		text: text;
		color: Color lightGray;
		when: TSMouseEnter do: [ [ :evt | evt shape color: Color blue; signalUpdate ] ];
		when: TSMouseLeave do: [ [ :evt | evt shape color: Color lightGray; signalUpdate ] ]
]

{ #category : #'public - specific' }
TSLegend >> polymetricWidth: labelWidth height: labelHeight box: labelBox [
	"very very specific shape"
	| box s marker line |
	box := RSShapeBuilder box
		size: 100.
	marker := RSShapeBuilder triangle
		color: Color black;
		size: 5; element.
	line := RSSingleEdgeBuilder line 
		marker: marker.
	s := RSShapeBuilder composite shapes: [ | g l1 l2 l3 line1 line2 |
		g := TSGroup new.
		l1 := defaultLabel elementOn: labelWidth.
		l2 := defaultLabel elementOn: labelHeight.
		l3 := defaultLabel elementOn: labelBox.
		l1 position: 0@70.
		l3 scaleBy: 90/ l3 width.
		l2 position: l2 width / 2 negated - 60 @ 0.
		line1 := line from: -50@60; to: 50@60; edge.
		line2 := line from: -60@ -50; to: -60@ 50; edge.
		g addAll: {box element. l1. l2. l3. line1. line2 }.
		g ].
	^ self custom: nil shape: s.
]

{ #category : #hooks }
TSLegend >> renderIn: aView [
	self isOnDemand 
		ifTrue: [ self renderOnDemandIn: aView ]
		ifFalse: [self basicRenderIn: aView ].
	
]

{ #category : #hooks }
TSLegend >> renderOnDemandIn: aView [
	| label i legendLabels update |
	label := menuShape element.
	label isFixed: true.
	aView addShape: label shape.
	i := TSAnimatedPopup new.
	i shape: shape. 
	label @ i.
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
			aView when: TSExtentChangedEvent do: update.
			TSGroup new: 5 ].
	legendLabels add: label.
	update value.

	
]

{ #category : #initialization }
TSLegend >> reset [
	elements := TSGroup new.
	location := RSLocation new below.
	layout := TSLayoutBuilder new.
	layout vertical gapSize: 0.
	defaultBox := defaultCircle := defaultLabel := defaultTitle := nil.
	
		
	
]

{ #category : #public }
TSLegend >> text: aString [
	^ self custom: aString shape: self defaultLabel.
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
	self defaultBox color: color.
	^ self
		custom: aString
		shape: (self horizontalComposite: defaultBox text: self defaultLabel)
]

{ #category : #public }
TSLegend >> text: aString withCircleColor: color [
	self defaultCircle color: color.
	^ self
		custom: aString
		shape: (self horizontalComposite: defaultCircle text: self defaultLabel)
]

{ #category : #'public - specific' }
TSLegend >> text: aString withFadingRamp: ramp [
	| gradient s |
	"very specific shape"
	gradient := TSGradientPalette linearGradient: ramp.
	gradient start: -20@0; stop: 20@0.
	s := RSShapeBuilder box
		extent: 40@20;
		paint: gradient.
	^ self
		custom: aString
		shape: (self horizontalComposite: s text: self defaultLabel)
]

{ #category : #public }
TSLegend >> title: aString [
	^ self custom: aString shape: self defaultTitle.
]

{ #category : #'public - composite' }
TSLegend >> verticalComposite: refShape text: textShape [ 
	^ self composite: refShape text: textShape layout: TSVerticalLineLayout new center
]
