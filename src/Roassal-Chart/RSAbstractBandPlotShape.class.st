Class {
	#name : 'RSAbstractBandPlotShape',
	#superclass : 'RSComposite',
	#instVars : [
		'color',
		'bandOffset',
		'bandWidth',
		'dataScale',
		'bandScale',
		'horizontal',
		'shouldShowBand'
	],
	#category : 'Roassal-Chart-Plots',
	#package : 'Roassal-Chart',
	#tag : 'Plots'
}

{ #category : 'rendering' }
RSAbstractBandPlotShape >> addChildrenToComposite [
	| shapesToRender |
	shapesToRender := self shapesToRender.
	self addAll: shapesToRender.
	self adjustToChildren.
	^ self
]

{ #category : 'band' }
RSAbstractBandPlotShape >> bandOffset: aNumber [
	bandOffset := aNumber
]

{ #category : 'scales' }
RSAbstractBandPlotShape >> bandScale [
	^ bandScale
]

{ #category : 'scales' }
RSAbstractBandPlotShape >> bandScale: aNSScale [
	bandScale := aNSScale
]

{ #category : 'band' }
RSAbstractBandPlotShape >> bandWidth: aNumber [
	bandWidth := aNumber
]

{ #category : 'accessing' }
RSAbstractBandPlotShape >> color [
	^ color
]

{ #category : 'accessing' }
RSAbstractBandPlotShape >> color: aColor [
	color := aColor
]

{ #category : 'shapes' }
RSAbstractBandPlotShape >> computeBandRectangle [
	^ RSPolygon new
			points: {
			(bandOffset-(bandWidth/2)) @ dataScale range first.
			(bandOffset+(bandWidth/2)) @ dataScale range first.
			(bandOffset+(bandWidth/2)) @ dataScale range last.
			(bandOffset-(bandWidth/2)) @ dataScale range last
			};
			color: Color blue translucent
]

{ #category : 'shapes' }
RSAbstractBandPlotShape >> createShapesAndLines [
	^ self subclassResponsibility
]

{ #category : 'scales' }
RSAbstractBandPlotShape >> dataScale [
	^ dataScale
]

{ #category : 'scales' }
RSAbstractBandPlotShape >> dataScale: aNSScale [
	dataScale := aNSScale
]

{ #category : 'defaults' }
RSAbstractBandPlotShape >> defaultShouldShowBand [
	^ false
]

{ #category : 'public' }
RSAbstractBandPlotShape >> horizontal [
	horizontal := true
]

{ #category : 'rendering' }
RSAbstractBandPlotShape >> maxDataValue [
	^ self subclassResponsibility
]

{ #category : 'rendering' }
RSAbstractBandPlotShape >> minDataValue [
	^ self subclassResponsibility
]

{ #category : 'rendering' }
RSAbstractBandPlotShape >> renderIn: canvas [
	^ self subclassResponsibility
]

{ #category : 'rendering' }
RSAbstractBandPlotShape >> shapesToRender [
	| shapesAndLines band |
	shapesAndLines := self createShapesAndLines.
	shouldShowBand ifTrue: [
		band := self computeBandRectangle.
		shapesAndLines add: band ].
	horizontal ifTrue: [ shapesAndLines do: [ :s | s invert ] ].
	^ shapesAndLines
]

{ #category : 'band' }
RSAbstractBandPlotShape >> shouldShowBand: aBoolean [
	shouldShowBand := aBoolean
]

{ #category : 'public' }
RSAbstractBandPlotShape >> showBand [
	self shouldShowBand: true
]

{ #category : 'public' }
RSAbstractBandPlotShape >> vertical [
	horizontal := false
]
