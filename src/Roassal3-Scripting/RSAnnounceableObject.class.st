"
I am the root for object with attributes and external values
"
Class {
	#name : #RSAnnounceableObject,
	#superclass : #RS3Object,
	#instVars : [
		'attributes'
	],
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #accessing }
RSAnnounceableObject >> announcer [ 
	self subclassResponsibility
]

{ #category : #attributes }
RSAnnounceableObject >> attributeAt: aKey [
	"Obtain an attribute to the element. For example: 
		RTElement new attributeAt: #magic put: 42; attributeAt: #magic
		RTEdge new attributeAt: #magic put: 42; attributeAt: #magic
	"
	^ self attributes at: aKey
]

{ #category : #attributes }
RSAnnounceableObject >> attributeAt: aKey ifAbsent: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsent: aBlockClosure 
]

{ #category : #attributes }
RSAnnounceableObject >> attributeAt: aKey ifAbsentPut: aBlockClosure [ 
	
	^ self attributes at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #attributes }
RSAnnounceableObject >> attributeAt: aKey put: value [
	"Set an attribute to the element. For example: 
		RTElement new attributeAt: #magic put: 42; yourself
		RTEdge new attributeAt: #magic put: 42; yourself
	"
	^ self attributes at: aKey put: value
]

{ #category : #attributes }
RSAnnounceableObject >> attributes [
	"Return the list of attributes associated to the element. Attributes are useful for caching values"

	^ attributes ifNil: [ attributes := Dictionary new ]
]

{ #category : #attributes }
RSAnnounceableObject >> attributesDo: block [
	block value: self attributes.
]

{ #category : #events }
RSAnnounceableObject >> click [
	self announcer announce: (RSMouseClick new).
]

{ #category : #accessing }
RSAnnounceableObject >> getInteractionsForClass: anInteractionClass [
	"Return the Announcement subscriptions for the interaction"
	^ self announcer subscriptions getInteractionsForClass: anInteractionClass
]

{ #category : #attributes }
RSAnnounceableObject >> hasAttribute: aKey [ 
	"Return true if attributes includes aKey"
	
	^ attributes notNil and: [ attributes includesKey: aKey ]
]

{ #category : #attributes }
RSAnnounceableObject >> hasAttributes [ 
	"Return true if at least one attributes is present"
	
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #interactions }
RSAnnounceableObject >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	self announcer subscriptions ifNil: [ ^ false ].
	^ self announcer subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : #attributes }
RSAnnounceableObject >> hasNotAttribute: aKey [ 
	"Return false if attributes includes aKey"
	
	^ (self hasAttribute: aKey) not 
]

{ #category : #attributes }
RSAnnounceableObject >> privateAttributes [
	^ attributes
]

{ #category : #dependencies }
RSAnnounceableObject >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #attributes }
RSAnnounceableObject >> removeAttributeAt: aKey [
	^ self attributes removeKey: aKey
]

{ #category : #attributes }
RSAnnounceableObject >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self attributes removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #interactions }
RSAnnounceableObject >> removeInteractionIfPresent: anInteractionClass [
	"Remove all the callbacks associated to the interaction."
	(self hasInteraction: anInteractionClass) ifFalse: [ ^ self ].
	(self getInteractionsForClass: anInteractionClass) do: [ :int | self announcer unsubscribe: int ]
]

{ #category : #attributes }
RSAnnounceableObject >> removeKey: aKey [
	| att |
	att := self attributes.
	(att includesKey: aKey) ifFalse: [ ^ self ].
	att removeKey: aKey.
	
]
