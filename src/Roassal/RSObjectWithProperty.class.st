"
This class has a set of properties useful to contains some meta-information.
Properties may be added, removed, and tested.
Furthermore, `RSObjectWithProperty` has an announcer and offers some abilities to handle event with interactions. 
My subclasses have attributes useful to add extra data to each component

*Responsibility*: support properties defined in terms of pairs key->values, and can do some event handling.

*Collaborators*: subclasses
"
Class {
	#name : 'RSObjectWithProperty',
	#superclass : 'RSObject',
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'announcer',
		'properties'
	],
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'examples' }
RSObjectWithProperty class >> exampleCanvas [
	| c |
	c := RSCanvas new.
	c propertyAt: #rick put: #morty.
	^ StInspector openOn: c properties
]

{ #category : 'examples' }
RSObjectWithProperty class >> exampleShapeBox [
	| shape |
	shape := RSBox new.
	shape propertyAt: #randy put: #stan.
	^ StInspector openOn: shape properties
]

{ #category : 'interactions' }
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

{ #category : 'interactions' }
RSObjectWithProperty >> addInteraction: anInteractionClassOrInstance [
 	anInteractionClassOrInstance onShape: self
]

{ #category : 'announcer' }
RSObjectWithProperty >> announcementClasses [
	"must return a collection of Announcement classes"
	^ self subclassResponsibility
]

{ #category : 'announcer' }
RSObjectWithProperty >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : 'accessing' }
RSObjectWithProperty >> canvas [
	^ self subclassResponsibility
]

{ #category : 'events' }
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
	self announcer announce: (RSMouseClick new
		canvas: self canvas;
		shape: self;
		yourself)
]

{ #category : 'interactions' }
RSObjectWithProperty >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	self announcer subscriptions ifNil: [ ^ false ].
	^ self announcer subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : 'properties' }
RSObjectWithProperty >> hasProperties [
	^ properties isNotNil and: [ properties notEmpty ]
]

{ #category : 'properties' }
RSObjectWithProperty >> hasProperty: aKey [
	^ properties isNotNil and: [ properties includesKey: aKey ]
]

{ #category : 'testing' }
RSObjectWithProperty >> isShape [
	"Useful to lookup the canvas in a hierarchy of nested shapes"
	^ false
]

{ #category : 'announcer' }
RSObjectWithProperty >> privateAnnouncer [
	^ announcer
]

{ #category : 'properties' }
RSObjectWithProperty >> properties [
	^ properties ifNil: [ properties := Dictionary new ]
]

{ #category : 'properties' }
RSObjectWithProperty >> properties: aDictionary [
	properties := aDictionary
]

{ #category : 'properties' }
RSObjectWithProperty >> propertiesDo: block [
	self hasProperties ifFalse: [ ^ self ].
	block value: self properties
]

{ #category : 'properties' }
RSObjectWithProperty >> propertyAt: aKey [
	^ self properties at: aKey ifAbsent: [ nil ]
]

{ #category : 'properties' }
RSObjectWithProperty >> propertyAt: aKey ifAbsent: anAbsentBlock [
	^ self properties at: aKey ifAbsent: anAbsentBlock
]

{ #category : 'properties' }
RSObjectWithProperty >> propertyAt: aKey ifAbsentPut: anAbsentBlock [
	^ self properties at: aKey ifAbsentPut: anAbsentBlock
]

{ #category : 'properties' }
RSObjectWithProperty >> propertyAt: aKey ifPresent: aPresentBlock [
	^ self properties at: aKey ifPresent: aPresentBlock
]

{ #category : 'properties' }
RSObjectWithProperty >> propertyAt: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self properties at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : 'properties' }
RSObjectWithProperty >> propertyAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [
	^ self properties at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : 'properties' }
RSObjectWithProperty >> propertyAt: aKey put: value [
	"Keep a value under a key. The key is usually a symbol.
For example:
```
RSBox new propertyAt: #hello put: 'World'; propertyAt: #hello
```
return World
	"

	^ self properties at: aKey put: value
]

{ #category : 'events' }
RSObjectWithProperty >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : 'properties' }
RSObjectWithProperty >> removeKey: aKey [
	| prop |
	prop := self properties.
	(prop includesKey: aKey) ifFalse: [ ^ self ].
	prop removeKey: aKey.
	prop ifEmpty: [ prop := nil ]
]

{ #category : 'properties' }
RSObjectWithProperty >> removePropertyAt: aKey [
	^ self properties removeKey: aKey
]

{ #category : 'properties' }
RSObjectWithProperty >> removePropertyAt: aKey ifAbsent: anErrorBlock [
	^ self properties removeKey: aKey ifAbsent: anErrorBlock
]
