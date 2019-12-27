"
I am a popup that uses Morphic and can be visible outside of the RSCanvas.
"
Class {
	#name : #RSMorphicPopup,
	#superclass : #RSAbstractPopup,
	#instVars : [
		'morphBuilder'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #accessing }
RSMorphicPopup >> backgroundColor [
	^ Smalltalk ui theme backgroundColor
]

{ #category : #hooks }
RSMorphicPopup >> createPopupFor: aShape event: event [
	| popup vertices targetMorph world |
	targetMorph := self morphBuilder cull: aShape model.
	vertices := SimpleBalloonMorph getVertices: targetMorph bounds.
	popup := SimpleBalloonMorph new
		color: self backgroundColor;
		addMorph: targetMorph;
		setTarget: nil;
		setVertices: vertices.
	world := event canvas morph world.
	world ifNil: [ ^ popup ].
	world addMorphFront: popup.
	world activeHand balloonHelp: popup.
	^ popup
]

{ #category : #initialization }
RSMorphicPopup >> initialize [
	super initialize.
	self morphBuilder: [ :model | model asString asTextMorph ].
]

{ #category : #accessing }
RSMorphicPopup >> morphBuilder [
	^ morphBuilder
]

{ #category : #accessing }
RSMorphicPopup >> morphBuilder: aBlock [
	morphBuilder := aBlock
]

{ #category : #hooks }
RSMorphicPopup >> popupKey [
	^ #popupMorph
]

{ #category : #hooks }
RSMorphicPopup >> releasePopup: popup [
	popup delete
]

{ #category : #hooks }
RSMorphicPopup >> translatePopup: aMorph event: evt [ 
	| position xdelta ydelta cMorph world |
	cMorph := evt canvas morph.
	world := cMorph world.
	position := (evt camera fromSpaceToPixel: evt position) + cMorph position.
	xdelta := ydelta := 0.
	
	(position x + aMorph width) > world width 
		ifTrue: [ xdelta := aMorph width negated ].
	(position y + aMorph height) > world height 
		ifTrue: [ ydelta := aMorph height negated ].
	
	aMorph
		lock;
		fullBounds;
		setProperty: #morphicLayerNumber toValue: aMorph morphicLayerNumber.
	
	aMorph position: ((position x + xdelta) max: 0) @ ((position y + ydelta) max: 0)

]
