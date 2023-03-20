Class {
	#name : #RSHeatmap,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'scale',
		'yLabels',
		'xLabels'
	],
	#category : #'Roassal3-Heatmap'
}

{ #category : #accessing }
RSHeatmap >> canvas [
	"Return the canvas in which the visualization is built"
	^ canvas
]

{ #category : #showing }
RSHeatmap >> configureScaleFrom: matrix [
	"For a given collection of collection of numbers, configure the scale"
	| minimumValue maximumValue tmp |
	tmp := matrix flatCollect: #yourself.
	minimumValue := tmp min.
	maximumValue := tmp max.
	scale
		domain:
			{minimumValue.
			maximumValue}
]

{ #category : #initialization }
RSHeatmap >> initialize [
	super initialize.
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	self initializeScale
]

{ #category : #showing }
RSHeatmap >> initializeScale [
	scale := NSScale linear range: #(black red)
]

{ #category : #initialization }
RSHeatmap >> open [
	^ canvas open
]

{ #category : #accessing }
RSHeatmap >> scale: aScale [
	"Set a new scale. This method is useful if you wish to set a new set of color. For example:

h := RSHeatmap new.
h scale: (TSScale linear range: #(purple red)).
h show: #(#(1 2) #(3 4)).
h open

	"
	scale := aScale
]

{ #category : #showing }
RSHeatmap >> setXLabelsOn: topMostShapes [
	"Do nothing if no label is set"
	| lShape |
	xLabels ifNil: [ ^ self ].
	self assert: [ xLabels isCollection ] description: 'Should provide a collection instead'.
	self assert: [ xLabels size = topMostShapes size ] description: 'Mismatched collection'.

	topMostShapes with: xLabels do: [ :s :l |
		lShape := RSLabel new text: l.
		lShape rotateByDegrees: -90.
		canvas addShape: lShape.
		RSLocation new
			offset: 0 @ -10;
			above; center;
			move: lShape on: s ]
]

{ #category : #showing }
RSHeatmap >> setYLabelsOn: leftMostShapes [
	"Do nothing if no label is set"
	| lShape |
	yLabels ifNil: [ ^ self ].
	self assert: [ yLabels isCollection ] description: 'Should provide a collection instead'.
	self assert: [ yLabels size = leftMostShapes size ] description: 'Mismatched collection'.

	leftMostShapes with: yLabels do: [ :s :l |
		lShape := RSLabel new text: l.
		canvas addShape: lShape.
		RSLocation new
			offset: -10 @ 0;
			outer;
			left;
			move: lShape on: s ]
]

{ #category : #showing }
RSHeatmap >> show: matrix [
	| box leftMostShapes topMostShapes boxes |
	self configureScaleFrom: matrix.
	leftMostShapes := OrderedCollection new.
	topMostShapes := OrderedCollection new.
	boxes := OrderedCollection new.
	matrix
		doWithIndex: [ :row :ic |
			row
				doWithIndex: [ :v :ir |
					box := RSBox new.
					box size: 40.
					box color: (scale scale: v).
					canvas addShape: box.
					boxes add: box.
					ir = 1 ifTrue: [ leftMostShapes add: box ].
					ic = 1 ifTrue: [ topMostShapes add: box ].
					 ] ].

	RSGridLayout new
		gapSize: 0;
		lineItemsCount: matrix first size;
		on: boxes.

	self setYLabelsOn: leftMostShapes.
	self setXLabelsOn: topMostShapes
]

{ #category : #accessing }
RSHeatmap >> xLabels: someLabels [
	"Set the labels for the X-Axis"
	xLabels := someLabels
]

{ #category : #accessing }
RSHeatmap >> yLabels: someLabels [
	"Set the labels for the Y-Axis"
	yLabels := someLabels
]
