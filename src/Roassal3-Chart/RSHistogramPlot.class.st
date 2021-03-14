"
TODO
"
Class {
	#name : #RSHistogramPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'x',
		'bins',
		'bars',
		'binningStrategy'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSHistogramPlot >> bars [
	^ bars
]

{ #category : #accessing }
RSHistogramPlot >> binningStrategy [

	^ binningStrategy
]

{ #category : #accessing }
RSHistogramPlot >> binningStrategy: aBinningStrategy [

	binningStrategy := aBinningStrategy
]

{ #category : #accessing }
RSHistogramPlot >> bins [
	^ bins
]

{ #category : #accessing }
RSHistogramPlot >> bins: aCollectionOrNumber [
	bins := aCollectionOrNumber.
	self computeXYValues.
]

{ #category : #private }
RSHistogramPlot >> computeBins [
	| binsSize first delta |
	(bins notNil and:[bins isCollection ]) ifTrue: [ ^ bins ].
	binsSize := bins.
	binsSize
		ifNil: [ binsSize := binningStrategy computeSizeFor: x. ].
	binsSize := binsSize +1.
	delta := (x last - x first) / binsSize.
	first := x first.
	bins := (1 to: binsSize) collect: [ :i |
		delta * (i - 1) + first ].
	^ bins
]

{ #category : #private }
RSHistogramPlot >> computeXYValues [
	| prev |
	bins := self computeBins.
	xValues := bins.
	prev := bins first.
	yValues := bins allButLast collectWithIndex: [ :val1 :index | 
		| val2 condition |
		val2 := bins at: index + 1.
		condition := index + 1 = bins size 
			ifTrue: [  [ :value | value between: val1 and: val2 ] ]
			ifFalse: [ [ :value | val1 <= value and: [ value < val2 ] ] ].
		(x select: condition ) size.
	].
	
	
	
]

{ #category : #initialization }
RSHistogramPlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : #rendering }
RSHistogramPlot >> definedValuesY [
	"Return the list Y values that are defined"
	^ yValues, {0}
]

{ #category : #initialization }
RSHistogramPlot >> initialize [
	super initialize.
	self binningStrategy: RSDefaultBinning new.
]

{ #category : #rendering }
RSHistogramPlot >> renderIn: canvas [
	bars := yValues collectWithIndex: [ :yVal :index |
		| rect xVal xVal2 |
		xVal := xValues at: index.
		xVal2 := xValues at: index +1.
		rect := Rectangle 
			origin: (self scalePoint: xVal @ yVal)
			corner: (self scalePoint: xVal2 @ 0).
		self shape copy
			model: (xVal->xVal2) -> yVal;
			color: self computeColor;
			fromRectangle: rect;
			yourself ].
	bars := bars asGroup.
	canvas addAll: bars.
]

{ #category : #accessing }
RSHistogramPlot >> x: aCollection [
	x := aCollection sorted.
	self computeXYValues.
]
