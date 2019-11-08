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
		'toPositions'
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

{ #category : #hook }
RSEdgeDrivenLayout >> doExecute: elements [
	
	self subclassResponsibility
]

{ #category : #hook }
RSEdgeDrivenLayout >> doIncrementallyExecute: anElementNode [
	"called by refreshLayoutEvery: ms. It is used to convey a feeling of incremental execution."
	
	self doExecute: anElementNode
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
	edges := aCollection
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

	self userDefinedEdges
		ifNil: [ self setEdgesFromElements: elements ]
		ifNotNil: [ | flat |
			flat := OrderedCollection new.
			self userDefinedEdges
				do: [ :each | 
					each isCollection
						ifTrue: [ flat addAll: each ]
						ifFalse: [ flat add: each ] ].
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
]

{ #category : #testing }
RSEdgeDrivenLayout >> isEdgeDrivenLayout [
	^ true
]

{ #category : #accessing }
RSEdgeDrivenLayout >> setEdgesFromElements: elements [ 

	elements isEmpty ifTrue: [ ^ self ].
	
	^ self edges:
		((elements flatCollect: #incomingEdges)
			select: [ :anEdge |elements includes: anEdge from])

]

{ #category : #accessing }
RSEdgeDrivenLayout >> toPositions: anArray [
	
	toPositions := anArray
]

{ #category : #private }
RSEdgeDrivenLayout >> userDefinedEdges [
	
	^userDefinedEdges
]

{ #category : #accessing }
RSEdgeDrivenLayout >> userDefinedEdges: aCollectionOfEdges [
	"useful to tell to the layout which edges have to be used for the layout"

	userDefinedEdges := aCollectionOfEdges.
	
]
