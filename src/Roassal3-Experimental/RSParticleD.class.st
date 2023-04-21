"
I am used in the delaunay example
"
Class {
	#name : #RSParticleD,
	#superclass : #RSObject,
	#instVars : [
		'pos',
		'level',
		'vel',
		'life',
		'decay',
		'maxLevel'
	],
	#category : #'Roassal3-Experimental-Delaunay'
}

{ #category : #accessing }
RSParticleD >> decay [
	^ decay ifNil: [ decay := 0.90 ]
]

{ #category : #accessing }
RSParticleD >> decay: aNumber [
	decay := aNumber
]

{ #category : #initialization }
RSParticleD >> initialize [
	super initialize.
	life := 0
]

{ #category : #accessing }
RSParticleD >> level: anInteger [
	| r |
	level := anInteger.
	r := SharedRandom globalGenerator.
	vel := (r next @ r next)* 2 - 1.
	vel := vel * (NSScale linear domain: {0. self maxLevel}; range: #(5 2); scale: level)
]

{ #category : #accessing }
RSParticleD >> life [
	^ life
]

{ #category : #accessing }
RSParticleD >> maxLevel [
	^ maxLevel ifNil: [ maxLevel := 5 ]
]

{ #category : #accessing }
RSParticleD >> maxLevel: aNumber [
	maxLevel := aNumber
]

{ #category : #updating }
RSParticleD >> moveIn: particles [
	life := life + 1.
	"add friction"
	vel := vel * decay.
	pos := pos + vel.
	"spawn new particles if conditions are met "
	life % 10 = 0 ifTrue: [
		level > 0 ifTrue: [
			level := level - 1.
			particles add: (self class new
				position: pos;
				decay: decay;
				maxLevel: self maxLevel;
				level: level - 1) ].
		 ]
]

{ #category : #accessing }
RSParticleD >> position [
	^ pos
]

{ #category : #accessing }
RSParticleD >> position: aPoint [
	pos := aPoint
]

{ #category : #accessing }
RSParticleD >> velocity [
	^ vel r
]

{ #category : #'accessing structure variables' }
RSParticleD >> x [
	^ pos x
]

{ #category : #'accessing structure variables' }
RSParticleD >> y [
	^ pos y
]
