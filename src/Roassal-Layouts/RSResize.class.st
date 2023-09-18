"
Adjust the size of the shapes
"
Class {
	#name : #RSResize,
	#superclass : #RSAbstractShapeHandling,
	#category : #'Roassal-Layouts-PositionAndResize'
}

{ #category : #examples }
RSResize class >> example [
	| values canvas colorPallete boxes |
	values := #(35 26 5 18 17 60 36 13 16 28 29 3 8 0 3 2 14 12 13 17 1 9 3 3 4 1 1 1 2 1 1 61).
	canvas := RSCanvas  new.
	colorPallete := NSScale category20c.
	boxes := RSBox models: values.
	boxes size: #yourself.
	boxes color: colorPallete.
	canvas addAll: boxes.
	"before this all of them have different sizes"
	self new shapes: boxes; sameSize.
	
	RSHorizontalLineLayout new gapSize: 0; on: boxes.
	canvas @ RSCanvasController.
	^ canvas open
]

{ #category : #'accessing - computed' }
RSResize >> biggestExtent [
	fixedShape ifNotNil: [ ^ fixedShape extent ].
	^ shapes inject: 0 @ 0 into: [ :maxExtent :e |
			maxExtent max: e extent ]
]

{ #category : #'accessing - computed' }
RSResize >> biggestShape [
	^ shapes inject: shapes anyOne into: [ :biggestShape :e |
			biggestShape extent < e extent
				ifTrue: [ e ] ifFalse: [ biggestShape ] ]
]

{ #category : #'accessing - computed' }
RSResize >> highestShape [
	^ shapes inject: shapes anyOne into: [ :highestShape :e |
			highestShape extent y < e extent y
				ifTrue: [ e ] ifFalse: [ highestShape ] ]
]

{ #category : #public }
RSResize >> sameHeight [
	self ifNoFixedShapeThen: [ self useHighestShape ].
	shapes do: [ :e | e height: self fixedShape height ]
]

{ #category : #public }
RSResize >> sameSize [
	self ifNoFixedShapeThen: [ self useBiggestShape ].
	shapes do: [ :e | e extent: self fixedShape extent ]
]

{ #category : #public }
RSResize >> sameWidth [
	self ifNoFixedShapeThen: [ self useWidestShape ].
	shapes do: [ :e | e width: self fixedShape width ]
]

{ #category : #'public - configuration' }
RSResize >> useBiggestShape [
	self fixedShape: self biggestShape
]

{ #category : #'public - configuration' }
RSResize >> useHighestShape [
	self fixedShape: self highestShape
]

{ #category : #'public - configuration' }
RSResize >> useWidestShape [
	self fixedShape: self widestShape
]

{ #category : #'accessing - computed' }
RSResize >> widestShape [
	^ shapes inject: shapes anyOne into: [ :widestElement :e |
			widestElement extent x < e extent x
				ifTrue: [ e ] ifFalse: [ widestElement ] ]
]
