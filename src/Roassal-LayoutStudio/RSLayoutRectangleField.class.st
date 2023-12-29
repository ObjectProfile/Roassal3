"
Similar to number field but I can handle rectangles
"
Class {
	#name : 'RSLayoutRectangleField',
	#superclass : 'RSLayoutEvalField',
	#category : 'Roassal-LayoutStudio-Fields',
	#package : 'Roassal-LayoutStudio',
	#tag : 'Fields'
}

{ #category : 'accessing' }
RSLayoutRectangleField >> layoutValue [
	| value |
	value := super layoutValue.
	value ifNil: [ ^ 'nil' ].
	^ value asString
]

{ #category : 'accessing' }
RSLayoutRectangleField >> transform: aString [
	| rect |
	rect := super transform: aString.
	self assert: rect isRectangle description: 'You should provide a rectangle'.
	^ rect
]
