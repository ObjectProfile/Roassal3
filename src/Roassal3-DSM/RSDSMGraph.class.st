"
I am a class used to find strong connections beteween objects
based on https://www.geeksforgeeks.org/strongly-connected-components/
"
Class {
	#name : #RSDSMGraph,
	#superclass : #Object,
	#instVars : [
		'graph',
		'numberOfVertices'
	],
	#category : #'Roassal3-DSM-Variations'
}

{ #category : #'instance creation' }
RSDSMGraph class >> new: aNumber [
	^ self new
		numberOfVertices: aNumber;
		yourself
]

{ #category : #adding }
RSDSMGraph >> addEdge: anInteger to: anInteger2 [
	(graph at: anInteger ifAbsentPut: [ OrderedCollection new ]) add: anInteger2
]

{ #category : #public }
RSDSMGraph >> computeSCCs [
	| stack visited gr groups |
	groups := OrderedCollection new.
	stack := Stack new.
	visited := Array new: numberOfVertices withAll: false.
	1 to: numberOfVertices do: [ :index |
		(visited at: index)
			ifFalse: [ self fillOrder: index visited: visited stack: stack ]
	].
	gr := self getTranspose.
	visited := Array new: numberOfVertices withAll: false.
	[ stack isEmpty ] whileFalse: [ | index |
		index := stack pop.
		(visited at: index) ifFalse: [
			gr dfsUtil: index visited: visited groups: groups.
			groups add: OrderedCollection new.
		]
	].
	^ groups allButLast
]

{ #category : #utilties }
RSDSMGraph >> dfsUtil: index visited: visited [
	visited at: index put: true.
	index trace.
	(graph at: index ifAbsent: [ #() ]) do: [ :each |
		(visited at: each)
			ifFalse: [ self dfsUtil: each visited: visited ]
		 ]
]

{ #category : #utilties }
RSDSMGraph >> dfsUtil: index visited: visited groups: groups [
	visited at: index put: true.
	groups ifEmpty: [
		groups add: OrderedCollection new.
		 ].
	groups last add: index.
	(graph at: index ifAbsent: [ #() ]) do: [ :each |
		(visited at: each)
			ifFalse: [ self dfsUtil: each visited: visited groups: groups ]
		 ]
]

{ #category : #examples }
RSDSMGraph >> example01 [
	<script: 'self new example01'>

	| g |
	g := self class new: 5.
	g
		addEdge: 2 to: 1;
		addEdge: 1 to: 3;
		addEdge: 3 to: 2;
		addEdge: 1 to: 4;
		addEdge: 4 to: 5.
	g printSCCs
]

{ #category : #examples }
RSDSMGraph >> example02 [
	<script: 'self new example02 inspect'>

	| g |
	g := self class new: 5.
	g
		addEdge: 2 to: 1;
		addEdge: 1 to: 3;
		addEdge: 3 to: 2;
		addEdge: 1 to: 4;
		addEdge: 4 to: 5.
	^ g computeSCCs
]

{ #category : #private }
RSDSMGraph >> fillOrder: index visited: visited stack: stack [
	visited at: index put: true.
	(graph at: index ifAbsent: [ #()]) do: [ :each |
		(visited at: each)
			ifFalse: [ self fillOrder: each visited: visited stack: stack ]
		 ].
	stack push: index
]

{ #category : #private }
RSDSMGraph >> getTranspose [
	| g |
	g := self class new: numberOfVertices.
	graph keysAndValuesDo: [ :k :value |
		value do: [ :j |
			g addEdge: j to: k ]
		 ].
	^ g
]

{ #category : #initialization }
RSDSMGraph >> initialize [
	super initialize.
	graph := Dictionary new
]

{ #category : #accessing }
RSDSMGraph >> numberOfVertices: anInteger [
	numberOfVertices := anInteger
]

{ #category : #public }
RSDSMGraph >> printSCCs [
	| stack visited gr |
	stack := Stack new.
	visited := Array new: numberOfVertices withAll: false.
	1 to: numberOfVertices do: [ :index |
		(visited at: index)
			ifFalse: [ self fillOrder: index visited: visited stack: stack ]
	].
	gr := self getTranspose.
	visited := Array new: numberOfVertices withAll: false.
	[ stack isEmpty ] whileFalse: [ | index |
		index := stack pop.
		(visited at: index) ifFalse: [
			gr dfsUtil: index visited: visited.
			'' traceCr.
			 ]
	 ]
]
