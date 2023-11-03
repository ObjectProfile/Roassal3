Class {
	#name : 'RandomExponential',
	#superclass : 'Random',
	#instVars : [
		'lambda'
	],
	#category : 'Roassal3-Random',
	#package : 'Roassal3',
	#tag : 'Random'
}

{ #category : 'accessing' }
RandomExponential >> density: x [

	^ lambda * (lambda * x) negated exp
]

{ #category : 'initialization' }
RandomExponential >> initialize [

	super initialize.

	self lambda: 1
]

{ #category : 'accessing' }
RandomExponential >> lambda: anObject [

	lambda := anObject
]

{ #category : 'accessing' }
RandomExponential >> next [

	^ (1 - super next) ln negated / lambda
]
