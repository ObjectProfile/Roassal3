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
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #accessing }
RSView >> add: anElementOrAnEdge [
	"Add a single roassal element to a view"
	true ifTrue: [ ^ self ].
	self
		assert: [ anElementOrAnEdge isRoassalElement ]
		description: 'Only trachel shapes or Roassal elements can be added to a view'.
	self
		assert: [ anElementOrAnEdge notNil ]
		description: 'Nil cannot be added to a view'.
	anElementOrAnEdge
		renderOn: trCanvas;
		addedIn: self.
	^ anElementOrAnEdge
]

{ #category : #accessing }
RSView >> addAll: someElements [
	"Add many roassal elements to a view"
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
	<debuggerCompleteToSender>
	^ aMessage sendTo: trCanvas
]

{ #category : #accessing }
RSView >> edges [
	"Return the edges that belongs to the view"
	^ edges
]

{ #category : #accessing }
RSView >> elements [
	^ RSGroup withAll: elements
]

{ #category : #inspector }
RSView >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['View'];
		initializeCanvas: [ self canvas ]
]

{ #category : #inspector }
RSView >> gtInspectorEdgesIn: composite [
	<gtInspectorPresentationOrder: 21>
	composite table
		when: [ self edges isNotEmpty ];
		title: 'Edges';
		showOnly: 50;
		display: [ :each | each edges ];
		column: 'Shape' evaluated: [ :each | each shape asString ];
		column: 'Model' evaluated: [ :each | each model asString ];
		column: 'Attributes' evaluated: [ :each | each privateAttributes asString ].
]

{ #category : #inspector }
RSView >> gtInspectorElementsIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite table 
		title: 'Elements';
		showOnly: 50;
		display: [ :each | each elements ];
		children: #children;
		column: 'Shape' evaluated: [ :each | each shape asString ];
		column: 'Model' evaluated: [ :each | each model asString ];
		column: 'Attributes' evaluated: [ :each | each privateAttributes asString ].
]

{ #category : #initialization }
RSView >> initialize [
	super initialize.
	self initializeContent.
	self setCanvas: RSCanvas new
]

{ #category : #initialization }
RSView >> initializeContent [
	elements := RSGroup new.
	edges := RSGroup new
]

{ #category : #accessing }
RSView >> numberOfEdges [
	"Return the number of edges that belongs to the view"
	^ self edges size
]

{ #category : #removing }
RSView >> removeEdge: edge [
	edges remove: edge ifAbsent: [ ].
	edge shape remove.
]

{ #category : #removing }
RSView >> removeElement: anElement [
	elements remove: anElement ifAbsent: [ ].
	anElement shape remove.
]

{ #category : #accessing }
RSView >> setCanvas: aTrachelCanvas [
	trCanvas := aTrachelCanvas.
	trCanvas view: self.
]

{ #category : #accessing }
RSView >> shapeFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements shapeFromModel: anObject

]

{ #category : #accessing }
RSView >> shapesFromModel: anObject [
	"Return an element that corresponds to the object provided as parameter. If none is found, then return nil"
	^ elements shapesFromModel: anObject

]

{ #category : #accessing }
RSView >> shapesFromModels: objects [
	"Return elements that corresponds to the objects provided as parameter. If none is found, then return an empty collection"
	^ elements shapesFromModels: objects

]
