Class {
	#name : #RSDensityPlotTest,
	#superclass : #TestCase,
	#instVars : [
		'chart'
	],
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSDensityPlotTest >> testDataIsACollectionOfNumbers [
	| data fakeData densityPlot |
	data := #(1 2 5 36 5 12 3).
	densityPlot := RSDensityPlot data: data.
	fakeData := #('a' 'b' '15' '25').
	self should: [ densityPlot := RSDensityPlot data: fakeData. ] raise: Error
]

{ #category : #tests }
RSDensityPlotTest >> testDensityCurveSample [
	| densityPlot data proveValues validationValues |
	data := #(14 15 28 27 32 35).
	proveValues := #(0 15 20 30 50).
	validationValues := #(5.105e-05 0.033 0.019 0.0495 1.536e-05).
	densityPlot := RSDensityPlot data: data.
	densityPlot bandwidth: 4.
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
RSDensityPlotTest >> testDensityPlotHasKernelDensity [
	| densityPlot data kernelDensity |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	kernelDensity := densityPlot kernelDensity.
	self assert: kernelDensity kernel class equals: RSKernelGaussianFunction.
]

{ #category : #tests }
RSDensityPlotTest >> testKernelDensityEstimation [
	| densityPlot data |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	densityPlot bandwidth: 4.
	self assert: (densityPlot kde: 30) closeTo: 0.0495.
]

{ #category : #tests }
RSDensityPlotTest >> testOpen [
	| densityPlot data window |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	window := densityPlot open.
	self assert: window isDisplayed.
	window delete.
]

{ #category : #tests }
RSDensityPlotTest >> testRedArea [
	| densityPlot data area |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	chart := RSChart new.
	densityPlot shape color: Color red.
	chart add: densityPlot.
	chart build.
	area := densityPlot area.
	self assert: area class equals: RSPolygon.
	self assert: area color equals: Color red.
	self assert: area equals: densityPlot createdShapes first.
]

{ #category : #tests }
RSDensityPlotTest >> testSetBandwidth [
	| densityPlot data |
	data := #(1 2 2 2 3 4).
	densityPlot := RSDensityPlot data: data.
 	self assert: densityPlot bandwidth equals: 1.
	densityPlot bandwidth: 4.
	self assert: densityPlot bandwidth equals: 4.
]
