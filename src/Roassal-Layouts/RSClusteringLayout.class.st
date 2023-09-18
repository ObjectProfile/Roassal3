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
	#category : #'Roassal-Layouts-Core'
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
	| result resultWithGroups |
	result := OrderedCollection new.
	shapes do: [ :s | | t |
		t := s allRecursiveConnectedShapes.
		(result includes: t) 
			ifFalse: [ result add: t ]
	].

	resultWithGroups := result
		collect: [ :coll |(coll asArray sortedAs: #asString) asGroup ]
		as: RSGroup.
	^ resultWithGroups
]

{ #category : #initialization }
RSClusteringLayout >> initialize [
	super initialize.
	forEachLayout := RSHorizontalLineLayout new.
	clustersLayout := RSFlowLayout new
]
