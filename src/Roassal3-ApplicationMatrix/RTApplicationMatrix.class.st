Class {
	#name : #RTApplicationMatrix,
	#superclass : #RSAbstractBuilder,
	#instVars : [
		'items'
	],
	#category : #'Roassal3-ApplicationMatrix'
}

{ #category : #adding }
RTApplicationMatrix >> add: anItem [
	items add: anItem
]

{ #category : #'accessing vectorwise' }
RTApplicationMatrix >> columns [
	items ifEmpty: [ ^ #() ].
	^ (items collect: #column) removeDuplicates asArray
]

{ #category : #hooks }
RTApplicationMatrix >> createShapeBuilder [
	| sb |
	sb := RSShapeBuilder composite
			shapes: [ :el | 
								| s1 s2 |
								s1 := RSShapeBuilder box height: 20; width: 200; color: el color; elementOn: el.
								s2 := RSShapeBuilder label text: #itemName; elementOn: el.
								TSGroup new add: s1; add: s2; yourself ].
	^ sb
	"^ ((RSShapeBuilder box height: 20; width: 200; color: #color) + (RSShapeBuilder label text: #itemName))"
	"| b |
	b := super createShapeBuilder.
	b rectangle width: 250; height: 20; color: #color.
	^ b"
]

{ #category : #accessing }
RTApplicationMatrix >> createView [
	^ super createView @ RSControlsView
]

{ #category : #examples }
RTApplicationMatrix >> example01 [
	<script: 'self new example01'>
	"
	self new example01
	"

	| b item01 item02 item03 item04 |
	b := RTApplicationMatrix new.
	item01 := RTAMItem new.
	item01 itemName: 'Contract Management'.
	item01 row: 'Australia'.
	item01 column: 'Corporate Services'.
	item01 color: Color lightRed.
	
	item02 := RTAMItem new.
	item02 itemName: 'Bonus Card Use Watch'.
	item02 row: 'Australia'.
	item02 column: 'Corporate Services'.

	item03 := RTAMItem new.
	item03 itemName: 'MailSnake'.
	item03 row: 'Australia'.
	item03 column: 'Customer Relationship'.

	item04 := RTAMItem new.
	item04 itemName: 'Saleforce light'.
	item04 row: 'France'.
	item04 column: 'Customer Relationship'.
	item04 color: Color lightGreen.
	
	b add: item01; add: item02; add: item03; add: item04.
	b build.
	b open.
	^ b
]

{ #category : #initialization }
RTApplicationMatrix >> initialize [
	super initialize.
	items := OrderedCollection new.
	
]

{ #category : #accessing }
RTApplicationMatrix >> itemsAtRow: row andColumn: column [
	^ (items select: [ :item | item row = row and: [ item column = column ] ]) asArray
]

{ #category : #accessing }
RTApplicationMatrix >> numberOfColumns [
	^ self columns size
]

{ #category : #accessing }
RTApplicationMatrix >> numberOfItems [
	^ items size
]

{ #category : #accessing }
RTApplicationMatrix >> numberOfRows [
	^ self rows size
]

{ #category : #hooks }
RTApplicationMatrix >> renderIn: aView [

	| cells el elementsAsGroup itemsPerCell rowElements  |
	cells := OrderedCollection new.
	
	"First line"
	cells add: (RSShapeBuilder label elementOn: 'AppMatrix').
	self columns do: [ :cName | 
		el := RSShapeBuilder label bold; elementOn: cName.
		aView add: el.
		cells add: el.
	].
	
	self rows do: [ :row |
		el := RSShapeBuilder label bold; elementOn: row.
		aView add: el.
		cells add: el.
		
		rowElements := TSGroup new.
		self columns do: [ :column |
			itemsPerCell := self itemsAtRow: row andColumn: column.
			
			"elementsAsGroup := ((RTBox new height: 20; width: 200) + (RTLabel new text: #itemName)) elementsOn: itemsPerCell."
			elementsAsGroup := self createShapeBuilder elementsOn: itemsPerCell.
		
			aView addAll: elementsAsGroup.
			RSVerticalLineLayout new gapSize: 1; on: elementsAsGroup.
			cells add: elementsAsGroup.
			rowElements addAll: elementsAsGroup.
		].
	].
	RSCellLayout new lineItemsCount: self numberOfColumns + 1; on: cells.
	
]

{ #category : #'accessing vectorwise' }
RTApplicationMatrix >> rows [
	items ifEmpty: [ ^ #() ].
	^ (items collect: #row) removeDuplicates asArray
]
