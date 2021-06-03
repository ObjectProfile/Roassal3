"
I define a new basic highlight interaction
"
Class {
	#name : #RSSunburstFadeInteraction,
	#superclass : #RSHighlightableInteraction,
	#instVars : [
		'still',
		'builder'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #accessing }
RSSunburstFadeInteraction >> builder [
	^ builder
]

{ #category : #accessing }
RSSunburstFadeInteraction >> builder: aBuilder [
	builder := aBuilder
]

{ #category : #initialization }
RSSunburstFadeInteraction >> highlightShapesFor: shape [
	| parents |
	parents := self pathFor: shape.
	^ builder shapes 
		reject: [ :s | parents includes: s].
]

{ #category : #initialization }
RSSunburstFadeInteraction >> initialize [
	super initialize.
	self highlightColor: [ :shape | shape color alpha: 0.15 ].
]

{ #category : #initialization }
RSSunburstFadeInteraction >> onShape: aShape [
	aShape
		when: RSMouseEnter do: [ :evt | 
			still := true.
			self doHighlight: evt shape.
			evt signalUpdate ];
		when: RSMouseLeave do: [ :evt | 
			still := false.
			evt canvas newAnimation
				duration: 300 milliSeconds; 
				onStepDo: [ :t | evt signalUpdate ];
				when: RSAnimationLoopEvent do: [ :e | 
					still ifFalse: [ self doUnhighlight: evt shape. ].
					].
			evt signalUpdate ]
]

{ #category : #initialization }
RSSunburstFadeInteraction >> pathFor: shape [
	| list current |
	list := OrderedCollection new.
	current := shape.
	[ current notNil ] whileTrue: [
		list add: current.
		current := current sparent ].
	^ list 
]
