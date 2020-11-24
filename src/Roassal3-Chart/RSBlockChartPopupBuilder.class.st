"
This uses a block, avoid to use this class and create a subclass of RSLineChartPopupBuilder
"
Class {
	#name : #RSBlockChartPopupBuilder,
	#superclass : #RSLineChartPopupBuilder,
	#instVars : [
		'rowShapeBlock'
	],
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #accessing }
RSBlockChartPopupBuilder >> rowShapeBlock [
	^ rowShapeBlock
]

{ #category : #accessing }
RSBlockChartPopupBuilder >> rowShapeBlock: aBlock [
	"two arguments block
	first argument is the line plot.
	second argument is the point value
	should return a RSShape "
	rowShapeBlock := aBlock
]

{ #category : #hooks }
RSBlockChartPopupBuilder >> rowShapeFor: aRSLinePlot point: aPoint [
	^ rowShapeBlock value: aRSLinePlot value: aPoint
]
