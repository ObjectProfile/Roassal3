"
RSVerticalGridLayout places shapes as a grid. Shapes keeps their order, from top to down, and then left to right.
"
Class {
	#name : #RSVerticalGridLayout,
	#superclass : #RSAbstractGridLayout,
	#instVars : [
		'alignment'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #'as yet unclassified' }
RSVerticalGridLayout class >> alignmentOptions [
	^ #()
]

{ #category : #accessing }
RSVerticalGridLayout >> alignment [

	^ alignment
]

{ #category : #accessing }
RSVerticalGridLayout >> alignment: anObject [

	alignment := anObject
]

{ #category : #hook }
RSVerticalGridLayout >> doExecute: shapes [
	| pointer lineItemCount lineItemSize maxLastLineWidth originalGapLeft originalGapTop gap align line |
	originalGapLeft := 0.
	originalGapTop := 0.

	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock rsValue: shapes.
	lineItemCount := 0.
	maxLastLineWidth := 0.
	gap := self gapSize.
	align := RSAlignment new.
	line := OrderedCollection new.
	shapes do: [ :shape |
		translator translateTopLeftOf: shape to: pointer.
		line add: shape.
		pointer := pointer x @ (pointer y + shape height + gap).
		lineItemCount := lineItemCount + 1.
		maxLastLineWidth := maxLastLineWidth max: shape width.
		lineItemCount >= lineItemSize ifTrue: [
			align shapes: line.
			alignment value: align.
			pointer := (pointer x + gap + maxLastLineWidth) @ originalGapLeft.
			maxLastLineWidth := 0.
			lineItemCount := 0 ]
	].
	line size < lineItemSize ifFalse: [ ^ self ].
	align shapes: line.
	alignment value: align
]

{ #category : #initialization }
RSVerticalGridLayout >> initialize [
	super initialize.
	self alignment: #none
]
