"
A RTHorizontalLineLayout locates all the elements horizontally
"
Class {
	#name : #RSHorizontalLineLayout,
	#superclass : #RSAbstractLineLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #alignment }
RSHorizontalLineLayout >> alignBottom [
	alignment := #bottom
]

{ #category : #alignment }
RSHorizontalLineLayout >> alignLabel [
	"Align shapes along the label baseline. It is here assumed that shapes are labels"
	alignment := #label
]

{ #category : #alignment }
RSHorizontalLineLayout >> alignMiddle [
	"Make the element middle"
	alignment := #middle
]

{ #category : #alignment }
RSHorizontalLineLayout >> alignTop [
	alignment := #top
]

{ #category : #hook }
RSHorizontalLineLayout >> deltaFor: aNodeFigure [
	| delta |
	delta := 0.
	alignment = #bottom ifTrue: [delta := aNodeFigure height].
	alignment = #middle ifTrue: [delta := aNodeFigure height / 2.0].
	alignment = #label 
		ifTrue: [ delta := aNodeFigure textExtents y_bearing negated ].
	^ 0 @ delta
]

{ #category : #'initialize-release' }
RSHorizontalLineLayout >> initialize [
	super initialize.
	self alignTop
]

{ #category : #hook }
RSHorizontalLineLayout >> movePointer: pointer accordingToFigure: element [
	^ (pointer x + element width + self horizontalGap) @ pointer y
]

{ #category : #hook }
RSHorizontalLineLayout >> positionOriginalPointer: elements [ 
	| maxHeight delta |
	delta := 0.
	self alignment == #bottom ifTrue: 
		[ maxHeight := elements maxValue: #height.
		delta := maxHeight ].
	self alignment == #center ifTrue: 
		[ maxHeight := elements maxValue: #height.
		delta := maxHeight / 2.0 ].
	^ (0) @ ((0) + delta)
]
