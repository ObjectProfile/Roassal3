Class {
	#name : #PLTPlot,
	#superclass : #PLTAbstractElement,
	#instVars : [
		'xValues',
		'yValues',
		'label'
	],
	#category : #'Roassal3-Matplotlib'
}

{ #category : #accessing }
PLTPlot >> index [
	"Return the index of the plot within the list of plots to display in the plt object"
	^ plt plots indexOf: self
]

{ #category : #initialization }
PLTPlot >> initialize [
	super initialize.
	label := ''
]

{ #category : #rendering }
PLTPlot >> maxValueX [
	^ xValues max
]

{ #category : #rendering }
PLTPlot >> maxValueY [
	^ yValues max
]

{ #category : #rendering }
PLTPlot >> minValueX [
	^ xValues min
]

{ #category : #rendering }
PLTPlot >> minValueY [
	^ yValues min
]

{ #category : #rendering }
PLTPlot >> renderIn: canvas [
	| elements xScale yScale |
	self assert: [ xValues notNil and: [ yValues notNil ] ] description: 'X and Y values must be added'.
	self assert: [ xValues size = yValues size ] description: 'X and Y values have not the same size, and they should'.
	
	elements := (1 to: xValues size) collect: [ :notUsed | TSEllipse new radius: 2; color: (plt defaultPlotColors at: self index) ].
	xScale := TSScale linear domain: { plt minValueX . plt maxValueX }; range: { 0 . plt extent x }.
	yScale := TSScale linear domain: { plt minValueY . plt maxValueY }; range: { 0 . plt extent y negated }.

	1 to: xValues size do: [ :i |
		| xt yt et |
		et := elements at: i.
		xt := xValues at: i.
		yt := yValues at: i.
		et translateTo: (xScale scale: xt) @ (yScale scale: yt) ].
	
	elements do: [ :e | canvas addShape: e ].
	

]

{ #category : #public }
PLTPlot >> x: aCollection y: aCollection2 [ 
	xValues := aCollection.
	yValues := aCollection2.
]
