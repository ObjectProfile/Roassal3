"
I represent a visual component box in a canvas.

Here is an example:
c := RSCanvas new.
(30 to: 150 by: 10) do: [ :nb |
	b := RSBox new size: nb.
	c add: b ].
RSFlowLayout on: c nodes.
c @ RSControlsCanvas
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
