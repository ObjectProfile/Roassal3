"
I am a abstract class to create visual elements based on tree structured in roassal3
"
Class {
	#name : #RSAbstractTreeBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'rootNodes',
		'weight'
	],
	#category : #'Roassal3-Builders'
}

{ #category : #private }
RSAbstractTreeBuilder >> createElements: atree nesting: block1 leaves: block2 depth: depth [
	| children e leaves nodes|
	
	e := self shapeFor: atree.
	shapes add: e.
	
	children := block1 rsValue: atree.
	e properties at: #depth put: depth.
	children := children collect: [ :child | | e2 |
		e2 := self createElements: child nesting: block1 
			leaves: block2 depth: depth + 1.
		e2 properties at: #parent put: e.
		e2 ] as: Array.
	leaves := (block2 rsValue: atree) collect: [:child | | e2 |
		e2 := self createElements: child nesting: #() 
			leaves: #() depth: depth +1.
		e2 properties at: #parent put: e.
		e2 ] as: Array.
	nodes := OrderedCollection new: (leaves size + children size).
	nodes addAll: children; addAll: leaves.
		
	e properties at: self childrenKey put: nodes.
	^ e.
]

{ #category : #private }
RSAbstractTreeBuilder >> createElements: atree using: ablock depth: depth [
	| children shape |
	
	shape := self shapeFor: atree.
	shapes add: shape.
	
	children := ablock rsValue: atree.
	shape depth: depth.
	children := children collect: [ :child | | e2 |
		e2 := self createElements: child using: ablock depth: depth + 1.
		e2 sparent: shape.
		e2 ] as: Array.
	shape schildren: children.
	^ shape.
]

{ #category : #'public - building' }
RSAbstractTreeBuilder >> explore: atree nesting: block1 leaves: block2 [
	shapes := RSGroup new.
	^ (self from: (Array with: atree) nesting: block1 leaves: block2) first
]

{ #category : #'public - building' }
RSAbstractTreeBuilder >> explore: atree using: ablock [
	shapes := RSGroup new.
	^ (self from: (Array with: atree) using: ablock) first.
	
]

{ #category : #'public - building' }
RSAbstractTreeBuilder >> from: objects nesting: block1 leaves: block2 [
	shapes := RSGroup new.
	rootNodes := objects collect: [:obj | self createElements: obj nesting: block1 leaves: block2 depth: 1 ].
	^ rootNodes
]

{ #category : #'public - building' }
RSAbstractTreeBuilder >> from: objects using: ablock [
	shapes := RSGroup new.
	"This is the main public method. Takes a list of objects, and a block to specify how to recurse"
	rootNodes := objects collect: [:obj | self createElements: obj using: ablock depth: 1 ].
	^ rootNodes
]

{ #category : #initialization }
RSAbstractTreeBuilder >> initialize [
	super initialize.
	rootNodes := RSGroup new.
]

{ #category : #weight }
RSAbstractTreeBuilder >> leafWeight: block [
	self weight: [ :shape | self weightLeafShape: shape block: block ].
]

{ #category : #default }
RSAbstractTreeBuilder >> minWeightValue [
	^ 1
]

{ #category : #hooks }
RSAbstractTreeBuilder >> renderIn: aCanvas [
	aCanvas addAll: self shapes
]

{ #category : #accessing }
RSAbstractTreeBuilder >> rootNodes [
	^ rootNodes
]

{ #category : #accessing }
RSAbstractTreeBuilder >> rootNodes: anArray [
	rootNodes := anArray
]

{ #category : #hooks }
RSAbstractTreeBuilder >> shapeFor: anObject [
	^ self subclassResponsibility
]

{ #category : #weight }
RSAbstractTreeBuilder >> weight [
	^ weight
]

{ #category : #weight }
RSAbstractTreeBuilder >> weight: anObject [
	weight := anObject
]

{ #category : #private }
RSAbstractTreeBuilder >> weightFromChildren: shape block: aBlock [
	| children weightValue |
	children := shape schildren.
	weightValue := children
		ifEmpty: [ aBlock rsValue: shape model ]
		ifNotEmpty: [ 
			children 
				inject: 0 
				into: [ :s :child | s + (self weightLeafShape: child block: aBlock) ] ].
	^ weightValue max: self minWeightValue.
	
]

{ #category : #'accessing - keys' }
RSAbstractTreeBuilder >> weightKey [
	^ #weight
]

{ #category : #private }
RSAbstractTreeBuilder >> weightLeafShape: shape block: aBlock [
	^ shape
		propertyAt: self weightKey
		ifAbsentPut: [ 
			self weightFromChildren: shape block: aBlock ]
]

{ #category : #weight }
RSAbstractTreeBuilder >> weightOf: aShape [
	^ self weight rsValue: aShape
]
