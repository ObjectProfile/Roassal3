"
I am an utility class for RTNiceStepSizeGenerator>>next

"
Class {
	#name : #TSNiceStep,
	#superclass : #TSObject,
	#instVars : [
		'stepSize',
		'offset',
		'i',
		'j'
	],
	#category : #'Roassal3-Utils-Labeling'
}

{ #category : #accessing }
TSNiceStep >> i [
	^ i
]

{ #category : #accessing }
TSNiceStep >> i: aNumber [
	i := aNumber
]

{ #category : #accessing }
TSNiceStep >> j [
	^ j
]

{ #category : #accessing }
TSNiceStep >> j: aNumber [
	j := aNumber
]

{ #category : #accessing }
TSNiceStep >> offset [
	^ offset
]

{ #category : #accessing }
TSNiceStep >> offset: aNumber [
	offset := aNumber
]

{ #category : #accessing }
TSNiceStep >> stepSize [
	^ stepSize
]

{ #category : #accessing }
TSNiceStep >> stepSize: aNumber [
	stepSize := aNumber
]
