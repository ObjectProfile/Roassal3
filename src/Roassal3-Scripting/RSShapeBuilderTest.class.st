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

{ #category : #tests }
RSShapeBuilderTest >> testMultilineLabel [
	| shape label child |
	shape := RSShapeBuilder multiline
		fontSize: 30;
		bold.
	label := shape elementOn: 'foo'.
	self assert: label shape class equals: RSComposite.
	self assert: label shape shapes size equals: 1.
	child := label shape shapes first.
	
	
]
