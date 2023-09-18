Class {
	#name : #RSLocationTest,
	#superclass : #TestCase,
	#instVars : [
		'shape',
		'target',
		'canvas'
	],
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #running }
RSLocationTest >> setUp [
	super setUp.

	shape := RSBox new size: 10 asPoint; position: 0 asPoint.
	shape color: Color blue.
	target := RSBox new size: 20 asPoint; position: 0 asPoint.
	canvas := RSCanvas new.
	canvas add: target; add: shape.
]

{ #category : #tests }
RSLocationTest >> testAbove [
	RSLocation new above; move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: 0 @ -15
]

{ #category : #tests }
RSLocationTest >> testAboveRectangle [
	RSLocation new above; move: shape on: (0 asPoint corner: 50 asPoint).
	self assert: shape position equals: 25 @ -5
]

{ #category : #tests }
RSLocationTest >> testBasic [
	| location |
	location := RSLocation new.
	self assert: shape extent equals: 10 asPoint.
	self assert: target extent equals: 20 asPoint.

	self assert: shape position equals: 0 asPoint.
	self assert: target position equals: 0 asPoint.

	location move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: 0 asPoint
]

{ #category : #tests }
RSLocationTest >> testBelow [

	RSLocation new below ; move: shape on: target.

	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: 0 @ 15
]

{ #category : #tests }
RSLocationTest >> testInComposite [
	| composite |
	canvas := RSCanvas new.
	composite := { target } asShape padding: 5.
	composite position: 10@10.
	canvas add: composite.
	canvas add: shape.

	self assert: composite extent equals: (20+(5*2)) asPoint.

	RSLocation new move: shape on: target.
	self assert: shape parent equals: canvas.
	self assert: target parent equals: composite.
	self assert: composite parent equals: canvas.
	self assert: shape position equals: 0@0
]

{ #category : #tests }
RSLocationTest >> testInComposite2 [
	| composite |
	canvas := RSCanvas new.
	composite := { target. shape} asShape padding: 5.
	composite position: 10@10.
	target position: 10@10.
	canvas add: composite.

	self assert: composite extent equals: (20+(5*2)) asPoint.

	RSLocation new move: shape on: target.

	self assert: shape parent equals: composite.
	self assert: target parent equals: composite.
	self assert: composite parent equals: canvas.
	self assert: shape position equals: 10 asPoint + 0 asPoint
]

{ #category : #tests }
RSLocationTest >> testInnerXInnerY [
	RSLocation new innerX; innerY; middle; right; move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: 5 @ 0
]

{ #category : #tests }
RSLocationTest >> testInnerXOuterY [
	RSLocation new innerX; outerY; bottom; right; move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: 5 @ 15
]

{ #category : #tests }
RSLocationTest >> testInsideCornerLeft [
	RSLocation new insideCornerLeft move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: -5 @ -15
]

{ #category : #tests }
RSLocationTest >> testInsideCornerRight [
	RSLocation new insideCornerRight move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: 5 @ -15.
]

{ #category : #tests }
RSLocationTest >> testMiddleLeft [
	RSLocation new middle; left; outer; move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: -15 @ 0
]

{ #category : #tests }
RSLocationTest >> testMiddleLeftInner [
	RSLocation new middle; left; inner; move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: -5 @ 0
]

{ #category : #tests }
RSLocationTest >> testOutsideXinsideY [
	RSLocation new outerX; innerY; bottom; right; move: shape on: target.
	self assert: target position equals: 0 asPoint.
	self assert: shape position equals: 15 @ 5
]
