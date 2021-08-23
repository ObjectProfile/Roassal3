"
I am a builder
"
Class {
	#name : #RSTreeMap,
	#superclass : #RSAbstractTreeBuilder,
	#instVars : [
		'boxShape',
		'extent',
		'inset'
	],
	#category : #'Roassal3-TreeMap'
}

{ #category : #accessing }
RSTreeMap >> boxShape [
	^ boxShape
]

{ #category : #defaults }
RSTreeMap >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #public }
RSTreeMap >> depthShadedBorder [
	| color depths |
	depths := self shapes collect: [ :shape | shape depth ] as: SortedCollection. 
	color := NSScale linear
		domain: { depths first. depths last};
		range: { Color gray. Color white darker }.
	self shapes do: [ :shape | 
		shape border: (RSBorder new color: (color rsValue: shape depth))  ]
]

{ #category : #accessing }
RSTreeMap >> extent [
	^ extent
]

{ #category : #accessing }
RSTreeMap >> extent: aPoint [
	extent := aPoint
]

{ #category : #initialization }
RSTreeMap >> initialize [
	super initialize.
	boxShape := RSBox new
		withBorder;
		popup;
		yourself.
	self 
		extent: 500@500;
		inset: 4.
	
]

{ #category : #accessing }
RSTreeMap >> inset [
	^ inset
]

{ #category : #accessing }
RSTreeMap >> inset: aPoint [
	inset := aPoint
]

{ #category : #rendering }
RSTreeMap >> renderIn: aCanvas [
	super renderIn: aCanvas.
	RSTreeMapLayout new
		rootNodes: rootNodes;
		inset: self inset;
		extent: self extent;
		weight: self weight;
		on: shapes
]

{ #category : #hooks }
RSTreeMap >> shapeFor: anObject [
	^ self boxShape copyWithAnnouncer
		model: anObject;
		yourself.
]
