Class {
	#name : 'RandomBinomial',
	#superclass : 'RandomBernoulli',
	#instVars : [
		'n'
	],
	#category : 'Roassal3-Random',
	#package : 'Roassal3',
	#tag : 'Random'
}

{ #category : 'accessing' }
RandomBinomial >> density: x [

	^ (n choose: x) * (p ** x) * (1 - p ** (n - x))
]

{ #category : 'accessing' }
RandomBinomial >> initialize [

	super initialize.

	self n: 1
]

{ #category : 'accessing' }
RandomBinomial >> n: anInteger [

	n := anInteger
]

{ #category : 'accessing' }
RandomBinomial >> next [

	^ (1 to: n)
		  inject: 0
		  into: [ :successes :each | successes + super next asInteger ]
]
