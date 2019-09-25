"
I am a class to create visualizations about rings, center is the root of the tree and arcs are the sub trees.

You can customize the angle of the arc, and play with the with radius and width of each arc.

"
Class {
	#name : #RSSunburstBuilder,
	#superclass : #RSAbstractTreeBuilder,
	#instVars : [
		'maxLevel',
		'strategy'
	],
	#category : #'Roassal3-Sunburst'
}

{ #category : #strategry }
RSSunburstBuilder >> constantWidthStrategy [
	self strategy: RSSunburstConstantWidthStrategy new.
	^ strategy
]

{ #category : #strategry }
RSSunburstBuilder >> extentStrategy [
	self strategy: RSSunburstExtentStrategy new.
	^ strategy
]

{ #category : #'public - building' }
RSSunburstBuilder >> from: objects nesting: block1 leaves: block2 [
	| r |
	r := super from: objects nesting: block1 leaves: block2.
	r do: [ :e | e attributes at: #parent put: nil].
	^ r
]

{ #category : #'public - building' }
RSSunburstBuilder >> from: objects using: ablock [
	| r |
	r := super from: objects using: ablock.
	r do: [ :e | e attributes at: #parent put: nil].
	^ r
]

{ #category : #initialization }
RSSunburstBuilder >> initialize [
	super initialize.
	"self constantWidthStrategy arcWidth: 25."
	self extentStrategy extent: 500@500.
	self leafWeight: 1.
	self shape: (RSShapeBuilder arc 
		color: [ Color random ];
		popup;
		yourself).
	maxLevel := 0.
]

{ #category : #accessing }
RSSunburstBuilder >> maxLevel [
	^ maxLevel
]

{ #category : #hooks }
RSSunburstBuilder >> renderIn: aView [
	super renderIn: aView.
	self strategy on: self rootNodes

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
