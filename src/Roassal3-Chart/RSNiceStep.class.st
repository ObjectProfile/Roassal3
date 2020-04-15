"
I am an utility class for RTNiceStepSizeGenerator>>next

"
Class {
	#name : #RSNiceStep,
	#superclass : #RSObject,
	#instVars : [
		'stepSize',
		'offset',
		'i',
		'j'
	],
	#category : #'Roassal3-Chart-Labeling'
}

{ #category : #accessing }
RSNiceStep >> i [
	^ i
]

{ #category : #accessing }
RSNiceStep >> i: aNumber [
	i := aNumber
]

{ #category : #accessing }
RSNiceStep >> j [
	^ j
]

{ #category : #accessing }
RSNiceStep >> j: aNumber [
	j := aNumber
]

{ #category : #accessing }
RSNiceStep >> offset [
	^ offset
]

{ #category : #accessing }
RSNiceStep >> offset: aNumber [
	offset := aNumber
]

{ #category : #accessing }
RSNiceStep >> stepSize [
	^ stepSize
]

{ #category : #accessing }
RSNiceStep >> stepSize: aNumber [
	stepSize := aNumber
]
