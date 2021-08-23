Class {
	#name : #RSSpecExamplesTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Spec-Examples'
}

{ #category : #tests }
RSSpecExamplesTest >> testRunExamples [

	| classes |
	classes := { RSColorPaletteChooser . RSEasel . RSEaselExample . RSPieChartExample }.
	classes do: [ :cls | cls new openWithSpec delete ]

]
