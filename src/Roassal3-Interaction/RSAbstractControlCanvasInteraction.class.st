"
I interact with RSControlsView. my subclasses are added to the controls
"
Class {
	#name : #RSAbstractControlCanvasInteraction,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'limits'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
RSAbstractControlCanvasInteraction >> configuration [
	^ limits ifNil: [ limits := RSControlConfiguration new ]
]

{ #category : #accessing }
RSAbstractControlCanvasInteraction >> configuration: aRSControlConfiguration [
	limits := aRSControlConfiguration
]

{ #category : #utilities }
RSAbstractControlCanvasInteraction >> correctCameraPosition: aCanvas [
	^ self
		correctCameraPosition: aCanvas
		inRectangle: (self expandedRectangle: aCanvas)
		position: aCanvas camera position
		scale: aCanvas camera scale
]

{ #category : #utilities }
RSAbstractControlCanvasInteraction >> correctCameraPosition: aCanvas inRectangle: rectangle position: position scale: scale [
	| canvasRect x y p |
	p := position.
	canvasRect := Rectangle
		floatCenter: p
		extent: aCanvas extent / scale.
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

{ #category : #utilities }
RSAbstractControlCanvasInteraction >> correctCameraPosition: aCanvas scale: scale [
	^ self
		correctCameraPosition: aCanvas
		inRectangle: (self expandedRectangle: aCanvas)
		position: aCanvas camera position
		scale: scale
]

{ #category : #utilities }
RSAbstractControlCanvasInteraction >> encompassingRectangleFor: aCanvas [
	^ aCanvas propertyAt: #encompassingRectangle
		ifAbsentPut: [ aCanvas encompassingRectangle  ]
]

{ #category : #utilities }
RSAbstractControlCanvasInteraction >> expandedRectangle: aCanvas [
	| key |
	key := #expanedEncompassingRectangle.
	^ aCanvas propertyAt: key ifAbsentPut: [
		| rectangle |
		rectangle := self encompassingRectangleFor: aCanvas.
		self configuration padding expandRectangle: rectangle ]
]

{ #category : #utilities }
RSAbstractControlCanvasInteraction >> removeRectanglesFor: aCanvas [
	aCanvas
		removeKey: #encompassingRectangle;
		removeKey: #expanedEncompassingRectangle
]

{ #category : #rendering }
RSAbstractControlCanvasInteraction >> renderLegendOn: aLegendBuilder [
	self subclassResponsibility
]

{ #category : #utilities }
RSAbstractControlCanvasInteraction >> scaleFor: aScale [
	| l |
	l := self configuration.
	^ (l maxScale min: aScale ) max: l minScale
]
