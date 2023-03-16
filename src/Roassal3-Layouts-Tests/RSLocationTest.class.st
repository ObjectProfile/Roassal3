Class {
	#name : #RSLocationTest,
	#superclass : #TestCase,
	#instVars : [
		'shape',
		'target'
	],
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #running }
RSLocationTest >> setUp [
	super setUp.

	shape := RSBox new size: 10 asPoint; position: 0 asPoint.
	target := RSBox new size: 20 asPoint; position: 0 asPoint
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
	| canvas composite |
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
	| canvas composite |
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
