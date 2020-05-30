"
My subclasses has attributes useful to add extra data to each component
"
Class {
	#name : #RSObjectWithProperty,
	#superclass : #RSObject,
	#instVars : [
		'announcer',
		'properties'
	],
	#category : #'Roassal3-Core'
}

{ #category : #interactions }
RSObjectWithProperty >> @ anInteractionClassOrInstance [
	"Add an interaction to the canvas or a shape.
Here is an example that illustrate two interactions, one for a shape and another for the canvas:
-=-=-=-=-=-=-=-=-=
c := RSCanvas new.
shape := RSEllipse new size: 30; model: 'hello'.
c add: shape.
shape @ RSPopup.
c @ RSCanvasController
-=-=-=-=-=-=-=-=-=
	"
	
	self addInteraction: anInteractionClassOrInstance
]

{ #category : #interactions }
RSObjectWithProperty >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance onShape: self
]

{ #category : #announcer }
RSObjectWithProperty >> announce: anEventOrAnEventClass [
	"Send an event"
	self subclassResponsibility
]

{ #category : #announcer }
RSObjectWithProperty >> announcer [ 
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #announcer }
RSObjectWithProperty >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #accessing }
RSObjectWithProperty >> canvas [
	^ self subclassResponsibility
]

{ #category : #events }
RSObjectWithProperty >> click [
	"Simulate a click. 
	
For example:
-=-=-=-=-=-=-=-=-=
c := RSCanvas new.
box := RSBox new size: 40.
box when: RSMouseClick do: [ :evt | self inform: 'hello' ].
c add: box.

box click.

c
-=-=-=-=-=-=-=-=-=
"
	self announcer announce: (RSMouseClick new).
]

{ #category : #interactions }
RSObjectWithProperty >> getInteractionsForClass: anInteractionClass [
	"Return the Announcement subscriptions for the interaction"
	^ self announcer subscriptions getInteractionsForClass: anInteractionClass
]

{ #category : #interactions }
RSObjectWithProperty >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	self announcer subscriptions ifNil: [ ^ false ].
	^ self announcer subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : #properties }
RSObjectWithProperty >> hasProperties [
	^ properties notNil and: [ properties notEmpty ]
]

{ #category : #properties }
RSObjectWithProperty >> hasProperty: aKey [ 
	^ properties notNil and: [ properties includesKey: aKey ]
]

{ #category : #announcer }
RSObjectWithProperty >> privateAnnouncer [
	^ announcer
]

{ #category : #private }
RSObjectWithProperty >> privateAttributes [
	^ properties
]

{ #category : #properties }
RSObjectWithProperty >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : #properties }
RSObjectWithProperty >> propertiesDo: block [
	self hasProperties ifFalse: [ ^ self ].
	block value: self properties.
]

{ #category : #properties }
RSObjectWithProperty >> propertyAt: aKey [
	^ self properties at: aKey ifAbsent: [ nil ]
]

{ #category : #properties }
RSObjectWithProperty >> propertyAt: aKey ifAbsent: aBlockClosure [ 
	^ self properties at: aKey ifAbsent: aBlockClosure 
]

{ #category : #properties }
RSObjectWithProperty >> propertyAt: aKey ifAbsentPut: aBlockClosure [ 
	^ self properties at: aKey ifAbsentPut: aBlockClosure 
]

{ #category : #properties }
RSObjectWithProperty >> propertyAt: aKey ifPresent: aBlockClosure [ 
	^ self properties at: aKey ifPresent: aBlockClosure 
]

{ #category : #properties }
RSObjectWithProperty >> propertyAt: aKey put: value [
	^ self properties at: aKey put: value
]

{ #category : #events }
RSObjectWithProperty >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #interactions }
RSObjectWithProperty >> removeInteractionIfPresent: anInteractionClass [
	"Remove all the callbacks associated to the interaction."
	(self hasInteraction: anInteractionClass) ifFalse: [ ^ self ].
	(self getInteractionsForClass: anInteractionClass) do: [ :int | self announcer unsubscribe: int ]
]

{ #category : #properties }
RSObjectWithProperty >> removeKey: aKey [
	| att |
	att := self properties.
	(att includesKey: aKey) ifFalse: [ ^ self ].
	att removeKey: aKey.
	
]

{ #category : #properties }
RSObjectWithProperty >> removePropertyAt: aKey [
	^ self properties removeKey: aKey
]

{ #category : #properties }
RSObjectWithProperty >> removePropertyAt: aKey ifAbsent: anErrorBlock [
	^ self properties removeKey: aKey ifAbsent: anErrorBlock
]

{ #category : #announcer }
RSObjectWithProperty >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #announcer }
RSObjectWithProperty >> when: anAnnouncementClass send: aSelector to: anObject [
	self announcer when: anAnnouncementClass send: aSelector to: anObject
]
