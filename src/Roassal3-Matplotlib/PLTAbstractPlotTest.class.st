Class {
	#name : #PLTAbstractPlotTest,
	#superclass : #TestCase,
	#instVars : [
		'plt'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #testing }
PLTAbstractPlotTest class >> isAbstract [
	^ self =  PLTAbstractPlotTest
]

{ #category : #tests }
PLTAbstractPlotTest >> classToTest [
	self subclassResponsibility
]

{ #category : #tests }
PLTAbstractPlotTest >> setUp [ 
	super setUp.
	plt := PLT new.
	
]

{ #category : #tests }
PLTAbstractPlotTest >> testBasic [

	self assert: plt numberOfPlots equals: 0
]

{ #category : #tests }
PLTAbstractPlotTest >> testOpening [
	| x |
	plt := PLT new.
	x := 0 to: 2 by: 1 / 100.
	plt addPlot: (self classToTest new x: x y: x).
	plt addPlot: (self classToTest new x: x y: (x collect: #squared)).
	plt addPlot: (self classToTest new x: x y: (x collect: [ :v | v * v * v ])).
	plt build.
	plt show delete
]

{ #category : #tests }
PLTAbstractPlotTest >> testWithOnePlot [

	| p |
	p := self classToTest new x: #(1 2 3) y: #(1 2 3).
	plt addPlot: p.
	self assert: plt numberOfPlots equals: 1.
	plt build.
	
	self assert: plt plots size equals: 1.
	self assert: plt plots first equals: p.
	self assert: p plt equals: plt
]

{ #category : #tests }
PLTAbstractPlotTest >> testWithOnePlotWithTitle [

	| p |
	p := self classToTest new x: #(1 2 3) y: #(1 2 3).
	plt addPlot: p.
	self assert: plt numberOfPlots equals: 1.
	plt title: 'Hello World'.
	plt build.
	
	self assert: plt plots size equals: 1.
	self assert: plt plots first equals: p.
	self assert: p plt equals: plt
]

{ #category : #tests }
PLTAbstractPlotTest >> testWithOnePlotWithTitleAndTitleOnAxes [

	| p |
	p := self classToTest new x: #(1 2 3) y: #(1 2 3).
	plt addPlot: p.
	plt xlabel: 'X Axis'.
	plt ylabel: 'Y Axis'.
	self assert: plt numberOfPlots equals: 1.
	plt title: 'Hello World'.
	plt build.
	
	self assert: plt plots size equals: 1.
	self assert: plt plots first equals: p.
	self assert: p plt equals: plt
]

{ #category : #tests }
PLTAbstractPlotTest >> testWithTwoPlots [

	| p1 p2 |
	p1 := self classToTest new x: #(1 2 3) y: #(1 2 3).
	p2 := self classToTest new x: #(-1 0 1) y: #(-2 0 2).
	plt addPlot: p1.
	plt addPlot: p2.
	self assert: plt numberOfPlots equals: 2.

	self assert: plt minValueX equals: -1.
	self assert: plt maxValueX equals: 3.
	self assert: plt maxValueY equals: 3.
	self assert: plt minValueY equals: -2.
]
