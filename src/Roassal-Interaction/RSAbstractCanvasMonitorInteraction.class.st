"
I am an interaction for RSView, I can add to the a fixed shape that contains basic information about

Frames per second, this number show the quantity of frames rendered. useful to debug animations
"
Class {
	#name : #RSAbstractCanvasMonitorInteraction,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'shape',
		'lastFrameEndTime',
		'canvas'
	],
	#category : #'Roassal3-Interaction-Extra'
}

{ #category : #accessing }
RSAbstractCanvasMonitorInteraction >> currentTime [
	^ canvas currentTime
]

{ #category : #initialization }
RSAbstractCanvasMonitorInteraction >> initialize [
	super initialize.
	self initializeShape
]

{ #category : #initialization }
RSAbstractCanvasMonitorInteraction >> initializeShape [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractCanvasMonitorInteraction >> lastFrameCPUConsumption [
	| res current |
	current := self currentTime.
	lastFrameEndTime ifNil: [ lastFrameEndTime := current - 10000 ].
	res := (current - lastFrameEndTime) * 1e-3.
	lastFrameEndTime := current.
	^ res
]

{ #category : #accessing }
RSAbstractCanvasMonitorInteraction >> lastFramePerSecond [
	| delta |
	delta := self lastFrameCPUConsumption.
	^ (1.0 / (delta max: 0.001) ) asInteger
]

{ #category : #hooks }
RSAbstractCanvasMonitorInteraction >> onShape: aCanvas [
	| location |
	self assert: shape notNil description: 'Define your monitor shape'.
	shape isFixed: true.
	aCanvas addShape: shape.
	location := RSLocation new inner; bottom; left; offset: 10@0.
	canvas := aCanvas.
	aCanvas newAnimation
		repeat;
		onStepDo: [ :t |
			self updateShape.
			location move: shape on: aCanvas basicRectangle ]
]

{ #category : #accessing }
RSAbstractCanvasMonitorInteraction >> shape [
	^ shape
]

{ #category : #accessing }
RSAbstractCanvasMonitorInteraction >> shape: aShape [
	shape := aShape
]

{ #category : #update }
RSAbstractCanvasMonitorInteraction >> updateShape [
	self subclassResponsibility
]
