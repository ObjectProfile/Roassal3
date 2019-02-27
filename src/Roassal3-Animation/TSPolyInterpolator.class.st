"
super class of poly interpolators

| linear quad cubic |
linear := TSPolyInOutInterpolator new
"
Class {
	#name : #TSPolyInterpolator,
	#superclass : #TSInterpolator,
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
