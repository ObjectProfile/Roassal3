Class {
	#name : 'RSViolinPlotShape',
	#superclass : 'RSAbstractBandPlotShape',
	#instVars : [
		'boxPlotShape',
		'kernelDensity',
		'densityArea'
	],
	#category : 'Roassal-Chart-Plots',
	#package : 'Roassal-Chart',
	#tag : 'Plots'
}

{ #category : 'accessing' }
RSViolinPlotShape class >> data: collectionOfData1D [
	| violinShape |
	violinShape := self new.
	violinShape data: collectionOfData1D.
	^ violinShape
]

{ #category : 'initialization' }
RSViolinPlotShape >> area [
	^ densityArea
]

{ #category : 'band' }
RSViolinPlotShape >> bandOffset: aNumber [
	super bandOffset: aNumber.
	boxPlotShape bandOffset: bandOffset
]

{ #category : 'scales' }
RSViolinPlotShape >> bandScale: aNSScale [
	super bandScale: aNSScale.
	boxPlotShape bandScale: aNSScale
]

{ #category : 'band' }
RSViolinPlotShape >> bandWidth: aNumber [
	super bandWidth: aNumber.
	boxPlotShape bandWidth: bandWidth*0.1.
	boxPlotShape outlierSize: (bandWidth*0.05) abs
]

{ #category : 'border' }
RSViolinPlotShape >> border [
	^ densityArea border
]

{ #category : 'border' }
RSViolinPlotShape >> borderColor: aColor [
	^ self border color: aColor
]

{ #category : 'accessing' }
RSViolinPlotShape >> color [
	^ color ifNil: [ densityArea color ]
]

{ #category : 'shapes' }
RSViolinPlotShape >> createShapesAndLines [
	| shapes |
	densityArea := self densityArea.
	boxPlotShape color: Color white.
	shapes := OrderedCollection withAll: { densityArea. }.
	shapes addAll: boxPlotShape shapesToRender.
	^ shapes
]

{ #category : 'accessing' }
RSViolinPlotShape >> data [
	^ kernelDensity data
]

{ #category : 'accessing' }
RSViolinPlotShape >> data: dataset [
	| aCollection |
	aCollection := dataset rsValue: model.
	kernelDensity data: aCollection.
	boxPlotShape data: aCollection
]

{ #category : 'scales' }
RSViolinPlotShape >> dataScale: aNSScale [
	super dataScale: aNSScale.
	boxPlotShape dataScale: aNSScale
]

{ #category : 'accessing' }
RSViolinPlotShape >> dataSorted [
	^ boxPlotShape data
]

{ #category : 'defaults' }
RSViolinPlotShape >> defaultBoxPlotShape [
	^ RSBoxPlotShape new
]

{ #category : 'defaults' }
RSViolinPlotShape >> defaultDensityArea [
	^ RSPolygon new
		noPaint
		borderColor: Color black
]

{ #category : 'defaults' }
RSViolinPlotShape >> defaultKernelDensity [
	"Check the default Kernel function in RSKernelDensity >> defaultKernel (by default a gaussian function)"
	^ RSKernelDensity new
]

{ #category : 'initialization' }
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
		((bandWidth/2 * point x)+bandOffset)@(dataScale scale: point y)
	 ].
	densityCurve reverseDo: [ :point |
		densityAreaPoints add: (bandOffset-(bandWidth/2 * point x))@(dataScale scale: point y)
	].

	densityArea points: densityAreaPoints.
	color := color ifNil: [ densityArea color ].
	densityArea color: color.
	^ densityArea
]

{ #category : 'private' }
RSViolinPlotShape >> errorMargin: aNumber [
	kernelDensity errorMargin: aNumber
]

{ #category : 'initialization' }
RSViolinPlotShape >> initialize [
	super initialize.
	kernelDensity := self defaultKernelDensity.
	boxPlotShape := self defaultBoxPlotShape.
	densityArea := self defaultDensityArea.
	horizontal := false.
	shouldShowBand := false
]

{ #category : 'accessing - attributes' }
RSViolinPlotShape >> kernelBandwidth: aNumber [
	kernelDensity bandwidth: aNumber
]

{ #category : 'rendering' }
RSViolinPlotShape >> maxDataValue [
	| maxYValueOfCurve |
	maxYValueOfCurve := (kernelDensity densityCurve collect: [ :point | point x ]) max.
	^ boxPlotShape maxDataValue max: maxYValueOfCurve
]

{ #category : 'accessing' }
RSViolinPlotShape >> medianLine [
	^ boxPlotShape medianLine
]

{ #category : 'shapes' }
RSViolinPlotShape >> medianLine: aRSLineModel [
	boxPlotShape medianLine: aRSLineModel copy
]

{ #category : 'rendering' }
RSViolinPlotShape >> minDataValue [
	| minYValueOfCurve |
	minYValueOfCurve := (kernelDensity densityCurve collect: [ :point | point x ]) min.
	^ boxPlotShape minDataValue min: minYValueOfCurve
]

{ #category : 'accessing - attributes' }
RSViolinPlotShape >> model: aModel [
	super model: aModel.
	boxPlotShape model: aModel
]

{ #category : 'initialization' }
RSViolinPlotShape >> outlierSize: aDimensionInPixels [
	boxPlotShape outlierSize: aDimensionInPixels
]

{ #category : 'rendering' }
RSViolinPlotShape >> renderIn: canvas [
	self addChildrenToComposite.
	canvas add: self.
	^ canvas
]

{ #category : 'initialization' }
RSViolinPlotShape >> scalePoint: aPoint [
	^ (bandScale scale: aPoint x) @ (dataScale scale: aPoint y)
]

{ #category : 'initialization' }
RSViolinPlotShape >> scales: collectionOfNSScales [
	self bandScale: collectionOfNSScales first.
	self dataScale: collectionOfNSScales second.
	boxPlotShape bandScale: collectionOfNSScales first.
	boxPlotShape dataScale: collectionOfNSScales second
]
