"
Use RSTreeMap to visualize trees similar to file system where each leaf has a metric value and each branch is a container of more branches or leafs
"
Class {
	#name : #RSTreeMap,
	#superclass : #RSAbstractTreeBuilder,
	#instVars : [
		'boxShape',
		'extent',
		'inset'
	],
	#category : #'Roassal3-TreeMap-Core'
}

{ #category : #accessing }
RSTreeMap >> boxShape [
	^ boxShape
]

{ #category : #defaults }
RSTreeMap >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #public }
RSTreeMap >> depthShadedBorder [
	| color depths |
	depths := self shapes collect: [ :shape | shape depth ] as: SortedCollection.
	color := NSScale linear
		domain: { depths first. depths last};
		range: { Color gray. Color white darker }.
	self shapes do: [ :shape |
		shape border: (RSBorder new color: (color rsValue: shape depth))  ]
]

{ #category : #accessing }
RSTreeMap >> extent [
	^ extent
]

{ #category : #accessing }
RSTreeMap >> extent: aPoint [
	extent := aPoint
]

{ #category : #private }
RSTreeMap >> focalPointFor: shape [
	| parent b1 b2 l1 rect |
	parent := shape sparent.
	rect := shape encompassingRectangle.
	(rect containsPoint: parent position)
		ifTrue: [ ^ parent position - shape position ].
	b1 := RSBox new size: 1; position: parent position.
	b2 := RSBox new fromRectangle: rect.
	l1 := RSLine new from: b1; to: b2.
	l1 color: Color black.
	l1 withBorderAttachPoint.
	l1 update.
	^ l1 endPoint - shape position
]

{ #category : #public }
RSTreeMap >> gradientFill: palette block: aBlock [
	^ self shapes
		collect: [ :shape | self gradientFill: palette block: aBlock shape: shape ]
		as: Bag
]

{ #category : #private }
RSTreeMap >> gradientFill: palette block: aBlock shape: shape [
	| attribute paint color |
	attribute := aBlock rsValue: shape model.
	shape isSLeaf ifFalse: [ ^ attribute ].
	paint := RadialGradientPaint new
		center: 0@0;
		focalPoint: (self focalPointFor: shape);
		radius: shape extent max * 0.8;
		yourself.
	color := palette scale: attribute.
	paint colorRamp:
		{ 0 -> (color alphaMixed: 0.2 with: Color white).
		0.3 -> (color alphaMixed: 0.7 with: Color white).
		0.6 -> color}.
	shape paint: paint.
	^ attribute
]

{ #category : #initialization }
RSTreeMap >> initialize [
	super initialize.
	boxShape := RSBox new
		withBorder;
		popup;
		yourself.
	self
		extent: 500@500;
		inset: 4
]

{ #category : #accessing }
RSTreeMap >> inset [
	^ inset
]

{ #category : #accessing }
RSTreeMap >> inset: aPoint [
	inset := aPoint
]

{ #category : #rendering }
RSTreeMap >> renderIn: aCanvas [
	super renderIn: aCanvas.
	RSTreeMapLayout new
		rootNodes: rootNodes;
		inset: self inset;
		extent: self extent;
		weight: self weight;
		on: shapes
]

{ #category : #hooks }
RSTreeMap >> shapeFor: anObject [
	^ self boxShape copyWithAnnouncer
		model: anObject;
		yourself
]
