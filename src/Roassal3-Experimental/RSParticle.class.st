"
I am used in the delaunay example
"
Class {
	#name : #RSParticle,
	#superclass : #RSObject,
	#instVars : [
		'pos',
		'level',
		'vel',
		'life'
	],
	#category : #'Roassal3-Experimental-Delaunay'
}

{ #category : #initialization }
RSParticle >> initialize [
	super initialize.
	life := 0.
]

{ #category : #accessing }
RSParticle >> level: anInteger [ 
	| r |
	level := anInteger.
	r := SharedRandom globalGenerator.
	vel := (r next @ r next)* 2 - 1.
	vel := vel * (NSScale linear domain: #(0 5); range: #(5 2); scale: level).
]

{ #category : #accessing }
RSParticle >> life [
	^ life
]

{ #category : #updating }
RSParticle >> moveIn: particles [
	life := life + 1.
	"add friction"
	vel := vel * 0.9.
	pos := pos + vel.
	"spawn new particles if conditions are met "
	life % 10 = 0 ifTrue: [ 
		level > 0 ifTrue: [ 
			level := level - 1.
			particles add: (self class new
				position: pos;
				level: level - 1 ) ].
		 ].
]

{ #category : #accessing }
RSParticle >> position [
	^ pos
]

{ #category : #accessing }
RSParticle >> position: aPoint [ 
	pos := aPoint
]

{ #category : #accessing }
RSParticle >> velocity [
	^ vel r
]

{ #category : #'accessing structure variables' }
RSParticle >> x [
	^ pos x
]

{ #category : #'accessing structure variables' }
RSParticle >> y [
	^ pos y
]
