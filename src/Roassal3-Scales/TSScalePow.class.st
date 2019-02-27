"
I scale using pow function
"
Class {
	#name : #TSScalePow,
	#superclass : #TSScaleLinear,
	#instVars : [
		'linear',
		'exponent',
		'powp',
		'powb'
	],
	#category : #'Roassal3-Scales-Core'
}

{ #category : #accessing }
TSScalePow >> clamp: x [
	linear clamp: x
]

{ #category : #accessing }
TSScalePow >> domain: x [
	linear domain: ((domain := x) collect: [ :i | powp scale: i ]).
]

{ #category : #accessing }
TSScalePow >> exponent [
	^ exponent
]

{ #category : #accessing }
TSScalePow >> exponent: x [
	exponent := x.
	powp exponent: exponent.
	powb exponent: 1/exponent.
	linear domain: (domain collect: [ :i | powp scale: i ])
]

{ #category : #initialization }
TSScalePow >> initialize [
	super initialize.
	linear := self class linear.
	exponent := 1.
	domain := #(0 1).
	powp := TSScalePowPow exponent: exponent.
	powb := TSScalePowPow exponent: 1 / exponent.
]

{ #category : #initialization }
TSScalePow >> interpolate [
	^ linear interpolate
]

{ #category : #initialization }
TSScalePow >> interpolate: x [
	linear interpolate: x
]

{ #category : #initialization }
TSScalePow >> invert: x [
	^ powb scale: (linear invert: x)
]

{ #category : #initialization }
TSScalePow >> range [
	^ linear range
]

{ #category : #initialization }
TSScalePow >> range: x [
	linear range: x
]

{ #category : #initialization }
TSScalePow >> rescale [
]

{ #category : #initialization }
TSScalePow >> scale: x [
	^ linear scale: (powp scale: x)
]
