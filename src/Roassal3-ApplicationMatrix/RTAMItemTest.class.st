Class {
	#name : #RTAMItemTest,
	#superclass : #Object,
	#instVars : [
		'item'
	],
	#category : #'Roassal3-ApplicationMatrix'
}

{ #category : #running }
RTAMItemTest >> setUp [
	super setUp.
	item := RTAMItem new.
	
]

{ #category : #tests }
RTAMItemTest >> testBasic [
	self assert: item itemName equals: 'Unnamed'.
	self assert: item tags isEmpty.
	self assert: item row equals: 'row'.
	self assert: item column equals: 'column'.
	self deny: item hasTag.
	self assert: item model isNil
]
