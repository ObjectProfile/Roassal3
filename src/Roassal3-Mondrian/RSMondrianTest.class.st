Class {
	#name : #RSMondrianTest,
	#superclass : #RSTest,
	#instVars : [
		'm'
	],
	#category : #'Roassal3-Mondrian-Tests'
}

{ #category : #running }
RSMondrianTest >> setUp [
	super setUp.
	m := RSMondrian new.
]

{ #category : #tests }
RSMondrianTest >> testBasic [
	| pos someNodes |
	someNodes := m nodes: (1 to: 5).
	m build.
	
	pos := m canvas shapes collect: #position.
	self assert: pos asArray equals: {(7.5@7.5). (17.5@7.5). (7.5@17.5). (17.5@17.5). (7.5@27.5)}.
	
	self assert: someNodes asArray equals: m canvas shapes asArray
]

{ #category : #tests }
RSMondrianTest >> testBasic2 [
	| pos someNodes |
	m shape size: #yourself.
	
	self assert: m shape height equals: #yourself.
	self assert: m shape width equals: #yourself.
	
	someNodes := m nodes: (10 to: 50 by: 10).
	m applyLayout.
	
	self assert: (m canvas shapes collect: #width) asArray equals: #(10.0 20.0 30.0 40.0 50.0).
	self assert: (m canvas shapes collect: #height) asArray equals: #(10.0 20.0 30.0 40.0 50.0).
	
	pos := m canvas shapes collect: #position.
	self assert: pos asArray equals: {(10.0@10.0). (30.0@15.0). (60.0@20.0). (25.0@60.0). (75.0@65.0)}.
	
	self assert: someNodes asArray equals: m canvas shapes asArray
]

{ #category : #tests }
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

{ #category : #tests }
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
	
	self assert: (nodes collect: #position) asArray equals:  {(7.5@7.5). (7.5@17.5). (7.5@27.5). (7.5@37.5)}.
]

{ #category : #tests }
RSMondrianTest >> testEdges [

	m nodes: (1 to: 100).
	m line connectFrom: [ :v | v // 2 ].
	m layout grid.
	m build.
	
	self assert: m canvas numberOfNodes equals: 100.
	self assert: m canvas numberOfEdges equals: 99.
]

{ #category : #tests }
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
	self assert: (subNodes collect: #position) asArray equals:  {(-5.0@ -20.0). (5.0@ -20.0). (-5.0@ -10.0). (5.0@ -10.0). (-5.0@0.0). (5.0@0.0). (-5.0@10.0). (5.0@10.0). (-5.0@20.0)}
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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
