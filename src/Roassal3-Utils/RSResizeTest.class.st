Class {
	#name : #RSResizeTest,
	#superclass : #TestCase,
	#instVars : [
		'resize',
		'shapes'
	],
	#category : #'Roassal3-Utils-Tests'
}

{ #category : #running }
RSResizeTest >> setUp [
	super setUp.
	shapes := (1 to: 3) collect: [ :o | 
		TSBox new
			height: o;
			width: o + 1;
			yourself ].
	resize := RSResize new.
	resize shapes: shapes.
]

{ #category : #tests }
RSResizeTest >> testBiggestElement [
	self assert: resize biggestShape equals: shapes last.
	resize useBiggestShape.
	self assert: resize fixedShape equals: shapes last.
]

{ #category : #tests }
RSResizeTest >> testBiggestExtent [
	self assert: resize biggestExtent equals: 4 @ 3
]

{ #category : #tests }
RSResizeTest >> testHighestElement [
	self assert: resize highestShape equals: shapes last.

]

{ #category : #tests }
RSResizeTest >> testSameHeight [
	resize fixedShape: shapes second.
	resize sameHeight.
	self assert: (shapes collect: #extent) sorted asArray equals: (Array with: (2.0@2.0) with: (3.0@2.0) with: (4.0@2.0))
]

{ #category : #tests }
RSResizeTest >> testSameSize [
	resize fixedShape: shapes second.
	resize sameSize.
	self assert: (shapes collect: #extent) asSet asArray equals: (Array with: (3.0@2.0))
]

{ #category : #tests }
RSResizeTest >> testSameSizeWithoutFixedElement [
	resize sameSize.
	self assert: (shapes collect: #extent) asSet asArray equals: (Array with: (4.0 @ 3.0))
]

{ #category : #tests }
RSResizeTest >> testSameWidth [
	resize fixedShape: shapes second.
	resize sameWidth.
	self assert: (shapes collect: #extent) sorted asArray equals: (Array with: (3.0@1.0) with:(3.0@2.0) with: (3.0@3.0))
]

{ #category : #tests }
RSResizeTest >> testWidestElement [
	self assert: resize widestElement equals: shapes last.

]
