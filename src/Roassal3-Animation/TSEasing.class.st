"
Given the specified normalized time t, typically in the range [0,1], returns the “eased” time tʹ, also typically in [0,1]. 0 represents the start of the animation and 1 represents the end. A good implementation returns 0 if t = 0 and 1 if t = 1.

I am highli inspired in d3js source code https://github.com/d3/d3-transition and in the base animation of Bloc https://github.com/pharo-graphics/Bloc
"
Class {
	#name : #TSEasing,
	#superclass : #TSInterpolator,
	#instVars : [
		'useOut',
		'useIn'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #back }
TSEasing class >> back [
	^ self backInOut
]

{ #category : #back }
TSEasing class >> backIn [
	^ TSBackInterpolator new in
]

{ #category : #back }
TSEasing class >> backInOut [
	^ TSBackInterpolator new
]

{ #category : #back }
TSEasing class >> backOut [
	^ TSBackInterpolator new out
]

{ #category : #bounce }
TSEasing class >> bounce [
	^ self bounceOut
]

{ #category : #bounce }
TSEasing class >> bounceIn [
	^ TSBounceInterpolator new in
]

{ #category : #bounce }
TSEasing class >> bounceInOut [
	^ TSBounceInterpolator new
]

{ #category : #bounce }
TSEasing class >> bounceOut [
	^ TSBounceInterpolator new out
]

{ #category : #circle }
TSEasing class >> circle [
	^ self circleInOut
]

{ #category : #circle }
TSEasing class >> circleIn [
	^ TSCircleInterpolator new in
]

{ #category : #circle }
TSEasing class >> circleInOut [
	^ TSCircleInterpolator new
]

{ #category : #circle }
TSEasing class >> circleOut [
	^ TSCircleInterpolator new out
]

{ #category : #cubic }
TSEasing class >> cubic [
	^ self cubicInOut
]

{ #category : #cubic }
TSEasing class >> cubicIn [
	^ TSCubicInterpolator new in
]

{ #category : #cubic }
TSEasing class >> cubicInOut [
	^ TSCubicInterpolator new
]

{ #category : #cubic }
TSEasing class >> cubicOut [
	^ TSCubicInterpolator new out
]

{ #category : #elastic }
TSEasing class >> elastic [
	^ self elasticInOut
]

{ #category : #elastic }
TSEasing class >> elasticIn [
	^ TSElasticInterpolator new in
]

{ #category : #elastic }
TSEasing class >> elasticInOut [
	^ TSElasticInterpolator new
]

{ #category : #elastic }
TSEasing class >> elasticOut [
	^ TSElasticInterpolator new out
]

{ #category : #exp }
TSEasing class >> exp [
	^ self expInOut
]

{ #category : #exp }
TSEasing class >> expIn [
	^ TSExpInterpolator new in
]

{ #category : #exp }
TSEasing class >> expInOut [
	^ TSExpInterpolator new
]

{ #category : #exp }
TSEasing class >> expOut [
	^ TSExpInterpolator new out
]

{ #category : #linear }
TSEasing class >> linear [
	^ TSLinearInterpolator new
]

{ #category : #poly }
TSEasing class >> poly [
	^ self polyInOut
]

{ #category : #poly }
TSEasing class >> polyIn [
	^ TSPolyInterpolator new in
]

{ #category : #poly }
TSEasing class >> polyInOut [
	^ TSPolyInterpolator new.
]

{ #category : #poly }
TSEasing class >> polyOut [
	^ TSPolyInterpolator new out
]

{ #category : #quad }
TSEasing class >> quad [
	^ self quadInOut
]

{ #category : #quad }
TSEasing class >> quadIn [
	^ TSQuadInterpolator new in
]

{ #category : #quad }
TSEasing class >> quadInOut [
	^ TSQuadInterpolator new
]

{ #category : #quad }
TSEasing class >> quadOut [
	^ TSQuadInterpolator new out
]

{ #category : #sin }
TSEasing class >> sin [
	^ self sinInOut
]

{ #category : #sin }
TSEasing class >> sinIn [
	^ TSSinInterpolator new in
]

{ #category : #sin }
TSEasing class >> sinInOut [
	^ TSSinInterpolator new
]

{ #category : #sin }
TSEasing class >> sinOut [
	^ TSSinInterpolator new out
]

{ #category : #actions }
TSEasing >> in [
	useIn := true.
]

{ #category : #actions }
TSEasing >> inOut [
	useIn := useOut := false
]

{ #category : #initialization }
TSEasing >> initialize [
	super initialize.
	self inOut.
]

{ #category : #interpolation }
TSEasing >> interpolate: t [
	useIn ifTrue: [ ^ self interpolateIn: t ].
	useOut ifTrue: [ ^ self interpolateOut: t ].
	^ self interpolateInOut: t.
]

{ #category : #interpolation }
TSEasing >> interpolateIn: t [
	^ self subclassResponsibility
]

{ #category : #interpolation }
TSEasing >> interpolateInOut: t [
	^ self subclassResponsibility 
]

{ #category : #interpolation }
TSEasing >> interpolateOut: t [
	^ self subclassResponsibility
]

{ #category : #actions }
TSEasing >> out [ 
	useOut := true.
]
