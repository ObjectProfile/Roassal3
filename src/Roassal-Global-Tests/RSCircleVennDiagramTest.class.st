Class {
	#name : 'RSCircleVennDiagramTest',
	#superclass : 'RSTest',
	#instVars : [
		'vennDiagram'
	],
	#category : 'Roassal-Global-Tests-Builder',
	#package : 'Roassal-Global-Tests',
	#tag : 'Builder'
}

{ #category : 'running' }
RSCircleVennDiagramTest >> setUp [
	super setUp.

	vennDiagram := RSCircleVennDiagram new
]

{ #category : 'tests' }
RSCircleVennDiagramTest >> testBasicVennDiagramOpen [

	| window |
	window := vennDiagram open.
	window delete
]

{ #category : 'tests' }
RSCircleVennDiagramTest >> testVennDiagramConvertsBigSetInputToSet [

	vennDiagram bigSet: { 1 . 2 }.
	self assert: vennDiagram bigSet class equals: Set
]

{ #category : 'tests' }
RSCircleVennDiagramTest >> testVennDiagramConvertsSmallSetInputToSet [

	vennDiagram smallSet: { 1 . 2 }.
	self assert: vennDiagram smallSet class equals: Set
]

{ #category : 'tests' }
RSCircleVennDiagramTest >> testVennDiagramOneSet [

	vennDiagram bigSet:  { 3 . 2 }.
	vennDiagram build.
	self assert: vennDiagram canvas shapes size equals: 0
]

{ #category : 'tests' }
RSCircleVennDiagramTest >> testVennDiagramTwoSets [

	vennDiagram bigSet:  { 3 . 2 }.
	vennDiagram smallSet:  { 1. 3 . 2 }.
	vennDiagram build.
	self assert: vennDiagram canvas shapes size equals: 2
]
