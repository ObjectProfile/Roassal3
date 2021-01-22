Class {
	#name : #RSColoredTreePalette,
	#superclass : #RSObject,
	#instVars : [
		'shapes'
	],
	#category : #'Roassal3-Colors'
}

{ #category : #'as yet unclassified' }
RSColoredTreePalette >> assignColor [

	| roots |
	roots := shapes select: [ :s | s numberOfIncomingLines = 0 ].
	roots do: [ :r | self assignColorToRoot: r ]
]

{ #category : #'as yet unclassified' }
RSColoredTreePalette >> assignColorToChildren: children low: low high: high [
	| step hs |
	step := high - low / children size.
	hs := low to: high count: children size.
	children with: hs do: [ :s :h |
		self assignColorToRoot: s h: (h min: 1 max: 0)
	]
	
]

{ #category : #'as yet unclassified' }
RSColoredTreePalette >> assignColorToRoot: aRootShape [
	self assignColorToRoot: aRootShape h: 0.5
]

{ #category : #'as yet unclassified' }
RSColoredTreePalette >> assignColorToRoot: aRootShape h: h [
	| children |
	"Halt if: [ aRootShape color = RSBox new color ]."
	
	aRootShape color: (Color h: h s: 1 v: 1).
	children := aRootShape outgoingLines collect: #to.
	children ifEmpty: [ ^ self ].
	self assignColorToChildren: children low: h - 0.01 high: h + 0.01.
]

{ #category : #accessing }
RSColoredTreePalette >> shapes [

	^ shapes
]

{ #category : #accessing }
RSColoredTreePalette >> shapes: someShapes [

	shapes := someShapes
]
