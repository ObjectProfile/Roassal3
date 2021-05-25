"
Given the specified normalized time t, typically in the range [0,1], returns the “eased” time tʹ, also typically in [0,1]. 0 represents the start of the animation and 1 represents the end. A good implementation returns 0 if t = 0 and 1 if t = 1.

I am highly inspired from d3js source code https://github.com/d3/d3-transition and from the base animation of Bloc https://github.com/pharo-graphics/Bloc
"
Class {
	#name : #RSEasing,
	#superclass : #NSInterpolator,
	#instVars : [
		'useOut',
		'useIn'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #back }
RSEasing class >> back [
	^ self backInOut
]

{ #category : #back }
RSEasing class >> backIn [
	^ RSBackInterpolator new in
]

{ #category : #back }
RSEasing class >> backInOut [
	^ RSBackInterpolator new
]

{ #category : #back }
RSEasing class >> backOut [
	^ RSBackInterpolator new out
]

{ #category : #bounce }
RSEasing class >> bounce [
	^ self bounceOut
]

{ #category : #bounce }
RSEasing class >> bounceIn [
	^ RSBounceInterpolator new in
]

{ #category : #bounce }
RSEasing class >> bounceInOut [
	^ RSBounceInterpolator new
]

{ #category : #bounce }
RSEasing class >> bounceOut [
	^ RSBounceInterpolator new out
]

{ #category : #circle }
RSEasing class >> circle [
	^ self circleInOut
]

{ #category : #circle }
RSEasing class >> circleIn [
	^ RSCircleInterpolator new in
]

{ #category : #circle }
RSEasing class >> circleInOut [
	^ RSCircleInterpolator new
]

{ #category : #circle }
RSEasing class >> circleOut [
	^ RSCircleInterpolator new out
]

{ #category : #cubic }
RSEasing class >> cubic [
	^ self cubicInOut
]

{ #category : #cubic }
RSEasing class >> cubicIn [
	^ RSCubicInterpolator new in
]

{ #category : #cubic }
RSEasing class >> cubicInOut [
	^ RSCubicInterpolator new
]

{ #category : #cubic }
RSEasing class >> cubicOut [
	^ RSCubicInterpolator new out
]

{ #category : #elastic }
RSEasing class >> elastic [
	^ self elasticInOut
]

{ #category : #elastic }
RSEasing class >> elasticIn [
	^ RSElasticInterpolator new in
]

{ #category : #elastic }
RSEasing class >> elasticInOut [
	^ RSElasticInterpolator new
]

{ #category : #elastic }
RSEasing class >> elasticOut [
	^ RSElasticInterpolator new out
]

{ #category : #exp }
RSEasing class >> exp [
	^ self expInOut
]

{ #category : #exp }
RSEasing class >> expIn [
	^ RSExpInterpolator new in
]

{ #category : #exp }
RSEasing class >> expInOut [
	^ RSExpInterpolator new
]

{ #category : #exp }
RSEasing class >> expOut [
	^ RSExpInterpolator new out
]

{ #category : #linear }
RSEasing class >> linear [
	^ RSLinearInterpolator new
]

{ #category : #poly }
RSEasing class >> poly [
	^ self polyInOut
]

{ #category : #poly }
RSEasing class >> polyIn [
	^ RSPolyInterpolator new in
]

{ #category : #poly }
RSEasing class >> polyInOut [
	^ RSPolyInterpolator new.
]

{ #category : #poly }
RSEasing class >> polyOut [
	^ RSPolyInterpolator new out
]

{ #category : #quad }
RSEasing class >> quad [
	^ self quadInOut
]

{ #category : #quad }
RSEasing class >> quadIn [
	^ RSQuadInterpolator new in
]

{ #category : #quad }
RSEasing class >> quadInOut [
	^ RSQuadInterpolator new
]

{ #category : #quad }
RSEasing class >> quadOut [
	^ RSQuadInterpolator new out
]

{ #category : #sin }
RSEasing class >> sin [
	^ self sinInOut
]

{ #category : #sin }
RSEasing class >> sinIn [
	^ RSSinInterpolator new in
]

{ #category : #sin }
RSEasing class >> sinInOut [
	^ RSSinInterpolator new
]

{ #category : #sin }
RSEasing class >> sinOut [
	^ RSSinInterpolator new out
]

{ #category : #actions }
RSEasing >> in [
	useIn := true.
]

{ #category : #actions }
RSEasing >> inOut [
	useIn := useOut := false
]

{ #category : #initialization }
RSEasing >> initialize [
	super initialize.
	self inOut.
]

{ #category : #interpolation }
RSEasing >> interpolate: t [
	useIn ifTrue: [ ^ self interpolateIn: t ].
	useOut ifTrue: [ ^ self interpolateOut: t ].
	^ self interpolateInOut: t.
]

{ #category : #interpolation }
RSEasing >> interpolateIn: t [
	^ self subclassResponsibility
]

{ #category : #interpolation }
RSEasing >> interpolateInOut: t [
	^ self subclassResponsibility 
]

{ #category : #interpolation }
RSEasing >> interpolateOut: t [
	^ self subclassResponsibility
]

{ #category : #actions }
RSEasing >> out [ 
	useOut := true.
]
