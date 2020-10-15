Class {
	#name : #RSMondrianTest,
	#superclass : #RSTest,
	#instVars : [
		'm'
	],
	#category : #'Roassal3-Mondrian-Tests'
}

{ #category : #tests }
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
RSMondrianTest >> testEdges [

	m nodes: (1 to: 100).
	m line connectFrom: [ :v | v // 2 ].
	m layout grid.
	m build.
	
	self assert: m canvas numberOfNodes equals: 100.
	self assert: m canvas numberOfEdges equals: 99.
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
