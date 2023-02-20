"
I can define offsets in each side of the attach point
"
Class {
	#name : #RSOffsetAttachPoint,
	#superclass : #RSAttachPoint,
	#instVars : [
		'startOffset',
		'endOffset'
	],
	#category : #'Roassal3-Shapes-AttachPoint'
}

{ #category : #testing }
RSOffsetAttachPoint class >> isAbstract [

	^ self == RSOffsetAttachPoint
]

{ #category : #accessing }
RSOffsetAttachPoint >> endOffset [
	^ endOffset
]

{ #category : #accessing }
RSOffsetAttachPoint >> endOffset: aNumber [
	endOffset := aNumber
]

{ #category : #initialization }
RSOffsetAttachPoint >> initialize [
	super initialize.
	startOffset := endOffset := 0
]

{ #category : #accessing }
RSOffsetAttachPoint >> startOffset [
	^ startOffset
]

{ #category : #accessing }
RSOffsetAttachPoint >> startOffset: aNumber [
	startOffset := aNumber
]
