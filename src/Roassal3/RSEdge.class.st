"
I represent lines models in RSView
"
Class {
	#name : #RSEdge,
	#superclass : #RSShapedObject,
	#instVars : [
		'from',
		'to',
		'attachPoint'
	],
	#category : #'Roassal3-Core'
}

{ #category : #'instance creation' }
RSEdge class >> from: anElement1 to: anElement2 [
	^ self new 
		from: anElement1;
		to: anElement2;
		yourself
]

{ #category : #adding }
RSEdge >> addedIn: aView [
	view := aView.
	view addEdge: self.
]

{ #category : #accessing }
RSEdge >> attachPoint [
	^ attachPoint
]

{ #category : #accessing }
RSEdge >> attachPoint: ap [
	attachPoint := ap.
]

{ #category : #accessing }
RSEdge >> from [
	^ from
]

{ #category : #accessing }
RSEdge >> from: anElement [
	from := self setAnchor: from element: anElement.
]

{ #category : #initialization }
RSEdge >> initialize [
	super initialize.
	attachPoint := RSCenteredAttachPoint new.
]

{ #category : #rendering }
RSEdge >> renderOn: v [
	super renderOn: v.
	self update.
]

{ #category : #private }
RSEdge >> setAnchor: ref element: anObject [
	
	(ref isNotNil and: [ anObject isPoint not ])
		ifTrue: [ ref removeConnectedEdge: self ].
	anObject ifNil: [ ^ nil ].
	anObject isPoint
		ifFalse: [ anObject addConnectedEdge: self ].
	^ anObject
]

{ #category : #accessing }
RSEdge >> to [ 	
	^ to
]

{ #category : #accessing }
RSEdge >> to: anElement [
	to := self setAnchor: to element: anElement.
]

{ #category : #updating }
RSEdge >> update [
	trachelShape 
		startPoint: (attachPoint startingPointOf: self);
		endPoint: (attachPoint endingPointOf: self).
]
