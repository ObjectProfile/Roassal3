"
I am a condition command. my use is the next.
-------------------------------
builder := RSShapeBuilder box
    size: 40;
    if: [ : shapeIndex | shapeIndex even ] actions: [: shape | 
        shape color: Color red ].
builder elementsOn: (1 to: 10).
-------------------------------
Subclasses of RSAbstractModelBuilder can use the method #if:actions: 
The previous method creates the RSConditionCommand to create elements based on a condition.

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
	#category : #'Roassal3-Scripting-Commands'
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

{ #category : #'special objects' }
RSConditionCommand >> fillGetterIn: dictionary [
	| target cmds bool  |
	target := self argumentTarget.
	(self condition rsValue: target) ifFalse: [ ^ self] .
	cmds := builder commands.
	bool := builder isForElement.
	builder commands: OrderedCollection new.
	self message rsValue: builder.
	builder updateElement: element innerComponent: component.
	builder commands: cmds.
	builder isForElement: bool.

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
