"
A RSVerticalLineLayout locates all the elements vertically.
"
Class {
	#name : #RSVerticalLineLayout,
	#superclass : #RSAbstractLineLayout,
	#category : #'Roassal-Layouts-Line'
}

{ #category : #examples }
RSVerticalLineLayout class >> example1 [
	| c |
	c := self canvasExample.
	self on: c nodes.
	c zoomToFit.
	^ c open
]

{ #category : #examples }
RSVerticalLineLayout class >> example2 [
	| c |
	c := self canvasExample.
	self new
		alignRight;
		on: c nodes.
	c zoomToFit.
	^ c open
]

{ #category : #alignment }
RSVerticalLineLayout >> alignCenter [
	"Make the element centered"
	self alignment: #center
]

{ #category : #alignment }
RSVerticalLineLayout >> alignLeft [
	self alignment: #left
]

{ #category : #alignment }
RSVerticalLineLayout >> alignRight [
	self alignment: #right
]

{ #category : #hook }
RSVerticalLineLayout >> deltaFor: anRSShape [
	| delta |
	delta := 0.
	alignment == #right ifTrue: [ delta := anRSShape width ].
	alignment == #center ifTrue: [ delta := anRSShape width / 2.0 ].
	^delta @ 0
]

{ #category : #hook }
RSVerticalLineLayout >> movePointer: pointer accordingToFigure: anRSShape [
	^ pointer x @ (pointer y + anRSShape height + self verticalGap)
]

{ #category : #hook }
RSVerticalLineLayout >> positionOriginalPointer: aCollectionOfShapes [
	| maxWidth delta |
	delta := 0.
	alignment == #right ifTrue: [
		maxWidth := aCollectionOfShapes maxValue: #width.
		delta := maxWidth ].
	alignment == #center ifTrue: [
		maxWidth := aCollectionOfShapes maxValue: #width.
		delta := maxWidth / 2.0 ].
	^ ((0) + delta) @ (0)
]
