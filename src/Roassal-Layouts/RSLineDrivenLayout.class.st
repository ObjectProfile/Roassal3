"
This class implements a layout algorithm that arranges objects based on their connections, using lines to guide their positioning.
My subclasses are `RSAbstractGraphLayout` and `RSForceBasedLayout`

I define utility methods to find the lines/edges connections used in my subclasses
"
Class {
	#name : #RSLineDrivenLayout,
	#superclass : #RSLayout,
	#instVars : [
		'lines',
		'userDefinedLines'
	],
	#category : #'Roassal-Layouts-ByConnection'
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

	^self new userDefinedLines: aCollection
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
	self userDefinedLines
		ifNil: [ self setEdgesFromElements: elements ]
		ifNotNil: [ | flat |
			flat := OrderedCollection new.
			self userDefinedLines
				do: [ :each |
					each isCollection
						ifTrue: [ flat addAll: each ]
						ifFalse: [ flat add: each ] ].
			self edges: flat ].
	super executeOnElements: elements
]

{ #category : #accessing }
RSLineDrivenLayout >> setEdgesFromElements: shapes [
	shapes isEmpty ifTrue: [ ^ self ].

	^ self edges:
		((shapes flatCollect: #incomingLines)
			select: [ :anEdge |shapes includes: anEdge from])
]

{ #category : #private }
RSLineDrivenLayout >> userDefinedLines [
	^ userDefinedLines
]

{ #category : #hook }
RSLineDrivenLayout >> userDefinedLines: aCollectionOfLines [
	"useful to tell to the layout which edges have to be used for the layout"
	userDefinedLines := aCollectionOfLines
]
