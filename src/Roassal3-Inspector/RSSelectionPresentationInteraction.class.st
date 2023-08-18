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
		'shadowInteraction'
	],
	#category : #'Roassal3-Inspector-Interactions'
}

{ #category : #hooks }
RSSelectionPresentationInteraction >> addInteractionToCanvas: aCanvas [

	aCanvas ifNil: [ ^ self ].
	(aCanvas hasInteraction: self class) ifTrue: [ ^ self ].
	aCanvas when: RSMouseClick send: #removeShadow: to: self
]

{ #category : #initialization }
RSSelectionPresentationInteraction >> initialize [

	super initialize.
	shadowInteraction := RSShadowInteraction new
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> noPushFront [

	shadowInteraction shouldPushFront: false
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> onShape: aShape [

	
	aShape model ifNil: [ ^ self ].
	self addInteractionToCanvas: aShape canvas.
	aShape removeInteractionIfPresent: self class.
	aShape when: RSMouseClick send: #selection: to: self
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> padding [

	^ shadowInteraction padding
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> padding: aNumber [

	shadowInteraction padding: aNumber 
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> presentation [
	^ presentation
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> presentation: aRSRoassalPresentation [
	presentation := aRSRoassalPresentation
]

{ #category : #dependencies }
RSSelectionPresentationInteraction >> release [
	presentation := nil
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> removeShadow: evt [

	shadowInteraction removeShadowsOn: evt canvas
]

{ #category : #hooks }
RSSelectionPresentationInteraction >> selection: evt [

	"evt can be a RSShape or RSEvent"

	| aShape |
	aShape := evt shape.
	self presentation ifNotNil: [ 
		self presentation value:
			(SpWrappedItem new selectedItem: aShape model) ].
	shadowInteraction removeShadowsOn: evt canvas.
	aShape @ shadowInteraction.
	aShape signalUpdate
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> shadowColor [

	^ shadowInteraction shadowColor
]

{ #category : #accessing }
RSSelectionPresentationInteraction >> shadowColor: aColor [

	shadowInteraction shadowColor: aColor
]
