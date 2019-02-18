"
I am a condition command. my use is the next.
-------------------------------
shape := RSGeometryBuilder box
	size: 40;
	if: [ :m | m even ] actions: [ 
		shapes background: Color red ].
	
shape elementsOn: (1 to: 10).
-------------------------------
Subclasses of RSAbstractModelBuilder can use the method #if:actions: 
The previous method creates the CAConditionCommand to create elements based on a condition.

the condition'block can be a block or a symbol, the actions'block can recive or not an argument

-------------------------------
(RSShapeBuilder box
	size: 40;
	background: Color blue;
	if: #even actions: [ :s|
		s background: Color red ]) elementsOn: (1 to: 10).
-------------------------------

"
Class {
	#name : #RSConditionCommand,
	#superclass : #RSCommand,
	#instVars : [
		'condition',
		'builder'
	],
	#category : #'Roassal3-Commands'
}

{ #category : #accessing }
RSConditionCommand >> builder [
	^ builder 
]

{ #category : #accessing }
RSConditionCommand >> builder: aBuilder [
	builder := aBuilder
]

{ #category : #accessing }
RSConditionCommand >> condition [
	^ condition
]

{ #category : #accessing }
RSConditionCommand >> condition: aBlock [
	condition := aBlock
]

{ #category : #executing }
RSConditionCommand >> execute [
	| target |
	target := self argumentTarget.
	(self condition rsValue: target) ifTrue: [ 
		builder 
			executeDuring: self message
			element: self element
			component: self component ].
]

{ #category : #testing }
RSConditionCommand >> isCondition [ 
	^ true
]

{ #category : #printing }
RSConditionCommand >> printOn: stream [
	stream nextPutAll: 'if: '.
	condition printOn: stream.
	stream nextPutAll: ' actions: '.
	message printOn: stream
]

{ #category : #dependencies }
RSConditionCommand >> release [ 
	super release.
	builder := condition := nil.
]

{ #category : #acccessing }
RSConditionCommand >> selector [ 
	^ nil
]
