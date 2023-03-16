"
I am the default roassal3 inspector presenter. I work with RSContextInteraction
"
Class {
	#name : #SpRoassal3InspectorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'canvas',
		'roassalMorph',
		'toolBar'
	],
	#category : #'Roassal3-Inspector-SP2'
}

{ #category : #layout }
SpRoassal3InspectorPresenter class >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: #roassalMorph;
		yourself
]

{ #category : #ports }
SpRoassal3InspectorPresenter >> activateOnDoubleClick [
]

{ #category : #ports }
SpRoassal3InspectorPresenter >> activateOnSingleClick [
]

{ #category : #accessing }
SpRoassal3InspectorPresenter >> canvas [
	^ canvas
]

{ #category : #accessing }
SpRoassal3InspectorPresenter >> canvas: aRSCanvas [
	canvas := aRSCanvas.
	roassalMorph morph: canvas createMorph
]

{ #category : #enumerating }
SpRoassal3InspectorPresenter >> createToolbarIfNecessary [
	| context interactions |
	context := canvas inspectorContext.
	interactions := context inspectorInteractions.
	interactions ifEmpty: [ ^ self ].
	toolBar := SpBoxLayout newLeftToRight.
	interactions do: [ :cls | | i |
		i := cls new.
		i canvas: canvas.
		toolBar add: i newButton withConstraints: [ :constraints |
			constraints
				width: 20;
				height: 20 ]  ].
	self layout: (SpBoxLayout newTopToBottom
		add: toolBar height: 25;
		add: #roassalMorph;
		yourself)
]

{ #category : #ports }
SpRoassal3InspectorPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : #initialization }
SpRoassal3InspectorPresenter >> initializePresenters [
	roassalMorph := self newMorph.
	toolBar := self newButton.
	toolBar label: 'fooo'
]

{ #category : #ports }
SpRoassal3InspectorPresenter >> outputActivationPort [
	^ SpActivationPort newPresenter: self
]

{ #category : #ports }
SpRoassal3InspectorPresenter >> outputSelectionPort [
	^ SpActivationPort newPresenter: self
]

{ #category : #enumerating }
SpRoassal3InspectorPresenter >> whenActivatedDo: aBlock [
	| context |
	self createToolbarIfNecessary.
	context := canvas inspectorContext.
	context presentation: aBlock.
	canvas shapes @ context.
	canvas
		when: RSShapeAddedEvent
		do: [ :evt | evt shape @ context ]
]
