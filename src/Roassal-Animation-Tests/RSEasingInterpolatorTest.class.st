Class {
	#name : #RSEasingInterpolatorTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #tests }
RSEasingInterpolatorTest >> testAllEasing [
	"Simply check if no error is raised"
	| someX |
	someX := (0 to: 1 by: 0.01).
	RSEasingInterpolator allSubclassesDo: [ :cls |
		someX collect: [ :v | cls new interpolate: v; interpolateOut: v ].
	]
]
