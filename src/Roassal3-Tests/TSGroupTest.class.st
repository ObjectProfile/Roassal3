"
A TSGroupTest is a test class for testing the behavior of TSGroup
"
Class {
	#name : #TSGroupTest,
	#superclass : #TestCase,
	#category : #'Roassal3-Tests-Trachel'
}

{ #category : #tests }
TSGroupTest >> testAddShape [
	| g |
	g := TSGroup new.
	g add: TSBox new.
]

{ #category : #tests }
TSGroupTest >> testDrawGroup [
	| g c |
	c := TSCanvas new.
	g := TSGroup new.
	g add: TSBox new.
	
	c addShape: g.
	self assert: c numberOfShapes equals: 1.
	c morph drawOnMockCanvas.
]
