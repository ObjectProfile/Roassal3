Class {
	#name : #RSChart,
	#superclass : #Object,
	#instVars : [
		'plots',
		'canvas',
		'width',
		'extent',
		'plot',
		'decorations'
	],
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #adding }
RSChart >> addDecoration: aDecoration [
	"Maybe use a double dispatch"
	decorations add: aDecoration.
	aDecoration chart: self
]

{ #category : #adding }
RSChart >> addPlot: aPlot [
	plots add: aPlot.
	aPlot chart: self
]

{ #category : #building }
RSChart >> build [
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	plots, decorations do: [ :e | e beforeRenderingIn: self ].
	self renderDecorationIn: canvas.
	self renderPlotsIn: canvas
]

{ #category : #building }
RSChart >> canvas [
	^ canvas
]

{ #category : #accessing }
RSChart >> decorations [
	^ decorations
]

{ #category : #'as yet unclassified' }
RSChart >> defaultPlotColors [
	^ { Color blue . Color orange . Color green darker }
]

{ #category : #accessing }
RSChart >> extent [
	^ extent
]

{ #category : #visualization }
RSChart >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Canvas'];
		initializeCanvas: [ self build; canvas ]
		
]

{ #category : #initialization }
RSChart >> initialize [
	super initialize.
	plots := OrderedCollection new.
	extent := 200 @ 200.
	self initializeDecorations
]

{ #category : #initialization }
RSChart >> initializeDecorations [
	decorations := OrderedCollection new.
	self addDecoration: RSChartSpineDecoration new.
]

{ #category : #accessing }
RSChart >> maxValueX [ 
	^ (plots collect: #maxValueX) max
]

{ #category : #accessing }
RSChart >> maxValueY [
	^ (plots collect: #maxValueY) max
]

{ #category : #accessing }
RSChart >> minValueX [ 
	^ (plots collect: #minValueX) min
]

{ #category : #accessing }
RSChart >> minValueY [
	^ (plots collect: #minValueY) min
]

{ #category : #'as yet unclassified' }
RSChart >> numberOfPlots [
	^ plots size
]

{ #category : #accessing }
RSChart >> plots [
	^ plots
]

{ #category : #building }
RSChart >> renderDecorationIn: aCanvas [
	decorations do: [ :d | d renderIn: aCanvas ]
]

{ #category : #building }
RSChart >> renderPlotsIn: aCanvas [
	plots do: [ :p | p renderIn: canvas ].
	
]

{ #category : #building }
RSChart >> show [
	self build.
	^ canvas open
]

{ #category : #accessing }
RSChart >> title: aTitle [
	self addDecoration: (RSChartTitleDecoration new title: aTitle)
]

{ #category : #'public - configuration' }
RSChart >> xLog [
	self xScale: TSScale log
]

{ #category : #'public - configuration' }
RSChart >> xScale: aScale [
	plots, decorations do: [ :e | e xScale: aScale ].
]

{ #category : #'public - configuration' }
RSChart >> xSqrt [
	self xScale: TSScale sqrt
]

{ #category : #'as yet unclassified' }
RSChart >> xlabel: aTitle [
	self addDecoration: (RSXLabelDecoration new title: aTitle)
]

{ #category : #'public - configuration' }
RSChart >> yLog [
	self yScale: TSScale log
]

{ #category : #'public - configuration' }
RSChart >> yScale: aScale [
	plots, decorations do: [ :e | e yScale: aScale ].
]

{ #category : #'public - configuration' }
RSChart >> ySqrt [
	self yScale: TSScale sqrt
]

{ #category : #'as yet unclassified' }
RSChart >> ylabel: aTitle [
	self addDecoration: (RSYLabelDecoration new title: aTitle)
]
