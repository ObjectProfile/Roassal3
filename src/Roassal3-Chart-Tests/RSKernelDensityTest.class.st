Class {
	#name : #RSKernelDensityTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Statistics'
}

{ #category : #tests }
RSKernelDensityTest >> testBadKernelArgument [
	| kernelDensity anXValue |
	anXValue := 30.
	kernelDensity := RSKernelDensity basicNew
		bandwidth: 4.0.
	self should: [ kernelDensity kernel: RSKernelDensity gaussian. ] raise: Error.
]

{ #category : #tests }
RSKernelDensityTest >> testBasicNewKernelDensity [
	| kernelDensity anXValue |
	anXValue := 30.
	kernelDensity := RSKernelDensity basicNew
		bandwidth: 4.0;
		kernel: RSKernelFunction gaussian.
	self assert: (kernelDensity evaluateKernel: anXValue) closeTo: 1.4736e-196.
]

{ #category : #tests }
RSKernelDensityTest >> testDensityCurveSample [
	| data proveValues validationValues kernelDensity |
	data := #(14 15 28 27 32 35).
	proveValues := #(0 15 20 30 50).
	validationValues := #(5.105e-05 0.033 0.019 0.0495 1.536e-05).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 4.
	self assert: (kernelDensity densityCurveSample: proveValues) closeTo: validationValues precision: 0.01.
]

{ #category : #tests }
RSKernelDensityTest >> testKDEDefaultBandwidth [
	| kernelDensity |
	kernelDensity := RSKernelDensity gaussian.
	self assert: kernelDensity bandwidth closeTo: 1.00.
]

{ #category : #tests }
RSKernelDensityTest >> testKDESetBandwidth [
	| kernelDensity anXValue |
	kernelDensity := RSKernelDensity gaussian.
	kernelDensity bandwidth: 4.
	anXValue := 30.
 	self assert: (kernelDensity evaluateKernel: anXValue) closeTo: 1.4736e-196.
]

{ #category : #tests }
RSKernelDensityTest >> testKernelDensityEstimation [
	| kernelDensity anXValue data |
	data := #(14 15 28 27 32 35).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 4.
	anXValue := 30.
	self assert: (kernelDensity kde: anXValue) closeTo: 0.0495 precision: 0.001.

]

{ #category : #tests }
RSKernelDensityTest >> testKernelFunction [
	| kernelDensity anXValue |
	kernelDensity := RSKernelDensity gaussian.
	anXValue := 30.
 	self assert: (kernelDensity evaluateKernel: anXValue) closeTo: 1.4736e-196.
]
