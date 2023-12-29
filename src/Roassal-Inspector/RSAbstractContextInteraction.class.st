"
A context is very usefull to describe de default interactions for a canvas.

My subclasses should override interaction
"
Class {
	#name : 'RSAbstractContextInteraction',
	#superclass : 'RSInteraction',
	#instVars : [
		'presentation',
		'propagateToChildren'
	],
	#category : 'Roassal-Inspector-Contexts',
	#package : 'Roassal-Inspector',
	#tag : 'Contexts'
}

{ #category : 'initialization' }
RSAbstractContextInteraction >> initialize [
	super initialize.
	self propagateToChildren: true
]

{ #category : 'accessing' }
RSAbstractContextInteraction >> inspectorInteractions [
	^ RSInspectorToolbar interactions
]

{ #category : 'hooks' }
RSAbstractContextInteraction >> interactionsToBeRegistered [
	^ self subclassResponsibility
]

{ #category : 'hooks' }
RSAbstractContextInteraction >> onShape: aShape [
	aShape removeInteractionIfPresent: self class.
	self interactionsToBeRegistered do: [ :i |
		i presentation: self presentation.
		aShape addInteraction: i ].
	self propagateToChildren ifFalse: [ ^ self ].
	aShape children ifNil: [ ^ self ].

	aShape children do: [ :child | child addInteraction: self ].
	aShape
		when: RSShapeAddedEvent
		do: [ :evt | evt shape @ self ]
		for: self
]

{ #category : 'accessing' }
RSAbstractContextInteraction >> presentation [
	^ presentation
]

{ #category : 'accessing' }
RSAbstractContextInteraction >> presentation: aGlamourPresentation [
	presentation := aGlamourPresentation
]

{ #category : 'accessing' }
RSAbstractContextInteraction >> propagateToChildren [
	^ propagateToChildren
]

{ #category : 'accessing' }
RSAbstractContextInteraction >> propagateToChildren: bool [
	propagateToChildren := bool
]
