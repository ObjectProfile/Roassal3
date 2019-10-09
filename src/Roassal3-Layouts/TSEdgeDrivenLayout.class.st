"
TODO
"
Class {
	#name : #TSEdgeDrivenLayout,
	#superclass : #TSLayout,
	#instVars : [
		'edges',
		'userDefinedEdges',
		'fromPositions',
		'toPositions'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'as yet unclassified' }
TSEdgeDrivenLayout class >> isAbstract [
	^ self = TSEdgeDrivenLayout
]

{ #category : #public }
TSEdgeDrivenLayout class >> on: elements edges: edges [
	^ self new on: elements edges: edges
]

{ #category : #'instance creation' }
TSEdgeDrivenLayout class >> withEdges: aCollection [
	
	^self new initialize userDefinedEdges: aCollection
]

{ #category : #hook }
TSEdgeDrivenLayout >> doExecute: elements [
	
	self subclassResponsibility
]

{ #category : #hook }
TSEdgeDrivenLayout >> doIncrementallyExecute: anElementNode [
	"called by refreshLayoutEvery: ms. It is used to convey a feeling of incremental execution."
	
	self doExecute: anElementNode
]

{ #category : #private }
TSEdgeDrivenLayout >> edges [
	
	^ edges
]

{ #category : #accessing }
TSEdgeDrivenLayout >> edges: aCollection [
	"Set the list of edges that should be considered for the layout.
	If none is specified (i.e., if this method is not called), then the 
	edges are infered."
	edges := aCollection
]

{ #category : #iterator }
TSEdgeDrivenLayout >> edgesDo: aBlock [
	"Iterates over all the edges of the receiver."
	
	edges ifNil: [ ^ self ].
	edges do: aBlock

]

{ #category : #hook }
TSEdgeDrivenLayout >> executeOnElements: elements [
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
TSEdgeDrivenLayout >> fromPositions: anArray [
	
	fromPositions := anArray
]

{ #category : #'initialize-release' }
TSEdgeDrivenLayout >> initialize [
	"Initialization"
	super initialize.
	edges := nil.
]

{ #category : #testing }
TSEdgeDrivenLayout >> isEdgeDrivenLayout [
	^ true
]

{ #category : #accessing }
TSEdgeDrivenLayout >> setEdgesFromElements: elements [ 

	elements isEmpty ifTrue: [ ^ self ].
	
	^ self edges:
		((elements flatCollect: #incomingEdges)
			select: [ :anEdge |elements includes: anEdge from])

]

{ #category : #accessing }
TSEdgeDrivenLayout >> toPositions: anArray [
	
	toPositions := anArray
]

{ #category : #private }
TSEdgeDrivenLayout >> userDefinedEdges [
	
	^userDefinedEdges
]

{ #category : #accessing }
TSEdgeDrivenLayout >> userDefinedEdges: aCollectionOfEdges [
	"useful to tell to the layout which edges have to be used for the layout"

	userDefinedEdges := aCollectionOfEdges.
	
]
