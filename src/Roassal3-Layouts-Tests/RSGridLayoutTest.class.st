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
