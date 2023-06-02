Class {
	#name : #RSViolinPlotTest,
	#superclass : #TestCase,
	#instVars : [
		'chart'
	],
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSViolinPlotTest >> testDensityCurveSample [
	| violinPlot data proveValues validationValues |
	data := #(14 15 28 27 32 35).
	proveValues := #(0 15 20 30 50).
	validationValues := #(5.105e-05 0.033 0.019 0.0495 1.536e-05).
	violinPlot := RSViolinPlot data: data.
 	"kernel density stimation"
	self assert: (violinPlot densityCurveSample: proveValues) closeTo: validationValues.
]

{ #category : #tests }
RSViolinPlotTest >> testKernelDensityEstimation [
	| violinPlot data |
	data := #(14 15 28 27 32 35).
	violinPlot := RSViolinPlot data: data.
 	"kernel density stimation"
	self assert: (violinPlot kde: 30) closeTo: 0.0495.
]

{ #category : #tests }
RSViolinPlotTest >> testOneViolinPlot [
	| violinPlot data |
	data := #(1 2 2 2 3 4).
	violinPlot := RSViolinPlot data: data.
 	self assert: violinPlot data equals: data.
]
