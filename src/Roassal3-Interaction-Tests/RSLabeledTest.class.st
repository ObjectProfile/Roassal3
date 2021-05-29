"
A RSLabeledTest is a test class for testing the behavior of RSLabeled
"
Class {
	#name : #RSLabeledTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #tests }
RSLabeledTest >> testFontSize [

	| c shapes labels |
	c := RSCanvas new.

	shapes := (1 to: 100)
		          collect: [ :v | RSBox new model: v ]
		          as: RSGroup.

	c addAll: shapes.
	RSNormalizer size
		shapes: shapes;
		from: 10;
		to: 30;
		normalize: #yourself.
	RSGridLayout on: shapes.

	self assert: c numberOfShapes equals: 100.

	shapes @ (RSLabeledInteraction new fontSize: 8).
	self assert: c numberOfShapes equals: 200.
	
	"We check the size of the labels"
	labels := c shapes select: [ :s | s class == RSLabel ].
	self assert: labels size equals: 100.
	self assert: (labels allSatisfy: [ :s | s fontSize = 8 ])
]
