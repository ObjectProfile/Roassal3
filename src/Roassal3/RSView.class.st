"
A RTView is xxxxxxxxx.

Roassal structures a visualization in terms of views, elements, shapes, interactions, and animations.
A ''view'' is a container of graphical elements and represents a layer that may be combined with other views.
"
Class {
	#name : #RSView,
	#superclass : #RSObject,
	#instVars : [
		'elements',
		'edges',
		'trCanvas'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
RSView >> add: anElementOrAnEdge [
	self assert: [ anElementOrAnEdge ~= nil ] description: 'Nil cannot be added to a view'.
	anElementOrAnEdge 
		addedIn: self;
		renderOn: trCanvas 
]

{ #category : #accessing }
RSView >> addAll: someElements [
	someElements do: [ :e | self add: e  ].
]

{ #category : #accessing }
RSView >> addEdge: anEdge [
	edges add: anEdge
]

{ #category : #accessing }
RSView >> addElement: anElement [
	elements add: anElement
]

{ #category : #accessing }
RSView >> canvas [
	^trCanvas 
]

{ #category : #'reflective operations' }
RSView >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: trCanvas
]

{ #category : #accessing }
RSView >> edges [
	^ edges
]

{ #category : #accessing }
RSView >> elements [
	^ elements
]

{ #category : #initialization }
RSView >> initialize [
	super initialize.
	self initializeContent.
	self setCanvas: TSCanvas new
]

{ #category : #initialization }
RSView >> initializeContent [
	elements := TSGroup new.
	edges := TSGroup new
]

{ #category : #accessing }
RSView >> setCanvas: aTrachelCanvas [
	trCanvas := aTrachelCanvas.
]
