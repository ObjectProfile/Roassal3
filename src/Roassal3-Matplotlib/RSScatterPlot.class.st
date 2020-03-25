Class {
	#name : #RSScatterPlot,
	#superclass : #RSAbstractPlot,
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSScatterPlot >> renderIn: canvas [
	| elements newPoint |
	self checkAssertion.
	elements := (1 to: xValues size)
		collect: [ :notUsed | 
			RSEllipse new
				radius: 2;
				color: (chart colorFor: self) ].
	1 to: xValues size do: [ :i | 
		| xt yt et |
		et := elements at: i.
		xt := xValues at: i.
		yt := yValues at: i.
		newPoint := (xScale scale: xt) @ (yScale scale: yt).
		(self isPointWellDefined: newPoint)
			ifTrue: [ et translateTo: newPoint.
				canvas addShape: et ] ]
]
