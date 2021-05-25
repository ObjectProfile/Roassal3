Class {
	#name : #RSEasingTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Animation-Tests'
}

{ #category : #tests }
RSEasingTest >> testAllEasing [
	"Simply check if no error is raised"
	| someX |
	someX := (0 to: 1 by: 0.01).
	RSEasing allSubclassesDo: [ :cls |
		someX collect: [ :v | cls new interpolate: v; interpolateOut: v ].
	]

]
