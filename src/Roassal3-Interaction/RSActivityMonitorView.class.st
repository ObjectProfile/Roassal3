"
I am an interaction for RSView, I can add to the a fixed shape that contains basic information about

Frames per second, this number show the quantity of frames rendered. useful to debug animations
"
Class {
	#name : #RSActivityMonitorView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'shape',
		'lastFrameEndTime'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #initialization }
RSActivityMonitorView >> currentTime [
	 ^ Time microsecondClockValue
]

{ #category : #initialization }
RSActivityMonitorView >> initialize [
	super initialize.
	self initializeShape.
]

{ #category : #initialization }
RSActivityMonitorView >> initializeShape [
	shape := RSShapeBuilder label
		color: Color green;
		text: [
			| delta |
			delta := self lastFrameCPUConsumption.
			(1.0 / (delta max: 0.001) ) asInteger asString, ' fps'. ].
		
]

{ #category : #initialization }
RSActivityMonitorView >> lastFrameCPUConsumption [
	| res current |
	current := self currentTime.
	lastFrameEndTime ifNil: [ 
		lastFrameEndTime := current ].
	res := (current - lastFrameEndTime) * 1e-6.
	lastFrameEndTime := current.
	^ res
]

{ #category : #hooks }
RSActivityMonitorView >> onElement: aView [
	| monitor location |
	monitor := shape element.
	monitor isFixed: true.
	aView addShape: monitor trachelShape. 
	location := RSLocate new inner; bottom; left; offset: 10@0.
	aView newAnimation
		repeat;
		onStepDo: [ :t | 
			shape updateElement: monitor.
			location move: monitor on: aView basicRectangle ].
]

{ #category : #initialization }
RSActivityMonitorView >> shape [
	^ shape
]

{ #category : #initialization }
RSActivityMonitorView >> shape: aShapeBuilder [
	shape := aShapeBuilder
]
