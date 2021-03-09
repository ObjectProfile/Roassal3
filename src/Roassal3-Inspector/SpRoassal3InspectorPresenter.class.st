Class {
	#name : #SpRoassal3InspectorPresenter,
	#superclass : #SpMorphPresenter,
	#instVars : [
		'activationBlock',
		'canvas'
	],
	#category : #'Roassal3-Inspector-SP2'
}

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
	self morph: canvas createMorph.
]

{ #category : #ports }
SpRoassal3InspectorPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : #initialization }
SpRoassal3InspectorPresenter >> initialize [
	super initialize
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
	context := canvas inspectorContext.
	context presentation: aBlock.
	canvas morph setTakeKeyboardFocus.
	canvas shapes @ context.
	canvas
		when: RSShapeAddedEvent
		do: [ :evt | evt shape @ context ].
]
