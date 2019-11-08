"
A RTHorizontalLineLayout locates all the elements horizontally
"
Class {
	#name : #RSHorizontalLineLayout,
	#superclass : #RSAbstractLineLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #hook }
RSHorizontalLineLayout >> deltaFor: aNodeFigure [
	
	| delta |
	delta := 0.
	self alignment == #bottom ifTrue: [delta := aNodeFigure height].
	self alignment == #center ifTrue: [delta := aNodeFigure height / 2.0].
	^0 @ delta
]

{ #category : #hook }
RSHorizontalLineLayout >> doCenter: elements [ 

 	| midTallest step |
	midTallest := 0.
	midTallest := elements nodes 
		inject: 0
		into: [ :m :el | m max: (el bounds height )].
	midTallest := midTallest / 2.
	elements nodes do: [ :node | 
		step := 0 @ (midTallest - (node bounds height / 2)) asInteger.
		node bounds origin: (node bounds origin + step).
		node bounds corner: (node bounds corner + step).
	] 

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
