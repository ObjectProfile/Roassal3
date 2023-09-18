"
The `RSRadialTreeLayout` class implements a layout algorithm for arranging nodes in a radial tree structure. It places nodes in a hierarchical structure with a single root node at the center and branches radiating outwards from it.

Radial tree layouts are useful for visualizing hierarchical relationships, such as organizational charts or family trees, where the focus is on the relationships between the nodes rather than the precise positions of the nodes.
"
Class {
	#name : #RSRadialTreeLayout,
	#superclass : #RSAbstractCompactTreeLayout,
	#category : #'Roassal3-Layouts-Tree'
}

{ #category : #algorithm }
RSRadialTreeLayout >> compareContourOf: aNode with: another [
	"return the number of radians the subtree induced by aNode must be displaced to be separated by a predefined distance (horizontalGap) from the one induced by anotherNode"
	| difference max nodeA nodeB |
	nodeB := aNode.	"the right one"
	nodeA := another.	"the left one"
	max := aNode = another
		ifTrue: [ 0 ]
		ifFalse: [ horizontalGap / (self layerOf: nodeB) / 2 - ((self xOf: nodeB) - (self getAbcissaOf: nodeA inSubtreeFromLayer: (self layerOf: aNode) - 1)) ].
	nodeB := self followLeftContour: nodeB toLayer: (self layerOf: nodeB) + 1.
	nodeA := self followRightContour: nodeA toLayer: (self layerOf: nodeA) + 1.
	[ nodeB isNil not & nodeA isNil not ]
		whileTrue: [
			difference := horizontalGap / (self layerOf: nodeA)
				-
					((self getAbcissaOf: nodeB inSubtreeFromLayer: (self layerOf: aNode) - 1)
						- (self getAbcissaOf: nodeA inSubtreeFromLayer: (self layerOf: aNode) - 1)).
			max := max max: difference.
			nodeB := self followLeftContour: nodeB toLayer: (self layerOf: nodeB) + 1.
			nodeA := self followRightContour: nodeA toLayer: (self layerOf: nodeA) + 1 ].
	^ max
]

{ #category : #hook }
RSRadialTreeLayout >> computeGap: aNode [
	" compute the vertical gap needed for drawing the radial tree "

	| gap maxAbcissa i abc nodeL nodeR layer |
	gap := 0.
	maxAbcissa := 0.
	layer := 1.

	i := 1.
	[
	nodeL := self followLeftContour: aNode toLayer: i.
	nodeR := self followRightContour: aNode toLayer: i.
	nodeL isNil not & nodeR isNil not ] whileTrue: [
		abc := (self getAbcissaOf: nodeR inSubtreeFromLayer: 0)
		       - (self getAbcissaOf: nodeL inSubtreeFromLayer: 0)
		       + (horizontalGap / layer / 2) / layer.
		maxAbcissa := maxAbcissa max: abc.
		i := i + 1 ].


	gap := (maxAbcissa / 2 / Float pi) floor + 1.

	(verticalGap isNil or: [ gap > verticalGap ]) ifTrue: [
		self verticalGap: gap ]
]

{ #category : #algorithm }
RSRadialTreeLayout >> computePosition: aNode [
	"compute the position of the given node and of his sons recursively"
	| children neighbor nodeA |
	children := self childrenFor: aNode.
	neighbor := self leftSiblingOf: aNode.
	children isEmpty ifTrue: [
		 neighbor
			ifNil: [ self xOf: aNode put: 0.
				self modOf: aNode put: 0 ]
			ifNotNil: [ self
					xOf: aNode
					put: (self xOf: neighbor) + (horizontalGap / (self layerOf: aNode) / 2).
				self modOf: aNode put: (self modOf: neighbor).
				self
					pointerOf: aNode
					put: (self followRightContour: neighbor toLayer: (self layerOf: aNode) + 1) ] ]
	ifFalse: [
		self leftContourOf: aNode put: children first.
		self rightContourOf: aNode put: children last.
		children do: [ :e | self computePosition: e ].
		self
			xOf: aNode
			put:
				((self xOf: (self leftContourOf: aNode))
					+ (self xOf: (self rightContourOf: aNode))
					+ (self modOf: (self rightContourOf: aNode))) / 2.
		self modOf: aNode put: 0.
		neighbor
			ifNotNil:
				[ self modOf: aNode put: (self compareContourOf: aNode with: neighbor).
				nodeA := self
					followLeftContour: (self fatherOf: aNode)
					toLayer: (self layerOf: aNode).
				[ (self
					followLeftContour: nodeA
					toLayer: (self layerOf: nodeA) + 1) isNil ]
					whileFalse: [ nodeA := self
							followLeftContour: nodeA
							toLayer: (self layerOf: nodeA) + 1 ].
				self
					pointerOf: nodeA
					put: (self followLeftContour: aNode toLayer: (self layerOf: nodeA) + 1).
				nodeA := self
					followRightContour: aNode
					toLayer: (self layerOf: aNode) + 1.
				nodeA ifNil: [ ^ self ].
				[ (self
					followRightContour: nodeA
					toLayer: (self layerOf: nodeA) + 1) isNil ]
					whileFalse: [ nodeA := self
							followRightContour: nodeA
							toLayer: (self layerOf: nodeA) + 1 ].
				self
					pointerOf: nodeA
					put: (self followRightContour: neighbor toLayer: (self layerOf: nodeA) + 1) ] ]
]

{ #category : #hook }
RSRadialTreeLayout >> doExecute: nodeElements [
	| rootNodes xOffset maximumRadius |
	rootNodes := self rootNodesFor: nodeElements.
	rootNodes do: [ :e | 
		self initialize: e whoseFatherIs: nil.
		self computePosition: e.
		self computeGap: e.
		self toRadialTree: e withMod: 0 
		 ].
	xOffset := 0.
	rootNodes do: [ :e |
		maximumRadius := self radialDraw: e.
		"Shifting all the subgroups"
		self shiftTree: e by: maximumRadius + xOffset @ maximumRadius.
		xOffset := xOffset + (2 * maximumRadius) + 10 ]
]

{ #category : #private }
RSRadialTreeLayout >> gap [
	^ self verticalGap
]

{ #category : #private }
RSRadialTreeLayout >> layoutLayer: aCollection radius: oldRadius from: aFromAngle to: aToAngle [

	| delta childRadius maximumRadius myRadius fromAngle toAngle |
	"Initialize with default value"
	maximumRadius := oldRadius.
	aCollection isEmpty ifFalse: [
		myRadius := oldRadius + self gap + (self maximumRadius: aCollection).
		childRadius := oldRadius + self gap
		               + (self maximumDiameter: aCollection). "This is a purely optical tweak"
		(aCollection size = 1 and: [ aToAngle - aFromAngle = (2 * Float pi) ])
			ifTrue: [
				delta := 0.4 * Float pi.
				fromAngle := 0.8 * Float pi.
				toAngle := fromAngle + delta ]
			ifFalse: [
				delta := aToAngle - aFromAngle / aCollection size.
				fromAngle := aFromAngle.
				toAngle := aFromAngle + delta ].
		aCollection do: [ :child |
			translator
				translateTopLeftOf: child
				to: (Point r: myRadius theta: toAngle - (delta / 2.0)).
			maximumRadius := maximumRadius max: (self
					                  layoutLayer: (self childrenFor: child)
					                  radius: childRadius
					                  from: fromAngle
					                  to: toAngle).
			fromAngle := toAngle.
			toAngle := toAngle + delta ] ].
	^ maximumRadius
]

{ #category : #private }
RSRadialTreeLayout >> moveAllElementsToTopLeft: elements [
	| pos min |
	pos := elements collect: #position.
	min := pos inject: 0 @ 0 into: [ :minimum :p | minimum min: p ].
	elements do: [ :e | e translateBy: min negated ]
]

{ #category : #algorithm }
RSRadialTreeLayout >> radialDraw: aNode [
	"draw the subtree induced by the given node"
	| children r max |
	r := (self rOf: aNode).
	translator translateTopLeftOf: aNode to: (Point r: r theta: (self thetaOf: aNode)).
	children := self childrenFor: aNode.
	max := 0.
	children do: [ :e | max := max max: (self radialDraw: e) ].
	^ r + max
]

{ #category : #hook }
RSRadialTreeLayout >> rotateSubtreeFrom: aNode by: aFloat [
	aNode theta: aNode theta + aFloat.
	(self childrenFor: aNode) do: [ :e |
		self rotateSubtreeFrom: e by: aFloat ]
]

{ #category : #algorithm }
RSRadialTreeLayout >> toRadialTree: aNode withMod: aFloat [
	"compute polar coordinates of the subtree induced by anode from its cartesian coordinates "

	| children |
	self rOf: aNode put: (self layerOf: aNode) * verticalGap.
	(self rOf: aNode) = 0
		ifTrue: [ self thetaOf: aNode put: 0 ]
		ifFalse: [
			self
				thetaOf: aNode
				put:
				(self xOf: aNode) + aFloat + (self modOf: aNode) / verticalGap ].

	children := self childrenFor: aNode.

	children do: [ :e |
		self toRadialTree: e withMod: (self modOf: aNode) + aFloat ]
]
