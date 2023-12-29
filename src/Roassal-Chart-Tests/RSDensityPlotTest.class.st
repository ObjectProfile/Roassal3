Class {
	#name : 'RSDensityPlotTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Core',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
RSDensityPlotTest >> testCreatePlotWihtKernelDensity [
	| data densityPlot kernelDensity |
	data := #(1 2 5 36 5 12 3).
	kernelDensity := RSKernelDensity data: data.
	densityPlot := RSDensityPlot kernelDensity: kernelDensity.
	self assert: densityPlot kernel class equals: RSKernelGaussianFunction.
	self assert: densityPlot data equals: data
]

{ #category : 'tests' }
RSDensityPlotTest >> testDataIsACollectionOfNumbers [
	| data fakeData densityPlot |
	data := #(1 2 5 36 5 12 3).
	densityPlot := RSDensityPlot data: data.
	fakeData := #('a' 'b' '15' '25').
	self should: [ densityPlot := RSDensityPlot data: fakeData. ] raise: Error
]

{ #category : 'tests' }
RSDensityPlotTest >> testDefaultColor [
	| densityPlot data kernelDensity window |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 10.
	densityPlot := RSDensityPlot kernelDensity: kernelDensity.
	window := densityPlot open. "area assigned to plot on renderIn"
	self assert: densityPlot area color equals: densityPlot defaultAreaColor.
	window delete
]

{ #category : 'tests' }
RSDensityPlotTest >> testDensityPlotDefaultValues [
	| densityPlot data |
	data := #(1 2 2 2 3 4).
	densityPlot := RSDensityPlot data: data.
 	self assert: densityPlot data equals: data.
	self assert: (densityPlot kernel isKindOf: RSKernelFunction).
	self assert: densityPlot bandwidth closeTo: 0.46936
]

{ #category : 'tests' }
RSDensityPlotTest >> testDensityPlotHasKernelDensity [
	| densityPlot data kernelDensity |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	kernelDensity := densityPlot kernelDensity.
	self assert: kernelDensity kernel class equals: RSKernelGaussianFunction
]

{ #category : 'tests' }
RSDensityPlotTest >> testOpen [
	| densityPlot data window |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	window := densityPlot open.
	self assert: window isDisplayed.
	window delete
]

{ #category : 'tests' }
RSDensityPlotTest >> testRedArea [
	| densityPlot data area |
	data := #(14 15 28 27 32 35).
	densityPlot := RSDensityPlot data: data.
	densityPlot shape color: Color red.
	densityPlot build.
	area := densityPlot area.
	self assert: area class equals: RSPolygon.
	self assert: area color equals: Color red.
	self assert: area equals: densityPlot createdShapes first
]

{ #category : 'tests' }
RSDensityPlotTest >> testSetBandwidth [
	| densityPlot data |
	data := #(1 2 2 2 3 4).
	densityPlot := RSDensityPlot data: data.
 	self assert: densityPlot bandwidth closeTo: 0.46936.
	densityPlot bandwidth: 4.
	self assert: densityPlot bandwidth equals: 4
]

{ #category : 'tests' }
RSDensityPlotTest >> testSetColor [
	| densityPlot data color |
	data := #(1 2 2 2 3 4).
	densityPlot := RSDensityPlot data: data.
	color := Color blue.

	densityPlot color: color.

 	self assert: densityPlot areaColor equals: color
]

{ #category : 'tests' }
RSDensityPlotTest >> testSetLabels [
	| densityPlot data |
	data := #(1 2 2 2 3 4).
	densityPlot := RSDensityPlot data: data.
 	densityPlot xlabel: 'x label'; ylabel: 'y label'; title:'Density plot'.
	self assert: densityPlot xlabel equals: 'x label'.
	self assert: densityPlot ylabel equals: 'y label'.
	self assert: densityPlot title equals: 'Density plot'
]
