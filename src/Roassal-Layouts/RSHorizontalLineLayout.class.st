"
A RSHorizontalLineLayout locates all the elements horizontally.

You can use label alignment to align labels based on baseline of each font.

"
Class {
	#name : #RSHorizontalLineLayout,
	#superclass : #RSAbstractLineLayout,
	#category : #'Roassal-Layouts-Line'
}

{ #category : #examples }
RSHorizontalLineLayout class >> example1 [
	| c |
	c := self canvasExample.
	self new
		alignMiddle;
		gapSize: 30;
		on: c nodes.
	^ c open
]

{ #category : #examples }
RSHorizontalLineLayout class >> exampleLabel [
	| c |
	c := RSCanvas new.
	c addAll: (#(This is very important) collect: [ :string | | label |
		label := RSLabel new
			text: string;
			color: Color black;
			yourself.
		string == #This
			ifTrue: [ label bold; color: Color blue; fontSize: 20 ].
		string == #important
			ifTrue: [ label bold; color: Color red; fontSize: 30 ].
		label
		] ).
	c @ RSCanvasController.
	self new
		alignLabel;
		gapSize: 3;
		on: c nodes.
	^ c open
]

{ #category : #alignment }
RSHorizontalLineLayout >> alignBottom [
	self alignment: #bottom
]

{ #category : #alignment }
RSHorizontalLineLayout >> alignLabel [
	"Align shapes along the label baseline. It is here assumed that shapes are labels"
	self alignment: #label
]

{ #category : #alignment }
RSHorizontalLineLayout >> alignMiddle [
	"Make the element middle"
	self alignment: #middle
]

{ #category : #alignment }
RSHorizontalLineLayout >> alignTop [
	self alignment: #top
]

{ #category : #hook }
RSHorizontalLineLayout >> deltaFor: anRSShape [
	| delta |
	delta := 0.
	alignment == #bottom ifTrue: [ delta := anRSShape height ].
	alignment == #middle ifTrue: [ delta := anRSShape height / 2.0 ].
	alignment == #label
		ifTrue: [ delta := anRSShape textExtents y_bearing negated ].
	^ 0 @ delta
]

{ #category : #hook }
RSHorizontalLineLayout >> movePointer: pointer accordingToFigure: anRSShape [
	^ (pointer x + anRSShape width + self horizontalGap) @ pointer y
]

{ #category : #hook }
RSHorizontalLineLayout >> positionOriginalPointer: aCollectionOfShapes [
	| maxHeight delta |
	delta := 0.
	alignment == #bottom ifTrue: [
		maxHeight := aCollectionOfShapes maxValue: #height.
		delta := maxHeight ].
	alignment == #middle ifTrue: [
		maxHeight := aCollectionOfShapes maxValue: #height.
		delta := maxHeight / 2.0 ].
	^ (0) @ ((0) + delta)
]
