Class {
	#name : 'RSSpecExamplesTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Spec-Tests',
	#package : 'Roassal-Spec-Tests'
}

{ #category : 'tests' }
RSSpecExamplesTest >> testRunExamples [
	| classes names |
	names := #(RSColorPaletteChooser RSEasel RSPieChartExample).
	classes := names
		collect: [ :name | Smalltalk globals at: name ifAbsent: [ nil ] ]
		thenSelect: [ :cls | cls isNotNil ].
	classes do: [ :cls | cls new asWindow open delete ]
]
