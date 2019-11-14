Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSLinePlot >> renderIn: canvas [
	| lastPoint newPoint |
	self checkAssertion. 
	lastPoint := (xScale scale: xValues first) @ (yScale scale: yValues second).
	2 to: xValues size do: [ :i | 
		| xt yt et |
		xt := xValues at: i.
		yt := yValues at: i.
		newPoint := (xScale scale: xt) @ (yScale scale: yt).
		(newPoint x isInfinite not and: [ newPoint x isInfinite not ]) ifTrue: [ 
			et := RSLine new startPoint: lastPoint; endPoint: (lastPoint := newPoint).
			et color: (chart defaultPlotColors at: (self index \\ chart defaultPlotColors size) + 1) .
			canvas addShape: et ] ].

]
