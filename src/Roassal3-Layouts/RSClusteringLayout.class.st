"
```
m := RSMondrian new.
m nodes: Collection allSubclasses.
m line connectFrom: #superclass.
m normalizeSize: #numberOfLinesOfCode.
m build.

nodes := m canvas nodes.

RSConditionalLayout new
	ifNotConnectedThen: RSGridLayout new;
	else: (RSClusteringLayout new 
				clustersLayout: RSFlowLayout new;
				forEachLayout: RSTreeLayout new);
	on: nodes.


m canvas.
```

Another example:

```
m := RSMondrian new.
m nodes: (10 to: 50).
m line connectFrom: [ :nb | nb // 2 ].
m build.

nodes := m canvas nodes.

RSConditionalLayout new
	ifNotConnectedThen: RSGridLayout new;
	else: (RSClusteringLayout new 
				clustersLayout: RSFlowLayout new;
				forEachLayout: RSTreeLayout new);
	on: nodes.



m canvas.
```
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
	| clusters groupToBeIncluded g |
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
	^ clusters
]

{ #category : #'initialize-release' }
RSClusteringLayout >> initialize [
	super initialize.
	forEachLayout := RSHorizontalLineLayout new.
	clustersLayout := RSFlowLayout new
]
