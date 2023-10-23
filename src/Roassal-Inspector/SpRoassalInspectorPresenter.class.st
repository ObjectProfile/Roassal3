"
I am the default Roassal inspector presenter. I work with RSContextInteraction
"
Class {
	#name : 'SpRoassalInspectorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'canvas',
		'roassalMorph',
		'toolBar'
	],
	#category : 'Roassal-Inspector-SP2',
	#package : 'Roassal-Inspector',
	#tag : 'SP2'
}

{ #category : 'layout' }
SpRoassalInspectorPresenter class >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: #roassalMorph;
		yourself
]

{ #category : 'ports' }
SpRoassalInspectorPresenter >> activateOnDoubleClick [
]

{ #category : 'ports' }
SpRoassalInspectorPresenter >> activateOnSingleClick [
]

{ #category : 'accessing' }
SpRoassalInspectorPresenter >> canvas [
	^ canvas
]

{ #category : 'accessing' }
SpRoassalInspectorPresenter >> canvas: aRSCanvas [
	canvas := aRSCanvas.
	roassalMorph morph: canvas createMorph
]

{ #category : 'enumerating' }
SpRoassalInspectorPresenter >> createToolbarIfNecessary [
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

{ #category : 'ports' }
SpRoassalInspectorPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : 'initialization' }
SpRoassalInspectorPresenter >> initializePresenters [
	roassalMorph := self newMorph.
	toolBar := self newButton.
	toolBar label: 'fooo'
]

{ #category : 'ports' }
SpRoassalInspectorPresenter >> outputActivationPort [
	^ SpActivationPort newPresenter: self
]

{ #category : 'ports' }
SpRoassalInspectorPresenter >> outputSelectionPort [
	^ SpActivationPort newPresenter: self
]

{ #category : 'enumerating' }
SpRoassalInspectorPresenter >> whenActivatedDo: aBlock [
	| context |
	self createToolbarIfNecessary.
	context := canvas inspectorContext.
	context presentation: aBlock.
	canvas shapes @ context.
	canvas
		when: RSShapeAddedEvent
		do: [ :evt | evt shape @ context ]
		for: self
]
