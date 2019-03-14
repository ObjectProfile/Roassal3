"
I can create labels for a pie builder and set the position acording to arc
"
Class {
	#name : #RSPieLabelBuilder,
	#superclass : #RSShapeBuilder,
	#instVars : [
		'pieBuilder',
		'rotated',
		'offset'
	],
	#category : #'Roassal3-Pie-Core'
}

{ #category : #'instance creation' }
RSPieLabelBuilder class >> label [ 
	| label |
	label := super label.
	label
		onElement;
		rotateByDegrees: [ :e | | arc a |
			label isRotated ifTrue: [ 
				arc := label builder elements at: e index.
				a := (arc alphaAngle + arc betaAngle) / 2.
				(a > 90 and: [ a < 270 ]) ifTrue: [ a := a - 180 ].
				a negated
			 ] ifFalse: [ 0 ].
			];
		position: [ :e | | arc |
			arc := label builder elements at: e index.
			(arc centroid: label offset) + arc position ];
		onModel.
	^ label
]

{ #category : #accessing }
RSPieLabelBuilder >> builder [
	^ pieBuilder
]

{ #category : #accessing }
RSPieLabelBuilder >> builder: aPieBuilder [
	pieBuilder := aPieBuilder
]

{ #category : #initialization }
RSPieLabelBuilder >> initialize [
	super initialize.
	offset := 0.
	rotated := false.
]

{ #category : #testing }
RSPieLabelBuilder >> isRotated [
	^ rotated
]

{ #category : #accessing }
RSPieLabelBuilder >> offset [
	^ offset
]

{ #category : #accessing }
RSPieLabelBuilder >> offset: aNumber [
	offset := aNumber
]

{ #category : #accessing }
RSPieLabelBuilder >> rotated [
	rotated := true.
]
