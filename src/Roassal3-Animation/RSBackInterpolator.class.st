"
TSEasing backIn
Anticipatory easing, like a dancer bending his knees before jumping off the floor. The degree of overshoot is configurable; if not specified, it defaults to 1.70158.

TSEasing backOut 
Reverse anticipatory easing; equivalent to 1 - (backIn value: 1 - t).

TSEasing back 
TSEasing backInOut
Symmetric anticipatory easing; scales backIn for t in [0, 0.5] and backOut for t in [0.5, 1].
"
Class {
	#name : #RSBackInterpolator,
	#superclass : #RSEasingInterpolator,
	#instVars : [
		'overshoot'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #initialization }
RSBackInterpolator >> initialize [
	super initialize.
	overshoot := 1.70158
]

{ #category : #interpolation }
RSBackInterpolator >> interpolateIn: t [
	^ t * t * ((overshoot + 1) * t - overshoot)
]

{ #category : #interpolation }
RSBackInterpolator >> interpolateInOut: i [
	"((t *= 2) < 1 ? t * t * ((s + 1) * t - s) : (t -= 2) * t * ((s + 1) * t + s) + 2) / 2;"
	| t |
	t := i * 2.
	^ (t < 1
		ifTrue: [ t * t * ((overshoot + 1) * t - overshoot) ]
		ifFalse: [
			t := t -2.
			t * t * ((overshoot + 1) * t + overshoot) + 2 ])/2
]

{ #category : #interpolation }
RSBackInterpolator >> interpolateOut: i [
	| t |
	t := i -1.
	^ t * t * ((overshoot + 1) * t + overshoot) + 1
]

{ #category : #accessing }
RSBackInterpolator >> overshoot [
	^ overshoot
]

{ #category : #accessing }
RSBackInterpolator >> overshoot: aNumber [
	overshoot := aNumber
]
