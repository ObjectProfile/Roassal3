Class {
	#name : #PLT,
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
PLT >> addDecoration: aDecoration [
	"Maybe use a double dispatch"
	decorations add: aDecoration.
	aDecoration plt: self
]

{ #category : #adding }
PLT >> addPlot: aPlot [
	plots add: aPlot.
	aPlot plt: self
]

{ #category : #building }
PLT >> build [
	canvas := TSCanvas new.
	"canvas @ RSControlsView."
	"RSControlsView new onElement: canvas."
	self renderDecorationIn: canvas.
	plots do: [ :p | p renderIn: canvas ].
	
]

{ #category : #accessing }
PLT >> decorations [
	^ decorations
]

{ #category : #'as yet unclassified' }
PLT >> defaultPlotColors [
	^ { Color blue . Color orange . Color green darker }
]

{ #category : #accessing }
PLT >> extent [
	^ extent
]

{ #category : #initialization }
PLT >> initialize [
	super initialize.
	plots := OrderedCollection new.
	extent := 200 @ 200.
	self initializeDecorations
]

{ #category : #initialization }
PLT >> initializeDecorations [
	decorations := OrderedCollection new.
	self addDecoration: PLTSpineDecoration new.
]

{ #category : #accessing }
PLT >> maxValueX [ 
	^ (plots collect: #maxValueX) max
]

{ #category : #accessing }
PLT >> maxValueY [
	^ (plots collect: #maxValueY) max
]

{ #category : #accessing }
PLT >> minValueX [ 
	^ (plots collect: #minValueX) min
]

{ #category : #accessing }
PLT >> minValueY [
	^ (plots collect: #minValueY) min
]

{ #category : #'as yet unclassified' }
PLT >> numberOfPlots [
	^ plots size
]

{ #category : #accessing }
PLT >> plots [
	^ plots
]

{ #category : #building }
PLT >> renderDecorationIn: aCanvas [
	decorations do: [ :d | d renderIn: aCanvas ]
]

{ #category : #building }
PLT >> show [
	^ canvas open
]

{ #category : #accessing }
PLT >> title: aTitle [
	self addDecoration: (PLTTitleDecoration new title: aTitle)
]

{ #category : #'as yet unclassified' }
PLT >> xlabel: aTitle [
	self addDecoration: (PLTXLabelDecoration new title: aTitle)
]

{ #category : #'as yet unclassified' }
PLT >> ylabel: aTitle [
	self addDecoration: (PLTYLabelDecoration new title: aTitle)
]
