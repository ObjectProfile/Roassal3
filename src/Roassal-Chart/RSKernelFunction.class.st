Class {
	#name : #RSKernelFunction,
	#superclass : #RSObject,
	#category : #'Roassal-Chart-Statistics'
}

{ #category : #'instance creation' }
RSKernelFunction class >> gaussian [
	^ RSKernelGaussianFunction new.
]

{ #category : #accessing }
RSKernelFunction >> evaluate: aNumber [
	^ self subclassResponsibility.
]
