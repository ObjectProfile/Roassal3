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
		'padding',
		'shouldPushFront'
	],
	#category : #'Roassal3-Inspector-Interactions'
}

{ #category : #hooks }
RSSelectionPresentationInteraction >> addInteractionToCanvas: aShape [
	| canvas key |
	canvas := aShape canvas.
	canvas ifNil: [ ^ self ].
	key := #canvasInspectorSelection.
	(canvas hasProperty: key) ifTrue: [ ^ self ].
	canvas when: RSScaleChangedEvent send: #updateShadow: to: self.
	canvas when: RSMouseClick send: #removeShadowFromCanvas: to: self.
	canvas propertyAt: key put: true
]

{ #category : #visitor }
RSSelectionPresentationInteraction >> createShadowFor: aShape [
	^ (aShape
		inspectorShadowFor: self padding / (self scaleFrom: aShape)
		color: self shadowColor)
		model: nil;
		propertyAt: self key put: aShape;
		yourself
]

{ #category : #initialization }
RSSelectionPresentationInteraction >> initialize [
	super initialize.
	self padding: 10.
	self usePushFront
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> key [
	^ self class name
]

{ #category : #public }
RSSelectionPresentationInteraction >> noPushFront [
	shouldPushFront := false
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> onShape: aShape [
	aShape model ifNil: [ ^ self ].
	aShape removeInteractionIfPresent: self class.
	self addInteractionToCanvas: aShape.
	aShape
		when: RSPositionChangedEvent send: #updateShadow: to: self;
		when: RSExtentChangedEvent send: #updateShadow: to: self;
		when: RSMouseClick send: #selection: to: self
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

{ #category : #visitor }
RSSelectionPresentationInteraction >> privateShadowFor: aShape [
	^ aShape class = RSBitmap ifTrue: [
		RSBox new
	] ifFalse: [
		aShape copy
			border: nil;
			properties: nil;
			yourself ]
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> putShadowOn: aShape [
	| shadow |
	shadow := self createShadowFor: aShape.
	(aShape parent notNil or: [ aShape canvas ]) ifNil: [ ^ self ].
	self shouldPushFront ifTrue: [ aShape pushFront ].
	aShape parent addShape: shadow before: aShape.
	aShape canvas propertyAt: self key put: shadow.
	self updateShadowPosition: aShape canvas
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
		ifPresent: [ :shadow |
			shadow remove.
			aShape canvas removeKey: self key. ]
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

{ #category : #testing }
RSSelectionPresentationInteraction >> shouldPushFront [
	^ shouldPushFront
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> updateShadow: evt [
	| shadow shape |
	(evt canvas hasProperty: self key) ifFalse: [ ^ self ].
	shadow := evt canvas propertyAt: self key.
	shape := shadow propertyAt: self key.
	self
		removeShadowOn: shape;
		putShadowOn: shape.
	evt canvas canvas signalUpdate
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> updateShadowPosition: aCanvas [
	| shadow |
	(aCanvas hasProperty: self key) ifFalse: [ ^ self ].
	shadow := aCanvas propertyAt: self key.
	RSLocation new move: shadow on: (shadow propertyAt: self key)
]

{ #category : #public }
RSSelectionPresentationInteraction >> usePushFront [
	shouldPushFront := true
]
