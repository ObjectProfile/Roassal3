"
I am a shape with a lot of shapes
"
Class {
	#name : #TSComposite,
	#superclass : #TSBoundingShape,
	#instVars : [
		'shapes'
	],
	#category : #'Roassal3-Shapes-Bounding'
}

{ #category : #adding }
TSComposite >> add: aShape [
	"Add a shape in a composite shape"
	aShape addedIn: self
]

{ #category : #adding }
TSComposite >> addAll: aCollection [
	shapes ifNil: [ shapes := RSGroup new: aCollection size ].
	aCollection do: [ :s| self add: s shape ].
]

{ #category : #adding }
TSComposite >> addBasicShape: aShape [
	self shapes add: aShape
]

{ #category : #adding }
TSComposite >> addFixedShape: aShape [
	self error: 'Composite can not add a fixed shape'
]

{ #category : #adding }
TSComposite >> addShape: aShape [
	"Add a shape in a composite shape"
	aShape addedIn: self
]

{ #category : #public }
TSComposite >> adjustToChildren [
	| rect delta |
	shapes ifNil: [ ^ self ].
	rect := shapes encompassingRectangle.
	delta := rect rsCenter negated.
	shapes do: [ :s | s basicTranslateBy: delta ].
	self 
		extent: rect extent;
		translateTo: delta.
]

{ #category : #accessing }
TSComposite >> camera [
	^ parent camera
]

{ #category : #initialization }
TSComposite >> initialize [
	super initialize.
	paint := nil.
	self resetPath.
	
]

{ #category : #accessing }
TSComposite >> padding: anObject [
	"anObject can be a number, a point or Margin"
	"Shapes should be set in the composite before calling #padding:"
	
	| margin rect center temp |
	temp := shapes 
		ifNil: [ RSGroup new: 0 ]
		ifNotNil: [shapes].
	margin := anObject asMargin. 
	rect := temp encompassingRectangle.
	rect := margin expandRectangle: rect.
	self extent: rect extent.
	
	(center := rect rsCenter) = (0@0) ifTrue: [ ^ self ].
	center := center negated.
	temp do: [ :s | s translateBy: center ].
]

{ #category : #removing }
TSComposite >> removeShape: shape [
	| evt |
	shapes remove: shape.
	shape parent: nil.
	evt := RSShapeRemovedEvent new shape: shape.
	self announce: evt.
	shape announce: evt.
	
]

{ #category : #path }
TSComposite >> resetPath [
	path := baseRectangle
]

{ #category : #path }
TSComposite >> sessionChanged [
	self resetPath.
	shapes ifNil: [ ^ self ].
	shapes do: #sessionChanged
]

{ #category : #'accessing - computed' }
TSComposite >> shapeWithAction: eventClass forPosition: position [
	| res pos |
	pos := self matrix inverseTransform: position.
	self shapes reverseDo: [ :s |
		res := s shapeWithAction: eventClass forPosition: pos.
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
	^ shapes ifNil: [ shapes := RSGroup new ]
]

{ #category : #accessing }
TSComposite >> shapes: aTSGroup [
	"
	create a groups of elements or trachel shapes, then added them to this composite shape
	this method changes the position of the shapes and set the position of this composite shape
	to the center of the encompassingRectangle.
	"
	aTSGroup do: [ :s | 
		s isInACanvas 
			ifTrue: [ s remove ] ].
	self addAll: aTSGroup.
	self adjustToChildren.

	
]

{ #category : #accessing }
TSComposite >> view [
	^ parent view
]
