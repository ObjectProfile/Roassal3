"
I can rotate one shape on its parent
"
Class {
	#name : #RSRotatedInteraction,
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
RSRotatedInteraction >> dragEnd: evt [
	drag := false.
	prevAngle := nil.
]

{ #category : #hooks }
RSRotatedInteraction >> dragStart: evt [
	drag := true.
]

{ #category : #hooks }
RSRotatedInteraction >> dragging: evt [
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
RSRotatedInteraction >> initialize [
	super initialize.
	drag := false.
]

{ #category : #hooks }
RSRotatedInteraction >> onShape: aShape [
	targetShape := aShape.
	aShape parent
		when: RSMouseLeftDragStart do: [ :evt|  self dragStart: evt ];
		when: RSMouseDragging do: [ :evt | self dragging: evt ];
		when: RSMouseDragEnd do: [ :evt | self dragEnd: evt ].
]
