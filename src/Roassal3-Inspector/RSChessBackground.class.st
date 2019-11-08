"
I am a basici class
"
Class {
	#name : #RSChessBackground,
	#superclass : #RSAbstractCanvasInteraction,
	#category : #'Roassal3-Inspector-Interaction'
}

{ #category : #hooks }
RSChessBackground >> onShape: aCanvas [
	| boxes theme color |
	theme := Smalltalk ui theme.
	aCanvas color: theme backgroundColor.
	color := theme caretColor alpha: 0.2.
	boxes := nil.
	aCanvas when: RSExtentChangedEvent do: [ 
		| extent side counter even camera |
		boxes ifNotNil: [ boxes do: #remove ].
		extent := aCanvas extent.
		camera := aCanvas camera.
		
		aCanvas zoomToFit.
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
					aCanvas addShape: box.
				 ].
				even := even not.
			].
			counter := counter + 1 ].
		boxes pushBack.
		aCanvas signalUpdate ].
	

]
