"
TODO
"
Class {
	#name : #RSQuadTree,
	#superclass : #RSObject,
	#instVars : [
		'charge',
		'x',
		'y',
		'leaf',
		'nodes',
		'origin',
		'corner',
		'node',
		'cx',
		'cy'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
RSQuadTree class >> withAll: aNodeCollection [

	^ self withAll: aNodeCollection origin: (aNodeCollection collect: [:e | e position x]) min @ (aNodeCollection collect: [:e | e position y]) min corner: (aNodeCollection collect: [:e | e position x]) max @ (aNodeCollection collect: [:e | e position y]) max
]

{ #category : #public }
RSQuadTree class >> withAll: aNodeCollection origin: aPoint corner: anotherPoint [

	| dx dy root |

	dx := anotherPoint x - aPoint x.
	dy := anotherPoint y - aPoint y.


	(dx closeTo: dy ) ifTrue: [ root := self new.
										root origin: aPoint;
											corner: anotherPoint.
										aNodeCollection do: [ :e | root add: e ].
										^ root ] .
	
	dx > dy ifTrue: [ ^ self withAll: aNodeCollection origin: aPoint corner: anotherPoint x @ (aPoint y + dx) ].
	dy > dx ifTrue: [ ^ self withAll: aNodeCollection origin: aPoint corner: (aPoint x + dy) @ anotherPoint y ] .
]

{ #category : #adding }
RSQuadTree >> add: aNode [

	|n|

	leaf ifTrue: [ x isNil ifFalse: [ (x - aNode position x) abs + (y - aNode position y) abs < 0.01 ifTrue: [ self addChild: aNode ]
																								   ifFalse: [ n := node.
																											x := nil.
																											y := nil.
																											node := nil.
																											self addChild: aNode;
																												addChild: n ] ] 
						ifTrue: [ x := aNode position x.
								y := aNode position y.
								node := aNode ] ] 
		 ifFalse: [ self addChild: aNode ] 
]

{ #category : #adding }
RSQuadTree >> addChild: aNode [


	| sx sy new |
	
	sx := (origin x + corner x) / 2.
	sy := (origin y + corner y) / 2.
	
	leaf := false.

	aNode position x < sx ifTrue: [ aNode position y < sy ifTrue: [ (nodes at: 1) isNil ifTrue: [ new := RSQuadTree new.
																								new origin: origin;
																									corner: sx@sy.
																								nodes at: 1 put: new ] .
																	(nodes at: 1) add: aNode ]
															ifFalse: [ (nodes at: 3) isNil ifTrue: [ new := RSQuadTree new.
																								new origin: origin x @ sy;
																									corner: sx @ corner y.
																								nodes at: 3 put: new ] .
																	(nodes at: 3) add: aNode ] ]
	 
						    ifFalse: [ aNode position y < sy ifTrue: [  (nodes at: 2) isNil ifTrue: [ new := RSQuadTree new.
																								new origin: sx @ origin y;
																									corner: corner x @ sy.
																								nodes at: 2 put: new ] .
																	(nodes at: 2) add: aNode ] 
															ifFalse: [ (nodes at: 4) isNil ifTrue: [ new := RSQuadTree new.
																								new origin: sx @ sy;
																									corner: corner.
																								nodes at: 4 put: new ] .
																	(nodes at: 4) add: aNode ] ] 
]

{ #category : #accessing }
RSQuadTree >> charge [
	^ charge
]

{ #category : #accessing }
RSQuadTree >> charge: anObject [
	charge := anObject
]

{ #category : #accessing }
RSQuadTree >> corner [
	^ corner
]

{ #category : #accessing }
RSQuadTree >> corner: anObject [
	corner := anObject
]

{ #category : #accessing }
RSQuadTree >> cx [
	^ cx
]

{ #category : #accessing }
RSQuadTree >> cx: aFloat [
	cx := aFloat
]

{ #category : #accessing }
RSQuadTree >> cy [
	^ cy
]

{ #category : #accessing }
RSQuadTree >> cy: aFloat [
	cy := aFloat
]

{ #category : #'initialize-release' }
RSQuadTree >> initialize [ 

	super initialize.
	
	leaf := true.
	nodes := Array new: 4.
	
]

{ #category : #accessing }
RSQuadTree >> leaf [
	^ leaf
]

{ #category : #accessing }
RSQuadTree >> node [
	^ node
]

{ #category : #accessing }
RSQuadTree >> nodes [
	^ nodes
]

{ #category : #accessing }
RSQuadTree >> origin [
	^ origin
]

{ #category : #accessing }
RSQuadTree >> origin: anObject [
	origin := anObject
]
