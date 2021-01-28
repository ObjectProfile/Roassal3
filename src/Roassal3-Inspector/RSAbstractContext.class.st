"
A context is very usefull to describe de default interactions for a canvas.

My subclasses should override interaction
"
Class {
	#name : #RSAbstractContext,
	#superclass : #RSInteraction,
	#instVars : [
		'context',
		'presentation',
		'propagateToChildren'
	],
	#category : #'Roassal3-Inspector-Contexts'
}

{ #category : #initialization }
RSAbstractContext >> initialize [
	super initialize.
	self propagateToChildren: true.
]

{ #category : #hooks }
RSAbstractContext >> interactionsToBeRegistered [
	^ self subclassResponsibility
]

{ #category : #hooks }
RSAbstractContext >> onShape: aShape [
	aShape removeInteractionIfPresent: self class.
	self interactionsToBeRegistered do: [ :i | 
		i presentation: self presentation.
		aShape addInteraction: i ].
	self propagateToChildren ifFalse: [ ^ self ].
	aShape children ifNil: [ ^ self ].
	
	aShape children do: [ :child | child addInteraction: self ].
	aShape
		when: RSShapeAddedEvent
		do: [ :evt | evt shape @ context ].
]

{ #category : #accessing }
RSAbstractContext >> presentation [
	^ presentation
]

{ #category : #accessing }
RSAbstractContext >> presentation: aGlamourPresentation [
	presentation := aGlamourPresentation
]

{ #category : #accessing }
RSAbstractContext >> propagateToChildren [
	^ propagateToChildren
]

{ #category : #accessing }
RSAbstractContext >> propagateToChildren: bool [
	propagateToChildren := bool
]
