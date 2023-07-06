Class {
	#name : #RSCompositeChartTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #running }
RSCompositeChartTest >> testExtentIsCorrect [

	| chart p1 p2 x1 x2  |
	
	x1 := 1 to: 5 by: 0.1.
	x2 := -6 to: -2 by: 0.1.
	p1 := RSLinePlot new x: x1 y: x1 squared.
	p2 := RSLinePlot new x: x2 y: x2 squared.
	chart := RSCompositeChart new.
	chart add: p1; add: p2.
	
	chart build.
	
self assert: chart minChartValueX equals: -6.
self assert: chart minChartValueY equals: 1.
self assert: chart minChartValueX equals: 5.
self assert: chart minChartValueX equals: 36.

]
