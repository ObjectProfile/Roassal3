Class {
	#name : 'RSPBoundingTest',
	#superclass : 'ParametrizedTestCase',
	#instVars : [
		'shapeClass',
		'canvas'
	],
	#category : 'Roassal-Shapes-Tests',
	#package : 'Roassal-Shapes-Tests'
}

{ #category : 'building suites' }
RSPBoundingTest class >> testParameters [
	| m classesToConsider |
	m := ParametrizedTestMatrix new.
	classesToConsider := RSBoundingShape allSubclasses select: [ :c | c isAbstract not ].
	classesToConsider do: [ :cls |
		m addCase: { (#shapeClass -> cls) }
	].
	^ m
]

{ #category : 'running' }
RSPBoundingTest >> setUp [
	super setUp.
	canvas := RSCanvas new
]

{ #category : 'accessing' }
RSPBoundingTest >> shapeClass [
	^ shapeClass
]

{ #category : 'accessing' }
RSPBoundingTest >> shapeClass: aShapeClass [
	shapeClass := aShapeClass
]

{ #category : 'tests' }
RSPBoundingTest >> testDraw [
	canvas addShape: (self shapeClass new extent: 50 @ 50).
	canvas createMorph drawOnMockCanvas
]

{ #category : 'tests' }
RSPBoundingTest >> testDrawBorder [
	canvas addShape: (self shapeClass new
		extent: 100 @ 100;
		withBorder;
		yourself).
	canvas createMorph drawOnMockCanvas
]

{ #category : 'tests' }
RSPBoundingTest >> testPosition [
	| b |
	b := self shapeClass new.
	self assert: b position equals: 0@0.
	b position: 0@0
]
