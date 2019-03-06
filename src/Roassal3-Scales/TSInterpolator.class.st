"
I determine the correct interpolator for a kind of data
my subclasses 
CAColorInterpolator
RTNumberInterpolator

The basic interpolation is between 2 values 
0 and 1, usually the value between these values is called 't'
"
Class {
	#name : #TSInterpolator,
	#superclass : #TSObject,
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolation }
TSInterpolator class >> colorInterpolator [
	^ TSColorRGBAInterpolator
]

{ #category : #interpolation }
TSInterpolator class >> interpolate: a and: b [
	| clazz |
	clazz := self interpolatorFor: b.
	^ clazz new start: a; stop: b.
]

{ #category : #interpolation }
TSInterpolator class >> interpolatorFor: b [
	(b isString or: [ b isColor ]) ifTrue: [ ^ self colorInterpolator ].
	b isNumber ifTrue: [ ^ TSNumberInterpolator ].
	b isPoint ifTrue: [ ^ TSNumberInterpolator ].
	self error: 'Invalid value for interpolator'
]

{ #category : #interpolation }
TSInterpolator >> interpolate: anObject [
	self subclassResponsibility
]
