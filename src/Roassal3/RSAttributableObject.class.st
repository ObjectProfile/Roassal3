"
My subclasses has attributes useful to add extra data to each component
"
Class {
	#name : #RSAttributableObject,
	#superclass : #RSObject,
	#instVars : [
		'attributes',
		'announcer'
	],
	#category : #'Roassal3-Core'
}

{ #category : #interactions }
RSAttributableObject >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #interactions }
RSAttributableObject >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance onShape: self
]

{ #category : #announcer }
RSAttributableObject >> announce: anEventOrAnEventClass [
	"Send an event"
	self subclassResponsibility
]

{ #category : #announcer }
RSAttributableObject >> announcer [ 
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #announcer }
RSAttributableObject >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #attributes }
RSAttributableObject >> attributeAt: aKey [
	^ self attributes at: aKey ifAbsent: nil
]

{ #category : #attributes }
RSAttributableObject >> attributeAt: aKey ifAbsent: aBlockClosure [ 
	^ self attributes at: aKey ifAbsent: aBlockClosure 
]

{ #category : #attributes }
RSAttributableObject >> attributeAt: aKey ifAbsentPut: aBlockClosure [ 
	^ self attributes at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #attributes }
RSAttributableObject >> attributeAt: aKey put: value [
	^ self attributes at: aKey put: value
]

{ #category : #attributes }
RSAttributableObject >> attributes [
	^ attributes ifNil: [ attributes := Dictionary new ]
]

{ #category : #attributes }
RSAttributableObject >> attributesDo: block [
	self hasAttributes ifFalse: [ ^ self ].
	block value: self attributes.
]

{ #category : #accessing }
RSAttributableObject >> canvas [
	^ self subclassResponsibility
]

{ #category : #events }
RSAttributableObject >> click [
	self announcer announce: (RSMouseClick new).
]

{ #category : #interactions }
RSAttributableObject >> getInteractionsForClass: anInteractionClass [
	"Return the Announcement subscriptions for the interaction"
	^ self announcer subscriptions getInteractionsForClass: anInteractionClass
]

{ #category : #attributes }
RSAttributableObject >> hasAttribute: aKey [ 
	^ attributes notNil and: [ attributes includesKey: aKey ]
]

{ #category : #attributes }
RSAttributableObject >> hasAttributes [
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #interactions }
RSAttributableObject >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	self announcer subscriptions ifNil: [ ^ false ].
	^ self announcer subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : #attributes }
RSAttributableObject >> hasNotAttribute: aKey [ 
	"Return false if attributes includes aKey"
	^ (self hasAttribute: aKey) not 
]

{ #category : #announcer }
RSAttributableObject >> privateAnnouncer [
	^ announcer
]

{ #category : #private }
RSAttributableObject >> privateAttributes [
	^ attributes
]

{ #category : #events }
RSAttributableObject >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #attributes }
RSAttributableObject >> removeAttributeAt: aKey [
	^ self attributes removeKey: aKey
]

{ #category : #attributes }
RSAttributableObject >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self attributes removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #interactions }
RSAttributableObject >> removeInteractionIfPresent: anInteractionClass [
	"Remove all the callbacks associated to the interaction."
	(self hasInteraction: anInteractionClass) ifFalse: [ ^ self ].
	(self getInteractionsForClass: anInteractionClass) do: [ :int | self announcer unsubscribe: int ]
]

{ #category : #attributes }
RSAttributableObject >> removeKey: aKey [
	| att |
	att := self attributes.
	(att includesKey: aKey) ifFalse: [ ^ self ].
	att removeKey: aKey.
	
]

{ #category : #announcer }
RSAttributableObject >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
