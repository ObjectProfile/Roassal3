"
I am an interaction for RSView, I can add to the a fixed shape that contains basic information about

Frames per second, this number show the quantity of frames rendered. useful to debug animations
"
Class {
	#name : #RSMonitorView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'shape',
		'lastFrameEndTime'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #initialization }
RSMonitorView >> currentTime [
	 ^ Time microsecondClockValue
]

{ #category : #initialization }
RSMonitorView >> initialize [
	super initialize.
	self initializeShape.
]

{ #category : #initialization }
RSMonitorView >> initializeShape [
	shape := RSShapeBuilder label
		color: Color green;
		text: [
			| delta |
			delta := self lastFrameCPUConsumption.
			(delta * 1000) asInteger asString, ' fps'. ].
		
]

{ #category : #initialization }
RSMonitorView >> lastFrameCPUConsumption [
	| res current |
	current := self currentTime.
	lastFrameEndTime ifNil: [ 
		lastFrameEndTime := current ].
	res := (current - lastFrameEndTime) * 1e-6.
	lastFrameEndTime := current.
	^ res
]

{ #category : #hooks }
RSMonitorView >> onElement: aView [
	| monitor location |
	monitor := shape element.
	monitor isFixed: true.
	aView addShape: monitor trachelShape. 
	location := RSLocate new inner; bottom; left.
	aView animation
		repeat;
		onStepDo: [ :t | 
			shape updateElement: monitor.
			location move: monitor on: aView basicRectangle ].
]

{ #category : #initialization }
RSMonitorView >> shape [
	^ shape
]

{ #category : #initialization }
RSMonitorView >> shape: aShapeBuilder [
	shape := aShapeBuilder
]
