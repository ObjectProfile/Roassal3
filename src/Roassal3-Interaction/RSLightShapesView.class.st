"
I am basic interaction that cuts shapes to the view in order to view in lightway
"
Class {
	#name : #RSLightShapesView,
	#superclass : #RSAbstractViewInteraction,
	#instVars : [
		'shapes'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #hooks }
RSLightShapesView >> onElement: aView [
	| update |
	shapes := aView shapes.
	update := [ self updateView: aView ].
	aView
		when: TSExtentChangedEvent do: update;
		when: TSPositionChangedEvent do: update;
		when: TSScaleChangedEvent do: update.
]

{ #category : #hooks }
RSLightShapesView >> shapes [
	^ shapes
]

{ #category : #hooks }
RSLightShapesView >> shapes: aCollection [
	shapes := aCollection
]

{ #category : #hooks }
RSLightShapesView >> updateView: aView [
	| extent cam p rect tempShapes |
	cam := aView camera.
	extent := aView extent.
	p := extent / cam scale.
	rect := Rectangle rsCenter: cam position extent: p.
	tempShapes := shapes select: [ :s | s encompassingRectangle intersects: rect ].
	aView shapes: tempShapes.
	"tempShapes size logCr."
]
