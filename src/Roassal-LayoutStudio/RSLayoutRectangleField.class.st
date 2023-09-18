"
Similar to number field but I can handle rectangles
"
Class {
	#name : #RSLayoutRectangleField,
	#superclass : #RSLayoutEvalField,
	#category : #'Roassal3-LayoutStudio-Fields'
}

{ #category : #accessing }
RSLayoutRectangleField >> layoutValue [
	| value |
	value := super layoutValue.
	value ifNil: [ ^ 'nil' ].
	^ value asString
]

{ #category : #accessing }
RSLayoutRectangleField >> transform: aString [
	| rect |
	rect := super transform: aString.
	self assert: rect isRectangle description: 'You should provide a rectangle'.
	^ rect
]
