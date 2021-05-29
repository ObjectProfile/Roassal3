"
I am a class to create visualizations about rings, center is the root of the tree and arcs are the sub trees.

You can customize the angle of the arc, and play with the with radius and width of each arc.

"
Class {
	#name : #RSSunburstBuilder,
	#superclass : #RSAbstractTreeBuilder,
	#instVars : [
		'maxLevel',
		'strategy',
		'sliceShape',
		'color'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #'public - shape' }
RSSunburstBuilder >> color: aBlock [
	"an object"
	color := aBlock
]

{ #category : #strategry }
RSSunburstBuilder >> constantWidthStrategy [
	self strategy: RSSunburstConstantWidthStrategy new.
	^ strategy
]

{ #category : #strategry }
RSSunburstBuilder >> extentStrategy [
	self strategy: RSSunburstExtentLayout new.
	^ strategy
]

{ #category : #'public - building' }
RSSunburstBuilder >> from: objects nesting: block1 leaves: block2 [
	| r |
	r := super from: objects nesting: block1 leaves: block2.
	r do: [ :e | e propertyAt: #parent put: nil].
	^ r
]

{ #category : #'public - building' }
RSSunburstBuilder >> from: objects using: ablock [
	| r |
	r := super from: objects using: ablock.
	r do: [ :e | e propertyAt: #parent put: nil].
	^ r
]

{ #category : #initialization }
RSSunburstBuilder >> initialize [
	super initialize. 
	self extentStrategy extent: 500@500.
	self leafWeight: 1.
	self sliceColor: NSScale category20c.
	sliceShape := RSPieSlice new.
	maxLevel := 0.
]

{ #category : #accessing }
RSSunburstBuilder >> maxLevel [
	^ maxLevel
]

{ #category : #hooks }
RSSunburstBuilder >> renderIn: aCanvas [
	super renderIn: aCanvas.
	self strategy on: self rootNodes
]

{ #category : #hooks }
RSSunburstBuilder >> shapeFor: anObject [
	| slice |
	slice := self sliceShape copy
		model: anObject;
		popup;
		draggable;
		yourself.
	slice color: (color rsValue: slice).
	^ slice 
]

{ #category : #'public - shape' }
RSSunburstBuilder >> sliceColor: aBlock [
	"an object"
	color := aBlock
]

{ #category : #accessing }
RSSunburstBuilder >> sliceShape [
	^ sliceShape
]

{ #category : #accessing }
RSSunburstBuilder >> strategy [
	^ strategy
]

{ #category : #accessing }
RSSunburstBuilder >> strategy: anStrategy [
	strategy := anStrategy.
	strategy builder: self
]
