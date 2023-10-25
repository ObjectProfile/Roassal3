Class {
	#name : 'RSViolinPlotTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Core',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
RSViolinPlotTest >> test4ViolinsAnd2Clusters [
	| violinPlotA violinPlotB data window chart |

	data := {{10. 20. 30. 40. 40. 50.}. {1. 30. 30. 30. 30. 40. 40. 50.}.}.
	violinPlotA := RSViolinPlot data: data.
	violinPlotB := RSViolinPlot data: data.
	chart := violinPlotA + violinPlotB.
	window := chart open.
	self assert: window isDisplayed.
	window delete
]

{ #category : 'tests' }
RSViolinPlotTest >> testAxisLabelsAndTitle [
	| violinPlot data window |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	violinPlot xlabel: 'X label'.
	violinPlot ylabel: 'Y label'.
	violinPlot title: 'Title'.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete
]

{ #category : 'tests' }
RSViolinPlotTest >> testBasicViolinPlot [
	| violinPlot data window |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete
]

{ #category : 'tests' }
RSViolinPlotTest >> testBorders [
	| violinPlotA data |

	data := #(10 20 30 40 40 50).
	violinPlotA := RSViolinPlot data: data.
	self assert: violinPlotA borders class equals: Array.
	self assert: violinPlotA borders first class equals: RSBorder
]

{ #category : 'tests' }
RSViolinPlotTest >> testBordersColor [
	| violinPlotA data |

	data := #(10 20 30 40 40 50).
	violinPlotA := RSViolinPlot data: data.
	violinPlotA borderColor: Color red.
	self assert: violinPlotA borderColor equals: Color red
]

{ #category : 'tests' }
RSViolinPlotTest >> testBordersColors [
	| violinPlotA data |

	data := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.
	violinPlotA := RSViolinPlot data: data.
	violinPlotA bordersColors: {Color red. Color green.}.
	self assert: violinPlotA bordersColor equals: {Color red. Color green.}
]

{ #category : 'tests' }
RSViolinPlotTest >> testExtractDatasetFromBlock [
	| data plot result model expectedResult |
	model := String.
	data := [:cls | cls methods collect: [:met | met linesOfCode ] ].
	plot := RSViolinPlot new.
	plot models: {model}.
	result := plot extractDatasetsFrom: data.
	expectedResult := data rsValue: model.
	self assert: result equals: {expectedResult}
]

{ #category : 'tests' }
RSViolinPlotTest >> testExtractDatasetFromSingleArray [
	| data plot result |
	data := #(10 20 30 40 40 50).
	plot := RSViolinPlot new.
	result := plot extractDatasetsFrom: data.
	self assert: result equals: {data}
]

{ #category : 'tests' }
RSViolinPlotTest >> testExtractDatasetFromValue [
	| data plot result |
	data := { #(10 20 30 40 40 50) }.
	plot := RSViolinPlot new.
	result := plot extractDatasetsFrom: data.
	self assert: result equals: data
]

{ #category : 'tests' }
RSViolinPlotTest >> testModel [
	| violinPlot aModel window |
	aModel := String.
	violinPlot := RSViolinPlot models: {aModel}.
	violinPlot data: [ :cls | cls methods collect: [:met | met linesOfCode ] ].
	window := violinPlot open.
	self assert: violinPlot models first equals: aModel.
	window delete
]

{ #category : 'tests' }
RSViolinPlotTest >> testModelOfEachViolin [
	| violinPlot aModel1 aModel2 dataset1 dataset2 waysToGetDataFromModel |
	aModel1 := String.
	aModel2 := Number.
	waysToGetDataFromModel := [ :cls | cls methods collect: [:met | met linesOfCode ] ].
	violinPlot := RSViolinPlot models: {aModel1. aModel2.}.
	violinPlot data: waysToGetDataFromModel.
	dataset1 := waysToGetDataFromModel rsValue: aModel1.
	dataset2 := waysToGetDataFromModel rsValue: aModel2.

	violinPlot build.
	self assert: violinPlot models equals: {aModel1. aModel2 }.
	self assert: violinPlot data equals: {dataset1. dataset2.}
]

{ #category : 'tests' }
RSViolinPlotTest >> testTwoViolinPlots [
	| violinPlot data window |
	data := {{10. 20. 30. 40. 40. 50.}. {1. 30. 30. 30. 30. 40. 40. 50.}.}.
	violinPlot := RSViolinPlot data: data.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete
]

{ #category : 'tests' }
RSViolinPlotTest >> testTwoViolinPlotsClustered [
	| violinPlotA violinPlotB data window chart |

	data := #(10 20 30 40 40 50).
	violinPlotA := RSViolinPlot data: data.
	violinPlotB := RSViolinPlot data: data.
	chart := violinPlotA + violinPlotB.
	window := chart open.
	self assert: window isDisplayed.
	window delete
]
