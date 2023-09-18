"
Elements of each column are centered along the same vertical line. And elements of each row are centered along the same horizontal line.

I have vertical and horizontal alignments. The alignment uses class `RSLocation` in the selected rectangle
"
Class {
	#name : #RSGridLayout,
	#superclass : #RSAbstractGridLayout,
	#instVars : [
		'verticalAlignment',
		'horizontalAlignment'
	],
	#category : #'Roassal-Layouts-Grid'
}

{ #category : #alignment }
RSGridLayout >> alignBottom [
	self verticalAlignment: #bottom
]

{ #category : #alignment }
RSGridLayout >> alignCenter [
	self horizontalAlignment: #center
]

{ #category : #alignment }
RSGridLayout >> alignLeft [
	self horizontalAlignment: #left
]

{ #category : #alignment }
RSGridLayout >> alignMiddle [
	self verticalAlignment: #middle
]

{ #category : #alignment }
RSGridLayout >> alignRight [
	self horizontalAlignment: #right
]

{ #category : #alignment }
RSGridLayout >> alignTop [
	self verticalAlignment: #top
]

{ #category : #hook }
RSGridLayout >> doExecute: shapes [
	| lineItemSize pointer columnCount rowCount maxHeight columnsWidths rowHeights location hgap vgap |
	lineItemSize := self lineItemsCountBlock rsValue: shapes.

	"We compute the size of the grid"
	columnCount := 1.
	rowCount := 1.
	maxHeight := 0.
	columnsWidths := OrderedCollection new.
	rowHeights := OrderedCollection new.
	hgap := self horizontalGap.
	vgap := self verticalGap.
	
	shapes do: [ :shape |
		columnsWidths size < columnCount
			ifTrue: [ columnsWidths add: 0 ].
		columnsWidths at: columnCount
			put: ((columnsWidths at: columnCount) max: shape extent x).
		maxHeight := maxHeight max: shape extent y.
		columnCount := columnCount + 1.

		columnCount > lineItemSize ifTrue: [
			columnCount := 1.
			rowHeights add: maxHeight.
			maxHeight := 0 ]
	].
	rowHeights add: maxHeight.
	"We do the translation"
	columnCount := 1.
	rowCount := 1.
	pointer := ((columnsWidths first / 2) @ (rowHeights first / 2)).
	location := RSLocation new inner.
	verticalAlignment value: location.
	horizontalAlignment value: location.
	
	shapes do: [ :shape | | width height |
		width := columnsWidths at: columnCount.
		height := rowHeights at: rowCount.
		location move: shape on: (Rectangle floatCenter: pointer extent: width @ height).
		pointer := (width/2 + hgap) @ 0 + pointer.
		
		columnCount := columnCount + 1.
		columnCount > lineItemSize ifTrue: [
			columnCount := 1.
			pointer := columnsWidths first / 2 @ (height / 2 + vgap + pointer y).
			rowCount := rowCount + 1.
			rowCount <= rowHeights size
				ifTrue: [ pointer := pointer + (0 @ ((rowHeights at: rowCount) / 2)) ]
		] ifFalse: [
			columnCount := columnCount min: columnsWidths size.
			pointer := pointer + (((columnsWidths at: columnCount ) / 2) @ 0) ].
	]
]

{ #category : #accessing }
RSGridLayout >> horizontalAlignment [

	^ horizontalAlignment
]

{ #category : #accessing }
RSGridLayout >> horizontalAlignment: anObject [

	horizontalAlignment := anObject
]

{ #category : #initialization }
RSGridLayout >> initialize [
	super initialize.
	self alignMiddle; alignCenter.
]

{ #category : #accessing }
RSGridLayout >> verticalAlignment [

	^ verticalAlignment
]

{ #category : #accessing }
RSGridLayout >> verticalAlignment: anObject [

	verticalAlignment := anObject
]
