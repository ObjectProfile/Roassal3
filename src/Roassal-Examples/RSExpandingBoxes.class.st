"
This is a simple example suggested by Nicolas Anquetil
"
Class {
	#name : 'RSExpandingBoxes',
	#superclass : 'RSObject',
	#instVars : [
		'canvas',
		'color',
		'base',
		'border'
	],
	#category : 'Roassal-Examples-Experimental',
	#package : 'Roassal-Examples',
	#tag : 'Experimental'
}

{ #category : 'events' }
RSExpandingBoxes >> close: shape [
	shape children copy do: #remove.
	self update
]

{ #category : 'initialization' }
RSExpandingBoxes >> initialize [
	super initialize.
	canvas := RSCanvas new.
	color := NSScale category20b.
	base := RSComposite new.
	base popup.
	base when: RSMouseClick do: [ :evt | self processEvent: evt ].
	border := RSBorder new
]

{ #category : 'helpers' }
RSExpandingBoxes >> nodeFor: cls [
	| com |
	com := base copy.
	com model: cls.
	cls subclasses ifNotEmpty: [ com border: border ].
	com announcer: base announcer.
	com color: (color scale: cls) translucent.
	^ com
]

{ #category : 'events' }
RSExpandingBoxes >> open: shape [
	| children |
	children := shape model subclasses
		collect: [ :cls | self nodeFor: cls ].
	shape addAll: children.
	self update
]

{ #category : 'events' }
RSExpandingBoxes >> processEvent: evt [
	| shape |
	shape := evt shape.
	shape children
		ifEmpty: [ self open: shape]
		ifNotEmpty: [ self close: shape ]
]

{ #category : 'updating' }
RSExpandingBoxes >> relayout: shape [
	shape propertyAt: #original put: shape encompassingRectangle.

	shape shapes do: [ :s | self relayout: s ].
	RSGridLayout on: shape shapes.
	shape adjustToChildren.
	shape padding: 10
]

{ #category : 'running' }
RSExpandingBoxes >> run [
	<script: 'self new run'>
	canvas add: (self nodeFor: Collection).
	self update.
	canvas open
]

{ #category : 'updating' }
RSExpandingBoxes >> saveCurrent: shape [
	shape children do: [ :s | self saveCurrent: s ].
	shape propertyAt: #current put: shape encompassingRectangle
]

{ #category : 'updating' }
RSExpandingBoxes >> scale: shape at: t [
	| rect1 rect2 |
	shape children do: [ :s | self scale: s at: t ].
	rect1 := shape propertyAt: #original ifAbsent: [ ^ self].

	rect2 := shape propertyAt: #current.


	shape translateTo: (rect1 floatCenter interpolateTo: rect2 floatCenter at: t).

	shape extent: (rect1 extent interpolateTo: rect2 extent at: t)
]

{ #category : 'updating' }
RSExpandingBoxes >> update [
	| first |
	first := canvas shapes first.
	self relayout: first.
	self saveCurrent: first.
	canvas newAnimation
		onStepDo: [ :t |
			self scale: first at: t.
			self zoomCanvans.
			canvas signalUpdate.
			 ]
]

{ #category : 'updating' }
RSExpandingBoxes >> zoomCanvans [
	canvas zoomToFit
	canvas camera scale: 1
]
