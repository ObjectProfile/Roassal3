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

RSGridLayoutTest >> testBasicCustomizedGapSizeGridLayout[
	
	RSGridLayout  new gapSize:15; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(2.5@2.5). (22.5@2.5). (42.5@2.5). (62.5@2.5). (2.5@22.5). (22.5@22.5). (42.5@22.5). (62.5@22.5). (2.5@42.5). (22.5@42.5)}
]


RSGridLayoutTest >>testBasicDefaultGapSizeGridLayout[
	
	RSGridLayout  new gapSize:5; on: canvas nodes.
	self assert: (shapes collect: #position) asArray equals: {(2.5@2.5). (12.5@2.5). (22.5@2.5). (32.5@2.5). (2.5@12.5). (12.5@12.5). (22.5@12.5). (32.5@12.5). (2.5@22.5). (12.5@22.5)}
	
	]
RSGridLayoutTest >>testCustomLineItemsCount[
		|expected res rsgrid|
	rsgrid :=RSGridLayout new lineItemsCount: 5; on: canvas nodes.
	res := rsgrid lineItemsCountBlock .
	expected:=5.
	self assert: res equals:expected
	]
