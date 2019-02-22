"
I represent lines models in RSView
"
Class {
	#name : #RSEdge,
	#superclass : #RSShapedObject,
	#instVars : [
		'from',
		'to'
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
RSEdge >> from [
	^ from
]

{ #category : #accessing }
RSEdge >> from: anElement [
	from := self setAnchor: from element: anElement.
]

{ #category : #rendering }
RSEdge >> renderOn: v [
	super renderOn: v.
	self update.
]

{ #category : #private }
RSEdge >> setAnchor: ref element: anElement [
	| attachPoint |
	ref isNotNil ifTrue: [ ref removeConnectedEdge: self ].
	attachPoint := anElement asAttachPoint.
	attachPoint addConnectedEdge: self.
	^ attachPoint
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
	trachelShape startPoint: from globalPoint.
	trachelShape endPoint: to globalPoint.
]
