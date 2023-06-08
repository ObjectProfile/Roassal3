"
TODO
"
Class {
	#name : #RSLineChartPopupBuilder,
	#superclass : #RSAbstractChartPopupBuilder,
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #hooks }
RSLineChartPopupBuilder >> rowShapeFor: aRSLinePlot [
	| valuePoint |
	valuePoint := self valuePointFor: aRSLinePlot.
	valuePoint ifNil: [ ^ nil ].
	^ self rowShapeFor: aRSLinePlot point: valuePoint
]

{ #category : #hooks }
RSLineChartPopupBuilder >> rowShapeFor: aRSLinePlot point: aPoint [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSLineChartPopupBuilder >> shapeFor: aRSChart [
	| plots |
	plots := aRSChart plots select: #isLinePlot.
	plots := plots
		collect: [ :plot | self rowShapeFor: plot ]
		as: RSGroup.
	plots := plots reject: #isNil.
	plots ifEmpty: [ ^ RSBox new size: 0 ].
	RSVerticalLineLayout new gapSize: 0; on: plots.
	^ plots asShape
		padding: 10;
		color: (Color white alpha: 0.8);
		withBorder;
		yourself
]

{ #category : #hooks }
RSLineChartPopupBuilder >> valuePointFor: aRSLinePlot [
	| xValue yValue index |
	xValue := (aRSLinePlot xScale invert: position x) roundTo: 1.
	index := aRSLinePlot xValues indexOf: xValue.
	index = 0 ifFalse: [ xValue := index ].
	(xValue between: 1 and: aRSLinePlot yValues size)
		ifFalse: [ ^ nil ].
	yValue := aRSLinePlot yValues at: xValue.
	^ xValue @ yValue
]
