Class {
	#name : #RSShapeBuilderTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests-Roassal'
}

{ #category : #tests }
RSShapeBuilderTest >> testColor [

	| sb |
	sb := RSShapeBuilder box.
	sb color: Color blue.
	self assert: sb element color equals: Color blue
]
