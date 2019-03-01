"
linear := TSEasing poly exponent: 1.
quad := TSEasing poly exponent: 2.
cubic := TSEasing poly exponent: 3

TSEasing polyIn 
Polynomial easing; raises t to the specified exponent. If the exponent is not specified, it defaults to 3, equivalent to cubicIn.

TSEasing polyOut
Reverse polynomial easing; equivalent to 1 - polyIn(1 - t). If the exponent is not specified, it defaults to 3, equivalent to cubicOut.

TSEasing poly 
TSEasing polyInOut 
Symmetric polynomial easing; scales polyIn for t in [0, 0.5] and polyOut for t in [0.5, 1]. If the exponent is not specified, it defaults to 3, equivalent to cubic.
"
Class {
	#name : #TSPolyInterpolator,
	#superclass : #TSEasing,
	#instVars : [
		'exponent'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #accessing }
TSPolyInterpolator >> exponent [
	^ exponent
]

{ #category : #accessing }
TSPolyInterpolator >> exponent: aNumber [
	exponent := aNumber
]

{ #category : #initialization }
TSPolyInterpolator >> initialize [
	super initialize.
	self exponent: 3.
]

{ #category : #interpolation }
TSPolyInterpolator >> interpolateIn: i [
	^ i raisedTo: exponent.
]

{ #category : #interpolation }
TSPolyInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2.
	^ (t <= 1
		ifTrue: [ t raisedTo: exponent ]
		ifFalse: [ 2 - ( ( 2 - t) raisedTo: exponent ) ]) / 2
	
]

{ #category : #interpolation }
TSPolyInterpolator >> interpolateOut:  t [
	^ 1 - ((1 -t) raisedTo: exponent).
]
