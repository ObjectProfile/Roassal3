Class {
	#name : #RSAbstractBandPlotShape,
	#superclass : #RSComposite,
	#instVars : [
		'color',
		'bandOffset',
		'bandWidth',
		'dataScale',
		'bandScale',
		'horizontal'
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

{ #category : #public }
RSAbstractBandPlotShape >> renderIn: canvas [
	^ self subclassResponsibility
]

{ #category : #public }
RSAbstractBandPlotShape >> vertical [
	horizontal := false.
]
