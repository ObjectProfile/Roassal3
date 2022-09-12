"
this attach point uses the angle between shapes
"
Class {
	#name : #RSSmartHorizontalCPController,
	#superclass : #RSAbstractCPController,
	#instVars : [
		'startOffset',
		'endOffset'
	],
	#category : #'Roassal3-Shapes-ControlPoints'
}

{ #category : #hooks }
RSSmartHorizontalCPController >> attachPointForRectangle: aRectangle lineAngle: anAngle offset: offset [

	| angleInDegrees |
	angleInDegrees := anAngle radiansToDegrees.
	
	(angleInDegrees between: -45 and: 45)
		ifTrue: [ ^ aRectangle rightCenter + (offset @ 0) ].
		
	(angleInDegrees between: -135 and: -45)
		ifTrue: [ ^ aRectangle topCenter - (0 @ offset) ].
		
	((angleInDegrees between: -180 and: -135) or: [ angleInDegrees between: 135 and: 180 ])
		ifTrue: [ ^ aRectangle leftCenter - (offset @ 0) ].
		
	(angleInDegrees between: 45 and: 135)
		ifTrue: [ ^ aRectangle bottomCenter + (0 @ offset) ].
		
	^ aRectangle floatCenter.
]

{ #category : #hooks }
RSSmartHorizontalCPController >> controlPointsFor: aLine [
	"return an array of points generated from the line"
	| fromShape fromRectangle toShape toRectangle angle from to mid firstAnglePoint secondAnglePoint |
	
	fromShape := aLine from.
	toShape := aLine to.
	
	fromRectangle := fromShape encompassingRectangle.
	toRectangle := toShape encompassingRectangle.
	
	angle := (toShape position - fromShape position) angle.
	from := self attachPointForRectangle: fromRectangle lineAngle: angle offset: startOffset.
	
	angle := (fromShape position - toShape position) angle.
	to := self attachPointForRectangle: toRectangle lineAngle: angle offset: endOffset.
	
	mid := (from + to) / 2.
	
	firstAnglePoint := fromRectangle floatCenter x = from x ifTrue: [ 
		from x @ mid y
	] ifFalse: [ mid x @ from y ].
		
	secondAnglePoint := toRectangle floatCenter x = to x
		ifTrue: [ to x @ mid y ]
		ifFalse: [ mid x @ to y ].
	
	^ { from. firstAnglePoint. secondAnglePoint. to }
]

{ #category : #accessing }
RSSmartHorizontalCPController >> endOffset [
	^ endOffset
]

{ #category : #accessing }
RSSmartHorizontalCPController >> endOffset: aNumber [
	endOffset := aNumber
]

{ #category : #initialization }
RSSmartHorizontalCPController >> initialize [
	super initialize.
	startOffset := endOffset := 0.
]

{ #category : #accessing }
RSSmartHorizontalCPController >> startOffset [
	^ startOffset
]

{ #category : #accessing }
RSSmartHorizontalCPController >> startOffset: aNumber [
	startOffset := aNumber
]
