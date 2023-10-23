Class {
	#name : 'RSSequenceableCollectionTest',
	#superclass : 'RSTest',
	#instVars : [
		'list'
	],
	#category : 'Roassal-Global-Tests-Rendering',
	#package : 'Roassal-Global-Tests',
	#tag : 'Rendering'
}

{ #category : 'running' }
RSSequenceableCollectionTest >> setUp [
	super setUp.
	list := RTSequenceableCollection new
]

{ #category : 'tests' }
RSSequenceableCollectionTest >> testBasic [

	list isEmpty.
	self assert: list size isZero
]

{ #category : 'tests' }
RSSequenceableCollectionTest >> testIncludes [
	| result |
	list addAll: { RSBox new size: 10. RSBox new position: 50@50; size: 10 asPoint}.
	self assert: list size equals: 2.
	result := list entriesAtPoint:  -100@ -100.
	self assert: result isEmpty.
	result := list entryAtPoint: -100@ -100 ifNone: [ nil ].
	self assert: result isNil
]

{ #category : 'tests' }
RSSequenceableCollectionTest >> testOneElement [
	list add: (RSBox new size: 10).
	self deny: list isEmpty
]
