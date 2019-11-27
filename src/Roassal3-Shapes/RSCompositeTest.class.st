"
I am test class for composite shapes in roassal
"
Class {
	#name : #RSCompositeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
RSCompositeTest >> testHasChildren [
	| b |
	b := RSComposite new.
	self deny: b hasChildren.
	b shapes: {}.
	self deny: b hasChildren.
	b shapes: {RSBox new. RSEllipse new}.
	self assert: b hasChildren.
]

{ #category : #tests }
RSCompositeTest >> testPaddingOkay [
	"No error should be raised"
	
	RSComposite new
		shapes: (RSGroup new add: RSBox new; yourself);
		padding: 5.

	RSComposite new
		shapes: (RSGroup new add: RSBox new; add: RSBox new; yourself);
		padding: 5.
		
	RSComposite new
		shapes: (RSGroup new);
		padding: 5.
]

{ #category : #tests }
RSCompositeTest >> testPositionInCanvas [
	| box composite canvas |
	canvas := RSCanvas new.
	box := RSBox new
		size: 100;
		yourself.
	composite := RSComposite new
		shapes: { box };
		position: 100@100;
		yourself.
	canvas add: composite.
	box translateTo: 10@10.
	self assert: composite position equals: 100@100.
	self assert: composite positionInCanvas equals: 100@100.
	self assert: box position equals: 10@10.
	self assert: box positionInCanvas equals: 110@110.
]
