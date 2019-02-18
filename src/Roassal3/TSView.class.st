"
A RTView is xxxxxxxxx.

Roassal structures a visualization in terms of views, elements, shapes, interactions, and animations.
A ''view'' is a container of graphical elements and represents a layer that may be combined with other views.
"
Class {
	#name : #TSView,
	#superclass : #RSObject,
	#instVars : [
		'elements',
		'edges',
		'trCanvas'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
TSView >> add: anElementOrAnEdge [
	self assert: [ anElementOrAnEdge ~= nil ] description: 'Nil cannot be added to a view'.
	anElementOrAnEdge 
		addedIn: self;
		renderOn: trCanvas 
]

{ #category : #accessing }
TSView >> addAll: someElements [
	someElements do: [ :e | self add: e  ].
]

{ #category : #accessing }
TSView >> addElement: anElement [
	elements add: anElement
]

{ #category : #accessing }
TSView >> canvas [
	^trCanvas 
]

{ #category : #'reflective operations' }
TSView >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: trCanvas
]

{ #category : #initialization }
TSView >> initialize [
	super initialize.
	self initializeContent.
	self setCanvas: TSCanvas new
]

{ #category : #initialization }
TSView >> initializeContent [
	elements := TSGroup new.
	edges := TSGroup new
]

{ #category : #accessing }
TSView >> setCanvas: aTrachelCanvas [
	trCanvas := aTrachelCanvas.
]
