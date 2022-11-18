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

{ #category : #hook }
RSAngleLineLayout >> defaultAngle [
	^ 90.
]

{ #category : #overrides }
RSAngleLineLayout >> doExecute: elements [
	| pointer |
	pointer := self positionOriginalPointer.
	elements doWithIndex: [ :element :index | 
		translator translateTopLeftOf: element to: pointer.
		pointer := pointer setR: index degrees: self angle 
]

]

{ #category : #'initialize-release' }
RSAngleLineLayout >> initialize [
	super initialize.
	angle := self defaultAngle
]

{ #category : #hook }
RSAngleLineLayout >> positionOriginalPointer [
	^ 0@0.
]
