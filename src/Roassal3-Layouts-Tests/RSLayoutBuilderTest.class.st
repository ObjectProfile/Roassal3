Class {
	#name : #RSLayoutBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #running }
RSLayoutBuilderTest >> setUp [
	super setUp.
	builder := RSLayoutBuilder new
]

{ #category : #tests }
RSLayoutBuilderTest >> testBasic [
	self assert: builder layout class equals: RSFlowLayout
]

{ #category : #tests }
RSLayoutBuilderTest >> testConditionalLayout [
	builder ifConnected: RSTreeLayout new ifNotConnected: RSFlowLayout new.
	self assert: builder layout class equals: RSConditionalLayout
]

{ #category : #tests }
RSLayoutBuilderTest >> testGridCircleTree [
	{#grid -> RSGridLayout.
	 #circle -> RSCircleLayout.
	#tree -> RSTreeLayout} do: [ :assoc | | selector class |
		selector := assoc key.
		class := assoc value.
		selector value: builder.
		self assert: builder layout class equals: class.
		 ]
]
