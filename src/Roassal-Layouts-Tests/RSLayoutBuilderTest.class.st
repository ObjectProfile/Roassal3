Class {
	#name : #RSLayoutBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #running }
RSLayoutBuilderTest >> setUp [
	super setUp.
	builder := RSLayoutBuilder new
]

{ #category : #tests }
RSLayoutBuilderTest >> testConditionalLayout [
	builder ifConnected: RSTreeLayout new ifNotConnected: RSFlowLayout new.
	self assert: builder layout class equals: RSConditionalLayout
]

{ #category : #tests }
RSLayoutBuilderTest >> testDefaultLayoutClass [
	self assert: builder layout class equals: RSFlowLayout
]

{ #category : #tests }
RSLayoutBuilderTest >> testSelectNoneLayout [
	| shapes |
	shapes := RSBox models: (1 to: 10).
	builder none.
	self assert: builder layout class equals: RSNoLayout.
	builder on: shapes.
	self assert: (shapes allSatisfy: [ :each | each position = (0@0) ])
]

{ #category : #tests }
RSLayoutBuilderTest >> testUseGridCircleTreeChangesSelectedLayout [
	{#grid -> RSGridLayout.
	 #circle -> RSCircleLayout.
	#tree -> RSTreeLayout} do: [ :assoc | | selector class |
		selector := assoc key.
		class := assoc value.
		selector value: builder.
		self assert: builder layout class equals: class.
		 ]
]
