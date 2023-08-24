Class {
	#name : #RSShadowInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'padding',
		'shadowColor',
		'shouldPushFront'
	],
	#category : #'Roassal3-Interaction-Selection'
}

{ #category : #hooks }
RSShadowInteraction >> addInteractionToCanvas: aShape [

	| canvas |
	canvas := aShape canvas.
	canvas ifNil: [ ^ self ].
	canvas shadowInteraction ifNotNil: [ ^ self ].
	canvas shadowInteraction: self.
	canvas when: RSScaleChangedEvent send: #updateAllShadows: to: self
]

{ #category : #hooks }
RSShadowInteraction >> createShadowFor: aShape [

	^ (aShape
		   inspectorShadowFor: self padding / (self scaleFrom: aShape)
		   color: self shadowColor)
		  model: nil;
		  yourself
]

{ #category : #initialization }
RSShadowInteraction >> initialize [

	super initialize.
	self padding: 4.
	self shadowColor: (Color fromHexString: 'E67E2255').
	self shouldPushFront: false
]

{ #category : #accessing }
RSShadowInteraction >> key [
	^ #shadowShapeList
]

{ #category : #hooks }
RSShadowInteraction >> onShape: aShape [

	aShape shadow ifNotNil: [ ^ self ].

	self addInteractionToCanvas: aShape.
	self putShadowOn: aShape.
	
	(aShape hasInteraction: self class) ifTrue: [ ^ self ].
	aShape
		when: RSPositionChangedEvent send: #updateShadow: to: self;
		when: RSExtentChangedEvent send: #updateShadow: to: self;
		when: RSShapeRemovedEvent send: #removeShadow: to: self
]

{ #category : #hooks }
RSShadowInteraction >> padding [

	^ padding
]

{ #category : #hooks }
RSShadowInteraction >> padding: number [ 

	padding := number
]

{ #category : #hooks }
RSShadowInteraction >> putShadowOn: aShape [

	| shadow canvas list |
	canvas := aShape canvas.
	shadow := self createShadowFor: aShape.
	aShape parent ifNil: [ ^ self ].
	self shouldPushFront ifTrue: [ aShape pushFront ].
	aShape parent addShape: shadow before: aShape.
	aShape shadow: shadow.
	shadow position: aShape position.

	list := canvas propertyAt: self key ifAbsentPut: [ Set new ].
	list add: aShape
]

{ #category : #hooks }
RSShadowInteraction >> removeShadow: evt [

	| canvas shape |
	canvas := evt canvas.
	shape := evt shape.
	shape removeShadow.
	canvas
		propertyAt: self key
		ifPresent: [ :list | list remove: shape ifAbsent: [  ] ]
]

{ #category : #removing }
RSShadowInteraction >> removeShadowsOn: aRSCanvas [
	| key |
	key := self key.
	aRSCanvas
		propertyAt: key
		ifPresent: [ :list | list do: #removeShadow ].
	aRSCanvas removeKey: key
]

{ #category : #hooks }
RSShadowInteraction >> scaleFrom: aShape [

	"Return the scale used by the canvas of the shape"

	aShape canvas ifNil: [ ^ 1 ].
	aShape isFixed ifTrue: [ ^ 1 ].
	^ aShape canvas camera scale
]

{ #category : #hooks }
RSShadowInteraction >> shadowColor [

	^ shadowColor
]

{ #category : #hooks }
RSShadowInteraction >> shadowColor: aColor [

	shadowColor := aColor
]

{ #category : #initialization }
RSShadowInteraction >> shouldPushFront [

	^ shouldPushFront
]

{ #category : #accessing }
RSShadowInteraction >> shouldPushFront: aBoolean [ 
	
	shouldPushFront := aBoolean
]

{ #category : #hooks }
RSShadowInteraction >> updateAllShadows: evt [

	| canvas |
	canvas := evt canvas.
	canvas
		propertyAt: self key
		ifPresent: [ :list | list do: [ :shape | self updateShadow: shape ] ]
]

{ #category : #hooks }
RSShadowInteraction >> updateShadow: evt [

	| shadow shape |
	shape := evt shape.
	shadow := shape shadow.
	shadow ifNil: [ ^ self ].
	shape removeShadow.
	self putShadowOn: shape.
	evt signalUpdate
]
