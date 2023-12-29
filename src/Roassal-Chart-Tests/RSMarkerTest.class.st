Class {
	#name : 'RSMarkerTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'tests' }
RSMarkerTest >> testAverageX [

	| plot marker mark |
	plot := RSScatterPlot new x: { 1. 2. 6 } y: { 1. 1. 1 }.
	marker := RSXMarkerDecoration new average.
	mark := marker getValueToBeMarkedFromPlot: plot.
	self assert: mark equals: 3
]

{ #category : 'tests' }
RSMarkerTest >> testAverageY [

	| plot marker mark |
	plot := RSScatterPlot new x: { 1. 1. 1 } y: { 1. 2. 6 }.
	marker := RSYMarkerDecoration new average.
	mark := marker getValueToBeMarkedFromPlot: plot.
	self assert: mark equals: 3
]

{ #category : 'tests' }
RSMarkerTest >> testSumUpTo [

	| plot marker mark |

	plot := RSScatterPlot new x: (1 to: 5) y: { 5. 5. 1 . 4 . 5 }.
	marker := RSXMarkerDecoration new sumUpTo: 0.6.
	mark := marker getValueToBeMarkedFromPlot: plot.

	self assert: mark equals: 4
]

{ #category : 'tests' }
RSMarkerTest >> testSumUpToLimit0 [

	| plot marker mark |

	plot := RSScatterPlot new x: (1 to: 5) y: (1 to: 5).
	marker := RSXMarkerDecoration new sumUpTo: 0.
	mark := marker getValueToBeMarkedFromPlot: plot.
	self assert: mark equals: 1
]

{ #category : 'tests' }
RSMarkerTest >> testSumUpToLimit1 [

	| plot marker mark |

	plot := RSScatterPlot new x: (1 to: 5) y: (1 to: 5).
	marker := RSXMarkerDecoration new sumUpTo: 1.
	mark := marker getValueToBeMarkedFromPlot: plot.
	self assert: mark equals: 5
]
