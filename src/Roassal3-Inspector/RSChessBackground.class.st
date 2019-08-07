"
I am a basici class
"
Class {
	#name : #RSChessBackground,
	#superclass : #RSAbstractViewInteraction,
	#category : #'Roassal3-Inspector-Interaction'
}

{ #category : #hooks }
RSChessBackground >> onElement: aView [
	| boxes theme color |
	theme := Smalltalk ui theme.
	aView color: theme backgroundColor.
	color := theme caretColor alpha: 0.2.
	boxes := nil.
	aView when: TSExtentChangedEvent do: [ 
		| extent side counter even camera |
		boxes ifNotNil: [ boxes do: #remove ].
		extent := aView extent.
		camera := aView camera.
		
		aView zoomToFit.
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
					aView addShape: box.
				 ].
				even := even not.
			].
			counter := counter + 1 ].
		boxes pushBack.
		aView signalUpdate ].
	

]
