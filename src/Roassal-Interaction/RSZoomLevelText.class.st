"
ZoomLevel clean text to avoid a lot of drawing elements

Please check class side for examples
"
Class {
	#name : 'RSZoomLevelText',
	#superclass : 'RSAbstractCanvasInteraction',
	#instVars : [
		'labels'
	],
	#category : 'Roassal-Interaction-Extra',
	#package : 'Roassal-Interaction',
	#tag : 'Extra'
}

{ #category : 'hooks' }
RSZoomLevelText >> emptyLimit [
	^ 1
]

{ #category : 'hooks' }
RSZoomLevelText >> key [
	^ #referenceLabel
]

{ #category : 'hooks' }
RSZoomLevelText >> limitText [
	^ 3
]

{ #category : 'hooks' }
RSZoomLevelText >> newEmptyBox: shape [
	| rect |
	rect := shape encompassingRectangle.
	^ RSBox new
		noPaint;
		fromRectangle: rect;
		yourself
]

{ #category : 'hooks' }
RSZoomLevelText >> newLine: shape [
	| rect |
	rect := shape encompassingRectangle.

	^ RSLine new
		paint: shape paint;
		startPoint: rect leftCenter;
		endPoint: rect rightCenter;
		width: rect height;
		yourself
]

{ #category : 'hooks' }
RSZoomLevelText >> onShape: aCanvas [
	self prepareLabels: aCanvas.
	aCanvas when: RSScaleChangedEvent send: #updateZoomLevel: to: self
]

{ #category : 'hooks' }
RSZoomLevelText >> prepareLabels: aCanvas [
	| key |
	labels := aCanvas allChildren select: [ :shape | shape isLabel ].
	key := self key.
	labels do: [ :each | each propertyAt: key put: each ]
]

{ #category : 'hooks' }
RSZoomLevelText >> update: label withNewShape: shape [
	| currentShape parent key |
	key := self key.
	currentShape := label propertyAt: key.
	parent := currentShape parent.
	currentShape remove.
	parent add: shape.
	label propertyAt: key put: shape
]

{ #category : 'hooks' }
RSZoomLevelText >> updateZoomLevel: evt [
	| key |
	key := self key.
	labels do: [ :each |
		| currentShape matrix rect parent |
		currentShape := each propertyAt: key.
		parent := currentShape parent.
		matrix := parent globalMatrix.
		matrix scaleBy: evt camera scale.
		rect := each computeEncompassingRectangleFor: each encompassingRectangle matrix: matrix.
		rect height >= self limitText ifTrue: [
			currentShape == each ifFalse: [ self update: each withNewShape: each ]
		].

		(rect height between: self emptyLimit and: self limitText) ifTrue: [
			currentShape isLine ifFalse: [

				self update: each withNewShape: (self newLine: each).
			]
		].
		(rect height < self emptyLimit) ifTrue: [
			currentShape class = RSBox ifFalse: [
				self update: each withNewShape: (self newEmptyBox: each).
			]
		]
	].
	evt signalUpdate
]
