Class {
	#name : #RSResizeTest,
	#superclass : #TestCase,
	#instVars : [
		'elements',
		'resize'
	],
	#category : #'Roassal3-Utils-Tests'
}

{ #category : #running }
RSResizeTest >> setUp [
	super setUp.
	elements := (RSShapeBuilder box height: #yourself; width: [ :o | o + 1 ]) elementsOn: (1 to: 3).
	resize := RSResize new.
	resize elements: elements.
]

{ #category : #tests }
RSResizeTest >> testBiggestElement [
	self assert: resize biggestElement equals: elements last.
	resize useBiggestElement.
	self assert: resize fixedElement equals: elements last.
]

{ #category : #tests }
RSResizeTest >> testBiggestExtent [
	self assert: resize biggestExtent equals: 4 @ 3
]

{ #category : #tests }
RSResizeTest >> testHighestElement [
	self assert: resize highestElement equals: elements last.

]

{ #category : #tests }
RSResizeTest >> testSameHeight [
	resize fixedElement: elements second.
	resize sameHeight.
	self assert: (elements collect: #extent) sorted asArray equals: (Array with: (2.0@2.0) with: (3.0@2.0) with: (4.0@2.0))
]

{ #category : #tests }
RSResizeTest >> testSameSize [
	resize fixedElement: elements second.
	resize sameSize.
	self assert: (elements collect: #extent) asSet asArray equals: (Array with: (3.0@2.0))
]

{ #category : #tests }
RSResizeTest >> testSameSizeWithoutFixedElement [
	resize sameSize.
	self assert: (elements collect: #extent) asSet asArray equals: (Array with: (4.0 @ 3.0))
]

{ #category : #tests }
RSResizeTest >> testSameWidth [
	resize fixedElement: elements second.
	resize sameWidth.
	self assert: (elements collect: #extent) sorted asArray equals: (Array with: (3.0@1.0) with:(3.0@2.0) with: (3.0@3.0))
]

{ #category : #tests }
RSResizeTest >> testWidestElement [
	self assert: resize widestElement equals: elements last.

]
