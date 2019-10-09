"
A RTVerticalLineLayout locates all the elements vertically
"
Class {
	#name : #TSVerticalLineLayout,
	#superclass : #TSAbstractLineLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
TSVerticalLineLayout >> deltaFor: aNodeFigure [
	
	| delta |
	delta := 0.
	self alignment == #right ifTrue: [delta := aNodeFigure width].
	self alignment == #center ifTrue: [delta := aNodeFigure width / 2.0].
	^delta @ 0
]

{ #category : #hook }
TSVerticalLineLayout >> doCenter: aGraph [ 

 	| midWidest step |
	midWidest := aGraph nodes 
		inject: 0
		into: [ :m :el | m max: (el bounds width )].
	midWidest := midWidest / 2.
	aGraph nodes do: [ :node | 
		step := (midWidest - (node bounds width /2)) asInteger @ 0.
		node bounds origin: (node bounds origin + step).
		node bounds corner: (node bounds corner + step).
	] 

]

{ #category : #'initialize-release' }
TSVerticalLineLayout >> initialize [
	
	super initialize.
	self alignLeft
]

{ #category : #hook }
TSVerticalLineLayout >> movePointer: pointer accordingToFigure: aNodeFigure [
	
	^ pointer x @ (pointer y + aNodeFigure height + self verticalGap)
]

{ #category : #hook }
TSVerticalLineLayout >> positionOriginalPointer: elements [ 
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
