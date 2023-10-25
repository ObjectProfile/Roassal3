"
Shadow Interaction puts a shadow in a shape
"
Class {
	#name : 'RSShadowInteraction',
	#superclass : 'RSInteraction',
	#instVars : [
		'padding',
		'shadowColor',
		'shouldPushFront'
	],
	#category : 'Roassal-Interaction-Selection',
	#package : 'Roassal-Interaction',
	#tag : 'Selection'
}

{ #category : 'examples' }
RSShadowInteraction class >> exampleBasic [
	| canvas |
	canvas := self canvasExample.
	canvas nodes first @ self.
	^ canvas open
]

{ #category : 'examples' }
RSShadowInteraction class >> exampleLine [
	| canvas int line |
	canvas := self canvasExample.
	int := self new.
	line  := RSLine new startPoint: 10@10; endPoint: 100@30; width: 20.
	line model: 'Drag me'.
	canvas add: line.
	line draggable.
	line @ int.
	^ canvas open
]

{ #category : 'examples' }
RSShadowInteraction class >> examplePieSlice [
	| canvas int slice |
	canvas := self canvasExample.
	int := self new.
	slice  := RSPieSlice new
		model: 'Drag me';
		alphaAngle: 0;
		betaAngle: 45;
		innerRadius: 50;
		cornerRadii: 10;
		externalRadius: 100;
		position: 50@ -50;
		yourself.
	slice position: 30@30.
	canvas add: slice.
	slice draggable; popup.
	slice @ int.
	^ canvas open
]

{ #category : 'examples' }
RSShadowInteraction class >> examplePolygon [
	| canvas int polygon |
	canvas := self canvasExample.
	int := self new.
	polygon  := RSShapeFactory plus size: 30.
	polygon model: 'Drag me'.
	polygon position: 30@30.
	canvas add: polygon.
	polygon draggable; popup.
	polygon @ int.
	^ canvas open
]

{ #category : 'examples' }
RSShadowInteraction class >> exampleShadowColor [
	| canvas int |
	canvas := self canvasExample.
	int := self new.
	int shadowColor: Color green translucent.
	canvas nodes first @ int.
	^ canvas open
]

{ #category : 'hooks' }
RSShadowInteraction >> addInteractionToCanvas: aShape [

	| canvas |
	canvas := aShape canvas.
	canvas ifNil: [ ^ self ].
	canvas shadowInteraction ifNotNil: [ ^ self ].
	canvas shadowInteraction: self.
	canvas when: RSScaleChangedEvent send: #updateAllShadows: to: self
]

{ #category : 'hooks' }
RSShadowInteraction >> createShadowFor: aShape [

	^ (aShape
		   inspectorShadowFor: self padding / (self scaleFrom: aShape)
		   color: self shadowColor)
		  model: nil;
		  yourself
]

{ #category : 'initialization' }
RSShadowInteraction >> initialize [

	super initialize.
	self padding: 4.
	self shadowColor: (Color fromHexString: 'E67E2255').
	self shouldPushFront: false
]

{ #category : 'accessing' }
RSShadowInteraction >> key [
	^ #shadowShapeList
]

{ #category : 'hooks' }
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

{ #category : 'hooks' }
RSShadowInteraction >> padding [

	^ padding
]

{ #category : 'hooks' }
RSShadowInteraction >> padding: number [

	padding := number
]

{ #category : 'hooks' }
RSShadowInteraction >> putShadowOn: aShape [

	| shadow canvas list |
	canvas := aShape canvas.
	shadow := self createShadowFor: aShape.
	aShape parent ifNil: [ ^ self ].
	self shouldPushFront ifTrue: [ aShape pushFront ].
	shadow isFixed: aShape isFixed.
	aShape parent addShape: shadow before: aShape.
	aShape shadow: shadow.
	shadow position: aShape position.

	list := canvas propertyAt: self key ifAbsentPut: [ Set new ].
	list add: aShape
]

{ #category : 'hooks' }
RSShadowInteraction >> removeShadow: evt [

	| canvas shape |
	canvas := evt canvas.
	shape := evt shape.
	shape removeShadow.
	canvas
		propertyAt: self key
		ifPresent: [ :list | list remove: shape ifAbsent: [  ] ]
]

{ #category : 'removing' }
RSShadowInteraction >> removeShadowsOn: aRSCanvas [
	| key |
	key := self key.
	aRSCanvas
		propertyAt: key
		ifPresent: [ :list | list do: #removeShadow ].
	aRSCanvas removeKey: key
]

{ #category : 'hooks' }
RSShadowInteraction >> scaleFrom: aShape [

	"Return the scale used by the canvas of the shape"

	aShape canvas ifNil: [ ^ 1 ].
	aShape isFixed ifTrue: [ ^ 1 ].
	^ aShape canvas camera scale
]

{ #category : 'hooks' }
RSShadowInteraction >> shadowColor [

	^ shadowColor
]

{ #category : 'hooks' }
RSShadowInteraction >> shadowColor: aColor [

	shadowColor := aColor
]

{ #category : 'initialization' }
RSShadowInteraction >> shouldPushFront [

	^ shouldPushFront
]

{ #category : 'accessing' }
RSShadowInteraction >> shouldPushFront: aBoolean [

	shouldPushFront := aBoolean
]

{ #category : 'hooks' }
RSShadowInteraction >> updateAllShadows: evt [

	| canvas |
	canvas := evt canvas.
	canvas
		propertyAt: self key
		ifPresent: [ :list | list do: [ :shape | self updateShadow: shape ] ]
]

{ #category : 'hooks' }
RSShadowInteraction >> updateShadow: evt [

	| shadow shape |
	shape := evt shape.
	shadow := shape shadow.
	shadow ifNil: [ ^ self ].
	shape removeShadow.
	self putShadowOn: shape.
	evt signalUpdate
]
