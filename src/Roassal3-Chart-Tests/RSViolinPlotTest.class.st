Class {
	#name : #RSViolinPlotTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSViolinPlotTest >> test4ViolinsAnd2Clusters [
	| violinPlotA violinPlotB data window chart |
	
	data := {{10. 20. 30. 40. 40. 50.}. {1. 30. 30. 30. 30. 40. 40. 50.}.}.
	violinPlotA := RSViolinPlot data: data.
	violinPlotB := RSViolinPlot data: data.
	chart := violinPlotA + violinPlotB.
	window := chart open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testAxisLabelsAndTitle [
	| violinPlot data window |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	violinPlot xlabel: 'X label'.
	violinPlot ylabel: 'Y label'.
	violinPlot title: 'Title'.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testBasicViolinPlot [
	| violinPlot data window |
	data := #(10 20 30 40 40 50).
	violinPlot := RSViolinPlot data: data.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testBorders [
	| violinPlotA data |
	
	data := #(10 20 30 40 40 50).
	violinPlotA := RSViolinPlot data: data.
	self assert: violinPlotA borders class equals: Array.
	self assert: violinPlotA borders first class equals: RSBorder.
]

{ #category : #tests }
RSViolinPlotTest >> testBordersColor [
	| violinPlotA data |
	
	data := #(10 20 30 40 40 50).
	violinPlotA := RSViolinPlot data: data.
	violinPlotA borderColor: Color red.
	self assert: violinPlotA borderColor equals: Color red.
]

{ #category : #tests }
RSViolinPlotTest >> testBordersColors [
	| violinPlotA data |
	
	data := {{6. 8. 7. 5. 7. 11. 9. }. { 12. 12. 13. 15. 18. 20. 21. 24. }}.
	violinPlotA := RSViolinPlot data: data.
	violinPlotA bordersColors: {Color red. Color green.}.
	self assert: violinPlotA bordersColor equals: {Color red. Color green.}.
]

{ #category : #tests }
RSViolinPlotTest >> testTwoViolinPlots [
	| violinPlot data window |
	data := {{10. 20. 30. 40. 40. 50.}. {1. 30. 30. 30. 30. 40. 40. 50.}.}.
	violinPlot := RSViolinPlot data: data.
	window := violinPlot open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSViolinPlotTest >> testTwoViolinPlotsClustered [
	| violinPlotA violinPlotB data window chart |
	
	data := #(10 20 30 40 40 50).
	violinPlotA := RSViolinPlot data: data.
	violinPlotB := RSViolinPlot data: data.
	chart := violinPlotA + violinPlotB.
	window := chart open.
	self assert: window isDisplayed.
	window delete.
]
