"
I am an handy class to build legend in a visualization
"
Class {
	#name : #RSLegendBuilder,
	#superclass : #RSAbstractBuilder,
	#instVars : [
		'layout',
		'padding',
		'defaultLabel',
		'defaultTitle',
		'defaultCircle',
		'defaultBox',
		'location',
		'menuShape'
	],
	#category : #'Roassal3-Legend'
}

{ #category : #'public - composite' }
RSLegendBuilder >> composite: refShape text: textShape layout: aLayout [
	^ RSShapeBuilder composite shapes: [ :m| | targetShape g text |
		targetShape := refShape class = RSShapeBuilder
			ifTrue: [ refShape elementOn: m]
			ifFalse: [ refShape edgeOn: m ]. "TODO do we need to separate elementOn: and edgeOn:?"
		text := textShape elementOn: m.
		g := TSGroup new.
		g add: targetShape; add: text.
		aLayout on: g.
		g ].
	
]

{ #category : #'public - specific' }
RSLegendBuilder >> custom: anObject shape: aShape [
	| element |
	"general propuse, you can add and define anything in aShape to be a legend"
	element := aShape elementOn: anObject.
	elements add: element.
	^ element.
]

{ #category : #accessing }
RSLegendBuilder >> defLabel [
	^ defaultLabel ifNil: [ defaultLabel := RSShapeBuilder label ].
]

{ #category : #accessing }
RSLegendBuilder >> defLabel: aShape [
	defaultLabel := aShape
]

{ #category : #accessing }
RSLegendBuilder >> defaultBox [
	^ defaultBox ifNil: [ defaultBox := RSShapeBuilder box 
		uniqueCommands;
		size: 15. ].
]

{ #category : #accessing }
RSLegendBuilder >> defaultCircle [
	^ defaultCircle ifNil: [ defaultCircle := RSShapeBuilder circle 
		uniqueCommands;
		size: 15. ]
]

{ #category : #accessing }
RSLegendBuilder >> defaultTitle [
	^ defaultTitle ifNil: [ defaultTitle := RSShapeBuilder label fontSize: 20; bold ].
]

{ #category : #accessing }
RSLegendBuilder >> defaultTitle: aShape [
	defaultTitle := aShape
]

{ #category : #'public - composite' }
RSLegendBuilder >> horizontalComposite: refShape text: textShape [ 
	^ self composite: refShape text: textShape layout: RSHorizontalLineLayout new center.
]

{ #category : #initialization }
RSLegendBuilder >> initialize [
	super initialize.
	self reset; initializeShape.
]

{ #category : #initialization }
RSLegendBuilder >> initializeShape [
	shape := RSShapeBuilder composite shapes: [ 
		layout on: elements.
		elements. ];
		padding: [padding];
		draggable.
]

{ #category : #layout }
RSLegendBuilder >> layout [ 
	^ layout
]

{ #category : #accessing }
RSLegendBuilder >> location [
	^ location
]

{ #category : #accessing }
RSLegendBuilder >> menuShape [
	^ menuShape
]

{ #category : #public }
RSLegendBuilder >> onDemand [
	self onDemand: 'Help'.
]

{ #category : #public }
RSLegendBuilder >> onDemand: text [
	menuShape := RSShapeBuilder label
		text: text;
		color: Color lightGray;
		when: TSMouseEnter do: [ [ :evt | evt shape color: Color blue; signalUpdate ] ];
		when: TSMouseLeave do: [ [ :evt | evt shape color: Color lightGray; signalUpdate ] ]
]

{ #category : #accessing }
RSLegendBuilder >> padding [
	^ padding
]

{ #category : #accessing }
RSLegendBuilder >> padding: anObject [
	"Number point or Margin"
	padding := anObject.
]

{ #category : #'public - specific' }
RSLegendBuilder >> polymetricWidth: labelWidth height: labelHeight box: labelBox [
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
RSLegendBuilder >> renderIn: aView [
	| legend label position |
	legend := shape element.
	menuShape ifNil: [ 
		location move: legend on: aView elements.
		aView add: legend.
		^ self. ].
	
	label := menuShape element.
	label isFixed: true.
	legend isFixed: true.
	aView addShape: label trachelShape.
	position := legend position.
	label when: TSMouseEnter do: [ :m | | p |
		aView add: legend.
		p := position.
		p := TSScale linear range: { p x @ (p y - (legend extent y/2)). p }.
		aView animation duration: 400 milliSeconds; from: 0.05; to: 1; onStepDo: [ :t | 
			legend matrix loadIdentity; 
				translation: (p scale: t);
				scaleBy: 1@t.
			legend signalUpdate].
		].
	label when: TSMouseLeave do: [ :m | legend remove ].
	aView when: TSExtentChangedEvent do: [ 
		RSLocate new 
			inner; top; right;
			move: label on: (Rectangle origin: 0@0 extent: aView extent);
			outer; bottom;
			offset: legend extent x negated - 5 @ 0;
			move: legend on: label.
		position := legend position. ].
	
		


]

{ #category : #initialization }
RSLegendBuilder >> reset [
	elements := TSGroup new.
	padding := 5.
	location := RSLocate new below.
	layout := RSLayoutBuilder new.
	layout vertical gapSize: 0.
	defaultBox := defaultCircle := defaultLabel := defaultTitle := nil.
	
		
	
]

{ #category : #public }
RSLegendBuilder >> text: aString [
	^ self custom: aString shape: self defLabel.
]

{ #category : #public }
RSLegendBuilder >> text: aString description: desc [
	| s |
	s := RSShapeBuilder label
		text: aString;
		bold.
	^ self
		custom: desc
		shape: (self horizontalComposite: s text: self defLabel)
]

{ #category : #public }
RSLegendBuilder >> text: aString withBoxColor: color [
	self defaultBox color: color.
	^ self
		custom: aString
		shape: (self horizontalComposite: defaultBox text: self defLabel)
]

{ #category : #public }
RSLegendBuilder >> text: aString withCircleColor: color [
	self defaultCircle color: color.
	^ self
		custom: aString
		shape: (self horizontalComposite: defaultCircle text: self defLabel)
]

{ #category : #'public - specific' }
RSLegendBuilder >> text: aString withFadingRamp: ramp [
	| gradient s |
	"very specific shape"
	gradient := TSGradientPalette linearGradient: ramp.
	gradient start: -20@0; stop: 20@0.
	s := RSShapeBuilder box
		extent: 40@20;
		paint: gradient.
	^ self
		custom: aString
		shape: (self horizontalComposite: s text: self defLabel)
]

{ #category : #public }
RSLegendBuilder >> title: aString [
	^ self custom: aString shape: self defaultTitle.
]

{ #category : #'public - composite' }
RSLegendBuilder >> verticalComposite: refShape text: textShape [ 
	^ self composite: refShape text: textShape layout: RSVerticalLineLayout new center
]
