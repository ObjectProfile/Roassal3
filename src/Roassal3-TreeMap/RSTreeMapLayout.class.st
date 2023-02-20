"
A layout for tree map layout
Created by Roberto Minelli for Roassal1
"
Class {
	#name : #RSTreeMapLayout,
	#superclass : #RSLayout,
	#instVars : [
		'rootNodes',
		'extent',
		'inset',
		'rectangle',
		'weight'
	],
	#category : #'Roassal3-TreeMap-Rectangle'
}

{ #category : #hook }
RSTreeMapLayout >> doExecute: shapes [
	"Performs the layout"
	self squarify: rootNodes
		inRectangle: (RSRectangleTreeMap origin: 0@0 extent: self extent)
]

{ #category : #accessing }
RSTreeMapLayout >> extent [
	^ extent
]

{ #category : #accessing }
RSTreeMapLayout >> extent: aPoint [
	extent := aPoint
]

{ #category : #hook }
RSTreeMapLayout >> highestAspectRatioFor: row remainingSpace: remainingSpace [
	| sum areas minArea maxArea |
	areas := row collect: [ :shape | shape propertyAt: #area ].
	sum := areas sum.
	maxArea := areas max.
	minArea := areas min.
	((remainingSpace <=0) or: [minArea <= 0])
		ifTrue: [ ^ SmallInteger maxVal ]
		ifFalse: [ ^ ((((remainingSpace * remainingSpace) * maxArea) / (sum * sum))  max: ((sum * sum) / (minArea * (remainingSpace * remainingSpace)))) ]
]

{ #category : #accessing }
RSTreeMapLayout >> inset [
	^ inset
]

{ #category : #accessing }
RSTreeMapLayout >> inset: aPoint [
	inset := aPoint
]

{ #category : #hook }
RSTreeMapLayout >> layoutChildrenOfRow: row [
	| oldCanvas|
	oldCanvas := self rectangle veryDeepCopy.
	row do: [ :each | | children |
		children := each propertyAt: #schildren ifAbsent: [ #() ].
		self
			squarify: children
			inRectangle: (RSRectangleTreeMap
				fromContainerBounds: (each position extent: each extent)
				withInset: self inset) ].

	self rectangle: oldCanvas
]

{ #category : #hook }
RSTreeMapLayout >> layoutHorizontalRow: row [

	| container totalWidth areaToLayout height |
	container := self rectangle currentSubrectangle.
	totalWidth := container width.
	areaToLayout := row inject: 0 into: [ :s :e | s + (e propertyAt: #area) ].
	height := areaToLayout / totalWidth.
	row do: [ :each | each extent: (((each propertyAt: #area) / height) @ height) ].
	self translateShapesHorizontally: row in: container
]

{ #category : #hook }
RSTreeMapLayout >> layoutRow: row [
	| container |
	container := rectangle currentSubrectangle.
	(container width >= container height)
		ifTrue: [ self layoutVerticalRow: row ]
		ifFalse: [ self layoutHorizontalRow: row ].
	self layoutChildrenOfRow: row.
	self prepareNextRectangleAfterRow: row
]

{ #category : #hook }
RSTreeMapLayout >> layoutVerticalRow: row [
	| container totalHeight areaToLayout width |
	container := rectangle currentSubrectangle.
	totalHeight := container height.
	areaToLayout := row inject: 0 into: [ :s :shape | s + (shape propertyAt: #area) ].
	width := areaToLayout /totalHeight.
	row do: [ :each | each extent: (width @ ( (each propertyAt: #area) / width)) ].
	self translateShapesVertically: row in: container
]

{ #category : #hook }
RSTreeMapLayout >> normalizeAreaOf: shapes byAreaOf: rec [
	| shapesArea viewArea area |
	shapes isEmpty ifTrue: [ ^ shapes ].
	shapesArea := shapes inject: 0 into: [ :s :shape |
		s + (weight rsValue: shape) ].

	viewArea := rec width * rec height.
	shapes do: [ :shape|
		area := ((viewArea * (weight rsValue: shape))/shapesArea) asFloat.
		shape propertyAt: #area put: area. ].

	^ shapes
]

{ #category : #hook }
RSTreeMapLayout >> prepareNextRectangleAfterRow: row [
	| nextRect |
	nextRect := self rectangle currentSubrectangle computeRemainingSubrectangleFrom: row.
	self rectangle addSubrectangle: nextRect
]

{ #category : #accessing }
RSTreeMapLayout >> rectangle [
	^ rectangle
]

{ #category : #hook }
RSTreeMapLayout >> rectangle: aTreeRectangle [
	rectangle := aTreeRectangle
]

{ #category : #accessing }
RSTreeMapLayout >> rootNodes: aCollection [
	rootNodes := aCollection
]

{ #category : #hook }
RSTreeMapLayout >> squarify: children currentRow: row remainingSpace: remainingSpace [
	| firstShape remainingChildren |
	firstShape := children first.
	(row isEmpty or: [
		| oldRatio newShapeRatio |
		oldRatio := self
			highestAspectRatioFor: row
			remainingSpace: remainingSpace.
		newShapeRatio := self
			highestAspectRatioFor: (row, (Array with: firstShape))
			remainingSpace: remainingSpace.
		oldRatio >= newShapeRatio ] )
	ifTrue: [
		remainingChildren := children allButFirst.
		(remainingChildren isEmpty) ifTrue: [
			self layoutRow: (row, (Array with: firstShape))
		] ifFalse: [
			self
				squarify: remainingChildren
				currentRow: (row, (Array with: firstShape) )
				remainingSpace: remainingSpace ]
	 ] ifFalse: [
		self layoutRow: row.
		self
			squarify: children
			currentRow: (OrderedCollection new)
			remainingSpace: self rectangle shortestSide.
	 ].
	firstShape pushBack
]

{ #category : #hook }
RSTreeMapLayout >> squarify: children inRectangle: aTreeRectangle [

	| elementsToLayout |
	children isEmpty ifTrue: [ ^ self  ].
	self rectangle: aTreeRectangle.
	elementsToLayout := self normalizeAreaOf: children byAreaOf: aTreeRectangle.
	self
		squarify: elementsToLayout
		currentRow: OrderedCollection new
		remainingSpace: (aTreeRectangle width min: aTreeRectangle height)
]

{ #category : #hook }
RSTreeMapLayout >> translateShapesHorizontally: row in: container [
	| currentPoint |
	currentPoint := container origin.
	row do: [ :each |
		each translateTo: currentPoint + (each extent / 2).
		currentPoint := currentPoint translateBy: ((each width) @ 0 ) ]
]

{ #category : #hook }
RSTreeMapLayout >> translateShapesVertically: row in: container [
	| currentPoint |
	currentPoint := container origin.
	row do: [ :each |
		each translateBy: currentPoint + (each extent/2).
		currentPoint := currentPoint + (0@(each height)) ]
]

{ #category : #accessing }
RSTreeMapLayout >> weight [
	^ weight
]

{ #category : #accessing }
RSTreeMapLayout >> weight: aBlock [
	weight := aBlock
]
