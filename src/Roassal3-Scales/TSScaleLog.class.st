"
for scale log
"
Class {
	#name : #TSScaleLog,
	#superclass : #TSScaleLinear,
	#instVars : [
		'linear',
		'base',
		'positive'
	],
	#category : #'Roassal3-Scales'
}

{ #category : #accessing }
TSScaleLog >> base [
	^ base
]

{ #category : #accessing }
TSScaleLog >> base: number [
	base := number.
	linear domain: (domain collect: [:n | self lg: n ]).
]

{ #category : #accessing }
TSScaleLog >> clamp: x [
	 linear clamp: x
]

{ #category : #accessing }
TSScaleLog >> domain: arr [
	positive := arr first >= 0.
	domain := arr.
	linear domain: (arr collect: [:n | self lg: n]).
]

{ #category : #initialization }
TSScaleLog >> initialize [
	super initialize.
	linear := self class linear.
	base := 10.
	positive := true.
	domain := #(1 0).
]

{ #category : #accessing }
TSScaleLog >> interpolate [
	^ linear interpolate
]

{ #category : #accessing }
TSScaleLog >> interpolate: x [
	linear interpolate: x
]

{ #category : #transformation }
TSScaleLog >> invert: x [
	^ self pow: (linear invert: x).
]

{ #category : #'math functions' }
TSScaleLog >> lg: x [
	"logarithm"
	^ (positive 
		ifTrue: [ (x max: 0) ln ]
		ifFalse: [ (x > 0 ifTrue: [ 0 ] ifFalse: [ 0 - x ] ) ln negated ])
		/ (base ln).
		
]

{ #category : #'math functions' }
TSScaleLog >> pow: x [
	^ positive  
		ifTrue: [ base raisedTo: x ]
		ifFalse: [ (base raisedTo: x negated) negated ].
		
]

{ #category : #accessing }
TSScaleLog >> range [
	^ linear range
]

{ #category : #accessing }
TSScaleLog >> range: x [
	linear range: x
]

{ #category : #transformation }
TSScaleLog >> scale: x [
	^ linear scale: (self lg: x)
]
