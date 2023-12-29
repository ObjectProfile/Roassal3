"
This interaction put dragging events. Use mouse left click to start the draging operation.
This interaction will modify the current matrix of the target shape.
"
Class {
	#name : 'RSRotated',
	#superclass : 'RSInteraction',
	#instVars : [
		'drag',
		'targetShape',
		'totalAngle',
		'prevAngle'
	],
	#category : 'Roassal-Interaction-Core',
	#package : 'Roassal-Interaction',
	#tag : 'Core'
}

{ #category : 'hooks' }
RSRotated >> dragEnd: evt [
	drag := false.
	prevAngle := nil
]

{ #category : 'hooks' }
RSRotated >> dragStart: evt [
	drag := true
]

{ #category : 'hooks' }
RSRotated >> dragging: evt [
	| angle |
	drag ifFalse: [ ^ self ].
	angle := evt position angle.
	totalAngle ifNil: [ totalAngle := 0 ].
	prevAngle ifNil: [ prevAngle := angle ].
	totalAngle := totalAngle + (angle - prevAngle).
	prevAngle := angle.
	targetShape matrix
		loadIdentity;
		rotateByRadians: totalAngle.
	targetShape resetBBox.
	targetShape signalUpdate
]

{ #category : 'initialization' }
RSRotated >> initialize [
	super initialize.
	drag := false
]

{ #category : 'hooks' }
RSRotated >> onShape: aShape [
	targetShape := aShape.
	aShape parent
		when: RSMouseLeftDragStart send: #dragStart: to: self;
		when: RSMouseDragging send: #dragging: to: self;
		when: RSMouseDragEnd send: #dragEnd: to: self
]
