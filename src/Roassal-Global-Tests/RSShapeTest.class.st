Class {
	#name : 'RSShapeTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Shapes',
	#package : 'Roassal-Global-Tests',
	#tag : 'Shapes'
}

{ #category : 'tests' }
RSShapeTest >> testAllConnectedShapes [
	| canvas shapes lb node1 node2 node3 node5 node6 |
	canvas := RSCanvas new.

	shapes := RSLabel models: (1 to: 6).
	canvas addAll: shapes.
	shapes @ RSDraggable.
	lb := RSLineBuilder arrowedLine.
	lb withBorderAttachPoint.
	lb shapes: shapes.
	lb useAssociations: { 1 -> 3 . 3 -> 2 . 3 -> 4 . 5 -> 6. }.
	RSForceBasedLayout on: shapes.

	node1 := canvas shapeFromModel: 1.
	node2 := canvas shapeFromModel: 2.
	node3 := canvas shapeFromModel: 3.
	node5 := canvas shapeFromModel: 5.
	node6 := canvas shapeFromModel: 6.

	self assert: (node1 allRecursiveConnectedNodes collect: #model) asSortedCollection asArray equals: (1 to: 4).

	self assert: node1 allRecursiveConnectedNodes equals: node2 allRecursiveConnectedNodes.
	self assert: node1 allRecursiveConnectedNodes equals: node3 allRecursiveConnectedNodes.
	self assert: node2 allRecursiveConnectedNodes equals: node3 allRecursiveConnectedNodes.

	self assert: node1 allRecursiveConnectedNodes ~= node5 allRecursiveConnectedNodes.

	self assert: node5 allRecursiveConnectedNodes equals: node6 allRecursiveConnectedNodes
]

{ #category : 'tests' }
RSShapeTest >> testBorderDoUpdatesInvalidateShape [

	| tmp1 tmp3 |
	tmp3 := RSBox new.
	tmp3 size: 20.
	tmp1 := tmp3 yourself.
	self
		assert: tmp1 encompassingRectangle
		equals: ( -10 asPoint corner: 10 asPoint).
	tmp1 borderDo: [ :arg1 |
		arg1
			width: 12;
			dashArray: #( 3 1 2 ) ].
	self
		assert: tmp1 encompassingRectangle
		equals: ( -16 asPoint corner: 16 asPoint)
]

{ #category : 'tests' }
RSShapeTest >> testChangeBorderUpdatesEncompassingRectangle [
	| box |
	box := RSBox new
		       size: 20;
		       yourself.
	self
		assert: box encompassingRectangle
		equals: (-10 asPoint corner: 10 asPoint).
	box border: (RSBorder new
			 width: 8;
			 yourself).
	self
		assert: box encompassingRectangle
		equals: (-14 asPoint corner: 14 asPoint)
]

{ #category : 'tests' }
RSShapeTest >> testChangeBorderWidthUpdatesEncompassingRectangle [
	| box |
	box := RSBox new
		       size: 20;
		       yourself.
	box border: (RSBorder new
			 width: 8;
			 yourself).
	self
		assert: box encompassingRectangle
		equals: (-14 asPoint corner: 14 asPoint).
	box borderWidth: 12.
	self
		assert: box encompassingRectangle
		equals: (-16 asPoint corner: 16 asPoint)
]

{ #category : 'tests' }
RSShapeTest >> testEmptyIndexesArray [

	| box |
	box := RSBox new.
	self assert: box indexesFromRoot isEmpty
]

{ #category : 'tests' }
RSShapeTest >> testEncompassingRectangleContainsBorderWidth [
	| box |
	box := RSBox new
		       size: 10;
		       yourself.
	box border: (RSBorder new
			 width: 4;
			 yourself).
	self assert: box encompassingRectangle equals: (-7 asPoint corner: 7 asPoint)
]

{ #category : 'tests' }
RSShapeTest >> testExtent [
	| extent box |
	extent := 100@100.
	box := RSBox new.
	box extent: extent.
	self assert: box extent equals: extent
]

{ #category : 'tests' }
RSShapeTest >> testExtentWithBorder [
	| extent box |
	extent := 100@100.
	box := RSBox new.
	box borderWidth: 10.
	box extent: extent.
	self assert: box extent equals: extent
]

{ #category : 'tests' }
RSShapeTest >> testExtentWithBorderMin [
	| extent box borderWidth|
	extent := 1@1.
	borderWidth := 10.
	box := RSBox new.
	box borderWidth: borderWidth.
	box extent: extent.
	self assert: box extent equals: borderWidth asPoint.
]

{ #category : 'tests' }
RSShapeTest >> testHasModel [

	self deny: RSCircle new hasModel.
	self assert: (RSShape new model: 52) hasModel.
	self assert: (RSLine new model: 52) hasModel.
	self deny: RSLine new hasModel
]

{ #category : 'tests' }
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
	self assert: node5 outgoingShapes equals: (c shapesFromModels: #(10 11))
]

{ #category : 'tests' }
RSShapeTest >> testIndexesArray [

	| box canvas |
	box := RSBox new.
	canvas := RSCanvas new.
	canvas add: box.

	self assert: box indexesFromRoot size equals: 1.
	self assert: box indexesFromRoot first equals: 1
]

{ #category : 'tests' }
RSShapeTest >> testIndexesArrayWithComposites [

	| box canvas comp box1 comp1 |
	box := RSBox new.
	box1 := RSBox new.
	comp := { box } asShape.
	comp1 := { box1 } asShape.
	canvas := RSCanvas new.
	canvas
		add: comp;
		add: comp1.

	self assert: box indexesFromRoot size equals: 2.
	self assert: box indexesFromRoot first equals: 1.
	self assert: box indexesFromRoot second equals: 1.

	self assert: box1 indexesFromRoot size equals: 2.
	self assert: box1 indexesFromRoot first equals: 2.
	self assert: box1 indexesFromRoot second equals: 1
]

{ #category : 'tests' }
RSShapeTest >> testInvert [

	| rectangle canvas positionBefore |
	canvas := RSCanvas new.
	rectangle := RSPolygon new points: {2@2. 2@10. 6@10. 6@2.}.
	self assert: rectangle points equals: {-2@(-4). -2@4. 2@4. 2@(-4).}.
	positionBefore := rectangle position.
	canvas @ RSCanvasController.
	canvas add: rectangle.
	rectangle invert.
	self assert: rectangle points equals: {-4@(-2). 4@(-2). 4@2. -4@2.}.
	self assert: rectangle position equals: (positionBefore y @ positionBefore x)
]

{ #category : 'tests' }
RSShapeTest >> testModelForIt [

	| s |
	s := RSBox model: 42 forIt: [ :ss :object | ss color: Color pink ].
	self assert: s class equals: RSBox.
	self assert: s model equals: 42.
	self assert: s color equals: Color pink
]

{ #category : 'tests' }
RSShapeTest >> testModels [

	| shapes |
	shapes := RSCircle models: (1 to: 10).
	self assert: shapes isCollection.
	self assert: shapes class equals: RSGroup.
	self assert: (shapes allSatisfy: [ :s | s class == RSCircle ]).
	self assert: (shapes collect: #width) asSet asArray equals: #(10)
]

{ #category : 'tests' }
RSShapeTest >> testModelsSize [

	| shapes |
	shapes := RSCircle models: (1 to: 10) size: #yourself.
	self assert: shapes isCollection.
	self assert: shapes class equals: RSGroup.
	self assert: (shapes allSatisfy: [ :s | s class == RSCircle ]).
	self assert: (shapes collect: #width) asArray equals: (1 to: 10) asArray.
	self assert: (shapes collect: #height) asArray equals: (1 to: 10) asArray
]

{ #category : 'tests' }
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
	self assert: (lbl position y = 0)
]
