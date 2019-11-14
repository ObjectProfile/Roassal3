Class {
	#name : #RSScatterPlot,
	#superclass : #RSAbstractPlot,
	#category : #'Roassal3-Matplotlib'
}

{ #category : #rendering }
RSScatterPlot >> renderIn: canvas [
	| elements newPoint |
	self checkAssertion.
	elements := (1 to: xValues size)
		collect: [ :notUsed | 
			RSEllipse new
				radius: 2;
				color: (chart defaultPlotColors at: self index) ].
	1 to: xValues size do: [ :i | 
		| xt yt et |
		et := elements at: i.
		xt := xValues at: i.
		yt := yValues at: i.
		newPoint := (xScale scale: xt) @ (yScale scale: yt).
		(newPoint x isInfinite not and: [ newPoint x isInfinite not ]) ifTrue: [ 
			et translateTo: newPoint ] ].
	elements do: [ :e | canvas addShape: e ]
]
