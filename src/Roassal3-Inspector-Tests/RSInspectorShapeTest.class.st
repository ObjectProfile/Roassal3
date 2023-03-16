Class {
	#name : #RSInspectorShapeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Inspector-Tests'
}

{ #category : #tests }
RSInspectorShapeTest >> testNoEvents [
	| box label composite canvas copy boxCopy labelCopy |
	box := RSBox new.
	label := RSLabel new text: 'io'.
	box popup.
	label popup.
	composite := { box. label } asShape.
	composite when: RSMouseEnter do: [:evt | ].
	canvas := composite canvasForInspector.

	self assert: canvas shapes size equals: 1.
	copy := canvas shapes first.

	self assert: copy children size equals: composite children size.
	boxCopy := copy children first.
	labelCopy := copy children second.
	self assert: boxCopy class equals: RSBox.
	self assert: labelCopy class equals: RSLabel.
	self assert: copy privateAnnouncer isNil.
	self assert: boxCopy privateAnnouncer isNil.
	self assert: labelCopy privateAnnouncer isNil
]
