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
	^ barWidth ifNil: [ barWidth := 5 ] 
]

{ #category : #accessing }
RSBarPlot >> barWidth: aBarWidth [
	"Set the width of the bar"
	barWidth := aBarWidth
]

{ #category : #rendering }
RSBarPlot >> renderIn: canvas [
	| color width |
	self checkAssertion.
	color := chart colorFor: self.
	width := self barWidth / 2.
	1 to: xValues size do: [ :i | 
		| xt yt origin corner r |
		xt := xValues at: i.
		yt := yValues at: i.
		origin := (xScale scale: xt) @ (yScale scale: yt).
		corner := origin x @ (yScale scale: 0).
		((self isPointWellDefined: origin) and: [ self isPointWellDefined: corner ]) ifTrue: [
			r := Rectangle origin: origin - (width@ 0) corner: corner + (width@0).
			canvas add: (RSBox new
				color: color;
				position: r rsCenter;
				extent: r extent;
				yourself).
			  ] ].

]
