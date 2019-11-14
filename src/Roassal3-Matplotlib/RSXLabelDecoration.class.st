Class {
	#name : #RSXLabelDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSXLabelDecoration >> renderIn: canvas [
	| label |
	label := self createLabel.
	canvas addShape: label.
	RSLocation new
		offset: 5;
		below;
		center;
		stick: label on: self spine
]
