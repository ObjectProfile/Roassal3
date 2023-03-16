"
I create markers in the visualization
"
Class {
	#name : #RSSimpleMarkerPopupBuilder,
	#superclass : #RSAbstractChartPopupBuilder,
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #hooks }
RSSimpleMarkerPopupBuilder >> shapeFor: aRSChart [
	| line box x |
	line := RSLine new dashArray: #(3).
	box := aRSChart spine globalEncompassingRectangle.
	x := position x.
	line
		startPoint: x @ box top;
		endPoint: x @ box bottom.
	^ line
]
