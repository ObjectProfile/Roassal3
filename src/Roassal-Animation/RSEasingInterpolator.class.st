"
Given the specified normalized time t, typically in the range [0,1], returns the “eased” time tʹ, also typically in [0,1]. 0 represents the start of the animation and 1 represents the end. A good implementation returns 0 if t = 0 and 1 if t = 1.

I am highly inspired from d3js source code https://github.com/d3/d3-transition and from the base animation of Bloc https://github.com/pharo-graphics/Bloc
"
Class {
	#name : 'RSEasingInterpolator',
	#superclass : 'NSInterpolator',
	#instVars : [
		'useOut',
		'useIn'
	],
	#category : 'Roassal-Animation-Easing',
	#package : 'Roassal-Animation',
	#tag : 'Easing'
}

{ #category : 'back' }
RSEasingInterpolator class >> back [
	^ self backInOut
]

{ #category : 'back' }
RSEasingInterpolator class >> backIn [
	^ RSBackInterpolator new in
]

{ #category : 'back' }
RSEasingInterpolator class >> backInOut [
	^ RSBackInterpolator new
]

{ #category : 'back' }
RSEasingInterpolator class >> backOut [
	^ RSBackInterpolator new out
]

{ #category : 'bounce' }
RSEasingInterpolator class >> bounce [
	^ self bounceOut
]

{ #category : 'bounce' }
RSEasingInterpolator class >> bounceIn [
	^ RSBounceInterpolator new in
]

{ #category : 'bounce' }
RSEasingInterpolator class >> bounceInOut [
	^ RSBounceInterpolator new
]

{ #category : 'bounce' }
RSEasingInterpolator class >> bounceOut [
	^ RSBounceInterpolator new out
]

{ #category : 'circle' }
RSEasingInterpolator class >> circle [
	^ self circleInOut
]

{ #category : 'circle' }
RSEasingInterpolator class >> circleIn [
	^ RSCircleInterpolator new in
]

{ #category : 'circle' }
RSEasingInterpolator class >> circleInOut [
	^ RSCircleInterpolator new
]

{ #category : 'circle' }
RSEasingInterpolator class >> circleOut [
	^ RSCircleInterpolator new out
]

{ #category : 'cubic' }
RSEasingInterpolator class >> cubic [
	^ self cubicInOut
]

{ #category : 'cubic' }
RSEasingInterpolator class >> cubicIn [
	^ RSCubicInterpolator new in
]

{ #category : 'cubic' }
RSEasingInterpolator class >> cubicInOut [
	^ RSCubicInterpolator new
]

{ #category : 'cubic' }
RSEasingInterpolator class >> cubicOut [
	^ RSCubicInterpolator new out
]

{ #category : 'elastic' }
RSEasingInterpolator class >> elastic [
	^ self elasticInOut
]

{ #category : 'elastic' }
RSEasingInterpolator class >> elasticIn [
	^ RSElasticInterpolator new in
]

{ #category : 'elastic' }
RSEasingInterpolator class >> elasticInOut [
	^ RSElasticInterpolator new
]

{ #category : 'elastic' }
RSEasingInterpolator class >> elasticOut [
	^ RSElasticInterpolator new out
]

{ #category : 'exp' }
RSEasingInterpolator class >> exp [
	^ self expInOut
]

{ #category : 'exp' }
RSEasingInterpolator class >> expIn [
	^ RSExpInterpolator new in
]

{ #category : 'exp' }
RSEasingInterpolator class >> expInOut [
	^ RSExpInterpolator new
]

{ #category : 'exp' }
RSEasingInterpolator class >> expOut [
	^ RSExpInterpolator new out
]

{ #category : 'linear' }
RSEasingInterpolator class >> linear [
	^ RSLinearInterpolator new
]

{ #category : 'poly' }
RSEasingInterpolator class >> poly [
	^ self polyInOut
]

{ #category : 'poly' }
RSEasingInterpolator class >> polyIn [
	^ RSPolyInterpolator new in
]

{ #category : 'poly' }
RSEasingInterpolator class >> polyInOut [
	^ RSPolyInterpolator new
]

{ #category : 'poly' }
RSEasingInterpolator class >> polyOut [
	^ RSPolyInterpolator new out
]

{ #category : 'quad' }
RSEasingInterpolator class >> quad [
	^ self quadInOut
]

{ #category : 'quad' }
RSEasingInterpolator class >> quadIn [
	^ RSQuadInterpolator new in
]

{ #category : 'quad' }
RSEasingInterpolator class >> quadInOut [
	^ RSQuadInterpolator new
]

{ #category : 'quad' }
RSEasingInterpolator class >> quadOut [
	^ RSQuadInterpolator new out
]

{ #category : 'sin' }
RSEasingInterpolator class >> sin [
	^ self sinInOut
]

{ #category : 'sin' }
RSEasingInterpolator class >> sinIn [
	^ RSSinInterpolator new in
]

{ #category : 'sin' }
RSEasingInterpolator class >> sinInOut [
	^ RSSinInterpolator new
]

{ #category : 'sin' }
RSEasingInterpolator class >> sinOut [
	^ RSSinInterpolator new out
]

{ #category : 'actions' }
RSEasingInterpolator >> in [
	useIn := true
]

{ #category : 'actions' }
RSEasingInterpolator >> inOut [
	useIn := useOut := false
]

{ #category : 'initialization' }
RSEasingInterpolator >> initialize [
	super initialize.
	self inOut
]

{ #category : 'interpolation' }
RSEasingInterpolator >> interpolate: t [
	useIn ifTrue: [ ^ self interpolateIn: t ].
	useOut ifTrue: [ ^ self interpolateOut: t ].
	^ self interpolateInOut: t
]

{ #category : 'interpolation' }
RSEasingInterpolator >> interpolateIn: t [
	^ self subclassResponsibility
]

{ #category : 'interpolation' }
RSEasingInterpolator >> interpolateInOut: t [
	^ self subclassResponsibility
]

{ #category : 'interpolation' }
RSEasingInterpolator >> interpolateOut: t [
	^ self subclassResponsibility
]

{ #category : 'actions' }
RSEasingInterpolator >> out [
	useOut := true
]
