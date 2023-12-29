"
`RSDensityPlot` is a visual representation of the density distribution of a dataset using a kernel density estimation.

**Responsibility:** plots the density distribution, provides options to customize the plot.

**Collaborators:** the instance variable kernel density is a `RSKernelDensity` object that calculates the points of the density curve.

**Public API and Key Messages**
- `data: aCollection` to create instances passing aCollection as argument.
- `kernelDensity aRSKernelDensity`: to create instances passing a `RSKernelDensity` object with set attributes like, bandwidth, kernel, etc.
- `bandwidth: aFloat` to set the bandwith (h) of the kernel in the kernel density estimation function. By `default 1.0`.

**Instance Variables:**
- `area`: an `RSPolygon` that represents the area under the density curve.
- `curvePoints`: an `OrderedCollection` of  `Point`s that store the result of evaluate the Kernel Density Estimation.
- `kernelDensity`: a `RSKernelDensity` object that made the calculation of the Kernel Density Estimation, several parametres are passed to this object to personalize the curve (bandwidth, kernel, etc.).
- `title`: aString that stores the title of the chart.
- `xlabel`:	aString that stores the label of x axis.
- `ylabel`: aString that stores the label of y axis.

**Example:**
```Smalltalk
| densityPlot data |
data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
densityPlot := RSDensityPlot data: data.
densityPlot bandwidth: 10.
densityPlot xlabel: 'X label'; ylabel: 'Y label'; title: 'Density plot (bandwidth:10)'.
densityPlot color: Color green.
densityPlot open.
```
"
Class {
	#name : 'RSDensityPlot',
	#superclass : 'RSAbstractPlot',
	#instVars : [
		'kernelDensity',
		'curvePoints',
		'area'
	],
	#category : 'Roassal-Chart-Core',
	#package : 'Roassal-Chart',
	#tag : 'Core'
}

