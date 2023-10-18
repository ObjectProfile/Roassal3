"
A chart styler is responsible to styler a chart and its element, in the future it would be connected to css description
"
Class {
	#name : 'RSChartStyler',
	#superclass : 'RSObject',
	#instVars : [
		'textColor',
		'textFont',
		'textSize',
		'tickColor',
		'spineColor'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'initialization' }
RSChartStyler >> initialize [
	super initialize.
	self
		textColor: Color black;
		tickColor: Color black;
		spineColor: Color black
]

{ #category : 'accessing' }
RSChartStyler >> spineColor [

	^ spineColor
]

{ #category : 'accessing' }
RSChartStyler >> spineColor: anObject [

	spineColor := anObject
]

{ #category : 'accessing' }
RSChartStyler >> textColor [

	^ textColor
]

{ #category : 'accessing' }
RSChartStyler >> textColor: anObject [

	textColor := anObject
]

{ #category : 'accessing' }
RSChartStyler >> textFont [

	^ textFont
]

{ #category : 'accessing' }
RSChartStyler >> textFont: anObject [

	textFont := anObject
]

{ #category : 'accessing' }
RSChartStyler >> textSize [

	^ textSize
]

{ #category : 'accessing' }
RSChartStyler >> textSize: anObject [

	textSize := anObject
]

{ #category : 'accessing' }
RSChartStyler >> tickColor [

	^ tickColor
]

{ #category : 'accessing' }
RSChartStyler >> tickColor: anObject [

	tickColor := anObject
]
