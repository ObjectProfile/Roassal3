"
Instances of FullMessageSend encapsulate messages send to objects, holding clients also.

Structure:
 client		Object -- object performing the message send
"
Class {
	#name : #RSFullMessageSend,
	#superclass : #MessageSend,
	#instVars : [
		'client',
		'callerSelector'
	],
	#category : #'Roassal3-UML-Descriptor'
}

{ #category : #comparing }
RSFullMessageSend >> = anObject [

	^ super = anObject and: [ client = anObject client ]
]

{ #category : #converting }
RSFullMessageSend >> asReturnMessageSend [

	^ RSReturnMessageSend new
		  key: self;
		  yourself
]

{ #category : #accessing }
RSFullMessageSend >> callerSelector [

	^ callerSelector
]

{ #category : #accessing }
RSFullMessageSend >> callerSelector: aSelector [

	callerSelector := aSelector
]

{ #category : #accessing }
RSFullMessageSend >> client [

	^ client
]

{ #category : #accessing }
RSFullMessageSend >> client: anObject [

	client := anObject
]

{ #category : #dispatching }
RSFullMessageSend >> dispatchCircleShapesOf: anAssociation onSequenceDescritor: aDescriptor [

	^ aDescriptor circleShapesOf: anAssociation messageSend: self
]

{ #category : #dispatching }
RSFullMessageSend >> dispatchSelectorShapeOnSequenceDescritor: aDescriptor [

	^ aDescriptor selectorShapeOfMessageSend: self
]

{ #category : #dispatching }
RSFullMessageSend >> dispatchTimespan: aTimespan selectorShape: aShape onSequenceDescritor: aDescriptor [

	^ aDescriptor
		  durationShapeOfMessageSend: self
		  timespan: aTimespan
		  selectorShape: aShape
]

{ #category : #comparing }
RSFullMessageSend >> hash [

	^ super hash bitXor: client hash
]

{ #category : #'as yet unclassified' }
RSFullMessageSend >> ifMessageSend: msBlock ifReturnMessageSend: rBlock [

	^ msBlock cull: self
]

{ #category : #'as yet unclassified' }
RSFullMessageSend >> ifSelfSend: sBlock ifNotSelfSend: nsBlock [

	^ self client == self receiver
		  ifTrue: [ sBlock cull: self ]
		  ifFalse: [ nsBlock cull: self ]
]

{ #category : #'as yet unclassified' }
RSFullMessageSend >> recordReturnSend: anAssoc inDictionary: aDictionary [

	"I've to record nothing"

	
]

{ #category : #'as yet unclassified' }
RSFullMessageSend >> styleLine: aLine [
]
