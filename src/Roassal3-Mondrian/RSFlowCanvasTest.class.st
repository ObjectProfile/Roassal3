Class {
	#name : #RSFlowCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'c',
		'shapes',
		'f'
	],
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #running }
RSFlowCanvasTest >> setUp [

	c := RSCanvas new.
	shapes := RSCircle models: (1 to: 20).
	c addAll: shapes.
	shapes @ RSLabeled @ RSPopup @ RSDraggable.
	RSNormalizer size
		shapes: shapes;
		normalize: #yourself.
	RSFlowLayout on: shapes.
	c @ RSCanvasController.

	f := RSFlowCanvas new.
	f setOnCanvas: c.

]

{ #category : #tests }
RSFlowCanvasTest >> testBreadcrumbs [

	self assert: f breadcrumbs isEmpty.
	
	(c shapeFromModel: 5) announce: RSMouseClick.
	self assert: f breadcrumbs equals: { 5 }.
]