{ #category : 'accessing' }
RSDensityPlot class >> data: aCollection [
	| densityPlot |
	densityPlot := self new.
	densityPlot data: aCollection.
	^ densityPlot
]

{ #category : 'examples' }
RSDensityPlot class >> exampleBasicDensityPlot [
	| densityPlot data |
	data := #(14 15 28 27 32 35).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open
]

{ #category : 'examples' }
RSDensityPlot class >> exampleBasicDensityPlot2 [
	| densityPlot data |
	data := #(5 5 5 45 45 45).
	densityPlot := self data: data.
	densityPlot bandwidth: 4.
	^ densityPlot open
]

{ #category : 'examples' }
RSDensityPlot class >> exampleBasicDensityPlot3 [
	| densityPlot data |
	data := #(10 10 10 10).
	densityPlot := self data: data.
"	densityPlot bandwidth: 4."
	^ densityPlot open
]

{ #category : 'examples' }
RSDensityPlot class >> exampleBasicDensityPlot4 [
	| densityPlot data |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	densityPlot := self data: data.
	densityPlot bandwidth: 10.
	^ densityPlot open
]

{ #category : 'examples' }
RSDensityPlot class >> exampleBasicDensityPlot5 [
	| densityPlot data |
	data := #(0.1 0.05 0.05 0.08).
	densityPlot := self data: data.
	densityPlot bandwidth." -0.02545046473618206"
"	densityPlot bandwidth: 4."
	^ densityPlot open
]

{ #category : 'examples' }
RSDensityPlot class >> exampleDensityPlotCreateWithKernelDesity [
	| densityPlot data kernelDensity |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	kernelDensity := RSKernelDensity data: data.
	kernelDensity bandwidth: 10.
	densityPlot := self kernelDensity: kernelDensity.
	densityPlot shape
		color: Color blue translucent;
		border: (RSBorder new
			color: Color red;
			width: 2;
			dashArray: #(2 4)).
	^ densityPlot open
]

{ #category : 'examples' }
RSDensityPlot class >> exampleDensityPlotWithLabels [
	| densityPlot data |
	data := #(-25 -25 -25 -25 10 20 30 40 50 50 50 50 ).
	densityPlot := self data: data.
	densityPlot bandwidth: 10.
	densityPlot xlabel: 'X label'; ylabel: 'Y label'; title: 'Density plot (bandwidth:10)'.
	^ densityPlot open
]

{ #category : 'accessing' }
RSDensityPlot class >> kernelDensity: anRSKernelDensity [
	| densityPlot |
	densityPlot := self new.
	densityPlot kernelDensity: anRSKernelDensity.
	^ densityPlot
]

{ #category : 'accessing' }
RSDensityPlot >> area [
	^ area
]

{ #category : 'accessing' }
RSDensityPlot >> areaColor [
	^ self computeColor
]

{ #category : 'accessing' }
RSDensityPlot >> bandwidth [
	^ kernelDensity bandwidth
]

{ #category : 'accessing' }
RSDensityPlot >> bandwidth: aNumber [
	kernelDensity bandwidth: aNumber.
	self computeCurvePoints
]

{ #category : 'private' }
RSDensityPlot >> computeCurvePoints [
	| ys yMax |
	curvePoints := kernelDensity densityCurve.
	xValues := { curvePoints first x. curvePoints last x. }.
	ys := curvePoints collect: [ :point | point y ].
	yMax := ys max.
	yValues := {0. yMax. }
]

{ #category : 'accessing' }
RSDensityPlot >> createdShapes [
	^ { area }
]

{ #category : 'accessing' }
RSDensityPlot >> curvePoints [
	^ curvePoints
]

{ #category : 'accessing' }
RSDensityPlot >> data [
	^ kernelDensity data
]

{ #category : 'accessing' }
RSDensityPlot >> data: aCollection [
	kernelDensity data: aCollection.
	self computeCurvePoints
]

{ #category : 'defaults' }
RSDensityPlot >> defaultAreaColor [
	^ area color
]

{ #category : 'defaults' }
RSDensityPlot >> defaultKernelDensity [
	^ RSKernelDensity new
]

{ #category : 'defaults' }
RSDensityPlot >> defaultLineColor [
	^ Color r:117 g:107 b:177 range: 255
]

{ #category : 'accessing - defaults' }
RSDensityPlot >> defaultShape [
	^ RSPolygon new
		noPaint
]

{ #category : 'initialization' }
RSDensityPlot >> initialize [
	super initialize.
	kernelDensity := self defaultKernelDensity
]

{ #category : 'accessing' }
RSDensityPlot >> kde: aNumber [
	^ kernelDensity kde: aNumber
]

{ #category : 'accessing' }
RSDensityPlot >> kernel [
	^ kernelDensity kernel
]

{ #category : 'accessing' }
RSDensityPlot >> kernel: anRSKernelFunction [
	kernelDensity kernel: anRSKernelFunction.
	self computeCurvePoints
]

{ #category : 'accessing' }
RSDensityPlot >> kernelDensity [
	^ kernelDensity
]

{ #category : 'accessing' }
RSDensityPlot >> kernelDensity: anRSKernelDensity [
	kernelDensity := anRSKernelDensity.
	self computeCurvePoints
]

{ #category : 'rendering' }
RSDensityPlot >> renderIn: canvas [
	| curve firstPoint lastPoint closingPointStart closingPointEnd |
	super renderIn: canvas.
	area := self shape copy.
	area color: self computeColor.
	firstPoint := curvePoints first.
	lastPoint := curvePoints last.
	closingPointStart := firstPoint x @ 0.
	closingPointEnd := lastPoint x @ 0.
	curve := curvePoints copy.
	curve addFirst: closingPointStart.
	curve add: closingPointEnd.
	lastPoint := curve last.
	area points: (curve collect: [ :aPoint | self scalePoint: aPoint ]).
	canvas add: area
]
