"
I am the attach point based on RSElements 
"
Class {
	#name : #RSElementAttachPoint,
	#superclass : #RSAttachPoint,
	#category : #'Roassal3-AttachPoint'
}

{ #category : #edges }
RSElementAttachPoint >> addConnectedEdge: edge [
	target addConnectedEdge: edge
]

{ #category : #accessing }
RSElementAttachPoint >> model [
	^ target model
]

{ #category : #edges }
RSElementAttachPoint >> removeConnectedEdge: edge [
	target removeConnectedEdge: edge
]
