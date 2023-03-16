"
TSEasing bounceIn
Bounce easing, like a rubber ball.

TSEasing bounce
TSEasing bounceOut
Reverse bounce easing; equivalent to 1 - bounceIn(1 - t).

TSEasing bounceInOut
Symmetric bounce easing; scales bounceIn for t in [0, 0.5] and bounceOut for t in [0.5, 1].
"
Class {
	#name : #RSBounceInterpolator,
	#superclass : #RSEasingInterpolator,
	#instVars : [
		'b1',
		'b2',
		'b3',
		'b4',
		'b5',
		'b6',
		'b7',
		'b8',
		'b9',
		'b0'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #initialization }
RSBounceInterpolator >> initialize [
	super initialize.
	b1 := 4 / 11.
	b2 := 6 / 11.
	b3 := 8 / 11.
	b4 := 3 / 4.
	b5 := 9 / 11.
	b6 := 10 / 11.
	b7 := 15 / 16.
	b8 := 21 / 22.
	b9 := 63 / 64.
	b0 := 1 / b1 / b1
]

{ #category : #interpolation }
RSBounceInterpolator >> interpolateIn: t [
	^ 1 - (self interpolateOut: 1 - t)
]

{ #category : #interpolation }
RSBounceInterpolator >> interpolateInOut: i [
	"((t *= 2) <= 1 ? 1 - bounceOut(1 - t) : bounceOut(t - 1) + 1) / 2;"
	| t |
	t := i * 2.
	^ (t <= 1
		ifTrue: [ 1 - (self interpolateOut: 1 -t) ]
		ifFalse: [ (self interpolateOut: t - 1) + 1 ] )/2
]

{ #category : #interpolation }
RSBounceInterpolator >> interpolateOut: i [
	| t |
	t := i.
	^ t < b1
		ifTrue: [ b0 * t * t ]
		ifFalse: [
			t < b3 ifTrue: [
				t := t - b2.
				b0 * t * t + b4 ]
			ifFalse: [
				t < b6 ifTrue: [
					t := t - b5.
					b0 * t * t + b7 ]
				ifFalse: [
					t := t - b8.
					b0 * t * t + b9 ] ] ]
]
