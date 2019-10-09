"
I am a basici class
"
Class {
	#name : #TSChessBackground,
	#superclass : #TSAbstractCanvasInteraction,
	#category : #'Roassal3-Inspector-Interaction'
}

{ #category : #hooks }
TSChessBackground >> onShape: aCanvas [
	| boxes theme color |
	theme := Smalltalk ui theme.
	aCanvas color: theme backgroundColor.
	color := theme caretColor alpha: 0.2.
	boxes := nil.
	aCanvas when: TSExtentChangedEvent do: [ 
		| extent side counter even camera |
		boxes ifNotNil: [ boxes do: #remove ].
		extent := aCanvas extent.
		camera := aCanvas camera.
		
		aCanvas zoomToFit.
		side := 20.
		boxes := TSGroup new.
		counter := 0.
		(side / 2) to: extent x by: 20 do: [ :j |
			even := counter even.
			(side / 2) to: extent y by: 20 do: [ :k |
				| box |
				even ifTrue: [ 
					box := TSBox new
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
