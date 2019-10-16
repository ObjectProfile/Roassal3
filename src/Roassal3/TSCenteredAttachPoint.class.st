"
I am the centered attach point
"
Class {
	#name : #TSCenteredAttachPoint,
	#superclass : #TSAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #'public - hooks' }
TSCenteredAttachPoint >> basicEndingPointOf: anEdge [
	^ self position: anEdge to
	
]

{ #category : #'public - hooks' }
TSCenteredAttachPoint >> basicStartingPointOf: anEdge [
	^ self position: anEdge from
]
