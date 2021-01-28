Class {
	#name : #RSColoredTreePaletteTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Colors'
}

{ #category : #tests }
RSColoredTreePaletteTest >> testBasic [

	| c nodes lb ctp node1 node2 node3 |
	c := RSCanvas new.
	nodes := RSBox models: (1 to: 10).
	c addAll: nodes.
	nodes @ RSPopup.
	lb := RSLineBuilder orthoVertical.
	lb withVerticalAttachPoint.
	lb shapes: nodes.
	lb connectFrom: [ :nb | nb // 2 ].

	RSTreeLayout on: nodes.

	c @ RSCanvasController.
	
	node1 := c shapeFromModel: 1. "The root"
	node2 := c shapeFromModel: 2. "Right below 1"
	node3 := c shapeFromModel: 3. "Right below 1"
	
	self assert: node1 color == node2 color.
	self assert: node3 color == node2 color.
	
	"Assign the color"
	ctp := RSColoredTreePalette new.
	ctp shapes: c nodes.
	ctp assignColor.

	self assert: node3 color ~= node2 color.
	self assert: node1 color ~= node2 color.
	

	
]

{ #category : #tests }
RSColoredTreePaletteTest >> testLeaves [

	| c nodes lb ctp node1 node2 node3 |
	c := RSCanvas new.
	nodes := RSBox models: (1 to: 10).
	c addAll: nodes.
	nodes @ RSPopup.
	lb := RSLineBuilder orthoVertical.
	lb withVerticalAttachPoint.
	lb shapes: nodes.
	lb connectFrom: [ :nb | nb // 2 ].

	RSTreeLayout on: nodes.

	c @ RSCanvasController.
	
	node1 := c shapeFromModel: 1. "The root"
	node2 := c shapeFromModel: 2. "Right below 1"
	node3 := c shapeFromModel: 3. "Right below 1"
	
	"Assign the color"
	ctp := RSColoredTreePalette new.
	ctp shapes: c nodes.
	ctp assignColor.
	
	self assert: ctp totalNumberOfLeaves equals: 5
]
