Class {
	#name : #RSGridLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #tests }
RSGridLayoutTest >> testBasic [

	RSGridLayout on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(2.5@2.5). (12.5@2.5). (22.5@2.5). (32.5@2.5). (2.5@12.5). (12.5@12.5). (22.5@12.5). (32.5@12.5). (2.5@22.5). (12.5@22.5)}
]

{ #category : #tests }
RSGridLayoutTest >> testBasicCustomizedGapSizeGridLayout [

	RSGridLayout  new gapSize:15; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(2.5@2.5). (22.5@2.5). (42.5@2.5). (62.5@2.5). (2.5@22.5). (22.5@22.5). (42.5@22.5). (62.5@22.5). (2.5@42.5). (22.5@42.5)}
]

{ #category : #tests }
RSGridLayoutTest >> testBasicDefaultGapSizeGridLayout [

	RSGridLayout  new gapSize:5; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(2.5@2.5). (12.5@2.5). (22.5@2.5). (32.5@2.5). (2.5@12.5). (12.5@12.5). (22.5@12.5). (32.5@12.5). (2.5@22.5). (12.5@22.5)}
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
