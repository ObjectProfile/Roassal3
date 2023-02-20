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
		equals: ((Array new: 41) at: 1 put: ((29.0@10.0)); at: 2 put: ((83.0@10.0)); at: 3 put: ((131.0@10.0)); at: 4 put: ((165.0@10.0)); at: 5 put: ((16.0@85.0)); at: 6 put: ((44.0@85.0)); at: 7 put: ((72.0@85.0)); at: 8 put: ((100.0@85.0)); at: 9 put: ((128.0@85.0)); at: 10 put: ((156.0@85.0)); at: 11 put: ((16.0@40.0)); at: 12 put: ((42.0@40.0)); at: 13 put: ((70.0@40.0)); at: 14 put: ((96.0@40.0)); at: 15 put: ((124.5@40.0)); at: 16 put: ((144.0@40.0)); at: 17 put: ((158.5@40.0)); at: 18 put: ((171.5@40.0)); at: 19 put: ((9.5@115.0)); at: 20 put: ((22.5@115.0)); at: 21 put: ((37.5@115.0)); at: 22 put: ((50.5@115.0)); at: 23 put: ((65.5@115.0)); at: 24 put: ((78.5@115.0)); at: 25 put: ((93.5@115.0)); at: 26 put: ((106.5@115.0)); at: 27 put: ((121.5@115.0)); at: 28 put: ((134.5@115.0)); at: 29 put: ((149.5@115.0)); at: 30 put: ((162.5@115.0)); at: 31 put: ((9.5@70.0)); at: 32 put: ((22.5@70.0)); at: 33 put: ((35.5@70.0)); at: 34 put: ((48.5@70.0)); at: 35 put: ((63.5@70.0)); at: 36 put: ((76.5@70.0)); at: 37 put: ((89.5@70.0)); at: 38 put: ((102.5@70.0)); at: 39 put: ((118.0@70.0)); at: 40 put: ((131.0@70.0)); at: 41 put: ((144.0@70.0)); yourself)
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
