"
`RSCellLayout` places shapes keeping their order from left to right.
Use `lineItemsCount:` to set the number of items per line.

Note with elements of different size each line will have different size also.


"
Class {
	#name : #RSCellLayout,
	#superclass : #RSAbstractGridLayout,
	#instVars : [
		'alignment'
	],
	#category : #'Roassal-Layouts-Grid'
}

{ #category : #accessing }
RSCellLayout >> alignment [

	^ alignment
]

{ #category : #accessing }
RSCellLayout >> alignment: anObject [

	alignment := anObject
]

{ #category : #hook }
RSCellLayout >> doExecute: shapes [

	| pointer lineItemCount lineItemSize maxLastLineHeight originalGapLeft 
	 originalGapTop vgap hgap line align |
	originalGapLeft := 0.
	originalGapTop := 0.
	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock rsValue: shapes.
	lineItemCount := 0.
	maxLastLineHeight := 0.
	vgap := self verticalGap.
	hgap := self horizontalGap.
	
	line := OrderedCollection new.
	align := RSAlignment new.
	shapes do: [ :shape |
		line add: shape.
		translator translateTopLeftOf: shape to: pointer.
		pointer := pointer x + shape width + hgap @ pointer y.
		lineItemCount := lineItemCount + 1.
		maxLastLineHeight := maxLastLineHeight max: shape height.
		lineItemCount >= lineItemSize ifTrue: [
			align shapes: line.
			alignment value: align.
			line := OrderedCollection new.
			pointer := originalGapLeft @ (pointer y + vgap + maxLastLineHeight).
			maxLastLineHeight := 0.
			lineItemCount := 0 ] ].
	line size < lineItemSize ifFalse: [ ^ self ].
	align shapes: line.
	alignment value: align
]

{ #category : #initialization }
RSCellLayout >> initialize [
	super initialize.
	self alignment: #none
]
