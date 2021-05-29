"
Make the shape blink.

For example:

```
c := RSCanvas new.
shapes := RSCircle models: (1 to: 9).
shapes size: 30.
c addAll: shapes.
RSGridLayout on: shapes.
shapes when: RSMouseClick do: [ :evt | evt shape @ RSBlink ].

shapes fifth @ RSBlink.
c @ RSCanvasController
```
"
Class {
	#name : #RSBlinkInteraction,
	#superclass : #RSInteraction,
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSBlinkInteraction >> onShape: aShape [
	| canvas previousColor |
	canvas := aShape canvas.
	previousColor := aShape color.
	aShape color: Color red.
	canvas signalUpdate.
	canvas newAnimation
				duration: 0.5 second;
				when: RSAnimationEndEvent do: [ :evt | 
					aShape color: previousColor.
					canvas signalUpdate. ]
]
