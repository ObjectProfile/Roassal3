"
I can rotate one shape on its parent
"
Class {
	#name : #RSRotated,
	#superclass : #RSInteraction,
	#instVars : [
		'drag',
		'targetShape',
		'totalAngle',
		'prevAngle'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSRotated >> dragEnd: evt [
	drag := false.
	prevAngle := nil
]

{ #category : #hooks }
RSRotated >> dragStart: evt [
	drag := true
]

{ #category : #hooks }
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
	evt signalUpdate
]

{ #category : #initialization }
RSRotated >> initialize [
	super initialize.
	drag := false
]

{ #category : #hooks }
RSRotated >> onShape: aShape [
	targetShape := aShape.
	aShape parent
		when: RSMouseLeftDragStart do: [ :evt|  self dragStart: evt ];
		when: RSMouseDragging do: [ :evt | self dragging: evt ];
		when: RSMouseDragEnd do: [ :evt | self dragEnd: evt ]
]
