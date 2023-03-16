"
I can create labels for a pie builder and set the position acording to arc
"
Class {
	#name : #RSPieLabeledInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'rotated',
		'offset',
		'labelColor',
		'labelText',
		'labelShape'
	],
	#category : #'Roassal3-Pie-Interactions'
}

{ #category : #initialization }
RSPieLabeledInteraction >> initialize [
	super initialize.
	self labelShape: RSLabel new.
	self labelColor: Color black.
	offset := 0.
	rotated := false
]

{ #category : #testing }
RSPieLabeledInteraction >> isRotated [
	^ rotated
]

{ #category : #accessing }
RSPieLabeledInteraction >> labelColor [
	^ labelColor
]

{ #category : #accessing }
RSPieLabeledInteraction >> labelColor: aColor [
	"can be a color, a block or color scale"
	"self labelColor: Color white"
	"self labelColor: [:model | model modelColor ]"
	"self labelColor: NSScale category20"
	labelColor := aColor
]

{ #category : #'accessing - keys' }
RSPieLabeledInteraction >> labelKey [
	^ #RSPieLabeledInteraction
]

{ #category : #accessing }
RSPieLabeledInteraction >> labelShape [
	^ labelShape
]

{ #category : #accessing }
RSPieLabeledInteraction >> labelShape: aLabel [
	labelShape := aLabel
]

{ #category : #accessing }
RSPieLabeledInteraction >> labelText [
	^ labelText
]

{ #category : #accessing }
RSPieLabeledInteraction >> labelText: anObject [
	"can be an object or block"
	"self labelText: 'Hi'"
	"self labelText: [:model | 'The model: ', model asString]"
	labelText := anObject
]

{ #category : #accessing }
RSPieLabeledInteraction >> offset [
	^ offset
]

{ #category : #accessing }
RSPieLabeledInteraction >> offset: aNumber [
	offset := aNumber
]

{ #category : #hooks }
RSPieLabeledInteraction >> onShape: aShape [
	| label parent |
	label := self shapeFor: aShape.
	aShape propertyAt: self labelKey put: label.
	parent := aShape parent.
	parent add: label
]

{ #category : #accessing }
RSPieLabeledInteraction >> rotated [
	rotated := true
]

{ #category : #hooks }
RSPieLabeledInteraction >> shapeFor: aPieSliceShape [
	| res arc ang |
	arc := aPieSliceShape.
	res := labelShape copy
		text: (self labelText rsValue: arc model);
		color: (self labelColor rsValue: arc model);
		position: (arc centroid: self offset) + arc position;
		yourself.
	self isRotated ifFalse: [ ^ res ].
	ang := arc middleAngle.
	(ang between: 90 and: 270) ifTrue: [ ang := ang - 180 ].
	res rotateByDegrees: ang negated.
	^ res
]
