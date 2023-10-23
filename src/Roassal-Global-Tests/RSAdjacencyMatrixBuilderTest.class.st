Class {
	#name : 'RSAdjacencyMatrixBuilderTest',
	#superclass : 'RSTest',
	#instVars : [
		'empty',
		'b'
	],
	#category : 'Roassal-Global-Tests-Examples',
	#package : 'Roassal-Global-Tests',
	#tag : 'Examples'
}

{ #category : 'running' }
RSAdjacencyMatrixBuilderTest >> setUp [

	super setUp.
	empty := RSAdjacencyMatrixBuilder new.

	b := RSAdjacencyMatrixBuilder new.
	b objects: (1 to: 4).
	b connections: { 1 -> 2 . 1 -> 3 . 2 -> 4 }
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testBasic01 [

	self assert: empty numberOfObjects equals: 0.
	self assert: empty numberOfConnections equals: 0
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testBasic02 [

	empty objects: (1 to: 10).
	self assert: empty numberOfObjects equals: 10.
	self assert: empty numberOfConnections equals: 0
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testBasic03 [

	empty objects: #( 'hello' 'bonjour' 'Guten Morgen' ).
	self assert: empty numberOfObjects equals: 3.
	self assert: empty numberOfConnections equals: 0
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testConnections01 [

	empty connections: {
			(1 -> 2).
			(2 -> 3) }.
	self assert: empty numberOfConnections equals: 2.
	self assert: (empty does: 1 dependsOn: 2).
	self deny: (empty does: 2 dependsOn: 1).
	self assert: (empty does: 2 dependsOn: 3).
	self deny: (empty does: 3 dependsOn: 2).
	self deny: (empty does: 1 dependsOn: 42)
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testCycle01 [

	self deny: b hasCycle
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testCycle02 [

	b := RSAdjacencyMatrixBuilder new.
	b objects: (1 to: 3).

	b connections: {
			(1 -> 2).
			(2 -> 3) }.
	self deny: b hasCycle.

	b connections: {
			(1 -> 2).
			(2 -> 3).
			(3 -> 1) }.
	self assert: b hasCycle
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testCycle03 [

	self deny: empty hasCycle
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testCycle04 [

	b := RSAdjacencyMatrixBuilder new.
	b objects: (1 to: 4).

	b connections: {
			(1 -> 2).
			(2 -> 3) }.
	self assert: b getAllCycles isEmpty.

	b connections: {
			(1 -> 2).
			(2 -> 3).
			(3 -> 1) }.
	self assert: b getAllCycles size equals: 1.

	b connections: {
			(1 -> 2).
			(2 -> 1).
			(3 -> 4).
			(4 -> 3) }.
	self assert: b getAllCycles size equals: 2.
	self assert: (b getAllCycles includes: (Set withAll: #(1 2))).
	self assert: (b getAllCycles includes: (Set withAll: #(3 4))).

	b connections: {
			(1 -> 2).
			(2 -> 1).
			(3 -> 4).
			(4 -> 3) }.
	self assert: b getAllCycles size equals: 2.
	self assert: (b getAllCycles includes: (Set withAll: #(1 2))).
	self assert: (b getAllCycles includes: (Set withAll: #(3 4)))
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testIncomingConnectionsOf [
	self assert: (b incomingConnectionsOf: 3) equals: #(3).
	self assert: (b numberOfIncomingConnectionsOf: 4) equals: 1.
	self assert: (b numberOfIncomingConnectionsOf: 3) equals: 1.
	self assert: (b numberOfIncomingConnectionsOf: 2) equals: 1.
	self assert: (b numberOfIncomingConnectionsOf: 1) equals: 0
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testOutgoingConnectionsOf [
	self assert: (b outgoingConnectionsOf: 1) equals: #(2 3).
	self assert: (b numberOfOutgoingConnectionsOf: 1) equals: 2.
	self assert: (b numberOfOutgoingConnectionsOf: 2) equals: 1
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testRendering01 [
	| canvas allCells |
	canvas := b build.

	self assert: canvas class == RSCanvas.

	allCells := canvas shapes select: [ :c | c class == RSBox ].
	self assert: allCells size equals: 4 * 4.

	self assert: allCells first model equals: 1 -> 1.
	self assert: allCells first color equals: b nonConnectingColor.

	self assert: allCells second model equals: 1 -> 2.
	self assert: allCells second color equals: b connectingColor
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testSorting01 [
	b build.
	self assert: b objects equals: (1 to: 4)
]

{ #category : 'tests' }
RSAdjacencyMatrixBuilderTest >> testSorting02 [
	b := RSAdjacencyMatrixBuilder new.
	b objects: (1 to: 4).
	b connections: { 2 -> 1 . 2 -> 4 . 4 -> 1 }.

	b sortByNumberOfOutgoingConnections.
	b build.
	self assert: b objects equals: #(3 1 4 2)
]
