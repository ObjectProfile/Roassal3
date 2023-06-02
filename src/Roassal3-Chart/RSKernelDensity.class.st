Class {
	#name : #RSKernelDensity,
	#superclass : #RSObject,
	#instVars : [
		'data',
		'bandwidth',
		'kernel'
	],
	#category : #'Roassal3-Chart-Statistics'
}

{ #category : #'as yet unclassified' }
RSKernelDensity class >> bandwidth: aNumber [
	^ self gaussian bandwidth: aNumber.
]

{ #category : #'as yet unclassified' }
RSKernelDensity class >> data: aCollection [
	| kernelDensity |
	kernelDensity := self gaussian.
	kernelDensity data: aCollection.
	^ kernelDensity
]

{ #category : #'as yet unclassified' }
RSKernelDensity class >> gaussian [
	| kernelDensity |
	kernelDensity := self new.
	kernelDensity kernel: RSKernelGaussianFunction new.
	^ kernelDensity
]

{ #category : #'as yet unclassified' }
RSKernelDensity class >> kernel: anRSKernelFunction [
	| kernelDensity |
	kernelDensity := self new.
	kernelDensity kernel: anRSKernelFunction. 
	^ kernelDensity
]

{ #category : #'as yet unclassified' }
RSKernelDensity class >> kernel: anRSKernelFunction data: aCollection [
	| kernelDensity |
	kernelDensity := self new.
	kernelDensity kernel: anRSKernelFunction.
	kernelDensity data: aCollection.
	^ kernelDensity
]

{ #category : #accessing }
RSKernelDensity >> bandwidth [
	^ bandwidth
]

{ #category : #accessing }
RSKernelDensity >> bandwidth: aNumber [
	bandwidth := aNumber
]

{ #category : #accessing }
RSKernelDensity >> data: aCollection [
	data := aCollection
]

{ #category : #accessing }
RSKernelDensity >> defaultBandwidth [
	^ 1.0.
]

{ #category : #accessing }
RSKernelDensity >> evaluateKernel: aNumber [
	^ kernel evaluate: aNumber.
]

{ #category : #accessing }
RSKernelDensity >> initialize [
	super initialize.
	self bandwidth: self defaultBandwidth.
]

{ #category : #accessing }
RSKernelDensity >> kde: aNumber [
	| sum h |
	sum := 0.
	h := bandwidth.
	data 
		do: [ :xi |
			sum := sum + (self evaluateKernel: ((aNumber - xi)/h))
		 ].
	^ sum / ((data size) * h)
]

{ #category : #accessing }
RSKernelDensity >> kernel [
	^ kernel
]

{ #category : #accessing }
RSKernelDensity >> kernel: anRSKernelFunction [
	self assert: (anRSKernelFunction isKindOf: RSKernelFunction) 
		description: 'Error: The argument passed to kernel is not an RSKernelFunction.'.
	kernel := anRSKernelFunction
]
