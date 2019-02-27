"
I am the basic uninterpolator, my subclasses are

TSUninterpolateClamp
TSUninterpolateNumber
"
Class {
	#name : #TSUninterpolate,
	#superclass : #TSObject,
	#instVars : [
		'a',
		'b'
	],
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolating }
TSUninterpolate class >> uninterpolate: aNum1 and: aNum2 [
	^ self new uninterpolate: aNum1 and: aNum2.
	
]

{ #category : #interpolating }
TSUninterpolate >> uninterpolate: x [
	self subclassResponsibility.
]

{ #category : #accessing }
TSUninterpolate >> uninterpolate: aNum1 and: aNum2 [
	a := aNum1.
	b := aNum2.
	a isNumber 
		ifFalse: [ ^ a := b := Float nan. ].
	b  := b - a.
	b isZero 
		ifTrue: [ b := 1 / aNum2 ].
]
