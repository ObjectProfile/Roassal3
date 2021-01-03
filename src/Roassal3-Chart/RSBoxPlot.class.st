Class {
	#name : #RSBoxPlot,
	#superclass : #RSAbstractBoxPlot,
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSBoxPlot >> barScale [
	^ xScale.
]

{ #category : #rendering }
RSBoxPlot >> beforeRenderingIn: aChart [
	| barScale |
	super beforeRenderingIn: aChart.
	xScale class = NSOrdinalScale ifTrue: [ ^ self ].
	barScale := NSOrdinalScale new 
		domain: xValues;
		rangeBands: xScale range padding: gapRatio.
	aChart xScale: barScale
]

{ #category : #hooks }
RSBoxPlot >> computeRectagleFor: aPoint index: index [
	| origin corner sizeOffset offset zero |
	zero := 0.
	bottom ifNotNil: [ zero := bottom at: index ].
	origin := (xScale scale: aPoint x) @ (yScale scale: aPoint y+zero).
	corner := origin x @ (yScale scale: zero ).
	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.
	^ Rectangle 
		origin: origin + offset - sizeOffset
		corner: corner + offset + sizeOffset
]

{ #category : #rendering }
RSBoxPlot >> computeWhiskersFor: aPoint index: index [
	| origin sizeOffset offset zero topLeft topCenter bottomLeft bottomCenter bottomRight bottomWhiskerExtent topWhiskerExtent |
	zero := 0.
	bottom ifNotNil: [ zero := bottom at: index ].
	origin := (xScale scale: aPoint x) @ (yScale scale: aPoint y+zero).
	sizeOffset := (self barSize / 2.0) @ 0.
	offset := self barOffset @ 0.
	
	topLeft := origin + offset - sizeOffset.
	bottomLeft := topLeft x @ (yScale scale: zero ).
	
	bottomRight := bottomLeft + offset + sizeOffset.
	bottomCenter := (bottomRight x + origin x / 2) @ bottomRight y.
	topCenter := bottomCenter x @ (topLeft y).
	
	bottomWhiskerExtent := bottomCenter x @ (yScale scale: zero - 2).
	topWhiskerExtent := bottomCenter x @ (yScale scale: aPoint y + zero + 2).
	^{RSLine new startPoint: bottomCenter; endPoint: bottomWhiskerExtent . RSLine new startPoint: topCenter; endPoint: topWhiskerExtent}
	
		
		
]

{ #category : #rendering }
RSBoxPlot >> definedValuesY [
	"Return the list Y values that are defined"
	| res |
	res := yValues.
	bottom ifNotNil: [ res := yValues + bottom ].
	^ res, {0}
]

{ #category : #hooks }
RSBoxPlot >> modelFor: aPoint [
	^ aPoint y
]

{ #category : #rendering }
RSBoxPlot >> renderIn: canvas [
	| index whiskers |
	self checkAssertion.
	index := 1.
	bars := xValues collect: [ :xt | 
		| yt bar |
		yt := yValues at: index.
		bar := self createBarFor: xt@yt index: index.
		index := index + 1.
		bar ] as: RSGroup.
	
	index := 1.
	whiskers := xValues flatCollect: [:xt | 
		|yt whis|
		yt := yValues at: index.
		whis := self computeWhiskersFor: xt@yt index: index. 
		index := index + 1.
		whis
		] as: RSGroup.
	canvas addAll: bars.
	canvas addAll: whiskers .

]
