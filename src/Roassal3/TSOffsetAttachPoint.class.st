"
I can define offsets in each side of the attach point
"
Class {
	#name : #TSOffsetAttachPoint,
	#superclass : #TSAttachPoint,
	#instVars : [
		'startOffset',
		'endOffset'
	],
	#category : #'Roassal3-AttachPoint'
}

{ #category : #accessing }
TSOffsetAttachPoint >> endOffset [
	^ endOffset
]

{ #category : #accessing }
TSOffsetAttachPoint >> endOffset: aNumber [
	endOffset := aNumber
]

{ #category : #'public - hooks' }
TSOffsetAttachPoint >> initialize [ 
	super initialize.
	startOffset := endOffset := 0.
]

{ #category : #accessing }
TSOffsetAttachPoint >> startOffset [
	^ startOffset
]

{ #category : #accessing }
TSOffsetAttachPoint >> startOffset: aNumber [
	startOffset := aNumber.
]
