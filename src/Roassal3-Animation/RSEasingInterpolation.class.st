"
Given the specified normalized time t, typically in the range [0,1], returns the “eased” time tʹ, also typically in [0,1]. 0 represents the start of the animation and 1 represents the end. A good implementation returns 0 if t = 0 and 1 if t = 1.

I am highly inspired from d3js source code https://github.com/d3/d3-transition and from the base animation of Bloc https://github.com/pharo-graphics/Bloc
"
Class {
	#name : #RSEasingInterpolation,
	#superclass : #NSInterpolator,
	#instVars : [
		'useOut',
		'useIn'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #back }
RSEasingInterpolation class >> back [
	^ self backInOut
]

{ #category : #back }
RSEasingInterpolation class >> backIn [
	^ RSBackInterpolator new in
]

{ #category : #back }
RSEasingInterpolation class >> backInOut [
	^ RSBackInterpolator new
]

{ #category : #back }
RSEasingInterpolation class >> backOut [
	^ RSBackInterpolator new out
]

{ #category : #bounce }
RSEasingInterpolation class >> bounce [
	^ self bounceOut
]

{ #category : #bounce }
RSEasingInterpolation class >> bounceIn [
	^ RSBounceInterpolator new in
]

{ #category : #bounce }
RSEasingInterpolation class >> bounceInOut [
	^ RSBounceInterpolator new
]

{ #category : #bounce }
RSEasingInterpolation class >> bounceOut [
	^ RSBounceInterpolator new out
]

{ #category : #circle }
RSEasingInterpolation class >> circle [
	^ self circleInOut
]

{ #category : #circle }
RSEasingInterpolation class >> circleIn [
	^ RSCircleInterpolator new in
]

{ #category : #circle }
RSEasingInterpolation class >> circleInOut [
	^ RSCircleInterpolator new
]

{ #category : #circle }
RSEasingInterpolation class >> circleOut [
	^ RSCircleInterpolator new out
]

{ #category : #cubic }
RSEasingInterpolation class >> cubic [
	^ self cubicInOut
]

{ #category : #cubic }
RSEasingInterpolation class >> cubicIn [
	^ RSCubicInterpolator new in
]

{ #category : #cubic }
RSEasingInterpolation class >> cubicInOut [
	^ RSCubicInterpolator new
]

{ #category : #cubic }
RSEasingInterpolation class >> cubicOut [
	^ RSCubicInterpolator new out
]

{ #category : #elastic }
RSEasingInterpolation class >> elastic [
	^ self elasticInOut
]

{ #category : #elastic }
RSEasingInterpolation class >> elasticIn [
	^ RSElasticInterpolator new in
]

{ #category : #elastic }
RSEasingInterpolation class >> elasticInOut [
	^ RSElasticInterpolator new
]

{ #category : #elastic }
RSEasingInterpolation class >> elasticOut [
	^ RSElasticInterpolator new out
]

{ #category : #exp }
RSEasingInterpolation class >> exp [
	^ self expInOut
]

{ #category : #exp }
RSEasingInterpolation class >> expIn [
	^ RSExpInterpolator new in
]

{ #category : #exp }
RSEasingInterpolation class >> expInOut [
	^ RSExpInterpolator new
]

{ #category : #exp }
RSEasingInterpolation class >> expOut [
	^ RSExpInterpolator new out
]

{ #category : #linear }
RSEasingInterpolation class >> linear [
	^ RSLinearInterpolator new
]

{ #category : #poly }
RSEasingInterpolation class >> poly [
	^ self polyInOut
]

{ #category : #poly }
RSEasingInterpolation class >> polyIn [
	^ RSPolyInterpolator new in
]

{ #category : #poly }
RSEasingInterpolation class >> polyInOut [
	^ RSPolyInterpolator new.
]

{ #category : #poly }
RSEasingInterpolation class >> polyOut [
	^ RSPolyInterpolator new out
]

{ #category : #quad }
RSEasingInterpolation class >> quad [
	^ self quadInOut
]

{ #category : #quad }
RSEasingInterpolation class >> quadIn [
	^ RSQuadInterpolator new in
]

{ #category : #quad }
RSEasingInterpolation class >> quadInOut [
	^ RSQuadInterpolator new
]

{ #category : #quad }
RSEasingInterpolation class >> quadOut [
	^ RSQuadInterpolator new out
]

{ #category : #sin }
RSEasingInterpolation class >> sin [
	^ self sinInOut
]

{ #category : #sin }
RSEasingInterpolation class >> sinIn [
	^ RSSinInterpolator new in
]

{ #category : #sin }
RSEasingInterpolation class >> sinInOut [
	^ RSSinInterpolator new
]

{ #category : #sin }
RSEasingInterpolation class >> sinOut [
	^ RSSinInterpolator new out
]

{ #category : #actions }
RSEasingInterpolation >> in [
	useIn := true.
]

{ #category : #actions }
RSEasingInterpolation >> inOut [
	useIn := useOut := false
]

{ #category : #initialization }
RSEasingInterpolation >> initialize [
	super initialize.
	self inOut.
]

{ #category : #interpolation }
RSEasingInterpolation >> interpolate: t [
	useIn ifTrue: [ ^ self interpolateIn: t ].
	useOut ifTrue: [ ^ self interpolateOut: t ].
	^ self interpolateInOut: t.
]

{ #category : #interpolation }
RSEasingInterpolation >> interpolateIn: t [
	^ self subclassResponsibility
]

{ #category : #interpolation }
RSEasingInterpolation >> interpolateInOut: t [
	^ self subclassResponsibility 
]

{ #category : #interpolation }
RSEasingInterpolation >> interpolateOut: t [
	^ self subclassResponsibility
]

{ #category : #actions }
RSEasingInterpolation >> out [ 
	useOut := true.
]
