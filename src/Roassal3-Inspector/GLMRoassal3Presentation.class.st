"
I am a presentation for Roassal3
"
Class {
	#name : #GLMRoassal3Presentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'canvas',
		'newCanvasBlock'
	],
	#category : #'Roassal3-Inspector-GT'
}

{ #category : #accessing }
GLMRoassal3Presentation >> canvas [
	^ canvas ifNil: [ canvas := newCanvasBlock value ].
]

{ #category : #initialization }
GLMRoassal3Presentation >> initialize [
	super initialize.
	self 
		act: [ :presentation | 
			canvas showRectangles
			ifTrue:[ canvas hideEncompassingRectangles]
			ifFalse:[canvas showEncompassingRectangles ].
			canvas signalUpdate ]
		icon: (self iconNamed: #smallDebug)
		entitled: 'Show Encompassing Rectangles'
]

{ #category : #initialization }
GLMRoassal3Presentation >> initializeCanvas: aZeroArgBlock [
	^ newCanvasBlock := aZeroArgBlock 
]

{ #category : #rendering }
GLMRoassal3Presentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRoassal3Presentation: self
]

{ #category : #initialization }
GLMRoassal3Presentation >> setUpInteractions [
	| interaction |
	interaction := TSSelectionPresentation new
		presentation: self.
	self canvas shapes @ interaction.
	self canvas
		when: TSShapedObjectAdded
		do: [ :evt| evt shapedObject @ interaction ].
	
	
	
]
