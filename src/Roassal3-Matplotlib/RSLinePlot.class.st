Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSLinePlot >> renderIn: canvas [
	self checkAssertion. 
	canvas addShape: (RSPolyline new
		color: (chart colorFor: self);
		controlPoints: ((1 to: xValues size) collect: [ :i |
			| xt yt |
			xt := xValues at: i.
			yt := yValues at: i.
			(xScale scale: xt)@ (yScale scale: yt) ] );
		yourself).
]
