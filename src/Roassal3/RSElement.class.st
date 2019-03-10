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

{ #category : #edges }
RSElement >> incomingEdges [
	"Return the list of incoming edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e to == self ]
]

{ #category : #initialization }
RSElement >> initialize [
	super initialize.
	self updateEdgesON
]

{ #category : #edges }
RSElement >> isDirectlyConnectedTo: anElement [
	connectedEdges ifNil: [ ^ false ].
	^ connectedEdges anySatisfy: [ :edge | edge to == anElement ]
]

{ #category : #edges }
RSElement >> outgoingEdges [
	"Return the list of outgoing edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e from == self ]
]

{ #category : #removing }
RSElement >> remove [
	view removeElement: self.
	view := nil.
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
