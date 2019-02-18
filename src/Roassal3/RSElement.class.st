"
Too abstract at this point, do we need instances of RSElement?
"
Class {
	#name : #RSElement,
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

{ #category : #adding }
RSElement >> addedIn: aView [
	view := aView.
	view addElement: self.
]

{ #category : #attributes }
RSElement >> attributeAt: aKey [
	"Obtain an attribute to the element. For example: 
		RTElement new attributeAt: #magic put: 42; attributeAt: #magic
		RTEdge new attributeAt: #magic put: 42; attributeAt: #magic
	"
	^ self attributes at: aKey
]

{ #category : #attributes }
RSElement >> attributeAt: aKey ifAbsent: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsent: aBlockClosure 
]

{ #category : #attributes }
RSElement >> attributeAt: aKey ifAbsentPut: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #attributes }
RSElement >> attributeAt: aKey put: value [
	"Set an attribute to the element. For example: 
		RTElement new attributeAt: #magic put: 42; yourself
		RTEdge new attributeAt: #magic put: 42; yourself
	"
	^ self attributes at: aKey put: value
]

{ #category : #attributes }
RSElement >> attributes [
	"Return the list of attributes associated to the element. Attributes are useful for caching values"

	^ attributes ifNil: [ attributes := Dictionary new ]
]

{ #category : #attributes }
RSElement >> hasAttribute: aKey [ 
	"Return true if attributes includes aKey"
	
	^ attributes notNil and: [ attributes includesKey: aKey ]
]

{ #category : #attributes }
RSElement >> hasAttributes [ 
	"Return true if at least one attributes is present"
	
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #attributes }
RSElement >> hasNotAttribute: aKey [ 
	"Return false if attributes includes aKey"
	
	^ (self hasAttribute: aKey) not 
]

{ #category : #accessing }
RSElement >> index [
	^ index
]

{ #category : #accessing }
RSElement >> index: anInteger [
	index := anInteger
]

{ #category : #accessing }
RSElement >> model [
	^ model
]

{ #category : #accessing }
RSElement >> model: anObject [
	model := anObject
]

{ #category : #attributes }
RSElement >> removeAttributeAt: aKey [
	^ self attributes removeKey: aKey
]

{ #category : #attributes }
RSElement >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self attributes removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #rendering }
RSElement >> renderOn: trCanvas [
	trachelShape isNil ifTrue: [ self error: 'Cannot add an element without a shape. Add a shape to myself, using + or addShape:' . ^ self ].
	trCanvas addShape: trachelShape.
	
]

{ #category : #accessing }
RSElement >> trachelShape [
	^ trachelShape 
]

{ #category : #accessing }
RSElement >> trachelShape: aShape [
	trachelShape := aShape
]
