"
I am a basici class
"
Class {
	#name : #RSChessBackgroundInteraction,
	#superclass : #RSAbstractCanvasInteraction,
	#category : #'Roassal3-Inspector-Interactions'
}

{ #category : #hooks }
RSChessBackgroundInteraction >> onShape: aCanvas [
	aCanvas when: RSExtentChangedEvent send: #updateExtent: to: self
]

{ #category : #hooks }
RSChessBackgroundInteraction >> removeBoxes: evt [
	evt canvas
		propertyAt: self class name
		ifPresent: [ :boxes | boxes do: #remove ]
]

{ #category : #hooks }
RSChessBackgroundInteraction >> updateExtent: evt [
	| extent side counter even camera canvas boxes color theme |
	theme := Smalltalk ui theme.
	canvas := evt canvas.
	canvas color: theme backgroundColor.
	color := theme caretColor alpha: 0.2.
	boxes := nil.
	extent := canvas extent.
	camera := canvas camera.
	self removeBoxes: evt.
	canvas zoomToFit.
	side := 20.
	boxes := RSGroup new.
	counter := 0.
	(side / 2) to: extent x by: 20 do: [ :j |
		even := counter even.
		(side / 2) to: extent y by: 20 do: [ :k |
			| box |
			even ifTrue: [
				box := RSBox new
					color: color;
					size: side / camera scale;
					position: (camera fromPixelToSpace: j@k).
				boxes add: box.
				canvas addShape: box.
			 ].
			even := even not.
		].
		counter := counter + 1 ].
	boxes pushBack.
	canvas
		propertyAt: self class name
		put: boxes.
	canvas signalUpdate
]
