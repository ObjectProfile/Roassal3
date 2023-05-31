Class {
	#name : #RSViolinPlotTest,
	#superclass : #TestCase,
	#instVars : [
		'chart'
	],
	#category : #'Roassal3-Chart-Tests-Core'
}

{ #category : #tests }
RSViolinPlotTest >> testOneViolinPlot [
	| violinPlot data |
	data := #(1 2 2 2 3 4).
	violinPlot := RSViolinPlot data: data.
 	self assert: violinPlot data equals: data.
]
