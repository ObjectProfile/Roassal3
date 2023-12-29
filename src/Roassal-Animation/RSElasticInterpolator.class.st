"
RSEasingInterpolator elasticIn
Elastic easing, like a rubber band. The amplitude and period of the oscillation are configurable; if not specified, they default to 1 and 0.3, respectively.

RSEasingInterpolator elasticOut
Reverse elastic easing; equivalent to 1 - elasticIn(1 - t).

RSEasingInterpolator elastic 
RSEasingInterpolator elasticInOut.
Symmetric elastic easing; scales elasticIn for t in [0, 0.5] and elasticOut for t in [0.5, 1].
"
Class {
	#name : 'RSElasticInterpolator',
	#superclass : 'RSEasingInterpolator',
	#instVars : [
		'tau',
		'amplitude',
		'period',
		's'
	],
	#category : 'Roassal-Animation-Easing',
	#package : 'Roassal-Animation',
	#tag : 'Easing'
}

{ #category : 'accessing' }
RSElasticInterpolator >> amplitude [
	^ amplitude
]

{ #category : 'accessing' }
RSElasticInterpolator >> amplitude: a [
	amplitude := a.
	period := period * tau.
	self calculateS
]

{ #category : 'accessing' }
RSElasticInterpolator >> calculateS [
	"var s = Math.asin(1 / (a = Math.max(1, a))) * (p /= tau);"
	amplitude := 1 max: amplitude.
	period := period / tau.
	s := (1 / amplitude) arcSin * period
]

{ #category : 'initialization' }
RSElasticInterpolator >> initialize [
	super initialize.
	tau := 2* Float pi.
	amplitude := 1.
	period := 0.3.

	self calculateS
]

{ #category : 'interpolation' }
RSElasticInterpolator >> interpolateIn: i [
	| t |
	t := i -1.
	^ amplitude * (2 raisedTo: 10*t) * ((s - t) / period) sin
]

{ #category : 'interpolation' }
RSElasticInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2 - 1.
	^ (t < 0
		ifTrue: [ amplitude * (2 raisedTo: 10 * t) * ((s - t)/period) sin ]
		ifFalse: [ 2 - (amplitude * (2 raisedTo: -10 * t) * ((s + t)/period) sin )   ]) / 2
]

{ #category : 'interpolation' }
RSElasticInterpolator >> interpolateOut: t [
	^ 1 - (amplitude * (2 raisedTo: -10 * t ) * ((t + s) / period) sin )
]

{ #category : 'accessing' }
RSElasticInterpolator >> period [
	^ period
]

{ #category : 'accessing' }
RSElasticInterpolator >> period: p [
	period := p.
	self calculateS
]
