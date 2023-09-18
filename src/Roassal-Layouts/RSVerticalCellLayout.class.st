"
RSVerticalGridLayout places shapes as a grid. Shapes keeps their order, from top to down, and then left to right.
"
Class {
	#name : #RSVerticalCellLayout,
	#superclass : #RSAbstractGridLayout,
	#instVars : [
		'alignment'
	],
	#category : #'Roassal-Layouts-Grid'
}

{ #category : #accessing }
RSVerticalCellLayout >> alignment [

	^ alignment
]

{ #category : #accessing }
RSVerticalCellLayout >> alignment: anObject [

	alignment := anObject
]

{ #category : #hook }
RSVerticalCellLayout >> doExecute: shapes [
	| pointer lineItemCount lineItemSize maxLastLineWidth originalGapLeft originalGapTop vgap hgap align line mocks|
	
	mocks := RSMockShape shapes: shapes.
	originalGapLeft := 0.
	originalGapTop := 0.
	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock rsValue: mocks.
	lineItemCount := 0.
	maxLastLineWidth := 0.
	vgap := self verticalGap.
	hgap := self horizontalGap.
	align := RSAlignment new.
	line := OrderedCollection new.
	mocks do: [ :shape |
		translator translateTopLeftOf: shape to: pointer.
		line add: shape.
		pointer := pointer x @ (pointer y + shape height + vgap).
		lineItemCount := lineItemCount + 1.
		maxLastLineWidth := maxLastLineWidth max: shape width.
		lineItemCount >= lineItemSize ifTrue: [
			align shapes: line.
			alignment value: align.
			line do: [:mock | mock applyToRealElement ].
			line removeAll.
			pointer := (pointer x + hgap + maxLastLineWidth) @ originalGapLeft.
			maxLastLineWidth := 0.
			lineItemCount := 0 ]
	].
	line ifEmpty: [ ^ self ].
	align shapes: line.
	alignment value: align.
	line do: [:mock | mock applyToRealElement ].
]

{ #category : #initialization }
RSVerticalCellLayout >> initialize [
	super initialize.
	self alignment: #none
]
