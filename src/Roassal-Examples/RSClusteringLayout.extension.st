Extension { #name : 'RSClusteringLayout' }

{ #category : '*Roassal-Examples' }
RSClusteringLayout class >> exampleMondrian [
	| m nodes |
	m := RSMondrian new.
	m nodes: Collection allSubclasses.
	m line connectFrom: #superclass.
	m normalizeSize: #numberOfLinesOfCode.
	m build.

	nodes := m canvas nodes.

	RSConditionalLayout new
		ifNotConnectedThen: RSGridLayout new;
		else: (self new
					clustersLayout: RSFlowLayout new;
					forEachLayout: RSTreeLayout new);
		on: nodes.


	^ m canvas open
]

{ #category : '*Roassal-Examples' }
RSClusteringLayout class >> exampleNumbers [
	| m nodes |
	m := RSMondrian new.
	m nodes: (10 to: 50).
	m line connectFrom: [ :nb | nb // 2 ].
	m build.

	nodes := m canvas nodes.

	RSConditionalLayout new
		ifNotConnectedThen: RSGridLayout new;
		else: (self new
					clustersLayout: RSFlowLayout new;
					forEachLayout: RSTreeLayout new);
		on: nodes.

	^ m canvas open
]
