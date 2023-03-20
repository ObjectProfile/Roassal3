"
A ROAbstractGridLayout is xxxxxxxxx.

Instance Variables
	gapSize:		<Object>
	lineItemsCountBlock:		<Object>

gapSize
	- xxxxx

lineItemsCountBlock
	- xxxxx

"
Class {
	#name : #RSAbstractGridLayout,
	#superclass : #RSLayout,
	#instVars : [
		'gapSize',
		'lineItemsCountBlock'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
RSAbstractGridLayout class >> isAbstract [
	^ self name = #RSAbstractGridLayout
]

{ #category : #public }
RSAbstractGridLayout class >> on: aCollectionOfElements withGap: anInteger withLineItemsCount: aBlock [
	"place the elements in a grid with (aBlock roValue: aCollectionOfElements) as the amount of elements horizontally"

	| myLayout |
	myLayout := self new gapSize: anInteger;  lineItemsCount: aBlock; yourself.
	myLayout applyOn: aCollectionOfElements.
	^ aCollectionOfElements
]

{ #category : #public }
RSAbstractGridLayout class >> on: aCollectionOfElements withLineItemsCount: aBlock [
	"place the elements in a grid with (aBlock roValue: aCollectionOfElements) as the amount of elements horizontally

	For example:
	self on: (ROElement forCollection: (1 to: 20)) withLineItemsCount: 5
	=> place the 20 elements on a grid 5 x 4

	self on: (ROElement forCollection: (1 to: 20)) withLineItemsCount: [ :elements | elements size // 3 ]
	=> place the 20 elements on a grid 3 x 7
	"


	| myLayout |
	myLayout := self new lineItemsCount: aBlock; yourself.
	myLayout applyOn: aCollectionOfElements.
	^ aCollectionOfElements
]

{ #category : #'instance creation' }
RSAbstractGridLayout class >> withGap: anInteger [

	^ self new
			gapSize: anInteger;
			yourself
]

{ #category : #'instance creation' }
RSAbstractGridLayout class >> withGap: anInteger withLineItemsCount: aBlock [

	^self new
		gapSize: anInteger;
		lineItemsCount: aBlock;
		yourself
]

{ #category : #'instance creation' }
RSAbstractGridLayout class >> withLineItemsCount: aBlock [

	^self new
		lineItemsCount: aBlock;
		yourself
]

{ #category : #'initialize-release' }
RSAbstractGridLayout >> defaultGapSize [
	^ 5
]

{ #category : #accessing }
RSAbstractGridLayout >> defaultLineItemsCount [
	^ [ :elements |
			| height width |
			(elements size < 3
				ifTrue: [ (elements size max: 1) @ 1 ]
				ifFalse:
					[ height := (elements size * 0.618034) sqrt ceiling truncated.
					width := (elements size / height) ceiling truncated.
					width @ height ]) x ]
]

{ #category : #accessing }
RSAbstractGridLayout >> gapSize [
	^ gapSize
]

{ #category : #accessing }
RSAbstractGridLayout >> gapSize: anInteger [
	gapSize := anInteger
]

{ #category : #initialization }
RSAbstractGridLayout >> initialize [
	super initialize.
	gapSize := self defaultGapSize.
	lineItemsCountBlock := self defaultLineItemsCount
]

{ #category : #accessing }
RSAbstractGridLayout >> lineItemsCount: aNumberOrASymbolOrABlock [
	"The argument will be evaluated (using rsValue:) against the set of elements to perform the layout on. The result of this evaluation has to be a number, which indicates the number of elements per line"
	lineItemsCountBlock := aNumberOrASymbolOrABlock
]

{ #category : #accessing }
RSAbstractGridLayout >> lineItemsCountBlock [
	^ lineItemsCountBlock
]
