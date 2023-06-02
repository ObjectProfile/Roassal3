Class {
	#name : #RSKernelDensityTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Chart-Tests-Statistics'
}

{ #category : #tests }
RSKernelDensityTest >> testKernelDensityEstimation [
	| kernelDensity anXValue data |
	data := #(14 15 28 27 32 35).
	kernelDensity := RSKernelDensity kernel: 'gaussian' data: data.
	anXValue := 30.
	self assert: (kernelDensity kde: anXValue) closeTo: 0.0495.

]

{ #category : #tests }
RSKernelDensityTest >> testKernelFunction [
	| kernelDensity anXValue |
	kernelDensity := RSKernelDensity kernel: 'gaussian'.
	anXValue := 30.
 	self assert: (kernelDensity kernelFunction: anXValue) closeTo: 1.4736e-196.
]
