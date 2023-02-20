"
TODO
"
Class {
	#name : #RSAlpharoExample,
	#superclass : #Object,
	#category : #'Roassal3-Experimental-Alpharo'
}

{ #category : #running }
RSAlpharoExample >> example01Basic [
	<script: 'self new example01Basic'>
	| b |
	b := RSAlpharo new.
	b objects: (1 to: 20).
	b build.
	b canvas inspect
]

{ #category : #running }
RSAlpharoExample >> example02Classes [
	<script: 'self new example02Classes'>
	| b classes |
	classes := (RPackage organizer packageNamed: 'Roassal3-Experimental') definedClasses.
	classes := classes select: [ :cls | cls comment size < 10 ].
	b := RSAlpharo new.
	b objects: classes.
	b build.
	(b shapes collect: [ :s | s children first ])
		when:RSMouseClick
		do: [ :evt | evt shape model browse ].
	b canvas inspect
]

{ #category : #running }
RSAlpharoExample >> example03Basic [
	<script: 'self new example03Basic open
		position: 0@20;
		extent: 800@800;
		color: Color transparent;
		setLabel: ''Amebas'''>
	| b |
	b := RSAlpharo new.
	b objects:( (1 to: 20) collect: [:i | 'Ameba', i asString]).
	b build.
	b canvas color: Color transparent.
	^ b canvas
]
