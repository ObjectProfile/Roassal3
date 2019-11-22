Class {
	#name : #RSShapeBuilderTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Scripting-Tests'
}

{ #category : #tests }
RSShapeBuilderTest >> testColor [

	| sb |
	sb := RSShapeBuilder box.
	sb color: Color blue.
	self assert: sb element color equals: Color blue
]
