"
RSGridLayout places shapes as a grid. Shapes keeps their order, from left to right.
"
Class {
	#name : #RSGridLayout,
	#superclass : #RSAbstractGridLayout,
	#instVars : [
		'alignment'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSGridLayout class >> layoutDefinition [
	^ super layoutDefinition
		add: (RSLayoutChooseField new
			label: 'Aligment';
			items: self alignmentOptions;
			selector: #alignment;
			yourself);
		yourself
]

{ #category : #accessing }
RSGridLayout >> alignment [

	^ alignment
]

{ #category : #accessing }
RSGridLayout >> alignment: anObject [

	alignment := anObject
]

{ #category : #hook }
RSGridLayout >> doExecute: shapes [

	| pointer lineItemCount lineItemSize maxLastLineHeight originalGapLeft originalGapTop gap line align |
	originalGapLeft := 0.
	originalGapTop := 0.
	pointer := originalGapLeft @ originalGapTop.
	lineItemSize := self lineItemsCountBlock rsValue: shapes.
	lineItemCount := 0.
	maxLastLineHeight := 0.
	gap := self gapSize.
	line := OrderedCollection new.
	align := RSAlignment new.
	shapes do: [ :shape |
		line add: shape.
		translator translateTopLeftOf: shape to: pointer.
		pointer := pointer x + shape width + gap @ pointer y.
		lineItemCount := lineItemCount + 1.
		maxLastLineHeight := maxLastLineHeight max: shape height.
		lineItemCount >= lineItemSize ifTrue: [
			align shapes: line.
			alignment value: align.
			line := OrderedCollection new.
			pointer := originalGapLeft @ (pointer y + gap + maxLastLineHeight).
			maxLastLineHeight := 0.
			lineItemCount := 0 ] ].
	line size < lineItemSize ifFalse: [ ^ self ].
	align shapes: line.
	alignment value: align
]

{ #category : #initialization }
RSGridLayout >> initialize [
	super initialize.
	self alignment: #none
]
