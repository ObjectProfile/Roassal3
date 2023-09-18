"
Abstract class of regular tree layouts defines utility methods for naviagate in the graph
in a tree style.

Description:
The `RSAbstractRegularTreeLayout` class is an abstract base class that provides common functionality for regular tree layout algorithms in Roassal. Regular tree layouts arrange nodes in a tree-like structure where each level of the tree is aligned horizontally or vertically

You can use it verticalReversed or horizontalReversed
"
Class {
	#name : #RSAbstractRegularTreeLayout,
	#superclass : #RSAbstractGraphLayout,
	#instVars : [
		'alreadyLayoutedNodes',
		'topGap',
		'leftGap',
		'nodesByLayer',
		'isLayered',
		'shouldBeHorizontallyReversed',
		'shouldBeVerticallyReversed'
	],
	#category : #'Roassal3-Layouts-Tree'
}

{ #category : #testing }
RSAbstractRegularTreeLayout class >> isAbstract [
	^ self = RSAbstractRegularTreeLayout
]

{ #category : #private }
RSAbstractRegularTreeLayout >> atLayer: aNumber add: aNodeCollection [
	| collection |
	collection := nodesByLayer at: aNumber ifAbsentPut: [OrderedCollection new].
	collection addAll: aNodeCollection
]

{ #category : #'private - hook' }
RSAbstractRegularTreeLayout >> computeChildrenFor: aNode [
	^ self subclassResponsibility
]

{ #category : #hook }
RSAbstractRegularTreeLayout >> doExecute: shapes [
	| rootNodes |
	alreadyLayoutedNodes := Set new.
	rootNodes := self rootNodesFor: shapes.
	self validateCachedParents.
	(rootNodes isEmpty and: [ shapes isNotEmpty ])
		ifTrue: [ rootNodes := self rootNodesFromCycles: shapes ].
	self sortCollection: rootNodes.
	nodesByLayer := OrderedCollection new.
	self
		layout: rootNodes
		atPoint: self leftGap @ self topGap
		atLayer: 1.
	self isLayered ifTrue: [
		self rearrangeByLayers: shapes ]
]

{ #category : #hook }
RSAbstractRegularTreeLayout >> doInitialize: shapes [
	self clear
]

{ #category : #hook }
RSAbstractRegularTreeLayout >> doPost: elements [
	shouldBeHorizontallyReversed ifTrue: [ self horizontallyReverse: elements ].
	shouldBeVerticallyReversed ifTrue: [ self verticallyReverse: elements ]
]

{ #category : #public }
RSAbstractRegularTreeLayout >> horizontallyReverse [
	shouldBeHorizontallyReversed := true
]

{ #category : #reversing }
RSAbstractRegularTreeLayout >> horizontallyReverse: shapes [
	"Horizontally reverse the elements, as well as the attachpoints"
	| g largeur |
	g := shapes asGroup.
	largeur := g extent x.
	shapes
		do: [ :el | el translateTo: (largeur - el position x) @ el position y ]
]

{ #category : #initialization }
RSAbstractRegularTreeLayout >> initialize [
	super initialize.
	topGap := 5.
	leftGap := 5.
	isLayered := false.
	shouldBeHorizontallyReversed := false.
	shouldBeVerticallyReversed := false
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> isLayered [
	"Is the layout layered"
	^ isLayered
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> isLayered: boolean [
	"Is the layout layered"
	isLayered := boolean
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> layered [
	self isLayered: true
]

{ #category : #'private - hook' }
RSAbstractRegularTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> leftGap [
	^ leftGap
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> leftGap: anInteger [
	"Perform an horizontal translation of the nodes"
	leftGap := anInteger
]

{ #category : #private }
RSAbstractRegularTreeLayout >> rearrangeByLayers: aGraph [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> shouldBeHorizontallyReversed [
	"Return if the layout is horizontally reversed"
	^ shouldBeHorizontallyReversed
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> shouldBeHorizontallyReversed: aBoolean [
	shouldBeHorizontallyReversed := aBoolean
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> shouldBeVerticallyReversed [
	"Return if the layout is vertically reversed"
	^ shouldBeVerticallyReversed
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> shouldBeVerticallyReversed: aBoolean [
	shouldBeVerticallyReversed := aBoolean
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> topGap [
	^ topGap
]

{ #category : #accessing }
RSAbstractRegularTreeLayout >> topGap: anInteger [
	"Perform a vertical translation of the nodes"
	topGap := anInteger
]

{ #category : #public }
RSAbstractRegularTreeLayout >> verticallyReverse [
	"Reverse the edge extremities"
	shouldBeVerticallyReversed := true
]

{ #category : #reversing }
RSAbstractRegularTreeLayout >> verticallyReverse: elements [
	"Vertically reverse the elements, as well as the attachpoints"
	| g hauteur |
	g := elements asGroup.
	hauteur := g extent y.
	elements
		do: [ :el | el translateTo: el position x @ (hauteur - el position y) ]
]
