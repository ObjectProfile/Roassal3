Class {
	#name : #RSKernelGaussianFunction,
	#superclass : #RSKernelFunction,
	#category : #'Roassal-Chart-Statistics'
}

{ #category : #accessing }
RSKernelGaussianFunction >> evaluate: aNumber [
	^ ((0-((aNumber squared)/2))) exp / ((2 * (Float pi)) sqrt).
]
