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
RSBox >> cornerRadius: aRSCornerRadius [
	"Set the radius of the corners. Accept a number as argument or a RSCornerRadius.

	For example:
-=-=-=-=-=-=-=-=-=
c := RSCanvas new.
box := RSBox new extent: 120 @ 180; color: Color gray; cornerRadius: 10.
c add: box.
c
-=-=-=-=-=-=-=-=-=
"

	aRSCornerRadius isNumber ifTrue: [ 
		cornerRadius := RSCornerRadius new radius: aRSCornerRadius.
		^ self	 ].
	cornerRadius := aRSCornerRadius 
]

{ #category : #testing }
RSBox >> hasCornerRadius [
	^ cornerRadius notNil
		and: [ cornerRadius max > 0 and: [ cornerRadius min >= 0 ] ]
]
