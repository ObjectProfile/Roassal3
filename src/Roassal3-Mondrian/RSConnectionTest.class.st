Class {
	#name : #RSConnectionTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Mondrian-Tests'
}

{ #category : #tests }
RSConnectionTest >> testBasic [

	| c connection |
	c := RSMondrian new.
	c nodes: (1 to: 100 by: 10).
	c build.

	connection := RSPopupConnection new.
	connection doNotOpenWindow.
	connection inputCanvas: c.
	connection output: [ :inputModel |
		| c2 |
		c2 := RSMondrian new.
		c2 nodes: (1 to: 10).
		c2 build.
	].
	
	self assert: connection numberOfCreatedCanvases equals: 0.
	(c canvas shapeFromModel: 1) announce: RSMouseClick.
	self assert: connection numberOfCreatedCanvases equals: 1.
	
	(c canvas shapeFromModel: 1) announce: RSMouseClick.
	self assert: connection numberOfCreatedCanvases equals: 2.
	
	(c canvas shapeFromModel: 91) announce: RSMouseClick.
	self assert: connection numberOfCreatedCanvases equals: 3.
]

{ #category : #tests }
RSConnectionTest >> testLastwindowIsNil [

	self assert: RSPopupConnection new lastWindow isNil
]

{ #category : #tests }
RSConnectionTest >> testNumberOfOutputs [

	self assert: RSPopupConnection new numberOfOutputs equals: 0
]
