"
I build canvas to show hierarchical information, a kind of flattened Sunburst.

Reference:
https://github.com/brendangregg/FlameGraph

"
Class {
	#name : #RSFlameGraph,
	#superclass : #RSAbstractTreeBuilder,
	#instVars : [
		'gap',
		'boxShape',
		'graphWidth',
		'boxHeight'
	],
	#category : #'Roassal3-FlameGraph'
}

{ #category : #accessing }
RSFlameGraph >> boxHeight: anInteger [
	"Set the height for the rectangles that will represent the nodes of the tree."

	boxHeight := anInteger
]

{ #category : #accessing }
RSFlameGraph >> boxShape [

	^ boxShape
]

{ #category : #private }
RSFlameGraph >> doLayout [
	"Establish the position and extent of each rectangle of the graph."

	| virtual roots |
	roots := self rootNodes.
	roots isEmpty ifTrue: [ ^ self ].
	roots size = 1
		ifTrue: [
			roots first width: graphWidth.
			self layoutFlameGraph: roots first ]
		ifFalse: [
			virtual := self shapeFor: nil.
			virtual width: graphWidth.
			virtual schildren: roots.
			roots do: [ :shape | shape sparent: virtual ].
			virtual sparent: nil.
			virtual depth: 0.
			self layoutFlameGraph: virtual.
			roots do: [ :shape | shape sparent: nil ]	 ]
]

{ #category : #accessing }
RSFlameGraph >> gap [

	^ gap
]

{ #category : #accessing }
RSFlameGraph >> gap: aPoint [
	"Set the gap between the rectangles.
	The x value represents the horizontal gap between siblings.
	The y value represents the vertical gap between parents and children."

	gap := aPoint
]

{ #category : #accessing }
RSFlameGraph >> graphWidth: anInteger [
	"Set the expected width for the roots."

	graphWidth := anInteger
]

{ #category : #initialization }
RSFlameGraph >> initialize [

	super initialize.

	boxShape := RSBox new.

	self
		graphWidth: 500;
		boxHeight: 20;
		gap: 1 asPoint
]

{ #category : #rendering }
RSFlameGraph >> layoutFlameGraph: aShape [

	self
		setupVerticallyOn: aShape;
		setupHorizontallyOn: aShape
]

{ #category : #rendering }
RSFlameGraph >> renderIn: aCanvas [

	super renderIn: aCanvas.

	self doLayout
]

{ #category : #rendering }
RSFlameGraph >> setupHorizontallyOn: shape [

	| children parentX parentWidth parentWeight ratio gap2 |
	parentX := shape encompassingRectangle origin x.
	parentWidth := shape width.
	parentWeight := self weightOf: shape.
	children := shape schildren.
	gap2 := self gap x.

	ratio := parentWidth / parentWeight.
	children do: [ :child |
		| a b |
		a := parentX.
		b := ratio * (self weightOf: child).
		parentX := a + b.

		b > gap2 ifTrue: [ b := b - gap2.].

		child
			position: (a+(b / 2)) @ child position y ;
			width: b.
		self layoutFlameGraph: child ]
]

{ #category : #rendering }
RSFlameGraph >> setupVerticallyOn: aShape [

	| depth y |
	depth := aShape propertyAt: #depth.
	y := depth * (boxHeight + gap y).

	aShape
		position: (aShape position x @ y negated);
		height: boxHeight
]

{ #category : #rendering }
RSFlameGraph >> shapeFor: anObject [

	^ self boxShape copyWithAnnouncer
		model: anObject;
		yourself
]
