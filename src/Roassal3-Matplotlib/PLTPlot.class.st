Class {
	#name : #PLTPlot,
	#superclass : #PLTAbstractPlot,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
PLTPlot >> renderIn: canvas [
	| xScale yScale lastPoint newPoint |
	self checkAssertion.
	xScale := self createXScale.
	yScale := self createYScale.
	lastPoint := (xScale scale: xValues first) @ (yScale scale: yValues second).
	2 to: xValues size do: [ :i | 
		| xt yt et |
		xt := xValues at: i.
		yt := yValues at: i.
		newPoint := (xScale scale: xt) @ (yScale scale: yt).
		et := RSLine new startPoint: lastPoint; endPoint: (lastPoint := newPoint).
		et color: (plt defaultPlotColors at: self index).
		canvas addShape: et ].

]
