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
	#name : #RSLegendBuilder,
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
RSLegendBuilder >> basicRenderIn: aCanvas [
	| legend |
	legend := self legend.
	location move: legend on: aCanvas shapes.
	aCanvas addShape: legend.
]

{ #category : #'public - specific' }
RSLegendBuilder >> customText: anObject shape: aShape [
	| shape |
	"general propuse, you can add and define anything in aShape to be a legend"
	shape := aShape copy text: anObject.
	shapes add: shape.
	^ shape.
]

{ #category : #accessing }
RSLegendBuilder >> defaultBoldText [
	^ defaultBoldText ifNil: [ defaultBoldText := RSLabel new bold ].
]

{ #category : #accessing }
RSLegendBuilder >> defaultBox [
	^ defaultBox ifNil: [ defaultBox := RSBox new size: 15 ].
]

{ #category : #accessing }
RSLegendBuilder >> defaultCircle [
	^ defaultCircle ifNil: [ defaultCircle := RSEllipse new size: 15. ]
]

{ #category : #accessing }
RSLegendBuilder >> defaultLabel [
	^ defaultLabel ifNil: [ defaultLabel := RSLabel new ].
]

{ #category : #accessing }
RSLegendBuilder >> defaultLabel: aShape [
	defaultLabel := aShape
]

{ #category : #accessing }
RSLegendBuilder >> defaultTitle [
	^ defaultTitle ifNil: [ defaultTitle := RSLabel new bold.
		defaultTitle fontSize: defaultTitle fontSize * 1.2.
		defaultTitle ].
]

{ #category : #accessing }
RSLegendBuilder >> defaultTitle: aShape [
	defaultTitle := aShape
]

{ #category : #initialization }
RSLegendBuilder >> initialize [
	super initialize.
	self reset.
]

{ #category : #testing }
RSLegendBuilder >> isOnDemand [
	^ menuShape notNil
]

{ #category : #layout }
RSLegendBuilder >> layout [ 
	^ layout
]

{ #category : #accessing }
RSLegendBuilder >> legend [
	| legend |
	layout on: self shapes.
	legend := RSComposite new
		shapes: self shapes;
		yourself.
	legendBlock value: legend.
	^ legend
]

{ #category : #public }
RSLegendBuilder >> legendDo: aBlock [
	legendBlock := aBlock
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
	^ self onDemand: 'Help'.
]

{ #category : #public }
RSLegendBuilder >> onDemand: text [
	^ menuShape := RSLabel new
		text: text;
		color: Color lightGray;
		@ (RSHighlightable new lowColor: Color lightGray highColor: Color blue);
		yourself
]

{ #category : #'public - specific' }
RSLegendBuilder >> polymetricWidth: labelWidth height: labelHeight box: labelBox [
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
RSLegendBuilder >> renderIn: aCanvas [
	self isOnDemand 
		ifTrue: [ self renderOnDemandIn: aCanvas ]
		ifFalse: [self basicRenderIn: aCanvas ].
	
]

{ #category : #hooks }
RSLegendBuilder >> renderOnDemandIn: aCanvas [
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
RSLegendBuilder >> reset [
	legendBlock := [ :l | l draggable ].
	shapes := RSGroup new.
	location := RSLocation new below.
	layout := RSLayoutBuilder new.
	layout vertical gapSize: 0.
	defaultBox := defaultCircle := defaultLabel := defaultTitle := nil.
	
		
	
]

{ #category : #utilities }
RSLegendBuilder >> shape: aShape withColor: color [
	| copy |
	copy := aShape copy.
	copy color: (color rsValue: copy).
	^ copy
]

{ #category : #public }
RSLegendBuilder >> text: aString [
	^ self customText: aString shape: self defaultLabel
]

{ #category : #public }
RSLegendBuilder >> text: aString description: desc [
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
RSLegendBuilder >> text: aString withBoxColor: color [
	^ self text: aString withShape: (self shape: self defaultBox withColor: color).
]

{ #category : #public }
RSLegendBuilder >> text: aString withCircleColor: color [
	^ self text: aString withShape: (self shape: self defaultCircle withColor: color).
]

{ #category : #'public - specific' }
RSLegendBuilder >> text: aString withFadingRamp: ramp [
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
RSLegendBuilder >> text: aString withShape: aShape [
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
RSLegendBuilder >> title: aString [
	^ self customText: aString shape: self defaultTitle
]

{ #category : #public }
RSLegendBuilder >> withFrame [
	"Set a frame around the legend"
	self legendDo: [ :l |
		l 
			border: RSBorder new;
			color: (Color white alpha: 0.8);
			padding: 10.
		].
]
