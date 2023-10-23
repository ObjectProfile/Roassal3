Class {
	#name : 'RSWrapLabelTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Wrap',
	#package : 'Roassal-Global-Tests',
	#tag : 'Wrap'
}

{ #category : 'tests' }
RSWrapLabelTest >> testWrapStrategyShouldNotProduceDuplicateLabels [
	| labelBuilder labels line |
	labelBuilder := RSMultilineLabelBuilder new.
	labelBuilder wrapStrategy: (RSWrapStrategy new wrapMaxWidth: 100).
	line := 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'.
	labels := labelBuilder wrapStrategy wrapLineShapesFor: line with: labelBuilder.
	self assert: labels size equals: labels asSet size
]
