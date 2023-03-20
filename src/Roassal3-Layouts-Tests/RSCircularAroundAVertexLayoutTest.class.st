"
A RSCircularAroundAVertexLayoutTest is a test class for testing the behavior of RSCircularAroundAVertexLayout
"
Class {
	#name : #RSCircularAroundAVertexLayoutTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas'
	],
	#category : #'Roassal3-Layouts-Tests'
}

{ #category : #running }
RSCircularAroundAVertexLayoutTest >> createCanvasToTest [
	^ RSCanvas new
		in:[ :c |
			c addAll: (RSBox models: (1 to: 10)).
			RSLineBuilder line
				shapes: c nodes;
				connectFrom: [ :number | number // 2 ].
			c
			 ];
	 yourself
]

{ #category : #running }
RSCircularAroundAVertexLayoutTest >> setUp [
	super setUp.
	canvas := self createCanvasToTest
]

{ #category : #tests }
RSCircularAroundAVertexLayoutTest >> testBasic [
	| layout oldPositions |
	layout := RSCircularAroundAVertexLayout new.
	oldPositions := canvas nodes collect: #position.
	layout on: canvas nodes.
	self deny: (canvas nodes collect: #position) equals: oldPositions
]

{ #category : #tests }
RSCircularAroundAVertexLayoutTest >> testDefaultRadius [
	| layout first second |
	layout := RSCircularAroundAVertexLayout new.
	layout on: canvas nodes.
	first := canvas nodes first.
	second := canvas nodes second.
	self deny: (first encompassingRectangle intersects: second encompassingRectangle)
]

{ #category : #tests }
RSCircularAroundAVertexLayoutTest >> testRadius [
	| layout boundingBox |
	layout := RSCircularAroundAVertexLayout new.
	layout radius: 1000.
	layout on: canvas nodes.

	boundingBox := canvas encompassingRectangle.
	self assert: boundingBox width > 1000
]
