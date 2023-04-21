"
TODO
"
Class {
	#name : #RSLineDrivenLayout,
	#superclass : #RSLayout,
	#instVars : [
		'userDefinedEdges',
		'fromPositions',
		'toPositions',
		'lines'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #testing }
RSLineDrivenLayout class >> isAbstract [
	^ self = RSLineDrivenLayout
]

{ #category : #public }
RSLineDrivenLayout class >> on: elements edges: edges [
	^ self new on: elements edges: edges
]

{ #category : #'instance creation' }
RSLineDrivenLayout class >> withEdges: aCollection [

	^self new initialize userDefinedEdges: aCollection
]

{ #category : #hook }
RSLineDrivenLayout >> doExecute: elements [
	self subclassResponsibility
]

{ #category : #hook }
RSLineDrivenLayout >> doIncrementallyExecute: anElementNode [
	"called by refreshLayoutEvery: ms. It is used to convey a feeling of incremental execution."
	self doExecute: anElementNode
]

{ #category : #private }
RSLineDrivenLayout >> edges [
	^ lines
]

{ #category : #accessing }
RSLineDrivenLayout >> edges: aCollection [
	"Set the list of edges that should be considered for the layout.
	If none is specified (i.e., if this method is not called), then the
	edges are infered."
	lines := aCollection
]

{ #category : #iterator }
RSLineDrivenLayout >> edgesDo: aBlock [
	"Iterates over all the edges of the receiver."
	lines ifNil: [ ^ self ].
	lines do: aBlock
]

{ #category : #hook }
RSLineDrivenLayout >> executeOnElements: elements [
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
RSLineDrivenLayout >> fromPositions: anArray [
	fromPositions := anArray
]

{ #category : #testing }
RSLineDrivenLayout >> isEdgeDrivenLayout [
	^ true
]

{ #category : #accessing }
RSLineDrivenLayout >> setEdgesFromElements: elements [
	elements isEmpty ifTrue: [ ^ self ].

	^ self edges:
		((elements flatCollect: #incomingLines)
			select: [ :anEdge |elements includes: anEdge from])
]

{ #category : #accessing }
RSLineDrivenLayout >> toPositions: anArray [
	toPositions := anArray
]

{ #category : #private }
RSLineDrivenLayout >> userDefinedEdges [
	^ userDefinedEdges
]

{ #category : #accessing }
RSLineDrivenLayout >> userDefinedEdges: aCollectionOfEdges [
	"useful to tell to the layout which edges have to be used for the layout"
	userDefinedEdges := aCollectionOfEdges
]
