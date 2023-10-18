"
Please use RSCompositeChart
"
Class {
	#name : 'RSCompositeChart',
	#superclass : 'RSAbstractChart',
	#instVars : [
		'plots'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'adding' }
RSCompositeChart >> add: aPlot [
	"Add a plot to the chart.

For example:
```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.
c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c
```
	"
	plots add: aPlot.
	aPlot chart: self.
	aPlot decorations removeAll.
	aPlot padding: self padding.
	aPlot extent: self extent.
	aPlot styler: self styler.
	^ aPlot
]

{ #category : 'adding' }
RSCompositeChart >> addAll: aCollection [

	aCollection do: [ :each | self add: each ]
]

{ #category : 'accessing' }
RSCompositeChart >> chart [

	^ self
]

{ #category : 'initialization' }
RSCompositeChart >> initialize [

	super initialize.
	plots := OrderedCollection new
]

{ #category : 'accessing - extension' }
RSCompositeChart >> maxChartValueX [
	"if not set before, returns the maximum x value of all the plots"

	^ self chartExtents maxValueX
		  ifNil: [
			  | res |
			  self chartExtents maxValueX:
				  (res := (self plots collect: #maxValueX) max).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'accessing - extension' }
RSCompositeChart >> maxChartValueY [
	"if not set before, returns the maximum y value of all the plots"

	^ self chartExtents maxValueY
		  ifNil: [
			  | res |
			  self chartExtents maxValueY:
				  (res := (self plots collect: #maxValueY) max).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'accessing - extension' }
RSCompositeChart >> minChartValueX [
	"if not set before, returns the minimum x value of all the plots"

	^ self chartExtents minValueX
		  ifNil: [
			  | res |
			  self chartExtents minValueX:
				  (res := (self plots collect: #minValueX) min).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'accessing - extension' }
RSCompositeChart >> minChartValueY [
	"if not set before, returns the minimum y value of all the plots"

	^ self chartExtents minValueY
		  ifNil: [
			  | res |
			  self chartExtents minValueY:
				  (res := (self plots collect: #minValueY) min).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : 'accessing' }
RSCompositeChart >> numberOfPlots [
	"Return the number of plots contained in the chart"

	^ self plots size
]

{ #category : 'public' }
RSCompositeChart >> openOnce [

	self build.
	^ self canvas openOnce
]

{ #category : 'accessing - extension' }
RSCompositeChart >> padding: aPoint [

	super padding: aPoint.
	plots ifNil: [ ^ self ].
	plots do: [ :plot | plot padding: aPoint ]
]

{ #category : 'accessing' }
RSCompositeChart >> plots [

	^ plots
]

{ #category : 'rendering' }
RSCompositeChart >> renderIn: aCanvas [

	decorations , plots do: [ :element | element beforeRenderingIn: self ].
	decorations , plots do: [ :element | element renderIn: aCanvas ].
	shapes := decorations , plots
		          flatCollect: [ :element | element createdShapes ]
		          as: RSGroup
]

{ #category : 'public - scales' }
RSCompositeChart >> xScale: aScale [

	super xScale: aScale.
	plots do: [ :plot | plot xScale: aScale ]
]

{ #category : 'public - scales' }
RSCompositeChart >> yScale: aScale [

	super yScale: aScale.
	plots do: [ :e | e yScale: aScale ]
]
