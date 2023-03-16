"
A ROCellLayout is like ROGridLayout. Elements of each column are centered along the same vertical line. And elements of each row are centered along the same horizontal line.

Instance Variables
	inCellPosition:		<Object | Block>

inCellPosition
	- Object which computes position of each element inside a cell. The cell is the space allocated for an element. Its height is maximum of heights of elements on the row. Its width is maximum of widths of elements on the column. By default elements are in the middle of their cell.
"
Class {
	#name : #RSCellLayout,
	#superclass : #RSAbstractGridLayout,
	#instVars : [
		'inCellPosition',
		'translateElement',
		'align'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSCellLayout >> centered [
	align := #center.
	translateElement := [ :aTranslator :anElement :newPos | translator translateCenterLeftOf: anElement to: newPos ].

	self inCellPosition: [ :cell | cell extent x @ 0 ]
]

{ #category : #hook }
RSCellLayout >> doExecute: shapes [
	| lineItemSize pointer columnCount rowCount maxHeight columnsWidths rowHeights |
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

		columnCount > lineItemSize
			ifTrue: [
				columnCount := 1.
				rowHeights add: maxHeight.
				maxHeight := 0 ]
	].
	rowHeights add: maxHeight.


	"We do the translation"
	columnCount := 1.
	rowCount := 1.
	pointer := (((columnsWidths at: 1) / 2) @ ((rowHeights at: 1) / 2)).
	shapes do: [ :e |
		e translateTo: pointer.
		pointer := pointer + (self gapSize * 2 @ 0) + (((columnsWidths at: columnCount) / 2) @ 0).

		columnCount := columnCount + 1.
		columnCount > lineItemSize
			ifTrue: [
				columnCount := 1.
				pointer := (((columnsWidths at: 1) / 2) @ pointer y)  + (0 @ ((rowHeights at: rowCount) / 2)).
				rowCount := rowCount + 1.
				rowCount <= rowHeights size
					ifTrue: [ pointer := pointer + (0 @ ((rowHeights at: rowCount) / 2)) ].
				 ]
			ifFalse: [ pointer := pointer + (self gapSize * 2 @ 0) + (((columnsWidths at: columnCount ) / 2) @ 0) ].
	]
]

{ #category : #accessing }
RSCellLayout >> inCellPosition: anObjectOrOneArgBlock [
	inCellPosition := anObjectOrOneArgBlock
]

{ #category : #initialization }
RSCellLayout >> initialize [
	super initialize.
	self leftCentered
]

{ #category : #accessing }
RSCellLayout >> leftCentered [
	align := #left.

	translateElement := [ :aTranslator :anElement :newPos | translator translateTopLeftOf: anElement to: newPos ].

	"self inCellPosition: [ :cell | 0 @ ((cell extent y - cell element height) / 2) ]"
	self inCellPosition: [ :cell | cell extent x @ 0 ]
]
