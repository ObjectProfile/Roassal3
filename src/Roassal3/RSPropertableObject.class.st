"
My subclasses has attributes useful to add extra data to each component
"
Class {
	#name : #RSPropertableObject,
	#superclass : #RSObject,
	#instVars : [
		'announcer',
		'properties'
	],
	#category : #'Roassal3-Core'
}

{ #category : #interactions }
RSPropertableObject >> @ anInteractionClassOrInstance [
	"Add an interaction to the node"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #interactions }
RSPropertableObject >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance onShape: self
]

{ #category : #announcer }
RSPropertableObject >> announce: anEventOrAnEventClass [
	"Send an event"
	self subclassResponsibility
]

{ #category : #announcer }
RSPropertableObject >> announcer [ 
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #announcer }
RSPropertableObject >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
RSPropertableObject >> canvas [
	^ self subclassResponsibility
]

{ #category : #events }
RSPropertableObject >> click [
	self announcer announce: (RSMouseClick new).
]

{ #category : #interactions }
RSPropertableObject >> getInteractionsForClass: anInteractionClass [
	"Return the Announcement subscriptions for the interaction"
	^ self announcer subscriptions getInteractionsForClass: anInteractionClass
]

{ #category : #interactions }
RSPropertableObject >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	self announcer subscriptions ifNil: [ ^ false ].
	^ self announcer subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : #properties }
RSPropertableObject >> hasProperties [
	^ properties notNil and: [ properties notEmpty ]
]

{ #category : #properties }
RSPropertableObject >> hasProperty: aKey [ 
	^ properties notNil and: [ properties includesKey: aKey ]
]

{ #category : #announcer }
RSPropertableObject >> privateAnnouncer [
	^ announcer
]

{ #category : #private }
RSPropertableObject >> privateAttributes [
	^ properties
]

{ #category : #properties }
RSPropertableObject >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : #properties }
RSPropertableObject >> propertiesDo: block [
	self hasProperties ifFalse: [ ^ self ].
	block value: self properties.
]

{ #category : #properties }
RSPropertableObject >> propertyAt: aKey [
	^ self properties at: aKey ifAbsent: [ nil ]
]

{ #category : #properties }
RSPropertableObject >> propertyAt: aKey ifAbsent: aBlockClosure [ 
	^ self properties at: aKey ifAbsent: aBlockClosure 
]

{ #category : #properties }
RSPropertableObject >> propertyAt: aKey ifAbsentPut: aBlockClosure [ 
	^ self properties at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #properties }
RSPropertableObject >> propertyAt: aKey ifPresent: aBlockClosure [ 
	^ self properties at: aKey ifPresent: aBlockClosure 
]

{ #category : #properties }
RSPropertableObject >> propertyAt: aKey put: value [
	^ self properties at: aKey put: value
]

{ #category : #events }
RSPropertableObject >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #properties }
RSPropertableObject >> removeAttributeAt: aKey [
	^ self properties removeKey: aKey
]

{ #category : #properties }
RSPropertableObject >> removeAttributeAt: aKey ifAbsent: anErrorBlock [
	^ self properties removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #interactions }
RSPropertableObject >> removeInteractionIfPresent: anInteractionClass [
	"Remove all the callbacks associated to the interaction."
	(self hasInteraction: anInteractionClass) ifFalse: [ ^ self ].
	(self getInteractionsForClass: anInteractionClass) do: [ :int | self announcer unsubscribe: int ]
]

{ #category : #properties }
RSPropertableObject >> removeKey: aKey [
	| att |
	att := self properties.
	(att includesKey: aKey) ifFalse: [ ^ self ].
	att removeKey: aKey.
	
]

{ #category : #announcer }
RSPropertableObject >> when: event do: aBlock [
	self announcer when: event do: aBlock
]
