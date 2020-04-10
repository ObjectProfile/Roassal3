"
I can create labels for a pie builder and set the position acording to arc
"
Class {
	#name : #RSPieLabeled,
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
RSPieLabeled >> initialize [
	super initialize.
	self labelShape: RSLabel new.
	self labelColor: Color black.
	offset := 0.
	rotated := false.
]

{ #category : #testing }
RSPieLabeled >> isRotated [
	^ rotated
]

{ #category : #accessing }
RSPieLabeled >> labelColor [
	^ labelColor
]

{ #category : #accessing }
RSPieLabeled >> labelColor: aColor [
	"can be a color, a block or color scale"
	"self labelColor: Color white"
	"self labelColor: [:model | model modelColor ]"
	"self labelColor: TSScale category20"
	labelColor := aColor
]

{ #category : #'accessing - keys' }
RSPieLabeled >> labelKey [
	^ #RSPieLabeled
]

{ #category : #accessing }
RSPieLabeled >> labelShape [
	^ labelShape
]

{ #category : #accessing }
RSPieLabeled >> labelShape: aLabel [
	labelShape := aLabel
]

{ #category : #accessing }
RSPieLabeled >> labelText [
	^ labelText
]

{ #category : #accessing }
RSPieLabeled >> labelText: anObject [
	"can be an object or block"
	"self labelText: 'Hi'"
	"self labelText: [:model | 'The model: ', model asString]"
	labelText := anObject
]

{ #category : #accessing }
RSPieLabeled >> offset [
	^ offset
]

{ #category : #accessing }
RSPieLabeled >> offset: aNumber [
	offset := aNumber
]

{ #category : #hooks }
RSPieLabeled >> onShape: aShape [
	| label parent |
	label := self shapeFor: aShape.
	aShape attributeAt: self labelKey put: label.
	parent := aShape parent.
	parent add: label.
]

{ #category : #accessing }
RSPieLabeled >> rotated [
	rotated := true.
]

{ #category : #hooks }
RSPieLabeled >> shapeFor: aPieSliceShape [
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
