Class {
	#name : #RSHighlightableTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Interaction-Tests'
}

{ #category : #tests }
RSHighlightableTest >> testBasic [

	| c shapes previousColor |
	c := RSCanvas new.
	shapes := (1 to: 10) collect: [ :n | RSEllipse new size: 20; model: n ] as: RSGroup.
	c addAll: shapes.
	RSGridLayout on: shapes.

	previousColor := shapes fifth color.
	RSHighlightable new doHighlight: shapes fifth.
	self assert: shapes fifth color equals: previousColor.
	
	RSHighlightable new record: shapes fifth selector: #color value: Color blue.
	self assert: shapes fifth color equals: Color blue.
	
	RSHighlightable new restore: shapes fifth selector: #color .
	self assert: shapes fifth color equals: previousColor.
]
