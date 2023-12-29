Class {
	#name : 'RandomGeometric',
	#superclass : 'RandomBernoulli',
	#category : 'Roassal3-Random',
	#package : 'Roassal3',
	#tag : 'Random'
}

{ #category : 'accessing' }
RandomGeometric >> density: x [

	^ 1 - p ** (x - 1) * p
]

{ #category : 'accessing' }
RandomGeometric >> next [

	| failures |
	failures := 0.
	[ 
	failures := failures + 1.
	super next = 0 ] whileTrue.

	^ failures
]
