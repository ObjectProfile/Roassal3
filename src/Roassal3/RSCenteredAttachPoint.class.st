"
I am the centered attach point
"
Class {
	#name : #RSCenteredAttachPoint,
	#superclass : #RSAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'public - hooks' }
RSCenteredAttachPoint >> basicEndingPointOf: anEdge [
	^ self position: anEdge to
	
]

{ #category : #'public - hooks' }
RSCenteredAttachPoint >> basicStartingPointOf: anEdge [
	^ self position: anEdge from
]
