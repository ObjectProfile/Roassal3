Class {
	#name : #RSChartTitleDecorationTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Chart-Tests'
}

{ #category : #tests }
RSChartTitleDecorationTest >> testBasic [
	| c |
	c := RSChart new.
	c title: 'hello'.
	c build.
	
	self assert: c canvas numberOfShapes equals: 2.
	self assert: c canvas shapes second class equals: RSLabel.
	self assert: c canvas shapes second fontSize equals: RSChartTitleDecoration new defaultFontSize.
]

{ #category : #tests }
RSChartTitleDecorationTest >> testBasic2 [
	| c |
	c := RSChart new.
	c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
	c build.
	 
	self assert: c canvas numberOfShapes equals: 2.
	self assert: c canvas shapes second class equals: RSLabel.
	self assert: c canvas shapes second fontSize equals: 20
]
