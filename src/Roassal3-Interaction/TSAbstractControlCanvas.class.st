"
I interact with RSControlsView. my subclasses are added to the controls
"
Class {
	#name : #TSAbstractControlCanvas,
	#superclass : #TSAbstractCanvasInteraction,
	#instVars : [
		'limits'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
TSAbstractControlCanvas >> configuration [
	^ limits ifNil: [ limits := TSControlConfiguration new ]
]

{ #category : #accessing }
TSAbstractControlCanvas >> configuration: aRSControlLimits [
	limits := aRSControlLimits
]

{ #category : #utilities }
TSAbstractControlCanvas >> correctCameraPosition: evt [ 
	^ self 
		correctCameraPosition: evt
		inRectangle: (self expandedRectangle: evt)
		position: evt camera position
		scale: evt camera scale
]

{ #category : #utilities }
TSAbstractControlCanvas >> correctCameraPosition: evt inRectangle: rectangle position: position scale: scale [
	| aCanvas canvasRect x y p |
	aCanvas := evt canvas.
	p := position.
	canvasRect := Rectangle
		rsCenter: p
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
TSAbstractControlCanvas >> correctCameraPosition: evt scale: scale [
	^ self 
		correctCameraPosition: evt
		inRectangle: (self expandedRectangle: evt)
		position: evt camera position
		scale: scale
]

{ #category : #utilities }
TSAbstractControlCanvas >> encompassingRectangleFor: aView [
	^ aView attributes 
		at: #encompassingRectangle 
		ifAbsentPut: [ aView encompassingRectangle  ].
]

{ #category : #utilities }
TSAbstractControlCanvas >> expandedRectangle: evt [
	| key | 
	key := #expanedEncompassingRectangle.
	^ evt canvas attributes at: key ifAbsentPut: [ 
		| rectangle |
		rectangle := self encompassingRectangleFor: evt canvas.
		self configuration padding expandRectangle: rectangle ].
	
]

{ #category : #utilities }
TSAbstractControlCanvas >> removeRectanglesFor: aView [
	aView 
		removeKey: #encompassingRectangle;
		removeKey: #expanedEncompassingRectangle
]

{ #category : #rendering }
TSAbstractControlCanvas >> renderOn: aLegendBuilder [
]

{ #category : #utilities }
TSAbstractControlCanvas >> scaleFor: aScale [
	| l |
	l := self configuration.
	^ (l maxScale min: aScale ) max: l minScale
]
