"
I am a popup that uses Morphic and can be visible outside of the RSCanvas.
"
Class {
	#name : 'RSMorphicPopupInteraction',
	#superclass : 'RSAbstractPopupInteraction',
	#instVars : [
		'morphBuilder',
		'gapFromPointer'
	],
	#category : 'Roassal-Interaction-Popup',
	#package : 'Roassal-Interaction',
	#tag : 'Popup'
}

{ #category : 'accessing' }
RSMorphicPopupInteraction >> backgroundColor [
	^ Smalltalk ui theme backgroundColor
]

{ #category : 'hooks' }
RSMorphicPopupInteraction >> createPopupFor: aShape event: event [
	| popup vertices targetMorph world |
	targetMorph := self morphBuilder cull: (self modelFor: aShape).
	vertices := SimpleBalloonMorph getVertices: targetMorph bounds.
	popup := SimpleBalloonMorph new
		"color: self backgroundColor;"

		addMorph: targetMorph;
		setTarget: nil;
		setVertices: vertices;
		borderColor: Color transparent;
		color: Color transparent.
	world := event canvas morph world.
	world ifNil: [ ^ popup ].
	world addMorphFront: popup.
	world activeHand balloonHelp: popup.
	^ popup
]

{ #category : 'accessing' }
RSMorphicPopupInteraction >> gapFromPointer [
	^ gapFromPointer
]

{ #category : 'accessing' }
RSMorphicPopupInteraction >> gapFromPointer: aPoint [
	gapFromPointer := aPoint
]

{ #category : 'initialization' }
RSMorphicPopupInteraction >> initialize [
	super initialize.
	self morphBuilder: [ :model | self popupFor: model ].
	gapFromPointer := 0@0
]

{ #category : 'accessing' }
RSMorphicPopupInteraction >> morphBuilder [
	^ morphBuilder
]

{ #category : 'accessing' }
RSMorphicPopupInteraction >> morphBuilder: aBlock [
	morphBuilder := aBlock
]

{ #category : 'hooks' }
RSMorphicPopupInteraction >> popupFor: model [
	^ model asString asTextMorph
		backgroundColor: (Smalltalk ui theme backgroundColor alpha: 0.9);
		borderColor: Color black;
		borderWidth: 1;
		margins: 15;
		yourself
]

{ #category : 'hooks' }
RSMorphicPopupInteraction >> popupKey [
	^ #popupMorph
]

{ #category : 'hooks' }
RSMorphicPopupInteraction >> releasePopup: popup [
	popup delete
]

{ #category : 'hooks' }
RSMorphicPopupInteraction >> translatePopup: aMorph event: evt [
	| position xdelta ydelta cMorph world |
	cMorph := evt canvas morph.
	world := cMorph world.
	world ifNil: [ ^ self ].
	position := (evt camera fromSpaceToPixel: evt position) + cMorph positionInWorld.
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
