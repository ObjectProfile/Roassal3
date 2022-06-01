"
Define the interaction used by the inspector to highlight a selected shape. This is very convenient in the inspector for example. Normally, it should not be invoked directly.

Here is an example:

```Smalltalk
c := RSCanvas new.
shapes := (1 to: 100) collect: [ :v | RSBox new model: v ] as: RSGroup.
c addAll: shapes.
RSNormalizer size shapes: shapes; normalize: #yourself.
RSFlowLayout on: shapes.
shapes @ RSSelectionPresentation.
c @ RSCanvasController.
c open
```

"
Class {
	#name : #RSSelectionPresentationInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'presentation',
		'shadowColor',
		'padding'
	],
	#category : #'Roassal3-Inspector-Interactions'
}

{ #category : #hooks }
RSSelectionPresentationInteraction >> addInteractionToCanvas: aShape [
	| canvas |
	canvas := aShape canvas.
	canvas ifNil: [ ^ self ].
	canvas propertyAt: #canvasInspectorSelection ifAbsentPut: [ 
		canvas removeInteractionIfPresent: self class.
		canvas when: RSMouseClick send: #removeShadowFromCanvas: to: self ]
]

{ #category : #initialization }
RSSelectionPresentationInteraction >> initialize [
	super initialize.
	self padding: 10.
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> key [
	^ self class name
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> onShape: aShape [
	aShape model ifNil: [ ^ self ].
	self addInteractionToCanvas: aShape.
	aShape removeInteractionIfPresent: self class.
	aShape when: RSMouseClick send: #selection: to: self
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> padding [
	^ padding
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> padding: aNumber [
	padding := aNumber
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> presentation [
	^ presentation
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> presentation: aRSRoassalPresentation [
	presentation := aRSRoassalPresentation
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> putShadowOn: aShape [

	| shadow pad |
	"Make sure that  the size is indenpendent of the camera scale"
	pad := self padding / (self scaleFrom: aShape).
	shadow := RSBox new
		fromRectangle: (aShape encompassingRectangle expandBy: pad);
		paint: self shadowColor;
		cornerRadius: pad * 0.75;
		yourself.
	aShape removeInteractionIfPresent: RSLocation.
	RSLocation new stick: shadow on: aShape.
	
	(aShape parent notNil or: [ aShape canvas ]) ifNil: [ ^ self ].
	aShape parent addShape: shadow before: aShape.
	aShape canvas propertyAt: self key put: shadow
]

{ #category : #dependencies }
RSSelectionPresentationInteraction >> release [
	presentation := nil
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> removeShadowFromCanvas: evt [
	self removeShadowOn: evt.
	evt signalUpdate
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> removeShadowOn: aShape [
	"Nothing to do if there is no canvas"
	aShape canvas ifNil: [ ^ self ].
	
	aShape canvas
		propertyAt: self key
		ifPresent: [ :shadow | shadow remove ].
	aShape canvas removeKey: self key.
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> scaleFrom: aShape [
	"Return the scale used by the canvas of the shape"
	aShape canvas ifNil: [ ^ 1 ].
	aShape isFixed ifTrue: [ ^ 1 ].
	^ aShape canvas camera scale
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> selection: evt [
	"evt can be a RSShape or RSEvent"
	| aShape |
	aShape := evt shape.
	self presentation 
		ifNotNil: [ self presentation value: (SpWrappedItem new selectedItem: aShape model) ]. 
	self
		removeShadowOn: aShape;
		putShadowOn: aShape.
	aShape canvas 
		ifNotNil: [ aShape canvas signalUpdate ]
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> shadowColor [
	^ shadowColor ifNil: [ shadowColor := Color blue alpha: 0.3 ]
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> shadowColor: aColor [
	shadowColor := aColor
]
