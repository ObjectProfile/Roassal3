"
TODO
"
Class {
	#name : #RSColorPerlinGenerator,
	#superclass : #RSAbstractColorGenerator,
	#instVars : [
		'perlin'
	],
	#category : #'Roassal3-Experimental-Force'
}

{ #category : #accessing }
RSColorPerlinGenerator >> backgroundColor [
	^ Color black
]

{ #category : #accessing }
RSColorPerlinGenerator >> colorFor: aParticle [
	| period n p color |
	period := 0.005.
	p := aParticle position.
	n := perlin noise: p x * period and: p y * period.
	color := Color h: -210 + (n * 600) s: 1 l: 8 * n * n * n.
	^ color alpha: 0.03
]

{ #category : #initialization }
RSColorPerlinGenerator >> initialize [
	super initialize.
	perlin := NSPerlinNoise3 new octaves: 5
]

{ #category : #accessing }
RSColorPerlinGenerator >> perlin: aNSPerlin [
	perlin := aNSPerlin
]
