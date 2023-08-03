Class {
	#name : #RSViolinPlotShape,
	#superclass : #RSComposite,
	#instVars : [
		'boxPlotShape',
		'dataModel',
		'kernelDensity',
		'densityArea',
		'color',
		'xScale',
		'yScale',
		'bandOffset',
		'bandWidth'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSViolinPlotShape class >> data: collectionOfData1D [
	| violinShape |
	violinShape := self new.
	violinShape data: collectionOfData1D.
	^ violinShape
]

{ #category : #accessing }
RSViolinPlotShape >> bandOffset: aNumber [
	bandOffset := aNumber.
	boxPlotShape bandOffset: bandOffset.
]

{ #category : #accessing }
RSViolinPlotShape >> bandWidth: aNumber [
	bandWidth := aNumber.
	boxPlotShape bandWidth: bandWidth*0.1.
	boxPlotShape outlierSize: bandWidth*0.05.
]

{ #category : #accessing }
RSViolinPlotShape >> border [
	^ densityArea border.
]

{ #category : #styling }
RSViolinPlotShape >> borderColor: aColor [
	^ self border color: aColor.
]

{ #category : #initialization }
RSViolinPlotShape >> color [
	^ color
]

{ #category : #initialization }
RSViolinPlotShape >> color: aColor [
	color := aColor
]

{ #category : #accessing }
RSViolinPlotShape >> data [
	^ kernelDensity data.
]

{ #category : #accessing }
RSViolinPlotShape >> data: dataset [
	| aCollection |
	aCollection := dataset rsValue: model.
	kernelDensity data: aCollection.
	boxPlotShape data: aCollection.
]

{ #category : #initialization }
RSViolinPlotShape >> dataModel: aModel [
	dataModel := aModel
]

{ #category : #accessing }
RSViolinPlotShape >> dataSorted [
	^ boxPlotShape data.
]

{ #category : #defaults }
RSViolinPlotShape >> defaultBoxPlotShape [
	^ RSBoxPlotShape new.
]

{ #category : #defaults }
RSViolinPlotShape >> defaultDensityArea [
	^ RSPolygon new
		noPaint
		borderColor: Color black.
]

{ #category : #defaults }
RSViolinPlotShape >> defaultKernelDensity [
	"Check the default Kernel function in RSKernelDensity >> defaultKernel (by default a gaussian function)"
	^ RSKernelDensity new.
]

{ #category : #initialization }
RSViolinPlotShape >> densityArea [
	| densityCurve densityAreaPoints maxX minX |
	
	"invert x and y"
	densityCurve := (kernelDensity densityCurve) collect: [:point | 
		(point y @ point x)
	].

	"normalize x"
	maxX := (densityCurve collect: [ :point | point x ]) max.
	minX := (densityCurve collect: [ :point | point x ]) min.
	densityCurve := densityCurve collect: [:point | 
		| normalizedX |
		normalizedX := ((point x)-minX)/(maxX - minX).
		((normalizedX) @ point y)
	].
	
	
	densityAreaPoints := densityCurve copy.
	densityAreaPoints := densityAreaPoints collect: [ :point |
		((bandWidth/2 * point x)+bandOffset)@(yScale scale: point y)
	 ].
	densityCurve reversed do: [ :point | 
		densityAreaPoints add: (bandOffset-(bandWidth/2 * point x))@(yScale scale: point y)
		"((point x * -1) @ point y) "
	].
	
	
	densityArea points: densityAreaPoints.
	densityArea color: color.
	^ densityArea
]

{ #category : #initialization }
RSViolinPlotShape >> initialize [
	super initialize.
	kernelDensity := self defaultKernelDensity.
	boxPlotShape := self defaultBoxPlotShape.
	densityArea := self defaultDensityArea.
]

{ #category : #defaults }
RSViolinPlotShape >> kernelBandwidth: aNumber [
	kernelDensity bandwidth: aNumber.
]

{ #category : #initialization }
RSViolinPlotShape >> maxYValue [
	| maxYValueOfCurve |
	maxYValueOfCurve := (kernelDensity densityCurve collect: [ :point | point x ]) max.
	^ boxPlotShape maxYValue max: maxYValueOfCurve.
]

{ #category : #initialization }
RSViolinPlotShape >> minYValue [
	| minYValueOfCurve |
	minYValueOfCurve := (kernelDensity densityCurve collect: [ :point | point x ]) min.
	^ boxPlotShape minYValue min: minYValueOfCurve.
]

{ #category : #initialization }
RSViolinPlotShape >> outlierSize: aDimensionInPixels [
	boxPlotShape outlierSize: aDimensionInPixels.
]

{ #category : #initialization }
RSViolinPlotShape >> renderIn: canvas [
	| shapes |
	self model: dataModel.
	shapes := self shapesToRender.
	shapes do: [ :aShape |
		aShape isCollection ifTrue: [ self addAll: aShape ]
		ifFalse: [ self add: aShape ].
	].
	self adjustToChildren.
	canvas add: self.
	boxPlotShape color: Color white.
	boxPlotShape renderIn: canvas.
	^ canvas.
]

{ #category : #initialization }
RSViolinPlotShape >> scalePoint: aPoint [
	^ (xScale scale: aPoint x) @ (yScale scale: aPoint y)
]

{ #category : #initialization }
RSViolinPlotShape >> scales: collectionOfNSScales [
	self xScale: collectionOfNSScales first.
	self yScale: collectionOfNSScales second.
	boxPlotShape scales: collectionOfNSScales.
]

{ #category : #initialization }
RSViolinPlotShape >> shapesToRender [
	densityArea := self densityArea.
	^ { densityArea. }.
]

{ #category : #initialization }
RSViolinPlotShape >> xScale: aNSScale [
	xScale := aNSScale.
]

{ #category : #initialization }
RSViolinPlotShape >> yScale: aNSScale [
	yScale := aNSScale
]
