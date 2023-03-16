"
TODO
"
Class {
	#name : #RSForceBuilder,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'interferences',
		'particles',
		'force',
		'particlesSize',
		'interferencesSize',
		'interferencesRadius',
		'particlesRadius',
		'random',
		'colorGenerator'
	],
	#category : #'Roassal3-Experimental-Force'
}

{ #category : #accessing }
RSForceBuilder >> colorGenerator: aRSColorGenerator [
	colorGenerator := aRSColorGenerator
]

{ #category : #private }
RSForceBuilder >> createObjects: amt radius: radius class: cls [
	^ (1 to: amt) collect: [ :i | | r |
		r := random next * 360.
		r := r radiansToDegrees.
		cls new
			position: r cos @ r sin * radius;
			yourself ]
]

{ #category : #accessing }
RSForceBuilder >> force [
	^ force
]

{ #category : #accessing }
RSForceBuilder >> force: aNumber [
	force := aNumber
]

{ #category : #initialization }
RSForceBuilder >> initialize [
	super initialize.
	interferences := particles := #().
	random := Random new.
	self
		force: 10;
		colorGenerator: RSColorMonoGenerator new;
		particlesSize: 1000;
		particlesRadius: 100;
		interferencesSize: 100;
		interferencesRadius: 100
]

{ #category : #accessing }
RSForceBuilder >> interferences [
	^ interferences
]

{ #category : #accessing }
RSForceBuilder >> interferencesRadius [
	^ interferencesRadius
]

{ #category : #accessing }
RSForceBuilder >> interferencesRadius: anInteger [
	interferencesRadius := anInteger
]

{ #category : #accessing }
RSForceBuilder >> interferencesSize [
	^ interferencesSize
]

{ #category : #accessing }
RSForceBuilder >> interferencesSize: anInteger [
	interferencesSize := anInteger
]

{ #category : #accessing }
RSForceBuilder >> particles [
	^ particles
]

{ #category : #accessing }
RSForceBuilder >> particlesRadius [
	^ particlesRadius
]

{ #category : #accessing }
RSForceBuilder >> particlesRadius: anInteger [
	particlesRadius := anInteger
]

{ #category : #accessing }
RSForceBuilder >> particlesSize [
	^ particlesSize
]

{ #category : #accessing }
RSForceBuilder >> particlesSize: anInteger [
	particlesSize := anInteger
]

{ #category : #hooks }
RSForceBuilder >> renderIn: aCanvas [
	aCanvas color: colorGenerator backgroundColor.
	self reset.
	aCanvas when: RSMouseClick send: #reset to: self.
	aCanvas newAnimation repeat; onStepDo: [ self update: self force ]
]

{ #category : #initialization }
RSForceBuilder >> reset [
	| c |
	c := self canvas.
	c shapes copy do: #remove.
	c shouldClearBackground: true.
	c newAnimation
		duration: 500 milliSeconds;
		when: RSAnimationEndEvent do: [
			self setParticles.
			self setInterferences.
			c shouldClearBackground: false.
			 ]
]

{ #category : #hooks }
RSForceBuilder >> setInterferences [
	interferences := self
		createObjects: self interferencesSize
		radius: self interferencesRadius
		class: RSInterference
]

{ #category : #hooks }
RSForceBuilder >> setParticles [
	particles := self
		createObjects: self particlesSize
		radius: self particlesRadius
		class: RSParticleForce
]

{ #category : #updating }
RSForceBuilder >> update: aFloat [
	| c |
	c := self canvas.
	interferences do: [ :i |
		particles do: [ :p | p update: i with: aFloat ] ].
	particles do: [ :p | p renderIn: c with: colorGenerator ]
]
