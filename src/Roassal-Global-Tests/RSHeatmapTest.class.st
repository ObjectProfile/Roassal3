Class {
	#name : 'RSHeatmapTest',
	#superclass : 'RSTest',
	#instVars : [
		'builder'
	],
	#category : 'Roassal-Global-Tests-DSM',
	#package : 'Roassal-Global-Tests',
	#tag : 'DSM'
}

{ #category : 'running' }
RSHeatmapTest >> setUp [
	super setUp.
	builder := RSHeatmap new
]

{ #category : 'tests' }
RSHeatmapTest >> testBuildCreateCompositeShapes [
	| cell |
	builder objectsX: #('A' 'B' 'C').
	builder objectsY: #('tomato' 'pumpkin').
   builder dataMatrix: #(#(1 2 5) #(3 4 6)).
	builder build.
	cell := builder shapeAt: 1@1.
	self assert: cell isComposite.
	self assert: cell children size equals: 2.
	self assert: cell children first class equals: RSBox.
	self assert: cell children second class equals: RSLabel
]

{ #category : 'tests' }
RSHeatmapTest >> testDataMatrixArrayShouldNotBeEmpty [
	self should: [builder dataMatrix: {{}. {}. {}}] raise: Error
]

{ #category : 'tests' }
RSHeatmapTest >> testDataMatrixShouldHaveTheSameSize [
	self should: [builder dataMatrix: {{100. 200}. {100. 200. 300}. {100}}] raise: Error
]

{ #category : 'tests' }
RSHeatmapTest >> testDataMatrixShouldNotBeEmpty [
	self should: [builder dataMatrix: #()] raise: Error
]

{ #category : 'tests' }
RSHeatmapTest >> testHeatmapContainsAGradientLegend [
	| legend |
	builder objectsX: #('A' 'B' 'C').
	builder objectsY: #('tomato' 'pumpkin').
   builder dataMatrix: #(#(1 2 5) #(3 4 6)).
	builder build.
	legend := builder gradientLegend.
	self assert: legend isComposite.
	self assert: legend children first isLabel.
	self assert: legend children second class equals: RSBox.
	self assert: legend children third isLabel
]

{ #category : 'tests' }
RSHeatmapTest >> testShouldShowCellLabelsIsTrue [
	self assert: builder shouldShowCellLabels
]
