"
TSEasing elasticIn
Elastic easing, like a rubber band. The amplitude and period of the oscillation are configurable; if not specified, they default to 1 and 0.3, respectively.

TSEasing elasticOut
Reverse elastic easing; equivalent to 1 - elasticIn(1 - t).

TSEasing elastic 
TSEasing elasticInOut.
Symmetric elastic easing; scales elasticIn for t in [0, 0.5] and elasticOut for t in [0.5, 1].
"
Class {
	#name : #TSElasticInterpolator,
	#superclass : #TSEasing,
	#instVars : [
		'tau',
		'amplitude',
		'period',
		's'
	],
	#category : #'Roassal3-Animation-Easing'
}

{ #category : #accessing }
TSElasticInterpolator >> amplitude [
	^ amplitude
]

{ #category : #accessing }
TSElasticInterpolator >> amplitude: a [
	amplitude := a.
	period := period * tau.
	self calculateS.
]

{ #category : #accessing }
TSElasticInterpolator >> calculateS [
	"var s = Math.asin(1 / (a = Math.max(1, a))) * (p /= tau);"
	amplitude := 1 max: amplitude.
	period := period / tau.
	s := (1 / amplitude) arcSin * period 
]

{ #category : #initialization }
TSElasticInterpolator >> initialize. [
	super initialize.
	tau := 2* Float pi.
	amplitude := 1.
	period := 0.3.
	self calculateS.
]

{ #category : #interpolation }
TSElasticInterpolator >> interpolateIn: i [
	| t |
	t := i -1.
	^ amplitude * (2 raisedTo: 10*t) * ((s - t) / period) sin
]

{ #category : #interpolation }
TSElasticInterpolator >> interpolateInOut: i [
	| t |
	t := i * 2 - 1.
	^ (t < 0
		ifTrue: [ amplitude * (2 raisedTo: 10 * t) * ((s - t)/period) sin ]
		ifFalse: [ 2 - (amplitude * (2 raisedTo: -10 * t) * ((s + t)/period) sin )   ]) / 2.
]

{ #category : #interpolation }
TSElasticInterpolator >> interpolateOut: t [
	^ 1 - (amplitude * (2 raisedTo: -10 * t ) * ((t + s) / period) sin )
]

{ #category : #accessing }
TSElasticInterpolator >> period [
	^ period
]

{ #category : #accessing }
TSElasticInterpolator >> period: p [
	period := p.
	self calculateS.
]
