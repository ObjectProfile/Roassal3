Class {
	#name : #RSKernelDensity,
	#superclass : #RSObject,
	#instVars : [
		'kernel',
		'data'
	],
	#category : #'Roassal3-Chart-Statistics'
}

{ #category : #'as yet unclassified' }
RSKernelDensity class >> kernel: aKernelFunctionNameStr [
	| kernelDensity |
	kernelDensity := self new.
	kernelDensity kernel: aKernelFunctionNameStr. 
	^ kernelDensity
]

{ #category : #'as yet unclassified' }
RSKernelDensity class >> kernel: aKernelFunctionNameStr data: aCollection [
	| kernelDensity |
	kernelDensity := self new.
	kernelDensity kernel: aKernelFunctionNameStr.
	kernelDensity data: aCollection.
	^ kernelDensity
]

{ #category : #accessing }
RSKernelDensity >> data: aCollection [
	data := aCollection
]

{ #category : #accessing }
RSKernelDensity >> kde: aNumber [
	| sum h |
	sum := 0.
	h := 4. "TO DO: make it a parameter"
	data 
		do: [ :xi |
			sum := sum + (self kernelFunction: ((aNumber - xi)/h))
		 ].
	^ sum / ((data size) * h)
]

{ #category : #accessing }
RSKernelDensity >> kernel: aKernelFunctionNameStr [
	kernel := aKernelFunctionNameStr
]

{ #category : #accessing }
RSKernelDensity >> kernelFunction: aNumber [
	"by now it is harcoded the normal (gaussian) kernel"
	^ ((0-((aNumber squared)/2))) exp / ((2 * (Float pi)) sqrt).
]
