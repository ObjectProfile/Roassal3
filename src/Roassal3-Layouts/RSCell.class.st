"
TODO
"
Class {
	#name : #RSCell,
	#superclass : #RSObject,
	#instVars : [
		'elements',
		'columns',
		'element',
		'number',
		'rowHeights',
		'columnWidths'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
RSCell class >> elements: aCollection columns: anInteger [ 
	
	^ self new columns: anInteger; elements: aCollection; yourself
]

{ #category : #accessing }
RSCell >> column [

	^((number - 1) rem: columns) + 1
]

{ #category : #accessing }
RSCell >> columnWidthAt: index [
	"private"

	^ columnWidths at: index
]

{ #category : #accessing }
RSCell >> columns [
	^ columns
]

{ #category : #accessing }
RSCell >> columns: anObject [
	columns := anObject
]

{ #category : #accessing }
RSCell >> computeColumnWidths [

	columnWidths := Array new: elements columnCount.
	1 to: elements columnCount do: [ :columnIndex |
		columnWidths at: columnIndex put: ((elements atColumn: columnIndex) select: #notNil thenCollect: #width) max
	 ].
]

{ #category : #accessing }
RSCell >> computeRowHeights [

	rowHeights := Array new: elements rowCount.
	1 to: elements rowCount do: [ :rowIndex |
		rowHeights at: rowIndex put: ((elements atRow: rowIndex) select: #notNil thenCollect: #height) max
	 ].
]

{ #category : #accessing }
RSCell >> element [
	^ element
]

{ #category : #accessing }
RSCell >> element: anObject [
	element := anObject
]

{ #category : #accessing }
RSCell >> elements: aCollection [ 

	| rows  col |
	rows := (aCollection size / columns) ceiling rounded.
	col := Array new: rows * columns.
	1 to: aCollection size do: [ :i | col at: i put: (aCollection at: i)].
	elements := RSCellMatrix 
						rows: rows
						columns: columns 
						contents: col.
	self computeColumnWidths.
	self computeRowHeights.
]

{ #category : #accessing }
RSCell >> extent [

	^ self width @ self height
]

{ #category : #accessing }
RSCell >> height [

	^ self rowHeightAt: self row
]

{ #category : #accessing }
RSCell >> number [
	^ number
]

{ #category : #accessing }
RSCell >> number: anObject [
	number := anObject
]

{ #category : #accessing }
RSCell >> row [

	^((number - 1) quo: columns) + 1
]

{ #category : #accessing }
RSCell >> rowHeightAt: index [
	"private"

	^ rowHeights at: index
]

{ #category : #accessing }
RSCell >> width [

	^ self columnWidthAt: self column
]
