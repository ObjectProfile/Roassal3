"
A TSGroupTest is a test class for testing the behavior of TSGroup
"
Class {
	#name : #TSGroupTest,
	#superclass : #TSTest,
	#category : #'Roassal3-Tests'
}

{ #category : #tests }
TSGroupTest >> testAddShape [
	| g |
	g := TSGroup new.
	g add: TSBox new.
]

{ #category : #tests }
TSGroupTest >> testAsGroup [
	| t |
	t := #(1 2 3) asGroup.
	self assert: t asArray equals: #(1 2 3).
	self assert: t class equals: TSGroup
]

{ #category : #tests }
TSGroupTest >> testDrawGroup [
	| g c com |
	c := TSCanvas new.
	g := TSGroup new.
	g add: TSBox new.
	com := TSComposite new
		shapes: g.
	c addShape: com.
	self assert: c numberOfShapes equals: 1.
	c createMorph drawOnMockCanvas.
]
