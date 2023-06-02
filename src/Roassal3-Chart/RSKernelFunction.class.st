Class {
	#name : #RSKernelFunction,
	#superclass : #RSObject,
	#category : #'Roassal3-Chart-Statistics'
}

{ #category : #'as yet unclassified' }
RSKernelFunction class >> gaussian [
	^ RSKernelGaussianFunction new.
]

{ #category : #accessing }
RSKernelFunction >> evaluate: aNumber [
	^ self subclassResponsibility.
]
