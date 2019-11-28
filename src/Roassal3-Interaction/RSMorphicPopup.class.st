"
I am a popup that uses Morphic and can be visible outside of the RSCanvas.
"
Class {
	#name : #RSMorphicPopup,
	#superclass : #RSPopup,
	#instVars : [
		'morphBuilder'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #hooks }
RSMorphicPopup >> createOrGetPopupOn: aShape event: event [

	| att popup |
	att := event canvas attributes.
	att at: self popupAttributeName ifPresent: [ :found | ^ found ].
	popup := self
		newPopupMorphFor: event canvas morph
		in: (event camera fromSpaceToPixel: event position)
		background: Color white
		innerMorph: (morphBuilder cull: aShape model).

	att at: self popupAttributeName put: popup.

	^ popup
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
RSMorphicPopup >> newPopupMorphFor: canvasMorph in: aPoint background: aColor innerMorph: innerMorph [
	| popup vertices xdelta ydelta world position |
	vertices := SimpleBalloonMorph getVertices: innerMorph bounds.
	popup := SimpleBalloonMorph new
		color: aColor;
		addMorph: innerMorph;
		setTarget: nil;
		setVertices: vertices.
	world := canvasMorph world 
		ifNil: [ ^ popup ].
	position := aPoint + canvasMorph position.
	xdelta := ydelta := 0.
	
	(position x + popup width) > world width 
		ifTrue: [ xdelta := popup width negated ].
	(position y + popup height) > world height 
		ifTrue: [ ydelta := popup height negated ].
	popup lock;
		fullBounds;
		setProperty: #morphicLayerNumber toValue: popup morphicLayerNumber.
	popup position: position + (xdelta @ydelta).
	canvasMorph world addMorphFront: popup.
	
	canvasMorph world activeHand balloonHelp: popup.
	^ popup
]

{ #category : #hooks }
RSMorphicPopup >> popupAttributeName [
	^ #popupMorph
]

{ #category : #hooks }
RSMorphicPopup >> removePopupOn: evt [
	| att popup |
	"It may happen that the canvas is not set. This is the case when an element is not added to a view.
	If the element is not part of a view, then there is nothing to remove, so we exit early."
	evt canvas ifNil: [ ^ self ].
	att := evt canvas attributes.
	(att includesKey: self popupAttributeName) ifFalse: [ ^ self ].
	popup := att at: self popupAttributeName.
	popup delete.
	att removeKey: self popupAttributeName.

]

{ #category : #hooks }
RSMorphicPopup >> translatePopup: aMorph event: evt [ 

]
