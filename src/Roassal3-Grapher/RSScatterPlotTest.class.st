Class {
	#name : #RSScatterPlotTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Grapher-Foo'
}

{ #category : #tests }
RSScatterPlotTest >> testBasic [ 
	| plot |
	plot := RSScatterPlotBasicForDemo new.
	plot models: #('AST' 'Calypso' 'Epicea').
	plot build.
]
