"
TODO
"
Class {
	#name : #RSColorHSBGenerator,
	#superclass : #RSAbstractColorGenerator,
	#instVars : [
		'colors'
	],
	#category : #'Roassal3-Experimental-Force'
}

{ #category : #accessing }
RSColorHSBGenerator >> backgroundColor [
	^ Color black
]

{ #category : #accessing }
RSColorHSBGenerator >> colorFor: aParticle [
	colors ifNil: [ colors := Dictionary new ].
	^ colors at: aParticle ifAbsentPut: [
		Color h: aParticle position angle radiansToDegrees s: 1 v: 1
		 ]
]
