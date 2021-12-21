"
I am the representation of the return of a `RSFullMessageSend`.
"
Class {
	#name : #RSReturnMessageSend,
	#superclass : #LookupKey,
	#instVars : [
		'return'
	],
	#category : #'Roassal3-UML-Descriptor'
}

{ #category : #accessing }
RSReturnMessageSend >> arguments [

	^ self key arguments
]

{ #category : #accessing }
RSReturnMessageSend >> client [

	^ self key receiver
]

{ #category : #dispatching }
RSReturnMessageSend >> dispatchCircleShapesOf: anAssociation onSequenceDescritor: aDescriptor [

	^ aDescriptor circleShapesOf: anAssociation returnMessageSend: self
]

{ #category : #dispatching }
RSReturnMessageSend >> dispatchSelectorShapeOnSequenceDescritor: aDescriptor [

	^ aDescriptor selectorShapeOfReturnMessageSend: self
]

{ #category : #dispatching }
RSReturnMessageSend >> dispatchTimespan: aTimespan selectorShape: aShape onSequenceDescritor: aDescriptor [

	^ aDescriptor
		  durationShapeOfReturnMessageSend: self
		  timespan: aTimespan
		  selectorShape: aShape
]

{ #category : #'as yet unclassified' }
RSReturnMessageSend >> ifMessageSend: msBlock ifReturnMessageSend: rBlock [

	^ rBlock cull: self
]

{ #category : #'as yet unclassified' }
RSReturnMessageSend >> ifSelfSend: sBlock ifNotSelfSend: nsBlock [

	^ self key ifSelfSend: sBlock ifNotSelfSend: nsBlock
]

{ #category : #printing }
RSReturnMessageSend >> printOn: aStream [

	aStream
		nextPutAll: self className;
		nextPut: $(.

	super printOn: aStream.

	aStream nextPutAll: ') → '.
	
	return printOn: aStream
]

{ #category : #accessing }
RSReturnMessageSend >> receiver [

	^ self key client
]

{ #category : #'as yet unclassified' }
RSReturnMessageSend >> recordReturnSend: anAssoc inDictionary: aDictionary [

	aDictionary
		at: self client put: anAssoc;
		at: self receiver put: anAssoc
]

{ #category : #accessing }
RSReturnMessageSend >> return [

	^ return
]

{ #category : #accessing }
RSReturnMessageSend >> return: anObject [

	return := anObject
]

{ #category : #accessing }
RSReturnMessageSend >> selector [

	^ self key selector
]

{ #category : #'as yet unclassified' }
RSReturnMessageSend >> styleLine: aLine [

	aLine dashArray: { Float goldenPlatinumRatio }
]
