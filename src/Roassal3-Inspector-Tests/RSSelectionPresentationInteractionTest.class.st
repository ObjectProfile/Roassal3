Class {
	#name : #RSSelectionPresentationInteractionTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Inspector-Tests'
}

{ #category : #tests }
RSSelectionPresentationInteractionTest >> testBasic [

	| c shapes |
	c := RSCanvas new.
	shapes := (1 to: 100)
		          collect: [ :v | RSBox new model: v ]
		          as: RSGroup.
	c addAll: shapes.
	RSNormalizer size
		shapes: shapes;
		normalize: #yourself.
	RSFlowLayout on: shapes.
	shapes @ RSSelectionPresentationInteraction.

	"make sure there is no error when clicking on an element, while being outside the GTInspector"
	c nodes first announce: RSMouseClick.
	self assert: c nodes first hasShadow
]

{ #category : #tests }
RSSelectionPresentationInteractionTest >> testCanvasInspect [

	| c window |
	c := RSCanvas new.
	c add: (RSBox model: 1).
	window := c inspect.
	window class = RSCanvas
		ifTrue: [ c morph window delete ]
		ifFalse: [ window delete ].
	self assert: (c hasInteraction: RSSelectionPresentationInteraction)
]

{ #category : #tests }
RSSelectionPresentationInteractionTest >> testClickOnCanvasShouldUnselectShape [

	| c |
	c := RSCanvas new.
	c add: (RSBox model: 1).
	c nodes @ RSSelectionPresentationInteraction new.

	c nodes first click.
	c click.
	self assert: c nodes first shadow isNil
]

{ #category : #tests }
RSSelectionPresentationInteractionTest >> testSelectAShapeShouldUnselect [

	| c |
	c := RSCanvas new.
	c
		add: (RSBox model: 1);
		add: (RSBox model: 2).
	c nodes @ RSSelectionPresentationInteraction new.

	c nodes first click.
	c nodes second click.
	self assert: c nodes first shadow isNil
]
