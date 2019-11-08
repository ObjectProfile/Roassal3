"
I represent a visual component box in a canvas
"
Class {
	#name : #RSBox,
	#superclass : #RSBoundingShape,
	#instVars : [
		'cornerRadius'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #visiting }
RSBox >> buildPathOn: visitor [
	visitor buildBoxPath: self
]

{ #category : #accessing }
RSBox >> cornerRadius [
	^ cornerRadius
]

{ #category : #accessing }
RSBox >> cornerRadius: aTSCornerRadius [
	aTSCornerRadius isNumber ifTrue: [ 
		cornerRadius := RSCornerRadius new radius: aTSCornerRadius.
		^ self	 ].
	cornerRadius := aTSCornerRadius 
]

{ #category : #testing }
RSBox >> hasCornerRadius [
	^ cornerRadius notNil
		and: [ cornerRadius max > 0 and: [ cornerRadius min >= 0 ] ]
]
