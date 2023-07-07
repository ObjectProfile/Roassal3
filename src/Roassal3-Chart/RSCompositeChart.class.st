"
<keyClass>
`RSChart` is the main class to build charts.

*Responsibility*: maintain and render plots

*Collaborators*: a chart closely interacts with plots and decorations. 

*Variables*:
- `plots`: the list of plots 
- `extent`: size of the produced chart. Note that this extent is for the area on which plots are draw. It does not comprise ticks and axis titles
- `decorations`: collection of decorations to annotate the chart
- `generator`: nice label generator, useful to have labels that are visually appealing
- `colors`: default color palette

*Example*:
Here is an example that adjust the font size used for the title, and axis labels:

```Smalltalk
x := -3.14 to: 3.14 by: 0.1.
y := x sin.

c := RSChart new.
c addPlot: (RSLinePlot new x: x y: y).
c addDecoration: (RSChartTitleDecoration new title: 'hello'; fontSize: 20).
c addDecoration: (RSXLabelDecoration new title: 'My X Axis'; fontSize: 12).
c addDecoration: (RSYLabelDecoration new title: 'My Y Axis'; fontSize: 15; vertical).
c
```
"
Class {
	#name : #RSCompositeChart,
	#superclass : #RSChart,
	#instVars : [
		'plots'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #adding }
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

{ #category : #adding }
RSCompositeChart >> addAll: aCollection [

	aCollection do: [ :each | self add: each ]
]

{ #category : #'public - plots' }
RSCompositeChart >> barHeights: aCollectionY [

	| res |
	self add:
		(res := RSBarPlot new x: (1 to: aCollectionY size) y: aCollectionY).
	^ res
]

{ #category : #'public - plots' }
RSCompositeChart >> barWidths: aCollectionX [

	| res |
	self add: (res := RSHorizontalBarPlot new
			        x: aCollectionX
			        y: (1 to: aCollectionX size)).
	^ res
]

{ #category : #adding }
RSCompositeChart >> chart [

	^ self
]

{ #category : #initialization }
RSCompositeChart >> initialize [

	super initialize.
	plots := OrderedCollection new
]

{ #category : #'accessing - extension' }
RSCompositeChart >> maxChartValueX [

	^ self chartExtents maxValueX
		  ifNil: [
			  | res |
			  self chartExtents maxValueX:
				  (res := (self plots collect: #maxValueX) max).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> maxChartValueY [

	^ self chartExtents maxValueY
		  ifNil: [
			  | res |
			  self chartExtents maxValueY:
				  (res := (self plots collect: #maxValueY) max).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> minChartValueX [

	^ self chartExtents minValueX
		  ifNil: [
			  | res |
			  self chartExtents minValueX:
				  (res := (self plots collect: #minValueX) min).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #'accessing - extension' }
RSCompositeChart >> minChartValueY [

	^ self chartExtents minValueY
		  ifNil: [
			  | res |
			  self chartExtents minValueY:
				  (res := (self plots collect: #minValueY) min).
			  res ]
		  ifNotNil: [ :res | res ]
]

{ #category : #accessing }
RSCompositeChart >> numberOfPlots [
	"Return the number of plots contained in the chart"

	^ self plots size
]

{ #category : #public }
RSCompositeChart >> openOnce [

	self build.
	^ self canvas openOnce
]

{ #category : #accessing }
RSCompositeChart >> plots [

	^ plots
]

{ #category : #hooks }
RSCompositeChart >> renderIn: aCanvas [

	decorations, plots do: [ :element |
		element beforeRenderingIn: self.
		element renderIn: aCanvas ].
	shapes := decorations, plots
		          flatCollect: [ :element | element createdShapes ]
		          as: RSGroup
]

{ #category : #building }
RSCompositeChart >> xScale: aScale [

	super xScale: aScale.
	plots do: [ :plot | plot xScale: aScale ]
]

{ #category : #building }
RSCompositeChart >> yScale: aScale [

	super yScale: aScale.
	plots do: [ :e | e yScale: aScale ]
]
