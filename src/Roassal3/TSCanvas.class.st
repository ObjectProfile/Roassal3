Class {
	#name : #TSCanvas,
	#superclass : #TSObject,
	#instVars : [
		'shapes',
		'fixedShapes',
		'camera',
		'renderTree',
		'extent',
		'color'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #visiting }
TSCanvas >> accept: visitor [
	visitor visitCanvas: self
]

{ #category : #adding }
TSCanvas >> addShape: aShape [
	"Add a shape to the canvas. The shape may be fixed or not"
	aShape isFixed 
		ifTrue: [ fixedShapes add: aShape ]
		ifFalse: [ shapes add: aShape ]
]

{ #category : #accessing }
TSCanvas >> camera [
	^ camera
]

{ #category : #accessing }
TSCanvas >> camera: aCamera [
	camera := aCamera
]

{ #category : #accessing }
TSCanvas >> color [ 
	^ color
]

{ #category : #accessing }
TSCanvas >> color: aColor [
	color := aColor
]

{ #category : #accessing }
TSCanvas >> extent [
	^ extent
]

{ #category : #accessing }
TSCanvas >> extent: aPoint [
	extent := aPoint
]

{ #category : #accessing }
TSCanvas >> fixedShapes [
	^ fixedShapes 
]

{ #category : #initialization }
TSCanvas >> initialize [
	super initialize.
	shapes := OrderedCollection new.
	fixedShapes := OrderedCollection new.
	color := Color white.
	camera := TSCamera new
		canvas: self;
		yourself.
]

{ #category : #'instance creation' }
TSCanvas >> morph [
	| morph |
	morph := TSAthensMorph new. 
	morph renderer: TSAthensRenderer new.
	morph canvas: self.
	^ morph
]

{ #category : #accessing }
TSCanvas >> numberOfFixedShapes [
	"Return the number of fixed shapes"
	^ fixedShapes size
]

{ #category : #accessing }
TSCanvas >> numberOfShapes [
	"Return the number of non-fixed shapes"
	^ shapes size
]

{ #category : #'instance creation' }
TSCanvas >> open [
	^ self openInWindowSized: 500@500
]

{ #category : #'instance creation' }
TSCanvas >> openInWindowSized: anExtentAsPoint [
	| morph window |
	morph := self morph.
	window := morph openInWindow.
	window extent: anExtentAsPoint.
	^ window
]

{ #category : #dependencies }
TSCanvas >> release [
	camera := nil
]

{ #category : #accessing }
TSCanvas >> shapes [
	^shapes
]
