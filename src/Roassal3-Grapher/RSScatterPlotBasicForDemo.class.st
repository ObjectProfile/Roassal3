"
I am a basic class for demo
"
Class {
	#name : #RSScatterPlotBasicForDemo,
	#superclass : #Object,
	#instVars : [
		'myObjects',
		'view',
		'xmetric',
		'ymetric',
		'extent',
		'labelsX',
		'labelsY',
		'axisX',
		'axisY',
		'position'
	],
	#category : #'Roassal3-Grapher-Foo'
}

{ #category : #private }
RSScatterPlotBasicForDemo >> addTick: value using: scale [
	view addShape: (TSBox new
		position: (scale scale: value)@0;
		extent: 20@5;
		yourself).
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> axisX [
	^ axisX
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> axisX: aRSAxis [ 
	axisX := aRSAxis
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> axisY [
	^ axisY
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> axisY: aRSAxis [ 
	axisY := aRSAxis
]

{ #category : #building }
RSScatterPlotBasicForDemo >> build [
	self initializeScales.
	self preareDecorators.
	myObjects do: [ :myObject | myObject buildOn: self] .
]

{ #category : #examples }
RSScatterPlotBasicForDemo >> example [
	<script: 'self new example'>
	self
		extent: 800@500;
		models: #('AST' 'Calypso' 'Epicea' 'Roassal3' 'Kernel' 'STON');
		xmetric: [ :pkg | pkg methods size ];
		ymetric: [ :pkg | pkg classes size ];
		build;
		open
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> extent [
	^ extent
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> extent: aPoint [ 
	extent := aPoint
]

{ #category : #initialize }
RSScatterPlotBasicForDemo >> initialize [
	super initialize.
	view := RSView new.
	view @ RSControlsView.
	self axisX: (RSAxis new
		direction: 1@0;
		positionForLabel: [ :lbl | lbl translateBy: 0@20 ];
		yourself).
		
	self axisY: (RSAxis new
		direction: 0@ 1;
		positionForLabel: [ :lbl | 
			lbl 
				translateBy: -10@0;
			 	translateBy: (lbl width negated @0) / 2 ];
		yourself).
]

{ #category : #initialize }
RSScatterPlotBasicForDemo >> initializeScales [
	| nice xmax ymax |
	nice := RSLabelGenerator new.
	nice setLooseFlag: true.
	xmax := self maxSumForX.
	ymax := self maxSumForY.
	"AXIS thing"
	labelsX := nice searchMin: 0 max: xmax desired: 10.
	labelsY := nice searchMin: 0 max: ymax desired: 10.
	position := TSScale linear
		domain: { labelsX min @ labelsY max.  labelsX max @ labelsY min };
		range: { 0@0. self extent }.
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> labelsX [
	^ labelsX
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> labelsY [
	^ labelsY
]

{ #category : #private }
RSScatterPlotBasicForDemo >> maxSumFor: metric [ 
	^ myObjects inject: 0 into: [ :max :myObject | 
		max max: (myObject applyMetric: metric) ]
]

{ #category : #private }
RSScatterPlotBasicForDemo >> maxSumForX [
	^ self maxSumFor: self xmetric
]

{ #category : #private }
RSScatterPlotBasicForDemo >> maxSumForY [
	^ self maxSumFor: self ymetric
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> models: strings [
	myObjects := strings collect: [ :name | 
		RSCollectionOfPackages new
			initializeWith: name;
			yourself ].
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> open [
	view open
]

{ #category : #'accessing - computed' }
RSScatterPlotBasicForDemo >> positionFor: aRSCollectionOfPackages [ 
	^ position
		scale: (aRSCollectionOfPackages applyMetric: self xmetric) @
			(aRSCollectionOfPackages applyMetric: self ymetric)
]

{ #category : #building }
RSScatterPlotBasicForDemo >> preareDecorators [
	view addShape: (TSBox new
		noPaint;
		border: (TSBorder new color: Color gray);
		position: self extent / 2;
		extent: self extent;
		yourself).
	self axisX 
		labels: self labelsX;
		renderOn: self.
	self axisY
		labels: self labelsY;
		renderOn: self.
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> scale [
	^ position 
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> view [
	^ view
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> xmetric [
	^ xmetric
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> xmetric: aBlockClosure [ 
	xmetric := aBlockClosure.
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> ymetric [
	^ ymetric
]

{ #category : #accessing }
RSScatterPlotBasicForDemo >> ymetric: aBlockClosure [ 
	ymetric := aBlockClosure
]
