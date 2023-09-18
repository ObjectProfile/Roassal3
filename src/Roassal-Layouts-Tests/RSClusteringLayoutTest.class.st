Class {
	#name : #RSClusteringLayoutTest,
	#superclass : #RSTest,
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #tests }
RSClusteringLayoutTest >> testBasic [

	| c shapes lb nodes |
	c := RSCanvas new.
	shapes := RSBox models: (10 to: 50).
	c addAll: shapes.

	RSFlowLayout on: shapes.

	lb := RSLineBuilder line.
	lb shapes: shapes.
	lb connectFrom: [ :nb | nb // 2 ].

	nodes := c nodes.

	RSConditionalLayout new
		ifNotConnectedThen: RSGridLayout new;
		else: (RSClusteringLayout new
				 clustersLayout: RSFlowLayout new;
				 forEachLayout: RSTreeLayout new);
		on: nodes.
	self assertIntegerPosition: nodes equals: {
29 @ 5.
83 @ 5.
131 @ 5.
165 @ 5.
16 @ 80.
44 @ 80.
72 @ 80.
100 @ 80.
128 @ 80.
156 @ 80.
16 @ 35.
42 @ 35.
70 @ 35.
96 @ 35.
124 @ 35.
144 @ 35.
159 @ 35.
172 @ 35.
10 @ 110.
23 @ 110.
38 @ 110.
51 @ 110.
66 @ 110.
79 @ 110.
94 @ 110.
107 @ 110.
122 @ 110.
135 @ 110.
150 @ 110.
163 @ 110.
10 @ 65.
23 @ 65.
36 @ 65.
49 @ 65.
64 @ 65.
77 @ 65.
90 @ 65.
103 @ 65.
118 @ 65.
131 @ 65.
144 @ 65.}
]

{ #category : #tests }
RSClusteringLayoutTest >> testBasic2 [

	| shapes c lb nodes clusters |
	c := RSCanvas new.
	shapes := RSBox models: (10 to: 50).
	c addAll: shapes.

	RSFlowLayout on: shapes.

	lb := RSLineBuilder line.
	lb shapes: shapes.
	lb connectFrom: [ :nb | nb // 2 ].

	nodes := c nodes.

	clusters := RSClusteringLayout new getClusterFor: nodes.
	self assert: clusters size equals: 10
]

{ #category : #tests }
RSClusteringLayoutTest >> testBasic3 [

	| c shapes lb nodes clusters |
	c := RSCanvas new.
	shapes := RSBox models: (1 to: 50).
	c addAll: shapes.

	RSFlowLayout on: shapes.

	lb := RSLineBuilder line.
	lb shapes: shapes.
	lb connectFrom: [ :nb | nb // 2 ].

	nodes := c nodes.

	clusters := RSClusteringLayout new getClusterFor: nodes.
	self assert: clusters size equals: 1
]

{ #category : #tests }
RSClusteringLayoutTest >> testCycles [
	| chars canvas shapes |
	canvas := RSCanvas new.
	chars := $a to: $e.
	shapes := RSComposite models: chars forEach: [ :composite :char |
		| box label |
		label := RSLabel text: char.
		box := RSBox new
			position: label position;
			extent: label extent + 10;
			yourself.

		composite
			draggable;
			add: box;
			add: label;
			yourself.
		].

	canvas addAll: shapes.
	RSLineBuilder arrowedLine
		canvas: canvas;
		withVerticalAttachPoint;
		useAssociations:
			{$a -> $b.
			$a -> $e.
			$b -> $c.
			$c -> $d.
			$d -> $a}. "cycle"
	self should: [RSClusterTreeLayout on: shapes] raise: Error
]
