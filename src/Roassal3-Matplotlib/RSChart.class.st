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
	#category : #'Roassal3-Matplotlib'
}

{ #category : #adding }
RSChart >> addDecoration: aDecoration [
	"Maybe use a double dispatch"
	decorations add: aDecoration.
	aDecoration plt: self
]

{ #category : #adding }
RSChart >> addPlot: aPlot [
	plots add: aPlot.
	aPlot plt: self
]

{ #category : #building }
RSChart >> build [
	canvas := RSCanvas new.
	canvas @ RSControlsCanvas.
	"RSControlsView new onElement: canvas."
	self renderDecorationIn: canvas.
	plots do: [ :p | p renderIn: canvas ].
	
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
	self addDecoration: PLTSpineDecoration new.
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
RSChart >> show [
	self build.
	^ canvas open
]

{ #category : #accessing }
RSChart >> title: aTitle [
	self addDecoration: (PLTTitleDecoration new title: aTitle)
]

{ #category : #'as yet unclassified' }
RSChart >> xlabel: aTitle [
	self addDecoration: (PLTXLabelDecoration new title: aTitle)
]

{ #category : #'as yet unclassified' }
RSChart >> ylabel: aTitle [
	self addDecoration: (PLTYLabelDecoration new title: aTitle)
]
