"
A RSShadowInteractionTest is a test class for testing the behavior of RSShadowInteraction
"
Class {
	#name : #RSShadowInteractionTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas',
		'shape',
		'interaction'
	],
	#category : #'Roassal3-Interaction-Tests-Selection'
}

{ #category : #running }
RSShadowInteractionTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	shape := RSBox new.
	canvas add: shape.
	interaction := RSShadowInteraction new
	
]

{ #category : #tests }
RSShadowInteractionTest >> testAddShadowSeveralTimesOnAShape [

	shape @ interaction.
	shape @ interaction.

	self assert: canvas shapes size equals: 2
]

{ #category : #tests }
RSShadowInteractionTest >> testRemoveAllShadows [

	| shapes |
	shapes := RSBox models: (1 to: 10).
	canvas addAll: shapes.
	shapes @ interaction.

	interaction removeShadowsOn: canvas.


	self assert: (shapes allSatisfy: [ :s | s shadow isNil ])
]

{ #category : #tests }
RSShadowInteractionTest >> testRemoveShadowFromShape [

	shape @ interaction.
	shape removeShadow.
	self assert: shape shadow isNil
]

{ #category : #tests }
RSShadowInteractionTest >> testRemoveShadowWhenShadowIsRemoved [

	shape @ interaction.
	shape remove.

	self assert: canvas shapes size equals: 0
]

{ #category : #tests }
RSShadowInteractionTest >> testShadowUpdatePositionWhenShapeMoves [

	shape @ interaction.
	shape translateTo: 10 @ 10.
	self assert: shape shadow position equals: shape position
]

{ #category : #tests }
RSShadowInteractionTest >> testShapeHasShadow [

	shape @ interaction.
	self assert: shape shadow notNil
]

{ #category : #tests }
RSShadowInteractionTest >> testShapeIsPushedFront [

	canvas add: RSBox new.
	self assert: canvas shapes first equals: shape.
	shape @ interaction.

	interaction shouldPushFront: true.
	self assert: canvas shapes second equals: shape
]

{ #category : #tests }
RSShadowInteractionTest >> testWhenCanvasScaleChangedUpdatesShadows [

	| shapes oldShadows newShadows |
	shapes := RSBox models: (1 to: 10).
	canvas addAll: shapes.
	shapes @ interaction.
	oldShadows := shapes collect: [ :each | each shadow ].
	canvas camera scale: 0.5.
	newShadows := shapes collect: [ :each | each shadow ].

	oldShadows
		with: newShadows
		do: [ :old :new | self assert: old extent < new extent ]
]
