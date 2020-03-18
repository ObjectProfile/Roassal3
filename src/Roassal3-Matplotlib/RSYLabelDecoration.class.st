Class {
	#name : #RSYLabelDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #initialization }
RSYLabelDecoration >> initialize [
	super initialize.
	self offset: -5
]

{ #category : #rendering }
RSYLabelDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	canvas addShape: label.
	RSLocation new
		offset: offset;
		center;
		left;
		outer;
		stick: label on: self spine
]
