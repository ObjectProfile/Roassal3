"
I am an handy class to build legend in a visualization

```Smalltalk
scale := NSScale ordinalColored: 4.

values := { 'Bonjour' . 'Guten Morgen' . 'Hello' . 'Hola' }.
c := RSCanvas new.
c @ RSCanvasController.
1 to: 20 do: [ :i |
	txt := values atRandom.
	c add: (RSLabel new text: txt; color: (scale scale: txt)).
].
RSFlowLayout on: c shapes.


legend := RSLegend new.
legend container: c.
legend title: 'Color legend'.
legend text: 'French' withBoxColor: (scale scale: values first).
legend text: 'German' withBoxColor: (scale scale: values second).
legend text: 'English' withBoxColor: (scale scale: values third).
legend text: 'Espagnol' withBoxColor: (scale scale: values fourth).
legend build.

c
```
"
Class {
	#name : #RSLegend,
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
RSLegend >> basicRenderIn: aCanvas [
	| legend |
	legend := self legend.
	location move: legend on: aCanvas shapes.
	aCanvas addShape: legend.
]

{ #category : #'public - specific' }
RSLegend >> customText: anObject shape: aShape [
	| shape |
	"general propuse, you can add and define anything in aShape to be a legend"
	shape := aShape copy text: anObject.
	shapes add: shape.
	^ shape.
]

{ #category : #accessing }
RSLegend >> defaultBoldText [
	^ defaultBoldText ifNil: [ defaultBoldText := RSLabel new bold ].
]

{ #category : #accessing }
RSLegend >> defaultBox [
	^ defaultBox ifNil: [ defaultBox := RSBox new size: 15 ].
]

{ #category : #accessing }
RSLegend >> defaultCircle [
	^ defaultCircle ifNil: [ defaultCircle := RSEllipse new size: 15. ]
]

{ #category : #accessing }
RSLegend >> defaultLabel [
	^ defaultLabel ifNil: [ defaultLabel := RSLabel new ].
]

{ #category : #accessing }
RSLegend >> defaultLabel: aShape [
	defaultLabel := aShape
]

{ #category : #accessing }
RSLegend >> defaultTitle [
	^ defaultTitle ifNil: [ defaultTitle := RSLabel new bold.
		defaultTitle fontSize: defaultTitle fontSize * 1.2.
		defaultTitle ].
]

{ #category : #accessing }
RSLegend >> defaultTitle: aShape [
	defaultTitle := aShape
]

{ #category : #initialization }
RSLegend >> initialize [
	super initialize.
	self reset.
]

{ #category : #testing }
RSLegend >> isOnDemand [
	^ menuShape notNil
]

{ #category : #layout }
RSLegend >> layout [ 
	^ layout
]

{ #category : #accessing }
RSLegend >> legend [
	| legend |
	layout on: self shapes.
	legend := RSComposite new
		shapes: self shapes;
		yourself.
	legendBlock value: legend.
	^ legend
]

{ #category : #public }
RSLegend >> legendDo: aBlock [
	legendBlock := aBlock
]

{ #category : #accessing }
RSLegend >> location [
	^ location
]

{ #category : #accessing }
RSLegend >> menuShape [
	^ menuShape
]

{ #category : #public }
RSLegend >> onDemand [
	^ self onDemand: 'Help'.
]

{ #category : #public }
RSLegend >> onDemand: text [
	^ menuShape := RSLabel new
		text: text;
		color: Color lightGray;
		@ (RSHighlightableInteraction new lowColor: Color lightGray highColor: Color blue);
		yourself
]

{ #category : #'public - specific' }
RSLegend >> polymetricWidth: labelWidth height: labelHeight box: labelBox [
	"very very specific shape"
	| box s marker line g l1 l2 l3 line1 line2  |
	box := RSBox new
		size: 100.
	marker := RSShapeFactory triangle
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
RSLegend >> renderIn: aCanvas [
	self isOnDemand 
		ifTrue: [ self renderOnDemandIn: aCanvas ]
		ifFalse: [self basicRenderIn: aCanvas ].
	
]

{ #category : #hooks }
RSLegend >> renderOnDemandIn: aCanvas [
	| i legendLabels update |
	menuShape isFixed: true.
	aCanvas addShape: menuShape.
	i := RSAnimatedPopup new.
	i shapeBuilder: [ self legend ].
	menuShape @ i.
	legendLabels := nil.
	update := [ 
		RSHorizontalLineLayout on: legendLabels.
		RSLocation new
			inner; top; right;
			offset: -5 @ 5;
			move: legendLabels
				on: aCanvas basicRectangle.
	].
	legendLabels := aCanvas propertyAt: #legendLabels
		ifAbsentPut: [ 
			aCanvas when: RSExtentChangedEvent do: update.
			RSGroup new: 5 ].
	legendLabels add: menuShape.
	update value.

	
]

{ #category : #initialization }
RSLegend >> reset [
	legendBlock := [ :l | l draggable ].
	shapes := RSGroup new.
	location := RSLocation new below.
	layout := RSLayoutBuilder new.
	layout vertical gapSize: 0.
	defaultBox := defaultCircle := defaultLabel := defaultTitle := nil.
	
		
	
]

{ #category : #utilities }
RSLegend >> shape: aShape withColor: color [
	| copy |
	copy := aShape copy.
	copy color: (color rsValue: copy).
	^ copy
]

{ #category : #public }
RSLegend >> text: aString [
	^ self customText: aString shape: self defaultLabel
]

{ #category : #public }
RSLegend >> text: aString description: desc [
	| text tshapes line l d|
	text := self defaultBoldText copy.
	text text: aString.
	d := self defaultLabel copy text: desc.
	tshapes := RSGroup with: text with: d.
	l := RSHorizontalLineLayout new alignMiddle.
	l on: tshapes.
	line := RSComposite new
		shapes: tshapes;
		yourself.
	self shapes add: line.
	^ line
]

{ #category : #public }
RSLegend >> text: aString withBoxColor: color [
	^ self text: aString withShape: (self shape: self defaultBox withColor: color).
]

{ #category : #public }
RSLegend >> text: aString withCircleColor: color [
	^ self text: aString withShape: (self shape: self defaultCircle withColor: color).
]

{ #category : #'public - specific' }
RSLegend >> text: aString withFadingRamp: ramp [
	| gradient s |
	"very specific shape"
	gradient := LinearGradientPaint fromArray: ramp.
	gradient start: -20@0; stop: 20@0.
	s := RSBox new
		extent: 40@20;
		paint: gradient;
		yourself.
	^ self text: aString withShape: s.
	
]

{ #category : #public }
RSLegend >> text: aString withShape: aShape [
	| text tshapes line l |
	text := self defaultLabel copy.
	text text: aString.
	tshapes := RSGroup with: aShape with: text.
	l := RSHorizontalLineLayout new alignMiddle.
	l on: tshapes.
	line := RSComposite new
		shapes: tshapes;
		yourself.
	self shapes add: line.
	^ line
]

{ #category : #public }
RSLegend >> title: aString [
	^ self customText: aString shape: self defaultTitle
]

{ #category : #public }
RSLegend >> withFrame [
	"Set a frame around the legend"
	self legendDo: [ :l |
		l 
			border: RSBorder new;
			color: (Color white alpha: 0.8);
			padding: 10.
		].
]
