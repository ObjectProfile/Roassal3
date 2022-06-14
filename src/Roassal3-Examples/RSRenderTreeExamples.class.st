"
This class is used to customize the render collection of roassal
check RSAbstractRenderCollection
"
Class {
	#name : #RSRenderTreeExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #lines }
RSRenderTreeExamples >> example01BigVisualization131k [
	<script: 'self new example01BigVisualization131k open
		setLabel: ''131K'' '>
	<noTest>
	"(2 raisedTo: 17) = 131072 = 131K"
	| c b1 b2 |
	c := RSCanvas new.
	c aaNone.
	b2 := nil.
	1 to: (2 raisedTo: 17) do: [ :i | 
		b1 := b2.
		b2 := RSBox new.
		b2 model: i.
		b2 translateTo: (i * 10) @ (i * 10).
		b2 @ RSDraggable.
		c add: b2.
	].
	c renderCollection: RSSequenceableCollection new.
	c @ RSDraggableCanvasInteraction new.
	c nodes @ RSPopup.
	c nodes @ RSHighlightable red.
	^ c
]

{ #category : #lines }
RSRenderTreeExamples >> example02BigVisualizationHalfMillion [
	<script: 'self new example02BigVisualizationHalfMillion open'>
	<noTest>
	"(2 raisedTo: 19) = 524288 = 0.52 Million"
	| c b1 b2 |
	c := RSCanvas new.
	c aaNone.
	b2 := nil.
	1 to: (2 raisedTo: 19) do: [ :i | 
		b1 := b2.
		b2 := RSBox new.
		b2 model: i.
		b2 translateTo: (i * 10) @ (i * 10).
		b2 @ RSDraggable.
		c add: b2.
	].
	c renderCollection: RSBulkLoadRTreeCollection new.
	"c @ RSDraggableCanvasInteraction new."
	c @ RSCanvasController simple.
	c nodes @ RSPopup.
	c nodes @ RSHighlightable red.
	^ c
]
