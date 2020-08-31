"
I am used on the inspector for Roassal3, when you select one element the view changes its shapes
"
Class {
	#name : #RSSelectionPresentation,
	#superclass : #RSInteraction,
	#instVars : [
		'presentation',
		'shadowColor',
		'padding'
	],
	#category : #'Roassal3-Inspector-Interactions'
}

{ #category : #initialization }
RSSelectionPresentation >> initialize [
	super initialize.
	self padding: 10.
]

{ #category : #accessing }
RSSelectionPresentation >> key [
	^ self class name
]

{ #category : #hooks }
RSSelectionPresentation >> onShape: aShape [
	aShape model ifNil: [ ^ self ].
	aShape canvas ifNotNil: [ :c | 
		c removeInteractionIfPresent: self class.
		c when: RSMouseClick do: [ :evt |
			self removeShadowOn: evt.
			evt signalUpdate. ]
		 ].
	aShape when: RSMouseClick do: [ :evt | self selection: evt shape ].
]

{ #category : #accessing }
RSSelectionPresentation >> padding [
	^ padding
]

{ #category : #accessing }
RSSelectionPresentation >> padding: aNumber [
	padding := aNumber
]

{ #category : #accessing }
RSSelectionPresentation >> presentation [
	^ presentation
]

{ #category : #accessing }
RSSelectionPresentation >> presentation: aRSRoassalPresentation [
	presentation := aRSRoassalPresentation
]

{ #category : #hooks }
RSSelectionPresentation >> putShadowOn: aShape [
	| shadow pad |
	pad := self padding / aShape canvas camera scale.
	shadow := RSBox new
		fromRectangle: (aShape encompassingRectangle expandBy: pad); 
		paint: self shadowColor;
		cornerRadius: pad * 0.75;
		yourself.
	aShape removeInteractionIfPresent: RSLocation.
	RSLocation new
		stick: shadow on: aShape.
	aShape parent
		addShape: shadow before: aShape.
	aShape canvas 
		propertyAt: self key
		put: shadow
]

{ #category : #dependencies }
RSSelectionPresentation >> release [
	presentation := nil
]

{ #category : #hooks }
RSSelectionPresentation >> removeShadowOn: aShape [
	aShape canvas
		propertyAt: self key
		ifPresent: [ :shadow | shadow remove ].
	aShape canvas removeKey: self key.
]

{ #category : #hooks }
RSSelectionPresentation >> selection: aShape [
	self presentation selection: aShape model.
	self
		removeShadowOn: aShape;
		putShadowOn: aShape.
]

{ #category : #accessing }
RSSelectionPresentation >> shadowColor [
	^ shadowColor ifNil: [ shadowColor := Color blue alpha: 0.3 ]
]

{ #category : #accessing }
RSSelectionPresentation >> shadowColor: aColor [
	shadowColor := aColor
]
