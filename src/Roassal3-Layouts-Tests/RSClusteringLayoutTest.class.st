Class {
	#name : #RSClusteringLayoutTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Layouts-Tests'
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
	self
		assert: (nodes collect: #position) asArray
		equals: {29.5@10.
83.5@10.
131@10.
165.5@10.
16.5@85.
44.5@85.
72.5@85.
100.5@85.
128.5@85.
156.5@85.
16.5@40.
42.5@40.
70.5@40.
96.5@40.
124.5@40.
144@40.
159@40.
172@40.
10@115.
23@115.
38@115.
51@115.
66@115.
79@115.
94@115.
107@115.
122@115.
135@115.
150@115.
163@115.
10@70.
23@70.
36@70.
49@70.
64@70.
77@70.
90@70.
103@70.
118@70.
131@70.
144@70}
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
