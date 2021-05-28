Class {
	#name : #RSEasingInterpolationTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #tests }
RSEasingInterpolationTest >> testAllEasing [
	"Simply check if no error is raised"
	| someX |
	someX := (0 to: 1 by: 0.01).
	RSEasingInterpolation allSubclassesDo: [ :cls |
		someX collect: [ :v | cls new interpolate: v; interpolateOut: v ].
	]

]
