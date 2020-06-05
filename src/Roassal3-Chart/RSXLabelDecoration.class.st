"
TODO
"
Class {
	#name : #RSXLabelDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #initialization }
RSXLabelDecoration >> initialize [
	super initialize.
	self offset: 5
]

{ #category : #rendering }
RSXLabelDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	RSLocation new
		offset: offset;
		below;
		center;
		move: label on: canvas encompassingRectangle.
	canvas add: label.
]
