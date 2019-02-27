"
Given the specified normalized time t, typically in the range [0,1], returns the “eased” time tʹ, also typically in [0,1]. 0 represents the start of the animation and 1 represents the end. A good implementation returns 0 if t = 0 and 1 if t = 1.
"
Class {
	#name : #TSEasing,
	#superclass : #TSInterpolator,
	#instVars : [
		'exponent'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #back }
TSEasing class >> back [
	^ self backInOut
]

{ #category : #back }
TSEasing class >> backIn [
	^ TSBackInInterpolator new
]

{ #category : #back }
TSEasing class >> backInOut [
	^ TSBackInOutInterpolator new
]

{ #category : #back }
TSEasing class >> backOut [
	^ TSBackOutInterpolator new
]

{ #category : #bounce }
TSEasing class >> bounce [
	^ self bounceInOut
]

{ #category : #bounce }
TSEasing class >> bounceIn [
	^ TSBounceInInterpolator new
]

{ #category : #bounce }
TSEasing class >> bounceInOut [
	^ TSBounceInOutInterpolator new
]

{ #category : #bounce }
TSEasing class >> bounceOut [
	^ TSBounceOutInterpolator new
]

{ #category : #circle }
TSEasing class >> circle [
	^ self circleInOut
]

{ #category : #circle }
TSEasing class >> circleIn [
	^ TSCircleInInterpolator new
]

{ #category : #circle }
TSEasing class >> circleInOut [
	^ TSCircleInOutInterpolator new
]

{ #category : #circle }
TSEasing class >> circleOut [
	^ TSCircleOutInterpolator new
]

{ #category : #cubic }
TSEasing class >> cubic [
	^ self cubicInOut
]

{ #category : #cubic }
TSEasing class >> cubicIn [
	^ TSCubicInInterpolator new
]

{ #category : #cubic }
TSEasing class >> cubicInOut [
	^ TSCubicInOutInterpolator new
]

{ #category : #cubic }
TSEasing class >> cubicOut [
	^ TSCubicOutInterpolator new
]

{ #category : #elastic }
TSEasing class >> elastic [
	^ self elasticInOut
]

{ #category : #elastic }
TSEasing class >> elasticIn [
	^ TSElasticInInterpolator new
]

{ #category : #elastic }
TSEasing class >> elasticInOut [
	^ TSElasticInOutInterpolator new
]

{ #category : #elastic }
TSEasing class >> elasticOut [
	^ TSElasticOutInterpolator new
]

{ #category : #exp }
TSEasing class >> exp [
	^ self expInOut
]

{ #category : #exp }
TSEasing class >> expIn [
	^ TSExpInInterpolator new
]

{ #category : #exp }
TSEasing class >> expInOut [
	^ TSExpInOutInterpolator new
]

{ #category : #exp }
TSEasing class >> expOut [
	^ TSExpOutInterpolator new
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
	^ TSPolyInInterpolator new.
]

{ #category : #poly }
TSEasing class >> polyInOut [
	^ TSPolyInOutInterpolator new.
]

{ #category : #poly }
TSEasing class >> polyOut [
	^ TSPolyOutInterpolator new.
]

{ #category : #quad }
TSEasing class >> quad [
	^ self quadInOut
]

{ #category : #quad }
TSEasing class >> quadIn [
	^ TSQuadInInterpolator new
]

{ #category : #quad }
TSEasing class >> quadInOut [
	^ TSQuadInOutInterpolator new
]

{ #category : #quad }
TSEasing class >> quadOut [
	^ TSQuadOutInterpolator new
]

{ #category : #sin }
TSEasing class >> sin [
	^ self sinInOut
]

{ #category : #sin }
TSEasing class >> sinIn [
	^ TSSinInInterpolator new
]

{ #category : #sin }
TSEasing class >> sinInOut [
	^ TSSinInOutInterpolator new
]

{ #category : #sin }
TSEasing class >> sinOut [
	^ TSSinOutInterpolator new
]

{ #category : #interpolation }
TSEasing >> interpolate: t [
	self shouldNotImplement
]
