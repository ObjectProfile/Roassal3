"
I represent an abstract canvas interaction.

I interact with:
- `RSCanvasController`.
- `RSControlConfiguration`

My subclasses have to define:
- `renderLegendOn:`, a nice description of the interaction. will be included in `Help` icon.
- `onShape:`, with the expected behavior of the canvas interaction.

 `RSCanvasController` defines a set of default interactions.
If users want to add more interaction user `RSCanvasController >> #addInteraction:` or to change the default interactions use `RSCanvasController >> #defaultInteractions`.

Each interaction has access to a global configuration `RSControlConfiguration`, then you can customize the interactions with the canvas.

My methods are utilities method to access information of the canvas, like the visible rectangle or the encompassing rectangle of the shapes.


"
Class {
	#name : 'RSAbstractControlCanvasInteraction',
	#superclass : 'RSAbstractCanvasInteraction',
	#instVars : [
		'limits'
	],
	#category : 'Roassal-Interaction-Controls',
	#package : 'Roassal-Interaction',
	#tag : 'Controls'
}

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> computeExpandedRectangle: aCanvas [
	| rectangle matrix |
	"we obtains the rectangle in the canvas space".
	rectangle := self encompassingRectangleFor: aCanvas.
	matrix := aCanvas camera originMatrix.

	"then we convert that to morph coordinates"
	rectangle := Rectangle encompassing: (rectangle corners
		collect: [:corner | matrix transform: corner]).
	"we expand the rectangle with the padding"
	rectangle := self configuration padding expandRectangle: rectangle.
	"the rectangle returns to the canvas space"
	rectangle := Rectangle encompassing: (rectangle corners
		collect: [:corner | matrix inverseTransform: corner]).

	^ rectangle
]

{ #category : 'accessing' }
RSAbstractControlCanvasInteraction >> configuration [
	^ limits ifNil: [ limits := RSControlConfiguration new ]
]

{ #category : 'accessing' }
RSAbstractControlCanvasInteraction >> configuration: aRSControlConfiguration [
	limits := aRSControlConfiguration
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> correctCamera: camera [
	^ self correctCamera: camera matrixDo: [ :mat | ]
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> correctCamera: camera matrixDo: aBlock [
	| canvas rectangle matrix origin correctRectangle |
	canvas := camera canvas.
	matrix := camera matrix.
	origin := nil.
	matrix restoreAfter: [ | diff |
		aBlock value: matrix.
		origin := matrix translation.
		rectangle := self expandedRectangle: canvas.
		correctRectangle := self correctRectangle: rectangle camera: camera.
		diff := (matrix transform: rectangle origin) - (matrix transform: correctRectangle origin).
		origin := origin - diff ].
	^ origin
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> correctCameraPosition: aCanvas inRectangle: rectangle position: position scale: scale [
	| canvasRect x y p |
	p := position.

	canvasRect := Rectangle
		floatCenter: p
		extent: aCanvas extent / scale.
	canvasRect := aCanvas visibleRectangle.

	x := rectangle width <= canvasRect width
		ifTrue: [rectangle origin x < canvasRect origin x
			ifTrue: [ p x - (canvasRect origin x - rectangle origin x) ]
			ifFalse: [ rectangle corner x < canvasRect corner x
				ifTrue: [ p x ]
				ifFalse: [ p x - (canvasRect corner x - rectangle corner x) ] ] ]
		ifFalse: [ canvasRect origin x < rectangle origin x
			ifTrue: [ p x - (canvasRect origin x - rectangle origin x) ]
			ifFalse: [ rectangle corner x < canvasRect corner x
				ifTrue: [ p x - (canvasRect corner x - rectangle corner x) ]
				ifFalse: [ p x ] ] ].
	y := rectangle height <= canvasRect height
		ifTrue: [rectangle origin y < canvasRect origin y
			ifTrue: [ p y - (canvasRect origin y - rectangle origin y) ]
			ifFalse: [ rectangle corner y < canvasRect corner y
				ifTrue: [ p y ]
				ifFalse: [ p y - (canvasRect corner y - rectangle corner y) ] ] ]
		ifFalse: [ canvasRect origin y < rectangle origin y
			ifTrue: [ p y - (canvasRect origin y - rectangle origin y) ]
			ifFalse: [ rectangle corner y < canvasRect corner y
				ifTrue: [ p y - (canvasRect corner y - rectangle corner y) ]
				ifFalse: [ p y ] ] ].
	^ x@y
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> correctRectangle: rectangle camera: camera [
	| visibleRectangle correctX correctY |
	visibleRectangle := camera visibleRectangle.
	correctX := self correctValues: {
		rectangle origin x.
		rectangle corner x.
		visibleRectangle origin x.
		visibleRectangle corner x}.
	correctY := self correctValues: {
		rectangle origin y.
		rectangle corner y.
		visibleRectangle origin y.
		visibleRectangle corner y}.
	^ correctX @ correctY extent: rectangle extent
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> correctValues: array [
	| min max targetMin targetMax width targetWidth res |
	min := array first.
	max := array second.
	targetMin := array third.
	targetMax := array fourth.
	width := max - min.
	targetWidth := targetMax - targetMin.
	res := width < targetWidth ifTrue: [
		max < targetMax ifTrue: [
			min < targetMin
				ifTrue: [ min + (targetMin - min) ]
				ifFalse: [ min ]
		] ifFalse: [ min - (max - targetMax) ].
	] ifFalse: [
		max < targetMax ifTrue: [
			min-(max - targetMax)
		] ifFalse: [
			min < targetMin
				ifTrue: [ min ]
				ifFalse: [ min + (targetMin - min) ]
		].
	].

	^ res
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> encompassingRectangleFor: aCanvas [
	^ aCanvas propertyAt: #encompassingRectangle
		ifAbsentPut: [ aCanvas encompassingRectangle  ]
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> expandedRectangle: aCanvas [
	"^ aCanvas
		propertyAt: #expanedEncompassingRectangle
		ifAbsentPut: [ self computeExpandedRectangle: aCanvas ]."
	^ self computeExpandedRectangle: aCanvas
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> removeRectanglesFor: aCanvas [
	aCanvas
		removeKey: #encompassingRectangle;
		removeKey: #expanedEncompassingRectangle
]

{ #category : 'rendering' }
RSAbstractControlCanvasInteraction >> renderLegendOn: anRSLegend [
	"put a nice description in this legend builder"
	self subclassResponsibility
]

{ #category : 'utilities' }
RSAbstractControlCanvasInteraction >> scaleFor: aScale [
	| l |
	l := self configuration.
	^ (l maxScale min: aScale ) max: l minScale
]
