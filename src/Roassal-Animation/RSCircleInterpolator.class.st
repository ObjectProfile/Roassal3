"
RSEasingInterpolator circleIn
Circular easing.

RSEasingInterpolator circleOut
Is Reverse circular easing; equivalent to 1 - interpolateIn: 1 - t.

RSEasingInterpolator circleInOut
RSEasingInterpolator circle
Symmetric circular easing; scales circleIn for t in {0. 0.5} and circleOut for t in {0.5, 1}.


"
Class {
	#name : 'RSCircleInterpolator',
	#superclass : 'RSEasingInterpolator',
	#category : 'Roassal-Animation-Easing',
	#package : 'Roassal-Animation',
	#tag : 'Easing'
}

{ #category : 'interpolation' }
RSCircleInterpolator >> interpolateIn:  t [
	^ 1 - (1 - (t * t) ) sqrt
]

{ #category : 'interpolation' }
RSCircleInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2.
	^ (t<=1
		ifTrue: [ 1 - (1 - (t*t)) sqrt ]
		ifFalse: [
			t := t - 2.
			(1 - (t*t)) sqrt + 1 ])/2
]

{ #category : 'interpolation' }
RSCircleInterpolator >> interpolateOut: i [
	| t |
	t := i -1.
	^ (1 - (t* t)) sqrt
]
