"
<keyClass>
`RSChart` is the abstract class that encompass bar plots.

*Responsibility*: maintain and render bar plots.

*Collaborators*: a plot closely interacts with decorations and can be added in a `RSCompositeChart`. 

*Variables*:
- barSize: the size of the bars
- bars: all the bars of the plot
- gapRatio: 
- barOffset: shifts the bars left or right
"
Class {
	#name : #RSAbstractBarPlot,
	#superclass : #RSAbstractBandPlot,
	#instVars : [
		'barSize',
		'bars',
		'gapRatio',
		'barOffset'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #testing }
RSAbstractBarPlot class >> isAbstract [

	^ self == RSAbstractBarPlot
]

{ #category : #rendering }
RSAbstractBarPlot >> bandsOffset: aNumber [
	self barOffset: aNumber.
]

{ #category : #rendering }
RSAbstractBarPlot >> bandsWidth: barWidthInScaleRangeUnits [
	self barSize: barWidthInScaleRangeUnits.
]

{ #category : #accessing }
RSAbstractBarPlot >> barOffset [
	^ barOffset
]

{ #category : #accessing }
RSAbstractBarPlot >> barOffset: aNumber [
	barOffset := aNumber
]

{ #category : #accessing }
RSAbstractBarPlot >> barScale [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBarPlot >> barSize [
	"Return the width of each bar"
	^ barSize ifNil: [ self barScale rangeBand ]
]

{ #category : #accessing }
RSAbstractBarPlot >> barSize: aBarWidth [
	"Set the width of the bar"
	barSize := aBarWidth
]

{ #category : #accessing }
RSAbstractBarPlot >> bars [
	^ bars
]

{ #category : #hooks }
RSAbstractBarPlot >> computeRectagleFor: aPoint index: index [
	^ self subclassResponsibility
]

{ #category : #rendering }
RSAbstractBarPlot >> createBarFor: aPoint index: index [

	^ self shape copy
		  model: (self modelFor: aPoint);
		  color: self computeColor;
		  fromRectangle: (self computeRectagleFor: aPoint index: index);
		  yourself
]

{ #category : #accessing }
RSAbstractBarPlot >> createdShapes [
	^ bars
]

{ #category : #accessing }
RSAbstractBarPlot >> data: aCollection [
	bandPlotShapes := aCollection collect: [ :value | RSBarPlotShape data: value ].
]

{ #category : #'accessing - defaults' }
RSAbstractBarPlot >> defaultShape [

	^ RSBox new noPaint
]

{ #category : #accessing }
RSAbstractBarPlot >> gapRatio [
	^ gapRatio
]

{ #category : #accessing }
RSAbstractBarPlot >> gapRatio: aNumber [
	"aNumber between 0 and 1"
	gapRatio := aNumber
]

{ #category : #initialization }
RSAbstractBarPlot >> initialize [
	super initialize.
	self
		gapRatio: 0.1;
		barOffset: 0.
	horizontal := false.
	bandPlotShapes := OrderedCollection new.
	offset := 0.
]

{ #category : #testing }
RSAbstractBarPlot >> isBarPlot [
	^ true
]

{ #category : #hooks }
RSAbstractBarPlot >> modelFor: aPoint [
	^ self subclassResponsibility
]

{ #category : #rendering }
RSAbstractBarPlot >> renderIn: canvas [
	self padding: 0@0.
	super renderIn: canvas.
	self computeBandsOffset.
	self computeBandsWidth.
	bandPlotShapes doWithIndex: [ :barPlotShape :idx |
		barPlotShape color ifNil: [ barPlotShape color: self computeColor. ].
		barPlotShape bandScale: bandScale.
		barPlotShape dataScale: dataScale.
		barPlotShape renderIn: canvas ].
]

{ #category : #accessing }
RSAbstractBarPlot >> y: aCollection [
	self data: aCollection.
]
