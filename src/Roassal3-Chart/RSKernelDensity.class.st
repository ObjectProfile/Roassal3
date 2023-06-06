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
RSKernelDensity >> data [
	^ data.
]

{ #category : #accessing }
RSKernelDensity >> data: aCollection [
	self assert: (aCollection allSatisfy: [ :each | each isNumber ]) 
		description: 'data: should receive only a collection of numbers'.
	data := aCollection
]

{ #category : #accessing }
RSKernelDensity >> defaultBandwidth [
	^ 1.0.
]

{ #category : #accessing }
RSKernelDensity >> defaultKernel [
	^ RSKernelGaussianFunction new.
]

{ #category : #rendering }
RSKernelDensity >> densityCurve [
	| curvePoints xi yi maxData minData epsilon step minXDomain maxXDomain maxY |
	maxData := data max.
	minData := data min.
	curvePoints := OrderedCollection new.
	epsilon := 0.0001.
	step := 0.05.
	maxY := 0.
	
	"Calculate left side"
	xi := minData.
	yi := self kde: xi.
	curvePoints add: xi@yi.
	maxY := yi max: maxY.
	[ yi > epsilon ] whileTrue: [
		xi := xi - step.
		yi := self kde: xi. 
		curvePoints addFirst: xi@yi.
		maxY := yi max: maxY.
	].
	minXDomain := xi.

	"Calculate middle"
	xi := minData + step.
	yi := self kde: xi.
	maxY := yi max: maxY.
	curvePoints add: xi@yi.
	[ xi < maxData ] whileTrue: [
		xi := xi + step.
		yi := self kde: xi. 
		curvePoints add: xi@yi.
		maxY := yi max: maxY.
	].
		
	"Calculate right side"
	[ yi > epsilon ] whileTrue: [
		xi := xi + step.
		yi := self kde: xi. 
		curvePoints add: xi@yi.
		maxY := yi max: maxY.
	].
	maxXDomain := xi.
	maxY := yi max: maxY.

	^ curvePoints.
]

{ #category : #accessing }
RSKernelDensity >> evaluateKernel: aNumber [
	^ kernel evaluate: aNumber.
]

{ #category : #initialization }
RSKernelDensity >> initialize [
	super initialize.
	self bandwidth: self defaultBandwidth.
	self kernel: self defaultKernel.
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
