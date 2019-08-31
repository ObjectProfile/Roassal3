Class {
	#name : #PLTYLabelDecoration,
	#superclass : #PLTAbstractLabelDecoration,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTYLabelDecoration >> renderIn: canvas [
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
