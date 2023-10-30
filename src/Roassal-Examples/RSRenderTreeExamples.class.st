"
This class is used to customize the render collection of roassal
check RSAbstractRenderCollection
"
Class {
	#name : 'RSRenderTreeExamples',
	#superclass : 'RSAbstractExamples',
	#category : 'Roassal-Examples-Basic',
	#package : 'Roassal-Examples',
	#tag : 'Basic'
}

{ #category : 'lines' }
RSRenderTreeExamples >> example01BigVisualization131k [
	<script: 'self new example01BigVisualization131k open
		setLabel: ''131K'' '>
	<noTest>
	"(2 raisedTo: 17) = 131072 = 131K"
	| c b1 b2 |
	c := RSCanvas new.
	c host aaNone.
	b2 := nil.
	1 to: (2 raisedTo: 17) do: [ :i |
		b1 := b2.
		b2 := RSBox new.
		b2 model: i.
		b2 translateTo: (i * 10) @ (i * 10).
		b2 @ RSDraggable.
		c add: b2.
	].
	"c renderCollection: RSSequenceableCollection new."
	c @ RSDraggableCanvasInteraction new.
	c nodes @ RSPopup.
	c nodes @ RSHighlightable red.
	^ c
]

{ #category : 'lines' }
RSRenderTreeExamples >> example02BigVisualizationHalfMillion [
	<script: 'self new example02BigVisualizationHalfMillion open'>
	<noTest>
	"(2 raisedTo: 19) = 524288 = 0.52 Million"
	| c b1 b2 |
	c := RSCanvas new.
	c host aaNone.
	b2 := nil.
	1 to: (2 raisedTo: 19) do: [ :i |
		b1 := b2.
		b2 := RSBox new.
		b2 model: i.
		b2 translateTo: (i * 10) @ (i * 10).
		b2 @ RSDraggable.
		c add: b2.
	].
	c shapeCollection: RTBulkLoadRTreeCollection new.

	c @ RSCanvasController simple.
	c nodes @ RSPopup.
	c nodes @ RSHighlightable red.
	^ c
]

{ #category : 'lines' }
RSRenderTreeExamples >> example03RTree [
	<script: 'self new example03RTree inspect'>
	<noTest>
	| tree random canvas |
	tree := RTreeCollection new.
	random := Random new.
	random seed: 777.
	canvas := RSCanvas new.
	1 to: 100 do: [ :each | | box |
		box := RSBox new.
		box size: 10.
		box model: each.
		box popup.
		box position: (random next @ random next) * 1000.
		canvas add: box.

		tree add: box.
	].
	canvas @ RSCanvasController.
	^ tree
]
