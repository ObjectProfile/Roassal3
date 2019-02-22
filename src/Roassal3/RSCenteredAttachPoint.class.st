"
I am the centered attach point
"
Class {
	#name : #RSCenteredAttachPoint,
	#superclass : #RSElementAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #accessing }
RSCenteredAttachPoint >> globalPoint [ 
	^ target position
]
