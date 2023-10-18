"
Used as example
"
Class {
	#name : 'RSAdjacencyMatrixBuilder',
	#superclass : 'RSBuilder',
	#instVars : [
		'connections',
		'objects'
	],
	#category : 'Roassal-Builders-Example',
	#package : 'Roassal-Builders',
	#tag : 'Example'
}

{ #category : 'hooks' }
RSAdjacencyMatrixBuilder >> connectingColor [

	^ Color blue
]

{ #category : 'accessing' }
RSAdjacencyMatrixBuilder >> connections: someConnections [

	"Set the connections used by the Adcency Matrix to build the matrix. The connections must be
	provided as a set of associations between the objects."

	connections := someConnections
]

{ #category : 'hooks' }
RSAdjacencyMatrixBuilder >> defaultSize [
	^ 10
]

{ #category : 'private -testing' }
RSAdjacencyMatrixBuilder >> does: obj1 dependsOn: obj2 [
	"Return true if there is a connection from obj1 to obj2"
	^ connections includes: obj1 -> obj2
]

{ #category : 'public - cycle' }
RSAdjacencyMatrixBuilder >> getAllCycles [

	"Return all the cycles contained in the graph"

	| answer |
	answer := Set new.
	objects do: [ :obj |
		| s |
		s := self getVisitedNodesStartingFrom: obj.
		(s includes: obj) ifTrue: [ answer add: s ] ].
	^ answer
]

{ #category : 'public - cycle' }
RSAdjacencyMatrixBuilder >> getVisitedNodesStartingFrom: obj [
	| visiting |
	visiting := Set new.
	(self outgoingConnectionsOf: obj) do: [ :o |
		  self hasCycleStartingFrom: o visiting: visiting ].
	^ visiting
]

{ #category : 'public - cycle' }
RSAdjacencyMatrixBuilder >> hasCycle [
	"Return true if the graph has some cycle. Else return false"
	^ objects anySatisfy: [ :obj | self hasCycleStartingFrom: obj ]
]

{ #category : 'public - cycle' }
RSAdjacencyMatrixBuilder >> hasCycleStartingFrom: obj [
	^ (self getVisitedNodesStartingFrom: obj) includes: obj
]

{ #category : 'public - cycle' }
RSAdjacencyMatrixBuilder >> hasCycleStartingFrom: obj visiting: visiting [

	(visiting includes: obj) ifTrue: [ ^ self ].
	visiting add: obj.
	(self numberOfOutgoingConnectionsOf: obj) = 0 ifTrue: [ ^ self ].
	(self outgoingConnectionsOf: obj) do: [ :o |
		self hasCycleStartingFrom: o visiting: visiting ]
]

{ #category : 'private' }
RSAdjacencyMatrixBuilder >> incomingConnectionsOf: anObject [

	^ connections
		  select: [ :assoc | assoc value = anObject ]
		  thenCollect: #value
]

{ #category : 'initialization' }
RSAdjacencyMatrixBuilder >> initialize [

	super initialize.
	objects := #(  ).
	connections := #(  )
]

{ #category : 'public - sorting' }
RSAdjacencyMatrixBuilder >> noSorting [
	"No sorting"
]

{ #category : 'hooks' }
RSAdjacencyMatrixBuilder >> nonConnectingColor [

	^ Color veryVeryLightGray
]

{ #category : 'accessing' }
RSAdjacencyMatrixBuilder >> numberOfConnections [

	^ connections size
]

{ #category : 'private' }
RSAdjacencyMatrixBuilder >> numberOfIncomingConnectionsOf: anObject [

	^ (self incomingConnectionsOf: anObject) size
]

{ #category : 'accessing' }
RSAdjacencyMatrixBuilder >> numberOfObjects [

	^ objects size
]

{ #category : 'private' }
RSAdjacencyMatrixBuilder >> numberOfOutgoingConnectionsOf: anObject [

	^ (self outgoingConnectionsOf: anObject) size
]

{ #category : 'accessing' }
RSAdjacencyMatrixBuilder >> objects [

	"Return the objects that are used in both axes"

	^ objects
]

{ #category : 'accessing' }
RSAdjacencyMatrixBuilder >> objects: someObjects [

	"Set the objects that must be used in both axes"

	self
		assert: [ someObjects isCollection ]
		description: 'Only a collection must be provided'.
	objects := someObjects
]

{ #category : 'private' }
RSAdjacencyMatrixBuilder >> outgoingConnectionsOf: anObject [

	^ connections
		  select: [ :assoc | assoc key = anObject ]
		  thenCollect: #value
]

{ #category : 'rendering' }
RSAdjacencyMatrixBuilder >> renderIn: aCanvas [

	"Display the adjacency matrix"

	| shape |
	objects do: [ :obj1 |
		objects do: [ :obj2 |
			shape := RSBox new.
			shape size: self defaultSize.
			(self does: obj1 dependsOn: obj2)
				ifTrue: [ shape color: self connectingColor ]
				ifFalse: [ shape color: self nonConnectingColor ].
			shape model: obj1 -> obj2.
			aCanvas add: shape ] ].
	RSGridLayout new
		gapSize: 0;
		lineItemsCount: self numberOfObjects;
		on: aCanvas shapes.

	aCanvas shapes @ RSPopup
]

{ #category : 'public - sorting' }
RSAdjacencyMatrixBuilder >> sortByNumberOfIncomingConnections [

	objects := objects asSortedCollection: [ :a :b |
		           (self numberOfIncomingConnectionsOf: a)
		           < (self numberOfIncomingConnectionsOf: b) ].
	objects := objects asArray
]

{ #category : 'public - sorting' }
RSAdjacencyMatrixBuilder >> sortByNumberOfOutgoingConnections [

	objects := objects asSortedCollection: [ :a :b |
		           (self numberOfOutgoingConnectionsOf: a)
		           < (self numberOfOutgoingConnectionsOf: b) ].
	objects := objects asArray
]
