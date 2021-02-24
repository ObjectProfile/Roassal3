Class {
	#name : #RSClusteringLayoutTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #tests }
RSClusteringLayoutTest >> testBasic [

	| m nodes |
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

	self
		assert: (nodes collect: #position) asArray
		equals: ((Array new: 41)
				 at: 1 put: 19.0 @ 7.5;
				 at: 2 put: 53.0 @ 7.5;
				 at: 3 put: 83.0 @ 7.5;
				 at: 4 put: 105.0 @ 7.5;
				 at: 5 put: 11.0 @ 67.5;
				 at: 6 put: 29.0 @ 67.5;
				 at: 7 put: 47.0 @ 67.5;
				 at: 8 put: 65.0 @ 67.5;
				 at: 9 put: 83.0 @ 67.5;
				 at: 10 put: 101.0 @ 67.5;
				 at: 11 put: 11.0 @ 32.5;
				 at: 12 put: 27.0 @ 32.5;
				 at: 13 put: 45.0 @ 32.5;
				 at: 14 put: 61.0 @ 32.5;
				 at: 15 put: 79.0 @ 32.5;
				 at: 16 put: 91.0 @ 32.5;
				 at: 17 put: 101.0 @ 32.5;
				 at: 18 put: 109.0 @ 32.5;
				 at: 19 put: 7.0 @ 92.5;
				 at: 20 put: 15.0 @ 92.5;
				 at: 21 put: 25.0 @ 92.5;
				 at: 22 put: 33.0 @ 92.5;
				 at: 23 put: 43.0 @ 92.5;
				 at: 24 put: 51.0 @ 92.5;
				 at: 25 put: 61.0 @ 92.5;
				 at: 26 put: 69.0 @ 92.5;
				 at: 27 put: 79.0 @ 92.5;
				 at: 28 put: 87.0 @ 92.5;
				 at: 29 put: 97.0 @ 92.5;
				 at: 30 put: 105.0 @ 92.5;
				 at: 31 put: 7.0 @ 57.5;
				 at: 32 put: 15.0 @ 57.5;
				 at: 33 put: 23.0 @ 57.5;
				 at: 34 put: 31.0 @ 57.5;
				 at: 35 put: 41.0 @ 57.5;
				 at: 36 put: 49.0 @ 57.5;
				 at: 37 put: 57.0 @ 57.5;
				 at: 38 put: 65.0 @ 57.5;
				 at: 39 put: 75.0 @ 57.5;
				 at: 40 put: 83.0 @ 57.5;
				 at: 41 put: 91.0 @ 57.5;
				 yourself)
]

{ #category : #tests }
RSClusteringLayoutTest >> testBasic2 [

	| m nodes clusters |
	m := RSMondrian new.
	m nodes: (10 to: 50).
	m line connectFrom: [ :nb | nb // 2 ].
	m build.

	nodes := m canvas nodes.

	clusters := RSClusteringLayout new getClusterFor: nodes.
	self assert: clusters size equals: 10.
]

{ #category : #tests }
RSClusteringLayoutTest >> testBasic3 [

	| m nodes clusters |
	m := RSMondrian new.
	m nodes: (1 to: 50).
	m line connectFrom: [ :nb | nb // 2 ].
	m build.

	nodes := m canvas nodes.

	clusters := RSClusteringLayout new getClusterFor: nodes.
	self assert: clusters size equals: 1.
]
