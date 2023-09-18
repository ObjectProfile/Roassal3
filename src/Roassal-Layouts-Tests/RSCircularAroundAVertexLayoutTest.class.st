"
A RSCircularAroundAVertexLayoutTest is a test class for testing the behavior of RSCircularAroundAVertexLayout
"
Class {
	#name : #RSCircularAroundAVertexLayoutTest,
	#superclass : #RSLayoutTest,
	#category : #'Roassal-Layouts-Tests'
}

{ #category : #tests }
RSCircularAroundAVertexLayoutTest >> testApplyDefaultLayoutOverlapsShapes [
	| layout first second |
	layout := RSCircularAroundAVertexLayout new.
	layout on: canvas nodes.
	first := canvas nodes first.
	second := canvas nodes second.
	self deny: (first encompassingRectangle intersects: second encompassingRectangle).
	self deny: first position equals: second position.
]

{ #category : #tests }
RSCircularAroundAVertexLayoutTest >> testApplyLayoutShouldChangeOldPositions [
	| layout oldPositions |
	layout := RSCircularAroundAVertexLayout new.
	oldPositions := canvas nodes collect: #position.
	layout on: canvas nodes.
	self deny: (canvas nodes collect: #position) equals: oldPositions
]

{ #category : #tests }
RSCircularAroundAVertexLayoutTest >> testRadius [
	| layout boundingBox |
	layout := RSCircularAroundAVertexLayout new.
	layout radius: 1000.
	layout on: canvas nodes.

	boundingBox := canvas encompassingRectangle.
	self assert: boundingBox width >  100
]
