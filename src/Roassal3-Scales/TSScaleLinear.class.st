"
I follow the linear function
"
Class {
	#name : #TSScaleLinear,
	#superclass : #TSScale,
	#instVars : [
		'clamp',
		'input',
		'output'
	],
	#category : #'Roassal3-Scales-Core'
}

{ #category : #accessing }
TSScaleLinear >> clamp: aBool [
	"If clamp is specified, enables or disables clamping accordingly. If clamping is disabled and the scale is passed a value outside the domain, the scale may return a value outside the range through extrapolation. If clamping is enabled, the return value of the scale is always within the scale’s range."
	clamp := aBool.
	self rescale.
]

{ #category : #accessing }
TSScaleLinear >> domain: x [
	super domain: x.
	self rescale.
]

{ #category : #initialization }
TSScaleLinear >> initialize [
	super initialize.
	range := domain := #(0 1).
	clamp := false.
	interpolate := TSInterpolator.
	self rescale.
]

{ #category : #accessing }
TSScaleLinear >> interpolate: x [
	interpolate := x.
	self rescale.
]

{ #category : #transformation }
TSScaleLinear >> invert: y [
	^ input scale: y.
]

{ #category : #accessing }
TSScaleLinear >> range: r [
	super range: r.
	self rescale.
]

{ #category : #accessing }
TSScaleLinear >> rangeRound: x [
	"x is a range"
	self 
		range: x;
		interpolate: TSRoundInterpolator.
]

{ #category : #hooks }
TSScaleLinear >> rescale [
	| linear |
	linear := (domain size min: range size ) > 2
		ifTrue: [ TSScalePolylinear ]
		ifFalse: [ TSScaleBilinear ].
	uninterpolate := clamp
		ifTrue: [ TSUninterpolateClamp ]
		ifFalse: [ TSUninterpolateNumber ].
	output := linear new domain: domain; range: range; 
		uninterpolate: uninterpolate; interpolate: interpolate.
	output rescale.
	input := linear new domain: range; range: domain;
		uninterpolate: uninterpolate; interpolate: TSInterpolator.
	input rescale.
]

{ #category : #transformation }
TSScaleLinear >> scale: x [
	^ output scale: x
]
