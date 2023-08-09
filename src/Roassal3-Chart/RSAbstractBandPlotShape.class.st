Class {
	#name : #RSAbstractBandPlotShape,
	#superclass : #RSComposite,
	#instVars : [
		'color',
		'bandOffset',
		'bandWidth',
		'dataScale',
		'bandScale',
		'horizontal',
		'shouldShowBand'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSAbstractBandPlotShape >> addChildrenToComposite [
	| shapesToRender |
	shapesToRender := self shapesToRender.
	self addAll: shapesToRender.
	self adjustToChildren.
	^ self.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> bandOffset: aNumber [
	bandOffset := aNumber.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> bandScale [
	^ bandScale.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> bandScale: aNSScale [
	bandScale := aNSScale
]

{ #category : #accessing }
RSAbstractBandPlotShape >> bandWidth: aNumber [
	bandWidth := aNumber
]

{ #category : #accessing }
RSAbstractBandPlotShape >> color [
	^ color
]

{ #category : #accessing }
RSAbstractBandPlotShape >> color: aColor [
	color := aColor.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> computeBandRectangle [
	^ RSPolygon new
			points: { 
			(bandOffset-(bandWidth/2)) @ dataScale range first. 
			(bandOffset+(bandWidth/2)) @ dataScale range first.
			(bandOffset+(bandWidth/2)) @ dataScale range last. 
			(bandOffset-(bandWidth/2)) @ dataScale range last
			};
			color: Color blue translucent.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> createShapesAndLines [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBandPlotShape >> dataScale [
	^ dataScale.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> dataScale: aNSScale [
	dataScale := aNSScale
]

{ #category : #public }
RSAbstractBandPlotShape >> horizontal [
	horizontal := true.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> maxYValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBandPlotShape >> minYValue [
	^ self subclassResponsibility
]

{ #category : #rendering }
RSAbstractBandPlotShape >> renderIn: canvas [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBandPlotShape >> shapesToRender [
	| shapesAndLines band |
	shapesAndLines := self createShapesAndLines.
	shouldShowBand ifTrue: [
		band := self computeBandRectangle.
		shapesAndLines add: band ].
	horizontal ifTrue: [ shapesAndLines do: [ :s | s invert ] ].
	^ shapesAndLines
]

{ #category : #accessing }
RSAbstractBandPlotShape >> shouldShowBand: aBoolean [
	shouldShowBand := aBoolean.
]

{ #category : #accessing }
RSAbstractBandPlotShape >> showBand [
	self shouldShowBand: true.
]

{ #category : #public }
RSAbstractBandPlotShape >> vertical [
	horizontal := false.
]
