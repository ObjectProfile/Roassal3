Class {
	#name : #RSSpecExamplesTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Spec-Tests'
}

{ #category : #tests }
RSSpecExamplesTest >> testRunExamples [
	| classes names |
	names := #(RSColorPaletteChooser RSEasel RSPieChartExample).
	classes := names
		collect: [ :name | Smalltalk globals at: name ifAbsent: [ nil ] ]
		thenSelect: [ :cls | cls notNil ].
	classes do: [ :cls | cls new asWindow open delete ]
]
