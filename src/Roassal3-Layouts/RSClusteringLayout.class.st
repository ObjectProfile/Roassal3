"
Creates a layout of all connected shapes, all connected shapes are going to have `forEachLayout`.
Then the clusters will have perform `clustersLayout`.
In general I have 2 layouts, one for clusters another of elements inside each cluster.
"
Class {
	#name : #RSClusteringLayout,
	#superclass : #RSLayout,
	#instVars : [
		'clustersLayout',
		'forEachLayout'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSClusteringLayout >> clustersLayout [

	^ clustersLayout
]

{ #category : #accessing }
RSClusteringLayout >> clustersLayout: anObject [

	clustersLayout := anObject
]

{ #category : #hook }
RSClusteringLayout >> doExecute: shapes [
	"Performs the layout"

	"A collection of collections"
	| clusters |
	clusters := self getClusterFor: shapes.
	clusters do: [ :group | forEachLayout on: group ].
	clustersLayout on: clusters
]

{ #category : #accessing }
RSClusteringLayout >> forEachLayout [

	^ forEachLayout
]

{ #category : #accessing }
RSClusteringLayout >> forEachLayout: anObject [

	forEachLayout := anObject
]

{ #category : #hook }
RSClusteringLayout >> getClusterFor: shapes [
	| result resultWithGroups st |
	result := OrderedCollection new.
	shapes do: [ :s |
		| t |
		t := s allRecursiveConnectedShapes.
		(result includes: t) ifFalse: [ result add: t ]
		 ].

	resultWithGroups := RSGroup new.
	result do: [ :coll |
		st := coll asArray sortedAs: #asString.
		resultWithGroups add: st asGroup ].
	^ resultWithGroups

"	| clusters groupToBeIncluded g |
	clusters := RSGroup new.

	shapes do: [ :s |
		groupToBeIncluded := s incomingShapes
									ifEmpty: [ nil ]
									ifNotEmpty: [
			 									clusters detect: [ :group | group includes: s incomingShapes anyOne ] ifNone: [ nil ] ].
		groupToBeIncluded
			ifNil: [ g := RSGroup new. g add: s. clusters add: g ]
			ifNotNil: [ groupToBeIncluded add: s ].
		].

	self assert: ((clusters collect: #size) sum = (clusters collect: #yourself as: Set) size).
	^ clusters"
]

{ #category : #initialization }
RSClusteringLayout >> initialize [
	super initialize.
	forEachLayout := RSHorizontalLineLayout new.
	clustersLayout := RSFlowLayout new
]
