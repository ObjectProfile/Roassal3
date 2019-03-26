"
I am a shape with a lot of shapes
"
Class {
	#name : #TSComposite,
	#superclass : #TSBoundingShape,
	#instVars : [
		'shapes'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #adding }
TSComposite >> add: aShape [
	aShape addedIn: self
]

{ #category : #adding }
TSComposite >> addAll: aCollection [
	aCollection do: [ :s| self add: s trachelShape ].
]

{ #category : #adding }
TSComposite >> addBasicShape: aShape [
	self shapes add: aShape
]

{ #category : #adding }
TSComposite >> addFixedShape: aShape [
	self error: 'Composite can not add a fixed shape'
]

{ #category : #initialization }
TSComposite >> initialize [
	super initialize.
	paint := nil.
	self resetPath.
	
]

{ #category : #removing }
TSComposite >> removeShape: shape [
	| evt |
	shapes remove: shape.
	shape parent: nil.
	evt := TSShapeRemovedEvent new shape: shape.
	self announce: evt.
	shape announce: evt.
	
]

{ #category : #path }
TSComposite >> resetPath [
	path := Rectangle center: 0@0 extent: extent asFloatPoint.
]

{ #category : #'accessing - computed' }
TSComposite >> shapeWithAction: eventClass forPosition: position [
	| res pos |
	pos := self matrix inverseTransform: position.
	self shapes reverseDo: [ :s |
		res := s shapeWithAction: eventClass forPosition: pos "position - self position".
		res ifNotNil: [ ^ res] ].
	^ super shapeWithAction: eventClass forPosition: position.
]

{ #category : #'accessing - computed' }
TSComposite >> shapeWithActionForPosition: position [
	| res pos |
	pos := self matrix inverseTransform: position.
	self shapes reverseDo: [ :s |
		res := s shapeWithActionForPosition: pos.
		res ifNotNil: [ ^ res] ].
	^ super shapeWithActionForPosition: position.
]

{ #category : #accessing }
TSComposite >> shapes [
	^ shapes ifNil: [ shapes := TSGroup new ]
]

{ #category : #accessing }
TSComposite >> shapes: aTSGroup [
	"
	create a groups of elements or trachel shapes, then added them to this composite shape
	this method changes the position of the shapes and set the position of this composite shape
	to the center of the encompassingRectangle.
	"
	| rect delta |
	rect := aTSGroup encompassingRectangle.
	delta := rect center.
	aTSGroup do: [ :s | 
		s isInACanvas ifTrue: [ s remove ].
		s translateBy: delta negated ].
	self 
		extent: rect extent;
		translateTo: delta.
	self addAll: aTSGroup.

	
]
