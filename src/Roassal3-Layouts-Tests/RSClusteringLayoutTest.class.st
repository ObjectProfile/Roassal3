Class {
	#name : #RSClusteringLayoutTest,
	#superclass : #RSTest,
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
	self assertIntegerPosition: nodes equals: {24 @ 5.
78 @ 5.
126 @ 5.
160 @ 5.
11 @ 80.
39 @ 80.
67 @ 80.
95 @ 80.
123 @ 80.
151 @ 80.
11 @ 35.
37 @ 35.
65 @ 35.
91 @ 35.
119 @ 35.
139 @ 35.
154 @ 35.
167 @ 35.
5 @ 110.
18 @ 110.
33 @ 110.
46 @ 110.
61 @ 110.
74 @ 110.
89 @ 110.
102 @ 110.
117 @ 110.
130 @ 110.
145 @ 110.
158 @ 110.
5 @ 65.
18 @ 65.
31 @ 65.
44 @ 65.
59 @ 65.
72 @ 65.
85 @ 65.
98 @ 65.
113 @ 65.
126 @ 65.
139 @ 65}
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
