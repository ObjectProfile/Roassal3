Class {
	#name : 'RSSequenceableCollectionTest',
	#superclass : 'RSTest',
	#instVars : [
		'list'
	],
	#category : 'Roassal3-Global-Tests-Rendering',
	#package : 'Roassal3-Global-Tests',
	#tag : 'Rendering'
}

{ #category : 'running' }
RSSequenceableCollectionTest >> setUp [
	super setUp.
	list := RSSequenceableCollection new
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
	result := list shapesAtPoint:  -100@ -100.
	self assert: result isEmpty.
	result := list shapeAtPoint: -100@ -100.
	self assert: result isNil
]

{ #category : 'tests' }
RSSequenceableCollectionTest >> testOneElement [
	list add: (RSBox new size: 10).
	self deny: list isEmpty
]
