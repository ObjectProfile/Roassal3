Class {
	#name : #RSSelectionPresentationTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Inspector-Tests'
}

{ #category : #tests }
RSSelectionPresentationTest >> testBasic [

	| c shapes |
	c := RSCanvas new.
	shapes := (1 to: 100) collect: [ :v | RSBox new model: v ] as: RSGroup.
	c addAll: shapes.
	RSNormalizer size shapes: shapes; normalize: #yourself.
	RSFlowLayout on: shapes.
	shapes @ RSSelectionPresentation.
	c @ RSCanvasController.

	"make sure there is no error when clicking on an element, while being outside the GTInspector"
	c nodes first announce: RSMouseClick

]

{ #category : #tests }
RSSelectionPresentationTest >> testWithNoCanvas [

	| shapes |
	shapes := (1 to: 100) collect: [ :v | RSBox new model: v ] as: RSGroup.
	shapes @ RSSelectionPresentation.
	shapes first announce: RSMouseClick
]
