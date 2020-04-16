"
I am used on the inspector for Roassal3, when you select one element the view changes its shapes
"
Class {
	#name : #RSSelectionPresentation,
	#superclass : #RSInteraction,
	#instVars : [
		'presentation',
		'shadowColor'
	],
	#category : #'Roassal3-Inspector-Interaction'
}

{ #category : #accessing }
RSSelectionPresentation >> key [
	^ self class name
]

{ #category : #hooks }
RSSelectionPresentation >> onShape: aShape [
	aShape model ifNil: [ ^ self ].
	aShape when: RSMouseClick do: [ self selection: aShape ]
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
	| shadow |
	shadow := RSBox new
		fromRectangle: (aShape encompassingRectangle expandBy: aShape extent * 0.05); 
		paint: self shadowColor;
		yourself.
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
		ifPresent: [ :shadow |shadow remove ].
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
