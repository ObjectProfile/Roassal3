Extension { #name : #RSClusteringLayout }

{ #category : #'*Roassal3-Examples' }
RSClusteringLayout class >> exampleMondrian [
	| m nodes class |
	class := Smalltalk globals
		at: #RSMondrian
		ifAbsent: [ ^ RSCanvas new open ].
	m := class new.
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

{ #category : #'*Roassal3-Examples' }
RSClusteringLayout class >> exampleNumbers [
	| m nodes class |
	class := Smalltalk globals
		at: #RSMondrian
		ifAbsent: [ ^ RSCanvas new open ].
	m := class new.
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
