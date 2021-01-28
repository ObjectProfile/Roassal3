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
		
	RSAbstractAction registerActionsOn: self.
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
	"consider remove this class"
	| context c |
	c := self canvas.
	context := c inspectorContext.
	context presentation: self.
	c createMorph setTakeKeyboardFocus.
	
	c shapes @ context.
	c
		when: RSShapeAddedEvent
		do: [ :evt | evt shape @ context ].
]

{ #category : #rendering }
GLMRoassal3Presentation >> value: aSpWrappedItem [
	self selection: aSpWrappedItem item
]
