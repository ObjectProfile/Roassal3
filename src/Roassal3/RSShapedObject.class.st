"
I am usefull to define RSElement and RSEdge
"
Class {
	#name : #RSShapedObject,
	#superclass : #RSObject,
	#instVars : [
		'model',
		'index',
		'view',
		'attributes',
		'trachelShape'
	],
	#category : #'Roassal3-Core'
}

{ #category : #interactions }
RSShapedObject >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #interactions }
RSShapedObject >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance onElement: self
]

{ #category : #adding }
RSShapedObject >> addedIn: c [
	self subclassResponsibility
]

{ #category : #attributes }
RSShapedObject >> attributeAt: aKey [
	"Obtain an attribute to the element. For example: 
		RTElement new attributeAt: #magic put: 42; attributeAt: #magic
		RTEdge new attributeAt: #magic put: 42; attributeAt: #magic
	"
	^ self attributes at: aKey
]

{ #category : #attributes }
RSShapedObject >> attributeAt: aKey ifAbsent: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsent: aBlockClosure 
]

{ #category : #attributes }
RSShapedObject >> attributeAt: aKey ifAbsentPut: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #attributes }
RSShapedObject >> attributeAt: aKey put: value [
	"Set an attribute to the element. For example: 
		RTElement new attributeAt: #magic put: 42; yourself
		RTEdge new attributeAt: #magic put: 42; yourself
	"
	^ self attributes at: aKey put: value
]

{ #category : #attributes }
RSShapedObject >> attributes [
	"Return the list of attributes associated to the element. Attributes are useful for caching values"

	^ attributes ifNil: [ attributes := Dictionary new ]
]

{ #category : #'as yet unclassified' }
RSShapedObject >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: trachelShape 
]

{ #category : #attributes }
RSShapedObject >> hasAttribute: aKey [ 
	"Return true if attributes includes aKey"
	
	^ attributes notNil and: [ attributes includesKey: aKey ]
]

{ #category : #attributes }
RSShapedObject >> hasAttributes [ 
	"Return true if at least one attributes is present"
	
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #attributes }
RSShapedObject >> hasNotAttribute: aKey [ 
	"Return false if attributes includes aKey"
	
	^ (self hasAttribute: aKey) not 
]

{ #category : #accessing }
RSShapedObject >> index [
	^ index
]

{ #category : #accessing }
RSShapedObject >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
RSShapedObject >> model [
	^ model
]

{ #category : #accessing }
RSShapedObject >> model: anObject [
	model := anObject
]

{ #category : #attributes }
RSShapedObject >> removeAttributeAt: aKey [
	^ self attributes removeKey: aKey
]

{ #category : #attributes }
RSShapedObject >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self attributes removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #rendering }
RSShapedObject >> renderOn: trCanvas [
	trachelShape isNil ifTrue: [ self error: 'Cannot add an element without a shape. Add a shape to myself, using + or addShape:' . ^ self ].
	trCanvas addShape: trachelShape.
	
]

{ #category : #accessing }
RSShapedObject >> trachelShape [
	^ trachelShape 
]

{ #category : #accessing }
RSShapedObject >> trachelShape: aShape [
	trachelShape := aShape
]
