"
I am a abstract class to create visual elements based on tree structured in Roassal
"
Class {
	#name : 'RSAbstractTreeBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'rootNodes',
		'weight'
	],
	#category : 'Roassal-Builders-Core',
	#package : 'Roassal-Builders',
	#tag : 'Core'
}

{ #category : 'private' }
RSAbstractTreeBuilder >> createElements: atree nesting: block1 leaves: block2 depth: depth [
	| children aShape leaves nodes|

	aShape := self shapeFor: atree.
	shapes add: aShape.

	children := block1 rsValue: atree.
	aShape depth: depth.
	children := children collect: [ :child | | aShape2 |
		aShape2 := self createElements: child nesting: block1
			leaves: block2 depth: depth + 1.
		aShape2 sparent: aShape.
		aShape2 ] as: Array.
	leaves := (block2 rsValue: atree) collect: [:child | | aShape2 |
		aShape2 := self createElements: child nesting: #()
			leaves: #() depth: depth +1.
		aShape2 sparent: aShape.
		aShape2 ] as: Array.
	nodes := OrderedCollection new: (leaves size + children size).
	nodes addAll: children; addAll: leaves.

	aShape schildren: nodes.
	^ aShape
]

{ #category : 'private' }
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
	^ shape
]

{ #category : 'public - building' }
RSAbstractTreeBuilder >> explore: atree nesting: block1 leaves: block2 [
	shapes := RSGroup new.
	^ (self from: (Array with: atree) nesting: block1 leaves: block2) first
]

{ #category : 'public - building' }
RSAbstractTreeBuilder >> explore: atree using: ablock [
	shapes := RSGroup new.
	^ (self from: (Array with: atree) using: ablock) first
]

{ #category : 'public - building' }
RSAbstractTreeBuilder >> from: objects nesting: block1 leaves: block2 [
	shapes := RSGroup new.
	rootNodes := objects collect: [:obj | self createElements: obj nesting: block1 leaves: block2 depth: 1 ].
	^ rootNodes
]

{ #category : 'public - building' }
RSAbstractTreeBuilder >> from: objects using: ablock [
	shapes := RSGroup new.
	"This is the main public method. Takes a list of objects, and a block to specify how to recurse"
	rootNodes := objects collect: [:obj | self createElements: obj using: ablock depth: 1 ].
	^ rootNodes
]

{ #category : 'initialization' }
RSAbstractTreeBuilder >> initialize [
	super initialize.
	rootNodes := RSGroup new
]

{ #category : 'weight' }
RSAbstractTreeBuilder >> leafWeight: block [
	self weight: [ :shape | self weightLeafShape: shape block: block ]
]

{ #category : 'accessing - defaults' }
RSAbstractTreeBuilder >> minWeightValue [
	^ 1
]

{ #category : 'weight' }
RSAbstractTreeBuilder >> modelWeight: anObject [
	self weight: [ :shape | anObject rsValue: shape model ]
]

{ #category : 'rendering' }
RSAbstractTreeBuilder >> renderIn: aCanvas [
	aCanvas addAll: self shapes
]

{ #category : 'accessing' }
RSAbstractTreeBuilder >> rootNodes [
	^ rootNodes
]

{ #category : 'accessing' }
RSAbstractTreeBuilder >> rootNodes: anArray [
	rootNodes := anArray
]

{ #category : 'hooks' }
RSAbstractTreeBuilder >> shapeFor: anObject [
	^ self subclassResponsibility
]

{ #category : 'weight' }
RSAbstractTreeBuilder >> weight [
	^ weight
]

{ #category : 'weight' }
RSAbstractTreeBuilder >> weight: anObject [
	"one arg block, example [:aRoassalShape | ]"
	weight := anObject
]

{ #category : 'private' }
RSAbstractTreeBuilder >> weightFromChildren: shape block: aBlock [
	| children weightValue |
	children := shape schildren.
	weightValue := children
		ifEmpty: [ aBlock rsValue: shape model ]
		ifNotEmpty: [
			children
				inject: 0
				into: [ :s :child | s + (self weightLeafShape: child block: aBlock) ] ].
	^ weightValue max: self minWeightValue
]

{ #category : 'accessing - keys' }
RSAbstractTreeBuilder >> weightKey [
	^ #weight
]

{ #category : 'private' }
RSAbstractTreeBuilder >> weightLeafShape: shape block: aBlock [
	^ shape
		propertyAt: self weightKey
		ifAbsentPut: [
			self weightFromChildren: shape block: aBlock ]
]

{ #category : 'weight' }
RSAbstractTreeBuilder >> weightOf: aShape [
	^ self weight rsValue: aShape
]
