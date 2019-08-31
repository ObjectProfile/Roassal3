Class {
	#name : #PLTXLabelDecoration,
	#superclass : #PLTAbstractLabelDecoration,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTXLabelDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	canvas addShape: label.
	RSLocation new
		offset: 5;
		below;
		center;
		stick: label on: self spine
]
