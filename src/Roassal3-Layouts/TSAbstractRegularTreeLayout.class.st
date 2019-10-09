"
TODO
"
Class {
	#name : #TSAbstractRegularTreeLayout,
	#superclass : #TSAbstractGraphLayout,
	#instVars : [
		'alreadyLayoutedNodes',
		'topGap',
		'leftGap',
		'nodesByLayer',
		'isLayered',
		'shouldBeHorizontallyReversed',
		'shouldBeVerticallyReversed'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #testing }
TSAbstractRegularTreeLayout class >> isAbstract [
	^ self = TSAbstractRegularTreeLayout
]

{ #category : #private }
TSAbstractRegularTreeLayout >> atLayer: aNumber add: aNodeCollection [
	| collection |
	collection := nodesByLayer at: aNumber ifAbsentPut: [OrderedCollection new].
	collection addAll: aNodeCollection
]

{ #category : #hook }
TSAbstractRegularTreeLayout >> doExecute: elements [
	| rootNodes |
	alreadyLayoutedNodes := OrderedCollection new.
	rootNodes := self rootNodesFor: elements.
	nodesByLayer := OrderedCollection new.
	self
		layout: rootNodes
		atPoint: self leftGap @ self topGap
		atLayer: 1.
	self isLayered ifTrue: [
		self rearrangeByLayers: elements ]
]

{ #category : #hook }
TSAbstractRegularTreeLayout >> doInitialize: elements [ 
	self clear
]

{ #category : #hook }
TSAbstractRegularTreeLayout >> doPost: elements [
	shouldBeHorizontallyReversed ifTrue: [ self horizontallyReverse: elements ].
	shouldBeVerticallyReversed ifTrue: [ self verticallyReverse: elements ].
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> horizontallyReverse [
	shouldBeHorizontallyReversed := true
]

{ #category : #reversing }
TSAbstractRegularTreeLayout >> horizontallyReverse: elements [
	"Horizontally reverse the elements, as well as the attachpoints"

	| g largeur |
	g := elements asGroup.
	largeur := g extent x.
	elements
		do: [ :el | el translateTo: (largeur - el position x) @ el position y ]
]

{ #category : #'initialize-release' }
TSAbstractRegularTreeLayout >> initialize [
	super initialize.
	topGap := 5.
	leftGap := 5.
	isLayered := false.
	shouldBeHorizontallyReversed := false.
	shouldBeVerticallyReversed := false.
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> isLayered [
	"Is the layout layered"
	
	^ isLayered
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> isLayered: boolean [
	"Is the layout layered"
	
	isLayered := boolean
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> layered [
	self isLayered: true
]

{ #category : #'hook-private' }
TSAbstractRegularTreeLayout >> layout: aNodeCollection atPoint: aPoint atLayer: anObject [
	self subclassResponsibility
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> leftGap [
	^ leftGap
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> leftGap: anInteger [
	leftGap := anInteger
]

{ #category : #private }
TSAbstractRegularTreeLayout >> rearrangeByLayers: aGraph [
	self subclassResponsibility
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> shouldBeHorizontallyReversed [
	"Return if the layout is horizontally reversed"
	^ shouldBeHorizontallyReversed 
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> shouldBeVerticallyReversed [
	"Return if the layout is vertically reversed"
	^ shouldBeVerticallyReversed
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> topGap [
	^ topGap
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> topGap: anInteger [
	topGap := anInteger
]

{ #category : #accessing }
TSAbstractRegularTreeLayout >> verticallyReverse [
	"Reverse the edge extremities"
	"Here is an example:

| b |	
b := RTMondrian new.
b nodes: (1 to: 100).
b edges connectFrom: [ :v | v // 2 ].
b layout tree verticallyReverse.
b
"
	shouldBeVerticallyReversed := true
	

]

{ #category : #reversing }
TSAbstractRegularTreeLayout >> verticallyReverse: elements [
	"Vertically reverse the elements, as well as the attachpoints"

	| g hauteur |
	g := elements asGroup.
	hauteur := g extent y.
	elements
		do: [ :el | el translateTo: el position x @ (hauteur - el position y) ]
]
