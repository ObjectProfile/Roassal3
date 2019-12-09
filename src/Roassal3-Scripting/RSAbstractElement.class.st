"
I represent a basic and composite elements
"
Class {
	#name : #RSAbstractElement,
	#superclass : #RSShapedObject,
	#instVars : [
		'shouldUpdateEdges',
		'connectedEdges'
	],
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #edges }
RSAbstractElement >> addConnectedEdge: anEdge [
	[ anEdge isEdge ] assert.
	(self connectedEdges includes: anEdge) 
		ifFalse: [ self connectedEdges add: anEdge ]
]

{ #category : #adding }
RSAbstractElement >> addedIn: aParent [
	aParent addElement: self.
	self announceAdded: RSElementAdded parent: aParent
]

{ #category : #'accessing - children' }
RSAbstractElement >> children [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractElement >> connectedEdges [
	"Return the list of connected egdes (i.e., incoming and outgoing edges)"
	connectedEdges ifNil: [ connectedEdges := RSGroup new ].
	^ connectedEdges
]

{ #category : #testing }
RSAbstractElement >> hasChildren [
	^ self subclassResponsibility
]

{ #category : #testing }
RSAbstractElement >> hasEdges [
	^ connectedEdges notNil
]

{ #category : #edges }
RSAbstractElement >> incomingEdges [
	"Return the list of incoming edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e to == self ]
]

{ #category : #initialization }
RSAbstractElement >> initialize [
	super initialize.
	self updateEdgesON
]

{ #category : #edges }
RSAbstractElement >> isDirectlyConnectedTo: anElement [
	connectedEdges ifNil: [ ^ false ].
	^ connectedEdges anySatisfy: [ :edge | edge to == anElement ]
]

{ #category : #testing }
RSAbstractElement >> isElement [
	^ true
]

{ #category : #edges }
RSAbstractElement >> outgoingEdges [
	"Return the list of outgoing edges from the node"
	connectedEdges ifNil: [ ^ #() ].
	^ self connectedEdges select: [ :e | e from == self ]
]

{ #category : #removing }
RSAbstractElement >> remove [
	parent ifNotNil: [ 
		parent removeElement: self.
		parent := nil.
	 ].
	self removeConnectedEdges.
]

{ #category : #edges }
RSAbstractElement >> removeConnectedEdge: anEdge [
	[  anEdge class == RSEdge ] assert.
	self connectedEdges remove: anEdge ifAbsent: [ ]
]

{ #category : #edges }
RSAbstractElement >> removeConnectedEdges [
	"Remove all the edges connected (incoming and outgoing)."
	self hasEdges ifFalse: [ ^ self ].
	self connectedEdges copy do: [ :edge | edge remove ]
]

{ #category : #testing }
RSAbstractElement >> shouldUpdateEdges [
	^ shouldUpdateEdges and: [ connectedEdges notNil ]
]

{ #category : #actions }
RSAbstractElement >> translateBy: delta [
	self translateTo: self shape position + delta.
	
]

{ #category : #actions }
RSAbstractElement >> translateTo: position [
	shape translateTo: position.
	 self updateConnectedEdges.
	
]

{ #category : #edges }
RSAbstractElement >> updateConnectedEdges [
	self shouldUpdateEdges ifFalse: [ ^ self ].
	self connectedEdges do: [ :edge | edge update ]
]

{ #category : #edges }
RSAbstractElement >> updateEdgesOFF [
	shouldUpdateEdges := false
]

{ #category : #edges }
RSAbstractElement >> updateEdgesON [
	shouldUpdateEdges := true
]
