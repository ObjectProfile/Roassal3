"
A `RSCellLayout` is like `RSGridLayout`. Elements of each column are centered along the same vertical line. And elements of each row are centered along the same horizontal line.

I have vertical and horizontal alignments. The alignment uses class `RSLocation` in the selected rectangle
"
Class {
	#name : #RSCellLayout,
	#superclass : #RSAbstractGridLayout,
	#instVars : [
		'verticalAlignment',
		'horizontalAlignment'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #alignment }
RSCellLayout >> alignBottom [
	self verticalAlignment: #bottom
]

{ #category : #alignment }
RSCellLayout >> alignCenter [
	self horizontalAlignment: #center
]

{ #category : #alignment }
RSCellLayout >> alignLeft [
	self horizontalAlignment: #left
]

{ #category : #alignment }
RSCellLayout >> alignMiddle [
	self verticalAlignment: #middle
]

{ #category : #alignment }
RSCellLayout >> alignRight [
	self horizontalAlignment: #right
]

{ #category : #alignment }
RSCellLayout >> alignTop [
	self verticalAlignment: #top
]

{ #category : #hook }
RSCellLayout >> doExecute: shapes [
	| lineItemSize pointer columnCount rowCount maxHeight columnsWidths rowHeights location |
	lineItemSize := self lineItemsCountBlock rsValue: shapes.

	"We compute the size of the grid"
	columnCount := 1.
	rowCount := 1.
	maxHeight := 0.
	columnsWidths := OrderedCollection new.
	rowHeights := OrderedCollection new.
	shapes do: [ :e |
		columnsWidths size < columnCount ifTrue: [ columnsWidths add: 0 ].
		columnsWidths at: columnCount put: ((columnsWidths at: columnCount) max: e extent x).
		maxHeight := maxHeight max: e extent y.
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
		"shape translateTo: pointer."
		location move: shape on: (Rectangle floatCenter: pointer extent: width @ height).
		pointer := pointer + (self gapSize * 2 @ 0) + ((width / 2) @ 0).
		
		columnCount := columnCount + 1.
		columnCount > lineItemSize ifTrue: [
			columnCount := 1.
			pointer := ((columnsWidths first / 2) @ pointer y)  + (0 @ (height / 2)).
			rowCount := rowCount + 1.
			rowCount <= rowHeights size
				ifTrue: [ pointer := pointer + (0 @ ((rowHeights at: rowCount) / 2)) ].
		]
		ifFalse: [ pointer := pointer + (self gapSize * 2 @ 0) + (((columnsWidths at: columnCount ) / 2) @ 0) ].
	].
	
]

{ #category : #accessing }
RSCellLayout >> horizontalAlignment [

	^ horizontalAlignment
]

{ #category : #accessing }
RSCellLayout >> horizontalAlignment: anObject [

	horizontalAlignment := anObject
]

{ #category : #initialization }
RSCellLayout >> initialize [
	super initialize.
	self alignMiddle; alignCenter.
]

{ #category : #accessing }
RSCellLayout >> verticalAlignment [

	^ verticalAlignment
]

{ #category : #accessing }
RSCellLayout >> verticalAlignment: anObject [

	verticalAlignment := anObject
]
