"
Histogram Plot for Roassal
```
| values c plot |
values := #(0.5 0.5 0.3 -0.2 1.6 0 0.1 0.1 0.6 0.4).
c := RSChart new.
plot := RSHistogramPlot new x: values; bins: #(-0.5 0 0.5 1 0.5 1 1.5 2).
c addPlot: plot.
c horizontalTick doNotUseNiceLabel.
^ c
```

- Bins, can be a number or array of sorted numbers.
- By default bins is 10.
- For the previous example bins are `#(-0.5 0 0.5 1 0.5 1 1.5 2)`.
- First bin is #(-0.5 0), second bin is #(0 0.5), etc.
- All bins but last use this expression to calculate the number of values in each bin: `start <= n and: [n < end]`
- Last bin uses this expression `n between: start and: end`
- `binningStrategy:` allows to the user define different strategies to calculate the size for bins. Check `RSBinningStrategy`


A histogram can also be generated from a collection and a bloc using `RSHistogramPlot of: aCollection on: aBloc`. It can be useful when the data is associated with something, like the number of lines of code of a class.
The histogram will `collect:` on the collection with the bloc on its own to get the data, then the plot will show the distribution of the elements of the collection according to their corresponding value from the data.
Here is an example for the number of lines of code of `Collection` and its subclasses:

```
classes := Collection withAllSubclasses.
plot := RSHistogramPlot of: classes on: #linesOfCode.
plot bins: (0 to: 1000 by: 20) , {1000. 2000. 3000 }.

p show
```
"
Class {
	#name : 'RSHistogramPlot',
	#superclass : 'RSAbstractPlot',
	#instVars : [
		'map',
		'x',
		'bins',
		'bars',
		'binningStrategy'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'instance creation' }
RSHistogramPlot class >> of: aCollection on: aBloc [

	^ self new collectDataOf: aCollection on: aBloc
]

{ #category : 'accessing' }
RSHistogramPlot >> bars [
	^ bars
]

{ #category : 'accessing' }
RSHistogramPlot >> binSize: aNumber [
	self binningStrategy: (RSBinSizeBinning new
		size: aNumber;
		yourself)
]

{ #category : 'accessing' }
RSHistogramPlot >> binningStrategy [

	^ binningStrategy
]

{ #category : 'accessing' }
RSHistogramPlot >> binningStrategy: aBinningStrategy [
	binningStrategy := aBinningStrategy.
	self computeXYValues
]

{ #category : 'accessing' }
RSHistogramPlot >> bins [
	^ bins
]

{ #category : 'accessing' }
RSHistogramPlot >> bins: aCollection [
	self assert: aCollection isCollection description: 'you must provide a collection'.
	self binningStrategy: (RSFixedBinning new
		bins: aCollection;
		yourself)
]

{ #category : 'enumerating' }
RSHistogramPlot >> collectDataOf: aCollection on: aBloc [

	x := aCollection collect: aBloc.
	map := Dictionary newFromKeys: aCollection andValues: x.
	x := x sorted.
	self computeXYValues
]

{ #category : 'private' }
RSHistogramPlot >> computeBins [
	^ binningStrategy createBinsFor: x
]

{ #category : 'private' }
RSHistogramPlot >> computeXYValues [
	| prev |
	x ifNil: [ ^ self ].
	bins := self computeBins.
	xValues := bins.
	prev := bins first.
	yValues := bins allButLast collectWithIndex: [ :val1 :index |
		| val2 condition |
		val2 := bins at: index + 1.
		condition := index + 1 = bins size
			ifTrue: [ [ :value | value between: val1 and: val2 ] ]
			ifFalse: [ [ :value | val1 <= value and: [ value < val2 ] ] ].

		(x select: condition ) size.
	]
]

{ #category : 'accessing' }
RSHistogramPlot >> createdShapes [
	^ bars
]

{ #category : 'accessing - defaults' }
RSHistogramPlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : 'rendering' }
RSHistogramPlot >> definedValuesY [
	"Return the list Y values that are defined"
	^ yValues, {0}
]

{ #category : 'initialization' }
RSHistogramPlot >> initialize [
	super initialize.
	self binningStrategy: RSDefaultBinning new
]

{ #category : 'accessing' }
RSHistogramPlot >> map [

	^ map
]

{ #category : 'accessing' }
RSHistogramPlot >> map: aMap [

	map := aMap
]

{ #category : 'accessing' }
RSHistogramPlot >> model: anArray [

	| toShow xVal xVal2 yVal |
	xVal := anArray first.
	xVal2 := anArray second.
	yVal := anArray last.

	map ifNil: [ ^ xVal -> xVal2 -> yVal ].
	^ toShow := map keys select: [ :e |
		          (map at: e) between: xVal and: xVal2 ]
]

{ #category : 'accessing' }
RSHistogramPlot >> numberOfBins [
	^ self binningStrategy numberOfBins
]

{ #category : 'accessing' }
RSHistogramPlot >> numberOfBins: aNumber [
	self binningStrategy numberOfBins: aNumber.
	self computeXYValues
]

{ #category : 'rendering' }
RSHistogramPlot >> renderIn: canvas [

	super renderIn: canvas.
	bars := yValues collectWithIndex: [ :yVal :index |
		        | rect xVal xVal2 |
		        xVal := xValues at: index.
		        xVal2 := xValues at: index + 1.
		        rect := Rectangle
			                origin: (self scalePoint: xVal @ yVal)
			                corner: (self scalePoint: xVal2 @ 0).
		        self shape copy
			        model: (self model: { xVal. xVal2. yVal });
			        color: self computeColor;
			        fromRectangle: rect;
			        yourself ].
	bars := bars asGroup.
	canvas addAll: bars
]

{ #category : 'accessing' }
RSHistogramPlot >> x [
	^ x
]

{ #category : 'accessing' }
RSHistogramPlot >> x: aCollection [
	x := aCollection sorted.
	self computeXYValues
]
