Class {
	#name : 'RSChartTitleDecorationTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Chart-Tests-Base',
	#package : 'Roassal-Chart-Tests',
	#tag : 'Base'
}

{ #category : 'tests' }
RSChartTitleDecorationTest >> testBasic [
	| plot title label |
	plot := RSLinePlot new y: #(1).
	plot removeAllTicks.
	title := plot title: 'hello'.
	title styler textColor: Color blue.
	plot build.

	self assert: plot canvas numberOfShapes equals: 3.
	label := title label.
	self assert: label class equals: RSLabel.
	self assert: label color equals: Color blue
]

{ #category : 'tests' }
RSChartTitleDecorationTest >> testBasic2 [
	| plot |
	plot := RSLinePlot new y: #(1).
	plot removeAllTicks.
	plot addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
	plot build.

	self assert: plot canvas numberOfShapes equals: 3.
	self assert: plot canvas shapes second class equals: RSLabel.
	self assert: plot canvas shapes second fontSize equals: 20
]
