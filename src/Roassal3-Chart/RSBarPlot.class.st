Class {
	#name : #RSBarPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'barWidth'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSBarPlot >> barWidth [
	"Return the width of each bar"
	^ barWidth
]

{ #category : #accessing }
RSBarPlot >> barWidth: aBarWidth [
	"Set the width of the bar"
	barWidth := aBarWidth
]

{ #category : #rendering }
RSBarPlot >> beforeRenderingIn: aChart [
	self minValueY > 0
		ifTrue: [ aChart minValueY: 0 ]
		ifFalse: [ self maxValueY < 0 
			ifTrue: [ aChart maxValueY: 0 ]].
	
	
	aChart decorations do: [ :e | e beforeRenderingIn: aChart ].
	super beforeRenderingIn: aChart.
	
]

{ #category : #rendering }
RSBarPlot >> renderIn: canvas [
	| color width myScale |
	self checkAssertion.
	color := chart colorFor: self.
	
	myScale := NSOrdinalScale new 
		domain: xValues;
		rangeBands: xScale range padding: 0.1.
	width := self barWidth.
	width ifNil: [ width := myScale rangeBand ].
	xValues doWithIndex: [ :xt : i | 
		| yt origin corner r |
		yt := yValues at: i.
		origin := (myScale scale: xt) @ (yScale scale: yt).
		corner := origin x @ (yScale scale: 0).
		((self isPointWellDefined: origin) and: [ self isPointWellDefined: corner ]) ifTrue: [
			r := Rectangle origin: origin corner: corner + (width@0).
			canvas add: (RSBox new
				color: color;
				fromRectangle: r;
				yourself).
			  ] ].

]
