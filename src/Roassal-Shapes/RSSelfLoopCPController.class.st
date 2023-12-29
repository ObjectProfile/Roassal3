"
Used for straight lines and self loop lines
"
Class {
	#name : 'RSSelfLoopCPController',
	#superclass : 'RSAbstractCPController',
	#category : 'Roassal-Shapes-ControlPoints',
	#package : 'Roassal-Shapes',
	#tag : 'ControlPoints'
}

{ #category : 'hooks' }
RSSelfLoopCPController >> controlPointsFor: aLine [
	| ap from to |
	ap := aLine attachPoint.

	aLine from = aLine to
		ifTrue: [ ^ self selfLoopControlPointsFor: aLine ].

	from := ap startingPointOf: aLine.
	to := ap endingPointOf: aLine.

	^ Array with: from with: to
]

{ #category : 'hooks' }
RSSelfLoopCPController >> selfLoopControlPointsFor: aLine [
	| temp from to delta matrix |
	temp := aLine from.
	delta := 50.
	matrix := temp parent globalMatrix.
	from := matrix transform: temp encompassingRectangle topCenter.
	to := matrix transform: temp encompassingRectangle leftCenter.
	^ Array
		with: from
		with: from - (0 @ delta)
		with: to - (delta @ 0)
		with: to - (5 @ 0)
]
