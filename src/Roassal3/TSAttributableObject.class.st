"
My subclasses has attributes useful to add extra data to each component
"
Class {
	#name : #TSAttributableObject,
	#superclass : #TSObject,
	#instVars : [
		'attributes',
		'announcer'
	],
	#category : #'Roassal3-Core'
}

{ #category : #interactions }
TSAttributableObject >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #interactions }
TSAttributableObject >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance onShape: self
]

{ #category : #announcer }
TSAttributableObject >> announce: anEventOrAnEventClass [
	"Send an event"
	self subclassResponsibility
]

{ #category : #announcer }
TSAttributableObject >> announcer [ 
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #announcer }
TSAttributableObject >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #attributes }
TSAttributableObject >> attributeAt: aKey [
	^ self attributes at: aKey
]

{ #category : #attributes }
TSAttributableObject >> attributeAt: aKey ifAbsent: aBlockClosure [ 
	^ self attributes at: aKey ifAbsent: aBlockClosure 
]

{ #category : #attributes }
TSAttributableObject >> attributeAt: aKey ifAbsentPut: aBlockClosure [ 
	^ self attributes at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #attributes }
TSAttributableObject >> attributeAt: aKey put: value [
	^ self attributes at: aKey put: value
]

{ #category : #attributes }
TSAttributableObject >> attributes [
	^ attributes ifNil: [ attributes := Dictionary new ]
]

{ #category : #attributes }
TSAttributableObject >> attributesDo: block [
	self hasAttributes ifFalse: [ ^ self ].
	block value: self attributes.
]

{ #category : #accessing }
TSAttributableObject >> canvas [
	^ self subclassResponsibility
]

{ #category : #events }
TSAttributableObject >> click [
	self announcer announce: (TSMouseClick new).
]

{ #category : #interactions }
TSAttributableObject >> getInteractionsForClass: anInteractionClass [
	"Return the Announcement subscriptions for the interaction"
	^ self announcer subscriptions getInteractionsForClass: anInteractionClass
]

{ #category : #attributes }
TSAttributableObject >> hasAttribute: aKey [ 
	^ attributes notNil and: [ attributes includesKey: aKey ]
]

{ #category : #attributes }
TSAttributableObject >> hasAttributes [
	^ attributes notNil and: [ attributes notEmpty ]
]

{ #category : #interactions }
TSAttributableObject >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	self announcer subscriptions ifNil: [ ^ false ].
	^ self announcer subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : #attributes }
TSAttributableObject >> hasNotAttribute: aKey [ 
	"Return false if attributes includes aKey"
	^ (self hasAttribute: aKey) not 
]

{ #category : #announcer }
TSAttributableObject >> privateAnnouncer [
	^ announcer
]

{ #category : #private }
TSAttributableObject >> privateAttributes [
	^ attributes
]

{ #category : #events }
TSAttributableObject >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #attributes }
TSAttributableObject >> removeAttributeAt: aKey [
	^ self attributes removeKey: aKey
]

{ #category : #attributes }
TSAttributableObject >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self attributes removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #interactions }
TSAttributableObject >> removeInteractionIfPresent: anInteractionClass [
	"Remove all the callbacks associated to the interaction."
	(self hasInteraction: anInteractionClass) ifFalse: [ ^ self ].
	(self getInteractionsForClass: anInteractionClass) do: [ :int | self announcer unsubscribe: int ]
]

{ #category : #attributes }
TSAttributableObject >> removeKey: aKey [
	| att |
	att := self attributes.
	(att includesKey: aKey) ifFalse: [ ^ self ].
	att removeKey: aKey.
	
]

{ #category : #announcer }
TSAttributableObject >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
