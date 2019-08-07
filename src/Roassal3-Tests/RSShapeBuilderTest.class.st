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

{ #category : #tests }
RSShapeBuilderTest >> testMultilineLabel [
	| shape label child |
	shape := RSShapeBuilder multiline
		fontSize: 30;
		bold.
	label := shape elementOn: 'foo'.
	self assert: label shape class equals: TSComposite.
	self assert: label shape shapes size equals: 1.
	child := label shape shapes first.
	
	
]
