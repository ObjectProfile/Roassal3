Class {
	#name : 'RandomBernoulli',
	#superclass : 'Random',
	#instVars : [
		'p'
	],
	#category : 'Roassal3-Random',
	#package : 'Roassal3',
	#tag : 'Random'
}

{ #category : 'accessing' }
RandomBernoulli >> density: x [

	^ p ** x * (1 - p ** (1 - x))
]

{ #category : 'accessing' }
RandomBernoulli >> ifHead: hBlock ifTail: tBlock [

	^ self next ifZero: tBlock ifNotZero: hBlock
]

{ #category : 'initialization' }
RandomBernoulli >> initialize [

	super initialize.

	self p: 0.5
]

{ #category : 'accessing' }
RandomBernoulli >> next [

	^ (super next < p) asInteger
]

{ #category : 'accessing' }
RandomBernoulli >> p: aNumber [

	p := aNumber
]
