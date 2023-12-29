Class {
	#name : 'RSKernelFunction',
	#superclass : 'RSObject',
	#category : 'Roassal3-Chart-Statistics',
	#package : 'Roassal3-Chart',
	#tag : 'Statistics'
}

{ #category : 'instance creation' }
RSKernelFunction class >> gaussian [
	^ RSKernelGaussianFunction new.
]

{ #category : 'accessing' }
RSKernelFunction >> evaluate: aNumber [
	^ self subclassResponsibility.
]
