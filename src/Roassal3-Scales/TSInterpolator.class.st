"
I determine the correct interpolator for a kind of data
my subclasses 
CAColorInterpolator
RTNumberInterpolator
"
Class {
	#name : #TSInterpolator,
	#superclass : #TSObject,
	#category : #'Roassal3-Scales-Core'
}

{ #category : #interpolation }
TSInterpolator class >> interpolate: a and: b [
	| clazz |
	clazz := self interpolatorFor: b.
	^ clazz new start: a; stop: b.
]

{ #category : #interpolation }
TSInterpolator class >> interpolatorFor: b [
	(b isString or: [ b isColor ]) ifTrue: [ ^ TSColorInterpolator ].
	b isNumber ifTrue: [ ^ TSNumberInterpolator ].
	b isPoint ifTrue: [ ^ TSNumberInterpolator ].
	self error: 'Invalid value for interpolator'
]

{ #category : #interpolation }
TSInterpolator >> interpolate: anObject [
	self subclassResponsibility
]
