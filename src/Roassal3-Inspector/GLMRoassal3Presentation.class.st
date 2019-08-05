"
I am a presentation for Roassal3
"
Class {
	#name : #GLMRoassal3Presentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'newViewBlock',
		'view'
	],
	#category : #'Roassal3-Inspector-GT'
}

{ #category : #initialization }
GLMRoassal3Presentation >> initializeView: aZeroArgBlock [
	^ newViewBlock := aZeroArgBlock 
]

{ #category : #rendering }
GLMRoassal3Presentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	
	^ aRenderer renderRoassal3Presentation: self
]

{ #category : #initialization }
GLMRoassal3Presentation >> setUpInteractions [
	| interaction |
	interaction := RSSelectionPresentation new
		presentation: self.
	self view elements @ interaction.
	self view edges @ interaction.
	self view 
		when: TSShapedObjectAdded
		do: [ :evt| evt shapedObject @ interaction ].
	
	
	
]

{ #category : #accessing }
GLMRoassal3Presentation >> view [
	^ view ifNil: [ view := newViewBlock value ].
]
