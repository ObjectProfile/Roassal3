Class {
	#name : #RSShapeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Shapes'
}

{ #category : #tests }
RSShapeTest >> testAllConnectedShapes [
	| c shapes lb node1 node2 node3 node5 node6 |
	c := RSCanvas new.


	shapes := RSLabel models: (1 to: 6).
	c addAll: shapes.
	shapes @ RSDraggableInteraction.
	lb := RSLineBuilder arrowedLine.
	lb withBorderAttachPoint.
	lb shapes: shapes.
	lb useAssociations: { 1 -> 3 . 3 -> 2 . 3 -> 4 . 5 -> 6. }.
	RSForceBasedLayout on: shapes.
	c @ RSCanvasController.
	
	node1 := c shapeFromModel: 1.
	node2 := c shapeFromModel: 2.
	node3 := c shapeFromModel: 3.
	node5 := c shapeFromModel: 5.
	node6 := c shapeFromModel: 6.
	
	self assert: (node1 allRecursiveConnectedShapes collect: #model) asSortedCollection asArray equals: (1 to: 4).
	
	self assert: node1 allRecursiveConnectedShapes equals: node2 allRecursiveConnectedShapes.
	self assert: node1 allRecursiveConnectedShapes equals: node3 allRecursiveConnectedShapes.
	self assert: node2 allRecursiveConnectedShapes equals: node3 allRecursiveConnectedShapes.

	self assert: node1 allRecursiveConnectedShapes ~= node5 allRecursiveConnectedShapes.
	
	self assert: node5 allRecursiveConnectedShapes equals: node6 allRecursiveConnectedShapes.

]

{ #category : #tests }
RSShapeTest >> testHasModel [

	self deny: RSCircle new hasModel.
	self assert: (RSShape new model: 52) hasModel.
	self assert: (RSLine new model: 52) hasModel.
	self deny: RSLine new hasModel.
]

{ #category : #tests }
RSShapeTest >> testIncomingAndOutgoingShapes [

	| c shapes lb node1 node5 |
	c := RSCanvas new.
	shapes := RSBox models: (1 to: 10).
	c addAll: shapes.
	lb := RSLineBuilder line.
	lb canvas: c.
	lb connectFrom: [ :nb | nb // 2 ].
	
	node1 := c shapeFromModel: 1.
	self assert: node1 model equals: 1.
	
	self assert: node1 outgoingLines size equals: 2.
	self assert: node1 outgoingShapes size equals: 2.
	self assert: node1 outgoingShapes equals: (c shapesFromModels: #(2 3)).
	
	self assert: node1 incomingLines isEmpty.
	self assert: node1 incomingShapes isEmpty.
	
	node5 := c shapeFromModel: 5.
	self assert: node5 incomingShapes equals: (c shapesFromModels: #(2)).
	self assert: node5 outgoingShapes equals: (c shapesFromModels: #(10 11)).
	
	
]

{ #category : #tests }
RSShapeTest >> testModelForIt [

	| s |
	s := RSBox model: 42 forIt: [ :ss :object | ss color: Color pink ].
	self assert: s class equals: RSBox.
	self assert: s model equals: 42.
	self assert: s color equals: Color pink
]

{ #category : #tests }
RSShapeTest >> testModels [

	| shapes |
	shapes := RSCircle models: (1 to: 10).
	self assert: shapes isCollection.
	self assert: shapes class equals: RSGroup.
	self assert: (shapes allSatisfy: [ :s | s class == RSCircle ]).
	self assert: (shapes collect: #width) asSet asArray equals: #(10)
]

{ #category : #tests }
RSShapeTest >> testModelsSize [

	| shapes |
	shapes := RSCircle models: (1 to: 10) size: #yourself.
	self assert: shapes isCollection.
	self assert: shapes class equals: RSGroup.
	self assert: (shapes allSatisfy: [ :s | s class == RSCircle ]).
	self assert: (shapes collect: #width) asArray equals: (1 to: 10) asArray.
	self assert: (shapes collect: #height) asArray equals: (1 to: 10) asArray
]

{ #category : #tests }
RSShapeTest >> testTranslateMiddleRightTo [

	| c center lbl |
	c := RSCanvas new.

	center := RSEllipse new size: 2; color: Color red.
	c add: center.
	center translateTo: 0 @ 0.

	lbl := RSLabel text: 'Middle right corner'.
	c add: lbl.
	lbl translateMiddleRightTo: 0 @ 0.
	
	self assert: (lbl position x < 0).
	self assert: (lbl position y = 0).
	
]
