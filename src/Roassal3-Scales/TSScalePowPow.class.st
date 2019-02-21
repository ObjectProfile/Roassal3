"
I am a utility clas for CAScalePow
"
Class {
	#name : #TSScalePowPow,
	#superclass : #TSObject,
	#instVars : [
		'exponent'
	],
	#category : #'Roassal3-Scales'
}

{ #category : #accessing }
TSScalePowPow >> exponent: aNumber [
	exponent := aNumber
]

{ #category : #transformations }
TSScalePowPow >> scale: x [
	^ x < 0
		ifTrue: [ (x negated raisedTo: exponent) negated ]
		ifFalse: [ x raisedTo: exponent ]
]
