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
GLMRoassal3Presentation >> initialize [
	super initialize.
	self 
		act: [ :presentation | 
			view showRectangles
			ifTrue:[ view hideEncompassingRectangles]
			ifFalse:[view showEncompassingRectangles ].
			view signalUpdate ]
		icon: (self iconNamed: #smallDebug)
		entitled: 'Show Encompassing Rectangles'
]

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
