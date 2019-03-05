"
Too abstract at this point, do we need instances of RSElement?
"
Class {
	#name : #RSElement,
	#superclass : #RSShapedObject,
	#instVars : [
		'shouldUpdateEdges',
		'connectedEdges'
	],
	#category : #'Roassal3-Core'
}

{ #category : #edges }
RSElement >> addConnectedEdge: anEdge [
	[ anEdge class == RSEdge ] assert.
	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #adding }
RSElement >> addedIn: aView [
	view := aView.
	view addElement: self.
]

{ #category : #accessing }
RSElement >> connectedEdges [
	"Return the list of connected egdes (i.e., incoming and outgoing edges)"
	connectedEdges ifNil: [ connectedEdges := TSGroup new ].
	^ connectedEdges
]

{ #category : #initialization }
RSElement >> initialize [
	super initialize.
	self updateEdgesON
]

{ #category : #removing }
RSElement >> remove [
	super remove.
	self removeConnectedEdges.
]

{ #category : #edges }
RSElement >> removeConnectedEdge: anEdge [
	[  anEdge class == RSEdge ] assert.
	self connectedEdges remove: anEdge ifAbsent: [ ]
]

{ #category : #edges }
RSElement >> removeConnectedEdges [
	"Remove all the edges connected (incoming and outgoing)."
	self connectedEdges copy do: [ :edge | edge remove ]
]

{ #category : #actions }
RSElement >> translateBy: delta [
	trachelShape translateBy: delta.
	self updateConnectedEdges.
]

{ #category : #edges }
RSElement >> updateConnectedEdges [
	shouldUpdateEdges ifFalse: [ ^ self ].
	self connectedEdges do: [ :edge | edge update ]
]

{ #category : #edges }
RSElement >> updateEdgesOFF [
	shouldUpdateEdges := false
]

{ #category : #edges }
RSElement >> updateEdgesON [
	shouldUpdateEdges := true
]
