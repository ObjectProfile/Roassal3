Class {
	#name : #RSChartTitleDecorationTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests-Base'
}

{ #category : #tests }
RSChartTitleDecorationTest >> testBasic [
	| c title label |
	c := RSCompositeChart new.
	c removeAllTicks.
	title := c title: 'hello'.
	title styler textColor: Color blue.
	c build.

	self assert: c canvas numberOfShapes equals: 2.
	label := title label.
	self assert: label class equals: RSLabel.
	self assert: label color equals: Color blue
]

{ #category : #tests }
RSChartTitleDecorationTest >> testBasic2 [
	| c |
	c := RSCompositeChart new.
	c removeAllTicks.
	c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
	c build.

	self assert: c canvas numberOfShapes equals: 2.
	self assert: c canvas shapes second class equals: RSLabel.
	self assert: c canvas shapes second fontSize equals: 20
]
