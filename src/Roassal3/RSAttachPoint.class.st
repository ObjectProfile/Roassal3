"
I am the base for attach points
"
Class {
	#name : #RSAttachPoint,
	#superclass : #RSObject,
	#instVars : [
		'target'
	],
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'instance creation' }
RSAttachPoint class >> centered [
	^ RSCenteredAttachPoint new
]

{ #category : #'instance creation' }
RSAttachPoint class >> point [
	^ RSPositionAttachPoint new
]

{ #category : #edges }
RSAttachPoint >> addConnectedEdge: edge [
]

{ #category : #accessing }
RSAttachPoint >> globalPoint [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
RSAttachPoint >> on: anObject [
	target := anObject
]

{ #category : #edges }
RSAttachPoint >> removeConnectedEdge: edge [
]

{ #category : #accessing }
RSAttachPoint >> target [
	target
]
