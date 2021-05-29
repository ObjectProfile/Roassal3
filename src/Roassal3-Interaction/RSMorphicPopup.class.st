"
I am a popup that uses Morphic and can be visible outside of the RSCanvas.
"
Class {
	#name : #RSMorphicPopup,
	#superclass : #RSAbstractPopupInteraction,
	#instVars : [
		'morphBuilder',
		'gapFromPointer'
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

{ #category : #accessing }
RSMorphicPopup >> gapFromPointer [
	^ gapFromPointer
]

{ #category : #accessing }
RSMorphicPopup >> gapFromPointer: aPoint [
	gapFromPointer := aPoint
]

{ #category : #initialization }
RSMorphicPopup >> initialize [
	super initialize.
	self morphBuilder: [ :model | model asString asTextMorph ].
	gapFromPointer := 0@0.
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
	xdelta := gapFromPointer x.
	ydelta := gapFromPointer y.
	
	(position x + aMorph width) > world width 
		ifTrue: [ xdelta := xdelta negated - aMorph width ].
	(position y + aMorph height) > world height
		ifTrue: [ ydelta := ydelta negated - aMorph height ].
	
	aMorph
		lock;
		fullBounds;
		setProperty: #morphicLayerNumber toValue: aMorph morphicLayerNumber.
	
	aMorph position: ((position x + xdelta) max: 0) @ ((position y + ydelta) max: 0)

]
