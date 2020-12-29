Class {
	#name : #RSPopupTest,
	#superclass : #RSTest,
	#instVars : [
		'canvas',
		'shapes'
	],
	#category : #'Roassal3-Interaction-Tests-Core'
}

{ #category : #running }
RSPopupTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	shapes := #(1 2) collect: [ :m | RSBox new model: m; yourself ] as: RSGroup.
	shapes addLast: (RSBox new
		model: 'Foo
bar';
		yourself).
	canvas addAll: shapes
]

{ #category : #tests }
RSPopupTest >> testMultiline [.
	shapes @ RSPopup.
	self assert: canvas fixedShapes size equals: 0 .
	
	shapes last announce: RSMouseMove.
	self assert: canvas numberOfShapes equals: shapes size.
	self assert: canvas fixedShapes size equals: 1.
	self assert: canvas fixedShapes first shapes second shapes size equals: 2
]

{ #category : #tests }
RSPopupTest >> testNoPopup [
	shapes first announce: RSMouseEnter.
	self assert: canvas numberOfShapes equals: shapes size.
]

{ #category : #tests }
RSPopupTest >> testPopup [
	"Test created while debugging https://github.com/ObjectProfile/Roassal3/issues/150"
	| c |
	c := RSCanvas new.
	shapes := (1 to: 30) collect: [ :v | RSEllipse new  model: v; size: 10 ] as: RSGroup.
	shapes @ RSPopup.
	c addAll: shapes.

	RSLineBuilder line
	    canvas: c;
	    withBorderAttachPoint;
	    connectFrom: [ :v | v // 2 ].

	RSTreeLayout on: shapes.
"	c edges pushBack."
	c @ RSCanvasController.

	self assert: c numberOfShapes equals: 59.
	self assert: c fixedShapes size equals: 3.
	shapes first announce: RSMouseMove.
	self assert: shapes first model equals: 1.
	self assert: c numberOfShapes equals: 59.
	self assert: c fixedShapes size equals: 4.
	self assert: c fixedShapes last children last text equals: '1'.
	
	shapes first announce: RSMouseLeave.
	
	shapes second announce: RSMouseMove.
	self assert: c fixedShapes size equals: 4.
	self assert: c fixedShapes last children last text equals: '2'.
]

{ #category : #tests }
RSPopupTest >> testPopupOnElementNotAddedToAView [
	| b |
	b := RSBox new.
	b @ RSPopup.
	b announce: RSMouseEnter.
	"Should not produce an error"
]

{ #category : #tests }
RSPopupTest >> testPopupSimple [
	| c s |
	c := RSCanvas new.
	s := RSEllipse new size: 10; model: 42.
	s @ RSPopup.
	c add: s.

	self assert: c numberOfShapes equals: 1.
	self assert: c fixedShapes isEmpty.
	c shapes first announce: RSMouseMove.
	self assert: c shapes first model equals: 42.
	self assert: c numberOfShapes equals: 1.
	self assert: c fixedShapes size equals: 1.
	self assert: c fixedShapes first children second text equals: '42'
]

{ #category : #tests }
RSPopupTest >> testPopupWithoutMouseLeave [
	"Test created while debugging https://github.com/ObjectProfile/Roassal3/issues/150"
	| c |
	c := RSCanvas new.
	shapes := (1 to: 30) collect: [ :v | RSEllipse new  model: v; size: 10 ] as: RSGroup.
	shapes @ RSPopup.
	c addAll: shapes.

	RSLineBuilder line
	    canvas: c;
	    withBorderAttachPoint;
	    connectFrom: [ :v | v // 2 ].

	RSTreeLayout on: shapes.
"	c edges pushBack."
	c @ RSCanvasController.

	self assert: c numberOfShapes equals: 59.
	self assert: c fixedShapes size equals: 3.
	shapes first announce: RSMouseMove.
	self assert: shapes first model equals: 1.
	self assert: c numberOfShapes equals: 59.
	self assert: c fixedShapes size equals: 4.
	self assert: c fixedShapes last children last text equals: '1'.
	
	"Note that we do not announce RSMouseLeave"
	shapes second announce: RSMouseMove.
	self assert: c fixedShapes size equals: 4.
	self assert: c fixedShapes last children last text equals: '2'.
]

{ #category : #tests }
RSPopupTest >> testWithPopup [
	shapes @ RSPopup.
	self assert: canvas fixedShapes size equals: 0 .
	
	shapes first announce: RSMouseMove.
	self assert: canvas numberOfShapes equals: shapes size.
	self assert: canvas fixedShapes size equals: 1.
]
