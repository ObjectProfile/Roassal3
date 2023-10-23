Class {
	#name : 'RSObjectWithPropertyTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Examples',
	#package : 'Roassal-Global-Tests',
	#tag : 'Examples'
}

{ #category : 'tests' }
RSObjectWithPropertyTest >> testBasic [

	| b1 b2 b3 |
	b1 := RSBox new.
	b2 := RSBox new.
	b3 := RSBox new.
	b1 schildren: {
			b2.
			b3 }.

	self assert: b2 sparent equals: b1.
	self assert: b3 sparent equals: b1
]

{ #category : 'tests' }
RSObjectWithPropertyTest >> testWithAllChildren [

	| b1 b2 b3 children childrenWithParent schildren b4 |
	b1 := RSBox new.
	b2 := RSBox new.
	b3 := RSBox new.
	b4 := RSBox new.
	children := {
		            b2.
		            b3 }.
	b1 schildren: children.
	b3 schildren: { b4 }.
	childrenWithParent := children , { b1. b4 }.
	schildren := b1 withAllSChildren.
	self assert: schildren size equals: 4.
	self assert:
		(schildren allSatisfy: [ :s | childrenWithParent includes: s ])
]
