Class {
	#name : #RSHeatmapTestCase,
	#superclass : #TestCase,
	#category : #'Roassal3-Heatmap'
}

{ #category : #tests }
RSHeatmapTestCase >> testBasic [
	| h |
	h := RSHeatmap new.
	h show: #(#(1 2) #(3 4)).

	self assert: h canvas numberOfShapes equals: 4
]
