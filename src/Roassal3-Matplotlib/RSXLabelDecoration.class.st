Class {
	#name : #RSXLabelDecoration,
	#superclass : #RSAbstractLabelDecoration,
	#category : #'Roassal3-Matplotlib-Core'
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
	canvas addShape: label.
	RSLocation new
		offset: offset;
		below;
		center;
		stick: label on: self spine
]
