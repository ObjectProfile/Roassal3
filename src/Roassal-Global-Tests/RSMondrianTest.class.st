Class {
	#name : 'RSMondrianTest',
	#superclass : 'RSTest',
	#instVars : [
		'm'
	],
	#category : 'Roassal-Global-Tests-Mondrian',
	#package : 'Roassal-Global-Tests',
	#tag : 'Mondrian'
}

{ #category : 'running' }
RSMondrianTest >> setUp [
	super setUp.
	m := RSMondrian new
]

{ #category : 'tests' }
RSMondrianTest >> testBasic [
	| someNodes |
	someNodes := m nodes: (1 to: 5).
	m build.

	self assertIntegerPosition: m canvas shapes equals: {2 @ 2. 12 @ 2. 2 @ 12. 12 @ 12. 2 @ 22}.
	self assert: someNodes asArray equals: m canvas shapes asArray
]

{ #category : 'tests' }
RSMondrianTest >> testBasic2 [
	| someNodes |
	m shape size: #yourself.

	self assert: m shape height equals: #yourself.
	self assert: m shape width equals: #yourself.

	someNodes := m nodes: (10 to: 50 by: 10).
	m applyLayout.

	self assert: (m canvas shapes collect: #width) asArray equals: #(10.0 20.0 30.0 40.0 50.0).
	self assert: (m canvas shapes collect: #height) asArray equals: #(10.0 20.0 30.0 40.0 50.0).

	self assertIntegerPosition: m canvas shapes equals: {5 @ 5. 25 @ 10. 55 @ 15. 20 @ 55. 70 @ 60}.

	self assert: someNodes asArray equals: m canvas shapes asArray
]

{ #category : 'tests' }
RSMondrianTest >> testColoredNodesForEach [

	m shape color: Color blue.
	m nodes: (1 to: 2) forEach: [ :v |
		m shape color: Color red.
		m nodes: #(3 4) ].
	m build.

	self assert: m canvas nodes size equals: 2.
	self assert: (m canvas nodes allSatisfy: [ :e | e color = Color blue ]).
	self assert: (m canvas nodes flatCollect: [ :e | e children collect: #color ]) asSet asArray equals: { Color red }
]

{ #category : 'tests' }
RSMondrianTest >> testComposingMondrian [

	| c compo m2 nodes |
	c := RSCanvas new.
	compo := RSComposite new.

	m := RSMondrian new.
	m canvas: compo.
	m shape box size: 10.
	m nodes: (1 to: 9).
	m build.

	c add: compo.

	compo color: Color blue.
	compo adjustToChildren.
	compo padding: 10.

	compo setAsFixed.

	m2 := RSMondrian new.
	m2 canvas: c.
	nodes := m2 nodes: (1 to: 4).
	m2 line connectFrom: [ :v | v // 2 ].
	m2 build.

	self assert: c numberOfEdges equals: 3.
	self assert: c numberOfNodes equals: 5.
	self assertIntegerPosition: nodes equals: {2 @ 2. 12 @ 2. 2 @ 12. 12 @ 12}
]

{ #category : 'tests' }
RSMondrianTest >> testEdges [

	m nodes: (1 to: 100).
	m line connectFrom: [ :v | v // 2 ].
	m layout grid.
	m build.

	self assert: m canvas numberOfNodes equals: 100.
	self assert: m canvas numberOfEdges equals: 99
]

{ #category : 'tests - labeled shape' }
RSMondrianTest >> testLabeled01 [

	| shape |
	m shape box labeled.
	m nodes: #(42).
	m build.

	self assert: m canvas numberOfNodes equals: 1.
	shape := m canvas nodes first.
	self assert: shape class equals: RSComposite.

	self assert: shape nodes size equals: 2.
	self assert: shape nodes second class equals: RSLabel.
	self assert: shape nodes first class equals: RSBox.
	self assert: shape nodes second text equals: '42'
]

{ #category : 'tests - labeled shape' }
RSMondrianTest >> testLabeled02 [

	| shape |
	m shape box labeled.
	m nodes: #(42) forEach: [ :nb | m nodes: { nb + 1 } ].
	m build.

	self assert: m canvas numberOfNodes equals: 1.
	shape := m canvas nodes first.
	self assert: shape class equals: RSComposite.

	self assert: shape nodes size equals: 2.
	self assert: shape nodes second class equals: RSLabel.
	self assert: shape nodes second text equals: '42'.
	self assert: shape nodes first class equals: RSBox
]

{ #category : 'tests - labeled shape' }
RSMondrianTest >> testLabeled03HasModel [

	m shape box labeled.
	m nodes: #(42) forEach: [ :nb | m nodes: { nb + 1 } ].
	m build.

	self assert: m canvas nodes first model equals: 42
]

{ #category : 'tests - labeled shape' }
RSMondrianTest >> testLabeled03bisHasModel [

	m shape box labeled.
	m nodes: #(42).
	m build.

	self assert: m canvas nodes first model equals: 42
]

{ #category : 'tests - labeled shape' }
RSMondrianTest >> testLabeled04HasModel [

	m shape box labeled.
	m nodes: #(1 2 3 4).
	m line connectTo: [ :nb | nb + 1 ].
	m build.

	self assert: (m canvas nodes allSatisfy: #hasModel)
]

{ #category : 'tests' }
RSMondrianTest >> testLabeledOuterShapes01 [

	| shape |
	m := RSMondrian new.
	m nodes: #(42).
	m build.
	self assert: m canvas shapes size equals: 1.
	shape := m canvas shapes first.
	self assert: shape class equals: RSBox
]

{ #category : 'tests' }
RSMondrianTest >> testLabeledOuterShapes02 [

	| shape |
	m := RSMondrian new.
	m nodes: #(42) forEach: [ :nb | m nodes: #(42) ].
	m build.
	self assert: m canvas shapes size equals: 1.
	shape := m canvas shapes first.
	self assert: shape class equals: RSComposite.
	self assert: shape children size equals: 1.
	self assert: shape children first class equals: RSBox
]

{ #category : 'tests' }
RSMondrianTest >> testLabeledOuterShapes03 [

	| shape |
	m := RSMondrian new.
	m shape labeled.
	m nodes: #(42) forEach: [ :nb | m nodes: #(42) ].
	m build.
	self assert: m canvas shapes size equals: 1.
	shape := m canvas shapes first.
	self assert: shape class equals: RSComposite.
	self assert: shape children size equals: 2.
	self assert: shape children first class equals: RSBox.
	self assert: shape children second class equals: RSLabel
]

{ #category : 'tests' }
RSMondrianTest >> testLabeledOuterShapes04 [

	| shape |
	m := RSMondrian new.
	m shape labeled color: Color white.
	m nodes: #(42) forEach: [ :nb | m nodes: #(42) ].
	m build.
	self assert: m canvas shapes size equals: 1.
	shape := m canvas shapes first.
	self assert: shape class equals: RSComposite.
	self assert: shape color equals: Color white.

	self assert: shape children size equals: 2.
	self assert: shape children first class equals: RSBox.
	self assert: shape children second class equals: RSLabel
]

{ #category : 'tests' }
RSMondrianTest >> testLabeledOuterShapes05 [

	| shape |
	m := RSMondrian new.
	m shape labeled color: Color white; borderWidth: 2.
	m nodes: #(42) forEach: [ :nb | m nodes: #(42) ].
	m build.
	self assert: m canvas shapes size equals: 1.
	shape := m canvas shapes first.
	self assert: shape class equals: RSComposite.
	self assert: shape color equals: Color white.
	self assert: shape border isNotNil.
	self assert: shape border width equals: 2.

	self assert: shape children size equals: 2.
	self assert: shape children first class equals: RSBox.
	self assert: shape children second class equals: RSLabel
]

{ #category : 'tests' }
RSMondrianTest >> testNesting [

	| c firstNode subNodes |
	m := RSMondrian new.

	m nodes: (1 to: 4) forEach: [ :v |
		m shape box color: Color blue.
		m nodes: (1 to: 9) ].

	m build.

	c := m canvas.

	self assert: c numberOfNodes equals: 4.

	firstNode := c nodes first.
	self assert: firstNode numberOfNodes equals: 9.

	subNodes := firstNode nodes.
	self assert: subNodes size equals: 9.
	self assertIntegerPosition: subNodes equals: {-10 @ -10. 0 @ -10. 10 @ -10. -10 @ 0. 0 @ 0. 10 @ 0. -10 @ 10. 0 @ 10. 10 @ 10}
]

{ #category : 'tests' }
RSMondrianTest >> testNodesForEach [

	m nodes: (1 to: 2) forEach: [ :v |
		m nodes: #(3 4) ].
	m build.

	self assert: m canvas numberOfNodes equals: 2.
	self assert: m canvas numberOfEdges equals: 0.
	self assert: (m canvas deepShapesFromModels: #(1 2 3 4)) asArray equals:
		{ m canvas shapes first . m canvas shapes first children first . m canvas shapes first children second .
		  m canvas shapes second . m canvas shapes second children first . m canvas shapes second children second }
]

{ #category : 'tests' }
RSMondrianTest >> testNodesForEachAndLAyout [

	m nodes: #(1) forEach: [ :v |
		m nodes: #(3 4) ].
	m build.

	self assert: m canvas numberOfNodes equals: 1.
	self assert: m canvas numberOfEdges equals: 0.
	self assert: (m canvas deepShapesFromModels: #(1 2 3 4)) asArray equals:
		{ m canvas shapes first . m canvas shapes first children first . m canvas shapes first children second }.

	self assert: m canvas shapes first children first position ~= m canvas shapes first children second position
]

{ #category : 'tests' }
RSMondrianTest >> testWithNullElement [

	| c lb shape nodes |
	c := RSCanvas new.
	shape := RSCircle new.
	c add: shape.
	shape setAsFixed.

	m := RSMondrian new.
	m canvas: c.
	nodes := m nodes: (1 to: 2).
	lb := m line.
	lb connectFrom: [ :v | v // 2 ].
	m build.

	self assert: lb fromShapes size equals: 2.
	self assert: lb fromShapes asArray equals: nodes asArray.
	self assert: (lb fromShapes noneSatisfy: [ :s | s model isNil ])
]

{ #category : 'tests' }
RSMondrianTest >> testWithNullElementWithFixed [

	| c shape lb nodes |
	c := RSCanvas new.
	shape := RSCircle new.
	c add: shape.
	shape setAsFixed.

	m := RSMondrian new.
	m canvas: c.
	nodes := m nodes: (1 to: 2).
	lb := m line.
	lb connectFrom: [ :v | v // 2 ].
	m build.

	self assert: lb fromShapes size equals: 2.
	self assert: lb fromShapes asArray equals: nodes asArray.
	self assert: (lb fromShapes noneSatisfy: [ :s | s model isNil ])
]
