Class {
	#name : #RSGridLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #tests }
RSGridLayoutTest >> testBasicCustomizedGapSizeGridLayout [

	RSGridLayout new gapSize:15; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(2.5@2.5). (22.5@2.5). (42.5@2.5). (62.5@2.5). (2.5@22.5). (22.5@22.5). (42.5@22.5). (62.5@22.5). (2.5@42.5). (22.5@42.5)}
]

{ #category : #tests }
RSGridLayoutTest >> testBasicDefaultGapSizeGridLayout [

	RSGridLayout new gapSize:5; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(2.5@2.5). (12.5@2.5). (22.5@2.5). (32.5@2.5). (2.5@12.5). (12.5@12.5). (22.5@12.5). (32.5@12.5). (2.5@22.5). (12.5@22.5)}
]

{ #category : #tests }
RSGridLayoutTest >> testFixedPositionsAfterApplyingTheLayout [

	RSGridLayout on: canvas nodes.
	self assert: (shapes collect: [:each | each position asIntegerPoint ] as: Array) equals: {2 @ 2.
12 @ 2.
22 @ 2.
32 @ 2.
2 @ 12.
12 @ 12.
22 @ 12.
32 @ 12.
2 @ 22.
12 @ 22}
]

{ #category : #tests }
RSGridLayoutTest >> testLineItemsCount [

	| shapesInLine |
	RSGridLayout new
		lineItemsCount: 3;
		on: canvas nodes.
	shapesInLine := canvas nodes groupedBy: [ :each | each position y ].
	self assert: (shapesInLine allSatisfy: [:group | group size between: 1 and: 3 ])
]

{ #category : #tests }
RSGridLayoutTest >> testLineItemsCountForASingleLineOfShapes [
	canvas := RSCanvas new.
	shapes := (1 to: 3) collect: [ :each | RSBox new size: 20 ].
	canvas addAll: shapes.
	RSGridLayout new
		gapSize: 10;
		lineItemsCount: 8;
		on: shapes.
	self assertIntegerPosition: shapes equals: {10@10. 40@10. 70@10}.
	
	
]
