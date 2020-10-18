"
A RTVerticalLineLayout locates all the elements vertically
"
Class {
	#name : #RSVerticalLineLayout,
	#superclass : #RSAbstractLineLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #alignment }
RSVerticalLineLayout >> alignCenter [
	"Make the element centered"
	alignment := #center
]

{ #category : #alignment }
RSVerticalLineLayout >> alignLeft [
	alignment := #left
]

{ #category : #alignment }
RSVerticalLineLayout >> alignRight [
	alignment := #right
]

{ #category : #hook }
RSVerticalLineLayout >> deltaFor: aNodeFigure [
	| delta |
	delta := 0.
	self alignment == #right ifTrue: [delta := aNodeFigure width].
	self alignment == #center ifTrue: [delta := aNodeFigure width / 2.0].
	^delta @ 0
]

{ #category : #'initialize-release' }
RSVerticalLineLayout >> initialize [
	super initialize.
	self alignLeft
]

{ #category : #hook }
RSVerticalLineLayout >> movePointer: pointer accordingToFigure: aNodeFigure [
	^ pointer x @ (pointer y + aNodeFigure height + self verticalGap)
]

{ #category : #hook }
RSVerticalLineLayout >> positionOriginalPointer: elements [ 
	| maxWidth delta |
	delta := 0.
	self alignment == #right ifTrue: 
		[ maxWidth := elements maxValue: #width.
		delta := maxWidth ].
	self alignment == #center ifTrue: 
		[ maxWidth := elements maxValue: #width.
		delta := maxWidth / 2.0 ].
	^ ((0) + delta) @ (0)

]
