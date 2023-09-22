Class {
	#name : 'RSKernelGaussianFunction',
	#superclass : 'RSKernelFunction',
	#category : 'Roassal3-Chart-Statistics',
	#package : 'Roassal3-Chart',
	#tag : 'Statistics'
}

{ #category : 'accessing' }
RSKernelGaussianFunction >> evaluate: aNumber [
	^ ((0-((aNumber squared)/2))) exp / ((2 * (Float pi)) sqrt).
]
