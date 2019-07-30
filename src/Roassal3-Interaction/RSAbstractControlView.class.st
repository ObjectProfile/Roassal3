"
I interact with RSControlsView. my subclasses are added to the controls
"
Class {
	#name : #RSAbstractControlView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'limits'
	],
	#category : #'Roassal3-Interaction-Controls'
}

{ #category : #accessing }
RSAbstractControlView >> configuration [
	^ limits ifNil: [ limits := RSControlConfiguration new ]
]

{ #category : #accessing }
RSAbstractControlView >> configuration: aRSControlLimits [
	limits := aRSControlLimits
]

{ #category : #utilities }
RSAbstractControlView >> correctCameraPosition: evt [ 
	^ self 
		correctCameraPosition: evt
		inRectangle: (self expandedRectangle: evt)
		position: evt camera position
		scale: evt camera scale
]

{ #category : #utilities }
RSAbstractControlView >> correctCameraPosition: evt inRectangle: rectangle position: position scale: scale [
	| aView viewRect x y p |
	aView := evt view.
	p := position.
	viewRect := Rectangle
		rsCenter: p
		extent: aView extent / scale.
	x := rectangle width <= viewRect width
		ifTrue: [rectangle origin x < viewRect origin x
			ifTrue: [ p x - (viewRect origin x - rectangle origin x) ]
			ifFalse: [ rectangle corner x < viewRect corner x
				ifTrue: [ p x ]
				ifFalse: [ p x - (viewRect corner x - rectangle corner x) ] ] ]
		ifFalse: [ viewRect origin x < rectangle origin x
			ifTrue: [ p x - (viewRect origin x - rectangle origin x) ]
			ifFalse: [ rectangle corner x < viewRect corner x
				ifTrue: [ p x - (viewRect corner x - rectangle corner x) ]
				ifFalse: [ p x ] ] ].
	y := rectangle height <= viewRect height
		ifTrue: [rectangle origin y < viewRect origin y
			ifTrue: [ p y - (viewRect origin y - rectangle origin y) ]
			ifFalse: [ rectangle corner y < viewRect corner y
				ifTrue: [ p y ]
				ifFalse: [ p y - (viewRect corner y - rectangle corner y) ] ] ]
		ifFalse: [ viewRect origin y < rectangle origin y
			ifTrue: [ p y - (viewRect origin y - rectangle origin y) ]
			ifFalse: [ rectangle corner y < viewRect corner y
				ifTrue: [ p y - (viewRect corner y - rectangle corner y) ]
				ifFalse: [ p y ] ] ].
	^ x@y
]

{ #category : #utilities }
RSAbstractControlView >> correctCameraPosition: evt scale: scale [
	^ self 
		correctCameraPosition: evt
		inRectangle: (self expandedRectangle: evt)
		position: evt camera position
		scale: scale
]

{ #category : #utilities }
RSAbstractControlView >> encompassingRectangleFor: aView [
	^ aView attributes 
		at: #encompassingRectangle 
		ifAbsentPut: [ aView encompassingRectangle  ].
]

{ #category : #utilities }
RSAbstractControlView >> expandedRectangle: evt [
	| key | 
	key := #expanedEncompassingRectangle.
	^ evt view attributes at: key ifAbsentPut: [ 
		| rectangle |
		rectangle := self encompassingRectangleFor: evt view.
		self configuration padding expandRectangle: rectangle ].
	
]

{ #category : #utilities }
RSAbstractControlView >> removeRectanglesFor: aView [
	aView 
		removeKey: #encompassingRectangle;
		removeKey: #expanedEncompassingRectangle
]

{ #category : #rendering }
RSAbstractControlView >> renderOn: aLegendBuilder [
]

{ #category : #utilities }
RSAbstractControlView >> scaleFor: aScale [
	| l |
	l := self configuration.
	^ (l maxScale min: aScale ) max: l minScale
]
