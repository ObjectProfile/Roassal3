"
I interact with RSControlsView. my subclasses are added to the controls
"
Class {
	#name : #RSAbstractControlCanvas,
	#superclass : #RSAbstractCanvasInteraction,
	#instVars : [
		'limits'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
RSAbstractControlCanvas >> configuration [
	^ limits ifNil: [ limits := RSControlConfiguration new ]
]

{ #category : #accessing }
RSAbstractControlCanvas >> configuration: aRSControlLimits [
	limits := aRSControlLimits
]

{ #category : #utilities }
RSAbstractControlCanvas >> correctCameraPosition: aCanvas [ 
	^ self 
		correctCameraPosition: aCanvas
		inRectangle: (self expandedRectangle: aCanvas)
		position: aCanvas camera position
		scale: aCanvas camera scale
]

{ #category : #utilities }
RSAbstractControlCanvas >> correctCameraPosition: aCanvas inRectangle: rectangle position: position scale: scale [
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
RSAbstractControlCanvas >> correctCameraPosition: aCanvas scale: scale [
	^ self 
		correctCameraPosition: aCanvas
		inRectangle: (self expandedRectangle: aCanvas)
		position: aCanvas camera position
		scale: scale
]

{ #category : #utilities }
RSAbstractControlCanvas >> encompassingRectangleFor: aCanvas [
	^ aCanvas propertyAt: #encompassingRectangle 
		ifAbsentPut: [ aCanvas encompassingRectangle  ].
]

{ #category : #utilities }
RSAbstractControlCanvas >> expandedRectangle: aCanvas [
	| key | 
	key := #expanedEncompassingRectangle.
	^ aCanvas propertyAt: key ifAbsentPut: [ 
		| rectangle |
		rectangle := self encompassingRectangleFor: aCanvas.
		self configuration padding expandRectangle: rectangle ].
	
]

{ #category : #utilities }
RSAbstractControlCanvas >> removeRectanglesFor: aCanvas [
	aCanvas 
		removeKey: #encompassingRectangle;
		removeKey: #expanedEncompassingRectangle
]

{ #category : #rendering }
RSAbstractControlCanvas >> renderLegendOn: aLegendBuilder [
	self subclassResponsibility
]

{ #category : #utilities }
RSAbstractControlCanvas >> scaleFor: aScale [
	| l |
	l := self configuration.
	^ (l maxScale min: aScale ) max: l minScale
]
