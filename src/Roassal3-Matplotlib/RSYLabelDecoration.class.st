Class {
	#name : #RSYLabelDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSYLabelDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	canvas addShape: label.
	RSLocation new
		offset: -5;
		center;
		left;
		outer;
		stick: label on: self spine
]
