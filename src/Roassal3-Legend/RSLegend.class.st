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
		'defaults',
		'location',
		'menuShape',
		'legendBlock',
		'isFixed',
		'isOnDemand',
		'currentLegend'
	],
	#category : #'Roassal3-Legend-Core'
}

{ #category : #hooks }
RSLegend >> basicRenderIn: aCanvas [
	| legend |
	legend := self createLegend.
	location move: legend on: aCanvas shapes.
	aCanvas addShape: legend
]

{ #category : #public }
RSLegend >> beFixedWithTitle: aString [
	isFixed := true.
	^ menuShape := self defaultTitle copy
		text: aString;
		yourself
]

{ #category : #'public - specific' }
RSLegend >> boxHeightIcon [
	| box marker arrow icon |
	box := RSBox new
		border: (RSBorder new color: Color black; width: 2);
		extent: 15@15;
		color: Color white;
		yourself.
	marker := RSShapeFactory arrow
		size: 10;
		color: Color black;
		yourself.
	arrow := RSLine new
		startPoint: 0@0;
		endPoint: 0 @ box height;
		color: Color black;
		marker: marker;
		yourself.
	icon := { arrow. box }.
	RSHorizontalLineLayout new gapSize: 5; on: icon.
	^ icon asGroup asShape
]

{ #category : #'public - specific' }
RSLegend >> boxHeightText: aString [
	^ self boxText: aString icon: self boxHeightIcon
]

{ #category : #'public - specific' }
RSLegend >> boxText: aString icon: aShape [
	| group row |
	group := { aShape. self defaultLabel copy text: aString }.
	RSHorizontalLineLayout new gapSize: 5; on: group.
	row := group asGroup asShape.
	row padding: (Margin fromPoint: 0@5).
	shapes add: row.
	^ row
]

{ #category : #'public - specific' }
RSLegend >> boxWidthIcon [
	| box marker arrow icon |
	box := RSBox new
		border: (RSBorder new color: Color black; width: 2);
		extent: 25@15;
		color: Color white;
		yourself.
	marker := RSShapeFactory arrow
		size: 10;
		color: Color black;
		yourself.
	arrow := RSLine new
		startPoint: 0@0;
		endPoint: box width @ 0;
		color: Color black;
		marker: marker;
		yourself.
	icon := { box. arrow }.
	RSVerticalLineLayout new gapSize: 5; on: icon.
	^ icon asGroup asShape
]

{ #category : #'public - specific' }
RSLegend >> boxWidthText: aString [
	^ self boxText: aString icon: self boxWidthIcon
]

{ #category : #private }
RSLegend >> createLegend [
	| legend |
	layout on: self shapes.
	legend := RSComposite new
		shapes: self shapes;
		yourself.
	legendBlock value: legend.
	currentLegend := legend.
	^ legend
]

{ #category : #'public - specific' }
RSLegend >> customText: anObject shape: aShape [
	| shape |
	"general propuse, you can add and define anything in aShape to be a legend"
	shape := aShape copy text: anObject.
	shapes add: shape.
	^ shape
]

{ #category : #accessing }
RSLegend >> defaultBoldText [
	^ defaults at: #defaultBoldText ifAbsentPut: [ RSLabel new bold ]
]

{ #category : #accessing }
RSLegend >> defaultBox [
	^ defaults at: #defaultBox ifAbsentPut: [ RSBox new size: 15 ]
]

{ #category : #accessing }
RSLegend >> defaultCircle [
	^ defaults at: #defaultCircle ifAbsentPut: [ RSEllipse new size: 15 ]
]

{ #category : #accessing }
RSLegend >> defaultLabel [
	^ defaults at: #defaultLabel ifAbsentPut: [ RSLabel new ]
]

{ #category : #accessing }
RSLegend >> defaultLabel: aShape [
	defaults at: #defaultLabel put: aShape
]

{ #category : #accessing }
RSLegend >> defaultTitle [
	^ defaults at: #defaultTitle ifAbsentPut: [ | l |
		l := RSLabel new.
		l fontSize: l fontSize * 1.2.
		l  ]
]

{ #category : #accessing }
RSLegend >> defaultTitle: aShape [
	defaults at: #defaultTitle put: aShape
]

{ #category : #initialization }
RSLegend >> initialize [
	super initialize.
	self reset
]

{ #category : #testing }
RSLegend >> isFixed [
	^ isFixed
]

{ #category : #testing }
RSLegend >> isOnDemand [
	^ isOnDemand
]

{ #category : #utilities }
RSLegend >> key [
	^ #legendLabels
]

{ #category : #layout }
RSLegend >> layout [
	^ layout
]

{ #category : #accessing }
RSLegend >> legend [
	^ currentLegend
]

{ #category : #public }
RSLegend >> legendDo: aBlock [
	legendBlock := aBlock
]

{ #category : #private }
RSLegend >> legendLabelsIn: aCanvas [
	^ aCanvas propertyAt: self key ifAbsentPut: [
		aCanvas when: RSExtentChangedEvent send: #updateLegendLabels: to: self.
		RSGroup new: 5 ]
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
	^ self onDemand: 'Help'
]

{ #category : #public }
RSLegend >> onDemand: text [
	isOnDemand := true.
	^ menuShape := RSLabel new
		text: text;
		color: Color lightGray;
		@ (RSHighlightable new lowColor: Color lightGray highColor: Color blue);
		yourself
]

{ #category : #'public - specific' }
RSLegend >> polymetricWidth: labelWidth height: labelHeight box: labelBox [
	"very very specific shape"
	| box s marker line g l1 l2 l3 line1 line2 defaultLabel |
	box := RSBox new
		size: 100.
	marker := RSShapeFactory triangle
		color: Color black;
		size: 5.
	line := RSLine new
		marker: marker;
		yourself.
	g := RSGroup new.
	defaultLabel := self defaultLabel.
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
	^ s
]

{ #category : #hooks }
RSLegend >> renderFixedOn: aCanvas [
	| legend legendLabels originalShapes flag |
	shapes addFirst: menuShape.
	originalShapes := shapes copy.
	legend := self createLegend.
	legend isFixed: true.
	aCanvas addShape: legend.
	legendLabels := self legendLabelsIn: aCanvas.
	legendLabels add: legend.
	self updateLegendLabels: aCanvas.
	flag := true.
	legend when: RSMouseClick do: [ :evt |
		legend remove.
		legendLabels remove: legend.
		shapes := flag
			ifTrue: [ { menuShape } ]
			ifFalse: [ originalShapes ].
		flag := flag not.
		legend := self createLegend.
		legend isFixed: true.
		legend announcer: evt shape announcer.
		aCanvas addShape: legend.
		legendLabels add: legend.
		self updateLegendLabels: aCanvas.
		evt signalUpdate ]
]

{ #category : #hooks }
RSLegend >> renderIn: aCanvas [
	self isOnDemand
		ifTrue: [ self renderOnDemandIn: aCanvas ]
		ifFalse: [
			self isFixed
				ifTrue: [ self renderFixedOn: aCanvas ]
				ifFalse: [self basicRenderIn: aCanvas ] ]
]

{ #category : #hooks }
RSLegend >> renderOnDemandIn: aCanvas [
	| i legendLabels |
	menuShape isFixed: true.
	aCanvas addShape: menuShape.
	i := RSAnimatedPopup new.
	i shapeBuilder: [ self createLegend ].
	menuShape @ i.
	legendLabels := self legendLabelsIn: aCanvas.
	legendLabels add: menuShape.
	self updateLegendLabels: aCanvas
]

{ #category : #initialization }
RSLegend >> reset [
	legendBlock := [ :l | l draggable ].
	shapes := RSGroup new.
	location := RSLocation new below.
	layout := RSLayoutBuilder new.
	layout vertical gapSize: 0.
	isFixed := false.
	isOnDemand := false.
	defaults := Dictionary new
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
	^ self text: aString withShape: (self shape: self defaultBox withColor: color)
]

{ #category : #public }
RSLegend >> text: aString withCircleColor: color [
	^ self text: aString withShape: (self shape: self defaultCircle withColor: color)
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
	^ self text: aString withShape: s
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

{ #category : #private }
RSLegend >> updateLegendLabels: evt [
	| legendLabels |
	legendLabels := self legendLabelsIn: evt canvas.
	RSHorizontalLineLayout on: legendLabels.
	RSLocation new
		inner; top; right;
		offset: -5 @ 5;
		move: legendLabels on: evt canvas basicRectangle
]

{ #category : #public }
RSLegend >> withFrame [
	"Set a frame around the legend"
	self legendDo: [ :l |
		l
			border: RSBorder new;
			color: (Color white alpha: 0.8);
			padding: 10.
		]
]
