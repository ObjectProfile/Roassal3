"
I represent a visual component box in a canvas
"
Class {
	#name : #TSBox,
	#superclass : #TSBoundingShape,
	#instVars : [
		'cornerRadius'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #accessing }
TSBox >> cornerRadius [
	^ cornerRadius
]

{ #category : #accessing }
TSBox >> cornerRadius: aTSCornerRadius [
	aTSCornerRadius isNumber ifTrue: [ 
		cornerRadius := TSCornerRadius new radius: aTSCornerRadius.
		^ self	 ].
	cornerRadius := aTSCornerRadius 
]

{ #category : #testing }
TSBox >> hasCornerRadius [
	^ cornerRadius notNil and: [ cornerRadius max > 0 and: [(cornerRadius min < 0) not] ].
]

{ #category : #visiting }
TSBox >> pathFor: visitor [
	^ visitor pathOfBox: self
]
