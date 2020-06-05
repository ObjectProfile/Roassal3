"
TODO
"
Class {
	#name : #RSYLabelDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #initialization }
RSYLabelDecoration >> initialize [
	super initialize.
	self offset: -5.
	self vertical.
]

{ #category : #rendering }
RSYLabelDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	
	RSLocation new
		offset: offset;
		center;
		left;
		outer;
		move: label on: canvas encompassingRectangle.
	canvas add: label.
]
