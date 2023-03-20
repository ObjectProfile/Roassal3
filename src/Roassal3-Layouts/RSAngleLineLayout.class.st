"
This layout uses an angle to put the elements in a line
"
Class {
	#name : #RSAngleLineLayout,
	#superclass : #RSAbstractLineLayout,
	#instVars : [
		'angle'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #accessing }
RSAngleLineLayout >> angle [
	^ angle
]

{ #category : #accessing }
RSAngleLineLayout >> angle: anAngleInDegrees [
	angle := anAngleInDegrees
]

{ #category : #hook }
RSAngleLineLayout >> defaultAngle [
	^ 90
]

{ #category : #hook }
RSAngleLineLayout >> doExecute: elements [
	| originalCenter radius gap ang |
	originalCenter := self positionOriginalPointer.
	radius := 0.
	gap := self gapSize.
	ang := self angle degreesToRadians.
	elements do: [ :element |
		| point |
		point := ang cos @ ang sin * radius.
		translator translateTopLeftOf: element to: originalCenter + point.
		radius := radius + gap ]
]

{ #category : #initialization }
RSAngleLineLayout >> initialize [
	super initialize.
	angle := self defaultAngle
]

{ #category : #hook }
RSAngleLineLayout >> positionOriginalPointer [
	^ 0@0
]
