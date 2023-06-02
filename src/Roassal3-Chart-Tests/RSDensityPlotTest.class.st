Class {
	#name : #RSDensityPlotTest,
	#superclass : #TestCase,
	#instVars : [
		'chart'
	],
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSDensityPlotTest >> testDensityCurveSample [
	| densityPlot data proveValues validationValues |
	data := #(14 15 28 27 32 35).
	proveValues := #(0 15 20 30 50).
	validationValues := #(5.105e-05 0.033 0.019 0.0495 1.536e-05).
	densityPlot := RSDensityPlot data: data.
	densityPlot bandwidth: 4.
 	"kernel density stimation"
	self assert: (densityPlot densityCurveSample: proveValues) closeTo: validationValues.
]

{ #category : #tests }
RSDensityPlotTest >> testDensityPlotDefaultValues [
	| densityPlot data |
	data := #(1 2 2 2 3 4).
	densityPlot := RSDensityPlot data: data.
 	self assert: densityPlot data equals: data.
	self assert: (densityPlot kernel isKindOf: RSKernelFunction).
	self assert: densityPlot bandwidth equals: 1.
]

{ #category : #tests }
RSDensityPlotTest >> testKernelDensityEstimation [
	| densityPlot data |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	densityPlot bandwidth: 4.
 	"kernel density stimation"
	self assert: (densityPlot kde: 30) closeTo: 0.0495.
]
