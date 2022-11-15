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
RSAngleLineLayout >> angle :anAngle [
	angle := anAngle
]

{ #category : #hook }
RSAngleLineLayout >> defaultAngle [
	^ 90.
]

{ #category : #hook }
RSAngleLineLayout >> positionOriginalPointer [
	^ 0@0.
]

{ #category : #'initialize-release' }
RSAngleLineLayout >> initialize [
	super initialize.
	angle := self defaultAngle
]

{ #category : #'overrides' }
RSAngleLineLayout >> doExecute: elements [
	| pointer |
	pointer := self positionOriginalPointer.
	elements doWithIndex: [ :element :index | 
		translator translateTopLeftOf: element to: pointer.
		pointer := pointer setR: index degrees: self angle 
]

]
