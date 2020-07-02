"
TODO
"
Class {
	#name : #RSParticleForce,
	#superclass : #RSObject,
	#instVars : [
		'position',
		'shape'
	],
	#category : #'Roassal3-Experimental-Force'
}

{ #category : #accessing }
RSParticleForce >> position [
	^ position
]

{ #category : #accessing }
RSParticleForce >> position: aPoint [
	^ position := aPoint
]

{ #category : #rendering }
RSParticleForce >> renderIn: aCanvas [
	shape ifNil: [ 
		shape := RSEllipse new size: 1; color: (Color black alpha: 0.1).
		aCanvas addShape: shape.
		 ].
	shape position: position
]

{ #category : #updating }
RSParticleForce >> update: itf with: force [
	| dist p1 p2 dir |
	p1 := position.
	p2 := itf position.
	dist := p1 distanceTo: p2.
	"dist < itf radius ifFalse: [ ^ self ]."
	dir := itf mode = #attract 
		ifTrue: [ p1 - p2 ]
		ifFalse: [ p2 - p1 ].
	dir := dir normalized * force / dist.
	position := position + dir.
]
