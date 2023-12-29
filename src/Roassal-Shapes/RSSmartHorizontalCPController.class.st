"
this attach point uses the angle between shapes
"
Class {
	#name : 'RSSmartHorizontalCPController',
	#superclass : 'RSAbstractCPController',
	#category : 'Roassal-Shapes-ControlPoints',
	#package : 'Roassal-Shapes',
	#tag : 'ControlPoints'
}

{ #category : 'utilities' }
RSSmartHorizontalCPController >> attachPointForRectangle: aRectangle lineAngle: anAngle [

	| angleInDegrees |
	angleInDegrees := anAngle radiansToDegrees.

	(angleInDegrees between: -45 and: 45)
		ifTrue: [ ^ aRectangle rightCenter ].

	(angleInDegrees between: -135 and: -45)
		ifTrue: [ ^ aRectangle topCenter ].

	((angleInDegrees between: -180 and: -135) or: [ angleInDegrees between: 135 and: 180 ])
		ifTrue: [ ^ aRectangle leftCenter ].

	(angleInDegrees between: 45 and: 135)
		ifTrue: [ ^ aRectangle bottomCenter ].

	^ aRectangle floatCenter
]

{ #category : 'hooks' }
RSSmartHorizontalCPController >> controlPointsFor: aLine [
	"return an array of points generated from the line"
	| fromShape fromRectangle toShape toRectangle angle from to mid firstAnglePoint secondAnglePoint |

	fromShape := aLine from.
	toShape := aLine to.

	fromRectangle := fromShape encompassingRectangle.
	toRectangle := toShape encompassingRectangle.

	angle := (toShape position - fromShape position) angle.
	from := self attachPointForRectangle: fromRectangle lineAngle: angle.

	angle := (fromShape position - toShape position) angle.

	to := self attachPointForRectangle: toRectangle lineAngle: angle.

	mid := (from + to) / 2.

	firstAnglePoint := fromRectangle floatCenter x = from x
		ifTrue: [ from x @ mid y ]
		ifFalse: [ mid x @ from y ].

	secondAnglePoint := toRectangle floatCenter x = to x
		ifTrue: [ to x @ mid y ]
		ifFalse: [ mid x @ to y ].

	^ { from. firstAnglePoint. secondAnglePoint. to }
]
