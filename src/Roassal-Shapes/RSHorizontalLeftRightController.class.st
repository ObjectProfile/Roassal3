"
Creates an armonic line between from and to
"
Class {
	#name : 'RSHorizontalLeftRightController',
	#superclass : 'RSHorizontalCPAPController',
	#category : 'Roassal-Shapes-ControlPoints',
	#package : 'Roassal-Shapes',
	#tag : 'ControlPoints'
}

{ #category : 'hooks' }
RSHorizontalLeftRightController >> controlPointsFrom: from to: to [
	| mid c1 c2 c3 c4 delta diff |
	mid := (from + to)/2.
	c1 := from.
	c4 := to.
	c2 := mid x @ c1 y.
	c3 := c1 x @ c4 y.
	delta := 10.
	diff := mid x - (c1 x + delta).
	diff < 0 ifTrue: [
		c2 := c1 x - diff  @ c1 y.
		c3 := c4 x + diff @ c4 y ].
	^{ c1. c2. c3. c4 }
]
