"
I am a heatmap, based on requirements of issue #562
"
Class {
	#name : 'RSHeatmap',
	#superclass : 'RSDSM',
	#instVars : [
		'dataMatrix',
		'colorPalette',
		'shouldShowCellLabels',
		'labelShapeCell',
		'gradientLegend'
	],
	#category : 'Roassal-DSM-Core',
	#package : 'Roassal-DSM',
	#tag : 'Core'
}

{ #category : 'public' }
RSHeatmap >> colorPalette [
	^ colorPalette
]

{ #category : 'public' }
RSHeatmap >> colorPalette: anNSLinearScale [
	colorPalette := anNSLinearScale
]

{ #category : 'hooks' }
RSHeatmap >> computeColor: aNumberInDataMatrix [
	^ colorPalette scale: aNumberInDataMatrix
]

{ #category : 'private' }
RSHeatmap >> computeDomain [
	| allNumbers|
	allNumbers := dataMatrix flatCollect: #yourself.
	^ { allNumbers min. allNumbers max }
]

{ #category : 'hooks' }
RSHeatmap >> createGradienBox [
	| row range box paint |
	row := (self rowAt: 1) asGroup.
	box := RSBox new
		extent: row width * 0.3 @ shape height;
		yourself.
	range := colorPalette range.
	paint := LinearGradientPaint fromArray: {0->range first. 1-> range last}.
	paint leftRight: box.
	^ box
]

{ #category : 'hooks' }
RSHeatmap >> createGradientLegend [
	| domain lb minLabel maxLabel box group legend lastRow |
	domain := colorPalette domain.
	lb := self labelShapeCell.
	minLabel := lb shapeFor: domain first.
	maxLabel := lb shapeFor: domain last.
	box := self createGradienBox.
	group := { minLabel. box. maxLabel }.
	RSHorizontalLineLayout new alignMiddle; on: group.
	legend := group asShape.
	lastRow := (self rowAt: self numberOfRows) asGroup.
	RSLocation new
		outer;
		bottom;
		right;
		orientation: 1@ -1; move: legend on: lastRow.
	^ legend
]

{ #category : 'hooks' }
RSHeatmap >> createShape: tuple [
	| box |
	box := shape copy.
	self shouldShowCellLabels ifFalse: [ ^ box model: tuple; yourself ].
	^ { box } asShape
		model: tuple;
		yourself
]

{ #category : 'public' }
RSHeatmap >> dataMatrix [
	^ dataMatrix
]

{ #category : 'public' }
RSHeatmap >> dataMatrix: aMatrix [
	self assert: aMatrix notEmpty description: 'you need data in your matrix'.
	self assert: (aMatrix allSatisfy: [ :each | each notEmpty ]) description: 'you do not have data in your rows'.
	self assert: (aMatrix collect: [ :each | each size ] as: Set) size = 1 description: 'All rows in the matrix should have the same size'.
	dataMatrix := aMatrix.
	colorPalette domain: self computeDomain
]

{ #category : 'defaults' }
RSHeatmap >> defaultColorPalette [
	^ NSScale linear range: (#('EFF3FF' '08519C') collect: [ :each | Color colorFrom: each ])
]

{ #category : 'accessing' }
RSHeatmap >> gradientLegend [
	^ gradientLegend
]

{ #category : 'initialization' }
RSHeatmap >> initialize [
	super initialize.
	self colorPalette: self defaultColorPalette.
	self shouldShowCellLabels: true.
	self labelShapeCell: RSMultilineLabelBuilder new
]

{ #category : 'accessing' }
RSHeatmap >> labelShapeCell [
	^ labelShapeCell
]

{ #category : 'accessing' }
RSHeatmap >> labelShapeCell: aBlock [
	labelShapeCell := aBlock
]

{ #category : 'hooks' }
RSHeatmap >> newLabelFor: aComposite [
	| position |
	position := aComposite propertyAt: self matrixKey.
	^ self labelShapeCell shapeFor: ((dataMatrix at: position y) at: position x)
]

{ #category : 'rendering' }
RSHeatmap >> renderIn: aCanvas [
	super renderIn: aCanvas.
	gradientLegend := self createGradientLegend.
	aCanvas add: gradientLegend
]

{ #category : 'hooks' }
RSHeatmap >> setUpShape: aComposite [
	| label matrixIndex value box |
	super setUpShape: aComposite.
	matrixIndex := aComposite propertyAt: self matrixKey.
	value := (dataMatrix at: matrixIndex y) at: matrixIndex x.
	self shouldShowCellLabels ifTrue: [
		label := self newLabelFor: aComposite.
		aComposite add: label.
	].
	box := self shouldShowCellLabels
		ifTrue: [ aComposite children first]
		ifFalse: [ aComposite ].
	box color: (self color cull: value)
]

{ #category : 'accessing' }
RSHeatmap >> shouldShowCellLabels [
	^ shouldShowCellLabels
]

{ #category : 'accessing' }
RSHeatmap >> shouldShowCellLabels: aBoolean [
	shouldShowCellLabels := aBoolean
]
