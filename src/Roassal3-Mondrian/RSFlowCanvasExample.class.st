Class {
	#name : #RSFlowCanvasExample,
	#superclass : #Object,
	#category : #'Roassal3-Mondrian-Connections'
}

{ #category : #examples }
RSFlowCanvasExample >> example01 [
	| c shapes f |
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
	f canvas: c.
	f open
]
