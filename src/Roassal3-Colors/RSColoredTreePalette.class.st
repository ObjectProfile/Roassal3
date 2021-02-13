"
Set the colors on a tree, based on the number of leaves

```
c := RSCanvas new.
nodes := RSBox models: (1 to: 10).
c addAll: nodes.
nodes @ RSPopup.
lb := RSLineBuilder orthoVertical.
lb withVerticalAttachPoint.
lb shapes: nodes.
lb connectFrom: [ :nb | nb // 2 ].

RSTreeLayout on: nodes.

c @ RSCanvasController.

ctp := RSColoredTreePalette new.
ctp shapes: c nodes.
ctp assignColor.

c.
```

```
m := RSMondrian new.
m nodes: Collection withAllSubclasses.

m orthoVerticalLine 
	connectFrom: #superclass.
m layout tree.
m normalizeSize: #numberOfLinesOfCode.
m build.

ctp := RSColoredTreePalette new.
ctp shapes: m canvas nodes.
ctp assignColor.

m canvas
```


"
Class {
	#name : #RSColoredTreePalette,
	#superclass : #RSObject,
	#instVars : [
		'shapes',
		'totalNumberOfLeaves',
		'alpha'
	],
	#category : #'Roassal3-Colors'
}

{ #category : #private }
RSColoredTreePalette >> allLeavesAccessibleFrom: aRootShape [ 

	| c |
	c := OrderedCollection new.
	self allLeavesAccessibleFrom: aRootShape in: c.
	^ c size
]

{ #category : #private }
RSColoredTreePalette >> allLeavesAccessibleFrom: aShape in: result [

	aShape numberOfOutgoingLines = 0 
		ifTrue: [
			result add: self ]
		ifFalse: [ 
			 (aShape outgoingLines collect: #to) do: [ :s | self allLeavesAccessibleFrom: s in: result ]
			 ]

]

{ #category : #accessing }
RSColoredTreePalette >> alpha: alphaValueAsFloat [
	"Set the transparency of the colors. Take as argument a number between 0.0 and 1.0"
	alpha := alphaValueAsFloat
]

{ #category : #public }
RSColoredTreePalette >> assignColor [

	| roots |
	roots := shapes select: [ :s | s numberOfIncomingLines = 0 ].
	roots do: [ :r | self assignColorToRoot: r ]
]

{ #category : #private }
RSColoredTreePalette >> assignColorToChildren: children low: low high: high [
	| step hs |
	step := high - low / children size.
	hs := low to: high count: children size.

	children with: hs do: [ :s :h |
		self assignColorToRoot: s h: (h min: 360 max: 0)
	]
	
]

{ #category : #private }
RSColoredTreePalette >> assignColorToRoot: aRootShape [
	self assignColorToRoot: aRootShape h: 360 / 2
]

{ #category : #private }
RSColoredTreePalette >> assignColorToRoot: aRootShape h: h [
	| children span |
	
	aRootShape color: ((Color h: h s: 1 v: 1) alpha: alpha).

	children := aRootShape outgoingShapes.
	children ifEmpty: [ ^ self ].
	span := (self allLeavesAccessibleFrom: aRootShape) * 360 / (totalNumberOfLeaves * 2).
	self assignColorToChildren: children low: h - (span / 2) high: h + (span / 2).
]

{ #category : #initialization }
RSColoredTreePalette >> initialize [
	super initialize.
	alpha := 1.0
]

{ #category : #accessing }
RSColoredTreePalette >> shapes [

	^ shapes
]

{ #category : #accessing }
RSColoredTreePalette >> shapes: someShapes [
	"Set the shapes (the nodes) that must be colored"
	shapes := someShapes.
	totalNumberOfLeaves := 0.
	(someShapes select: [ :s | s numberOfIncomingLines = 0 ]) do: [ :s | 
		totalNumberOfLeaves := totalNumberOfLeaves + (self allLeavesAccessibleFrom: s)
	]
]

{ #category : #accessing }
RSColoredTreePalette >> totalNumberOfLeaves [
	"Return the total number of leaves"
	^ totalNumberOfLeaves
]
