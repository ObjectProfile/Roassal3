Class {
	#name : 'RSKernelDensityTest',
	#superclass : 'TestCase',
	#category : 'Roassal-Chart-Tests-Statistics',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Statistics'
}

{ #category : 'tests' }
RSKernelDensityTest >> testBadKernelArgument [
	| kernelDensity anXValue |
	anXValue := 30.
	kernelDensity := RSKernelDensity basicNew
		bandwidth: 4.0.
	self should: [ kernelDensity kernel: RSKernelDensity gaussian. ] raise: Error
]

{ #category : 'tests' }
RSKernelDensityTest >> testBasicNewKernelDensity [
	| kernelDensity anXValue |
	anXValue := 30.
	kernelDensity := RSKernelDensity basicNew
		bandwidth: 4.0;
		kernel: RSKernelFunction gaussian.
	self assert: (kernelDensity evaluateKernel: anXValue) closeTo: 1.4736e-196
]

{ #category : 'tests' }
RSKernelDensityTest >> testComputeBandwidth [
	| data kernelDensity |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	kernelDensity := RSKernelDensity data: data.
	self assert: kernelDensity bandwidth closeTo: 8.432115827458984
]

{ #category : 'tests' }
RSKernelDensityTest >> testComputeDensityCurveDataOnlyOneValue [
	| kernelDensity data |
	data := #(87 87 87 87 87 87).
	kernelDensity := RSKernelDensity data: data.
	self assert: kernelDensity curveStep closeTo: 0.01
]

{ #category : 'tests' }
RSKernelDensityTest >> testComputeDensityCurveStep [
	| kernelDensity data |
	data := #(14 15 28 27 32 35).
	kernelDensity := RSKernelDensity data: data.
	self assert: kernelDensity curveStep closeTo: 0.21
]

{ #category : 'tests' }
RSKernelDensityTest >> testDefaultErrorMargin [
	| kernelDensity data |
	data := { 100. 200. 300. 400. 500. 600. }.
	kernelDensity := RSKernelDensity data: data.
	self assert: kernelDensity errorMargin closeTo: kernelDensity defaultErrorMargin
]

{ #category : 'tests' }
RSKernelDensityTest >> testDensityCurveSample [
	| data proveValues validationValues kernelDensity |
	data := #(14 15 28 27 32 35).
	proveValues := #(0 15 20 30 50).
	validationValues := #(5.105e-05 0.033 0.019 0.0495 1.536e-05).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 4.
	self assert: (kernelDensity densityCurveSample: proveValues) closeTo: validationValues precision: 0.01
]

{ #category : 'tests' }
RSKernelDensityTest >> testGetStandardDeviation [
	| data standardDeviation |
	data := #(6 7 15 36 39 40 41 42 43 47 49).
	standardDeviation := data standardDeviation.
	self assert: standardDeviation closeTo: 15.134657288477642
]

{ #category : 'tests' }
RSKernelDensityTest >> testKDEDefaultBandwidth [
	| kernelDensity |
	kernelDensity := RSKernelDensity gaussian.
	self assert: kernelDensity bandwidth isNil
]

{ #category : 'tests' }
RSKernelDensityTest >> testKDESetBandwidth [
	| kernelDensity anXValue |
	kernelDensity := RSKernelDensity gaussian.
	kernelDensity bandwidth: 4.
	anXValue := 30.
 	self assert: (kernelDensity evaluateKernel: anXValue) closeTo: 1.4736e-196
]

{ #category : 'tests' }
RSKernelDensityTest >> testKernelDensityEstimation [
	| kernelDensity anXValue data |
	data := #(14 15 28 27 32 35).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 4.
	anXValue := 30.
	self assert: (kernelDensity kde: anXValue) closeTo: 0.0495 precision: 0.001
]

{ #category : 'tests' }
RSKernelDensityTest >> testKernelFunction [
	| kernelDensity anXValue |
	kernelDensity := RSKernelDensity gaussian.
	anXValue := 30.
 	self assert: (kernelDensity evaluateKernel: anXValue) closeTo: 1.4736e-196
]

{ #category : 'tests' }
RSKernelDensityTest >> testSetDensityCurveStep [
	| kernelDensity data densityCurveBeforeStepChange densityCurveAfterStepChange|
	data := #(14 15 28 27 32 35).
	kernelDensity := RSKernelDensity data: data.
	densityCurveBeforeStepChange := kernelDensity densityCurve.
	kernelDensity curveStep: 5.
	densityCurveAfterStepChange := kernelDensity densityCurve.
	self assert: kernelDensity curveStep closeTo: 5.
	self assert: densityCurveBeforeStepChange size > densityCurveAfterStepChange size.
]

{ #category : 'tests' }
RSKernelDensityTest >> testSetErrorMargin [
	| kernelDensity data densityCurveSizeBefore densityCurveSizeAfter |
	data := { 100. 200. 300. 400. 500. 600. }.
	kernelDensity := RSKernelDensity data: data.
	densityCurveSizeBefore := kernelDensity densityCurve size.
	kernelDensity errorMargin: 0.000001.
	self assert: kernelDensity errorMargin < kernelDensity defaultErrorMargin.
	densityCurveSizeAfter := kernelDensity densityCurve size.
	self assert: densityCurveSizeBefore < densityCurveSizeAfter
]
