"
TODO
"
Class {
	#name : #RSEdgeDrivenLayout,
	#superclass : #RSLayout,
	#instVars : [
		'edges',
		'userDefinedEdges',
		'fromPositions',
		'toPositions',
		'shouldSetDefaultAttachPoint'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'as yet unclassified' }
RSEdgeDrivenLayout class >> isAbstract [
	^ self = RSEdgeDrivenLayout
]

{ #category : #public }
RSEdgeDrivenLayout class >> on: elements edges: edges [
	^ self new on: elements edges: edges
]

{ #category : #'instance creation' }
RSEdgeDrivenLayout class >> withEdges: aCollection [
	
	^self new initialize userDefinedEdges: aCollection
]

{ #category : #'default attach points' }
RSEdgeDrivenLayout >> addDefaultAttachPointToEdges [
	"TODO!!!!!"

"	| a |
	a := self defaultAttachPoint.
	edges do: [ :e | e shape attachPoint: a ]"
]

{ #category : #accessing }
RSEdgeDrivenLayout >> affectedNodes [
	
	^affectedNodes
]

{ #category : #accessing }
RSEdgeDrivenLayout >> affectedNodes: anObject [
	
	affectedNodes := anObject
]

{ #category : #accessing }
RSEdgeDrivenLayout >> affectedNodesOf:  aNode [ 
	^ affectedNodes ifNil: [ aNode nodes ]
]

{ #category : #'default attach points' }
RSEdgeDrivenLayout >> defaultAttachPoint [
	^ RTCenteredAttachPoint new
]

{ #category : #'default values' }
RSEdgeDrivenLayout >> defaultFromPositions [
	^ #()
	
]

{ #category : #'default values' }
RSEdgeDrivenLayout >> defaultToPositions [
	^ #()

]

{ #category : #'default attach points' }
RSEdgeDrivenLayout >> doAttachPoint [
	"Change the attach point of edges when added"
	shouldSetDefaultAttachPoint := true
]

{ #category : #hook }
RSEdgeDrivenLayout >> doExecute: elements [
	
	self subclassResponsibility
]

{ #category : #hook }
RSEdgeDrivenLayout >> doIncrementallyExecute: anElementNode [
	"called by refreshLayoutEvery: ms. It is used to convey a feeling of incremental execution."
	
	self doExecute: anElementNode
]

{ #category : #'default attach points' }
RSEdgeDrivenLayout >> doNotAttachPoint [
	"Do not add an attach point to edges when doing the layout"
	shouldSetDefaultAttachPoint := false
]

{ #category : #private }
RSEdgeDrivenLayout >> edges [
	
	^ edges
]

{ #category : #accessing }
RSEdgeDrivenLayout >> edges: aCollection [
	"Set the list of edges that should be considered for the layout.
	If none is specified (i.e., if this method is not called), then the 
	edges are infered."
	edges := aCollection.
	self shouldSetDefaultAttachPoint
		ifTrue: [ self addDefaultAttachPointToEdges ]
]

{ #category : #iterator }
RSEdgeDrivenLayout >> edgesDo: aBlock [
	"Iterates over all the edges of the receiver."
	
	edges ifNil: [ ^ self ].
	edges do: aBlock

]

{ #category : #hook }
RSEdgeDrivenLayout >> executeOnElements: elements [ 
	"Execute the layout, myself, on the elements"

	self userDefinedEdges isNil 
		ifTrue: [ self setEdgesFromElements: elements ]
		ifFalse: 
			[ | flat |
			flat := OrderedCollection new.
			self userDefinedEdges do: 
				[ :each | 
				each isCollection 
					ifTrue: [ flat addAll: each ]
					ifFalse: [ flat add: each ] ].
			flat := flat select: #isUsedInLayout. 
			self edges: flat ].
		
	super executeOnElements: elements
]

{ #category : #accessing }
RSEdgeDrivenLayout >> fromPositions: anArray [
	
	fromPositions := anArray
]

{ #category : #'initialize-release' }
RSEdgeDrivenLayout >> initialize [
	"Initialization"
	super initialize.
	edges := nil.
	shouldSetDefaultAttachPoint := false
]

{ #category : #testing }
RSEdgeDrivenLayout >> isEdgeDrivenLayout [
	^ true
]

{ #category : #accessing }
RSEdgeDrivenLayout >> setEdgesFromElements: elements [ 

	elements isEmpty ifTrue: [ ^ self ].
	
	^ self
		edges:
			((elements flatCollect: #incomingEdges)
				select: [ :anEdge | anEdge isUsedInLayout and: (elements includes: anEdge from) ])
"	view := elements anyOne view.
	view ifNil: [ ^ self ].
	self edges: (view edges select: [ :el | 
		(el isUsedInLayout and: [ elements includes: el from ]) and: [ elements includes: el to ] ]).
	"
]

{ #category : #'default attach points' }
RSEdgeDrivenLayout >> shouldSetDefaultAttachPoint [
	"Return true if an attach point has to be added to edges. False else"
	^ shouldSetDefaultAttachPoint
]

{ #category : #accessing }
RSEdgeDrivenLayout >> toPositions: anArray [
	
	toPositions := anArray
]

{ #category : #private }
RSEdgeDrivenLayout >> userDefinedEdges [
	
	^userDefinedEdges
]

{ #category : #'initialize-release' }
RSEdgeDrivenLayout >> userDefinedEdges: aCollectionOfEdges [
	"useful to tell to the layout which edges have to be used for the layout"

	userDefinedEdges := aCollectionOfEdges.
	
]
