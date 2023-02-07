Class {
	#name : #RSSpecExamplesTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Spec-Tests'
}

{ #category : #tests }
RSSpecExamplesTest >> testRunExamples [

	| classes |
	classes := { RSColorPaletteChooser. RSEasel. RSPieChartExample }.
	classes do: [ :cls | cls new asWindow open delete ]
]
