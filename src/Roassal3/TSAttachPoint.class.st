"
I am the base for attach points
"
Class {
	#name : #TSAttachPoint,
	#superclass : #TSObject,
	#instVars : [
		'inverted'
	],
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'instance creation' }
TSAttachPoint class >> centered [
	^ TSCenteredAttachPoint new
]

{ #category : #'public - hooks' }
TSAttachPoint >> basicEndingPointOf: anEdge [
	^ self subclassResponsibility 
]

{ #category : #'public - hooks' }
TSAttachPoint >> basicStartingPointOf: anEdge [
	^ self subclassResponsibility 
]

{ #category : #'public - hooks' }
TSAttachPoint >> endingPointOf: anEdge [
	(anEdge from = anEdge to) 
		ifTrue: [ ^ self position: anEdge from ].
    ^ inverted
        ifTrue: [ self basicStartingPointOf: anEdge ]
        ifFalse: [ self basicEndingPointOf: anEdge ]
]

{ #category : #'public - hooks' }
TSAttachPoint >> initialize [
	super initialize.
	inverted := false.
]

{ #category : #private }
TSAttachPoint >> position: anObject [
	anObject isPoint ifTrue: [ ^ anObject ].
	^ self positionFor: anObject point: anObject position.
]

{ #category : #private }
TSAttachPoint >> positionFor: anElement point: aPoint [
	| parent |
	(parent := anElement parent )ifNil: [ ^ aPoint ].
	^ parent transform: aPoint
	
]

{ #category : #'public - hooks' }
TSAttachPoint >> startingPointOf: anEdge [
	(anEdge from = anEdge to) 
		ifTrue: [ ^ self position: anEdge from ].
    ^ inverted
        ifTrue: [ self basicEndingPointOf: anEdge ]
        ifFalse: [ self basicStartingPointOf: anEdge ]

]
