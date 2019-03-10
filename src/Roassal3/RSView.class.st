"
A RTView is xxxxxxxxx.

Roassal structures a visualization in terms of views, elements, shapes, interactions, and animations.
A ''view'' is a container of graphical elements and represents a layer that may be combined with other views.
"
Class {
	#name : #RSView,
	#superclass : #RSAnnounceableObject,
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
		renderOn: trCanvas.
	^ anElementOrAnEdge
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
RSView >> announcer [ 
	^ trCanvas announcer
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
	"Return the edges that belongs to the view"
	^ edges
]

{ #category : #accessing }
RSView >> elementFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements elementFromModel: anObject

]

{ #category : #accessing }
RSView >> elements [
	^ TSGroup withAll: elements
]

{ #category : #accessing }
RSView >> elementsFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements elementsFromModel: anObject

]

{ #category : #accessing }
RSView >> elementsFromModels: objects [
	"Return elements that corresponds to the objects provided as parameter. If none is found, then return an empty collection"
	^ elements elementsFromModels: objects

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
RSView >> numberOfEdges [
	"Return the number of edges that belongs to the view"
	^ self edges size
]

{ #category : #removing }
RSView >> removeEdge: edge [
	edges remove: edge ifAbsent: [ ].
	edge trachelShape remove.
]

{ #category : #removing }
RSView >> removeElement: anElement [
	elements remove: anElement ifAbsent: [ ].
	anElement trachelShape remove.
]

{ #category : #accessing }
RSView >> setCanvas: aTrachelCanvas [
	trCanvas := aTrachelCanvas.
]
