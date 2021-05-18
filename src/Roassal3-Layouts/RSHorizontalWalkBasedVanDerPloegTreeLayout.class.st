"
I am a refinement of the Walker algorithm described in the publication ""Drawing non-layered tidy trees in linear time"" by Atze van der Ploeg [1] (companion repo at [2]).

[1]: https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923
[2]: https://github.com/cwi-swat/non-layered-tidy-trees
"
Class {
	#name : #RSHorizontalWalkBasedVanDerPloegTreeLayout,
	#superclass : #RSHorizontalWalkBasedTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> addChildSpacing: children [

	^ children inject: 0 @ 0 into: [ :aPoint :child | 
		  | x newPoint |
		  x := aPoint x + (self shiftOf: child).
		  newPoint := Point x: x y: x + aPoint y + (self changeOf: child).
		  self modOf: child put: (self modOf: child) + newPoint y.
		  newPoint ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> bottom: aShape [

	^ (self xOf: aShape) + aShape width
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> firstWalk: v [

	self
		is: v
		ifLeaf: [ self setExtremesOfLeaf: v ]
		ifNotLeaf: [ :children | 
			| leftMostChild rightMostChild chain ihInitial minY |
			leftMostChild := children first.
			rightMostChild := children last.

			"Recur down on v's leftmost child."
			self firstWalk: leftMostChild.

			"Create siblings in contour minimal vertical coordinate and index list."
			minY := self bottom: (self elOf: leftMostChild).
			ihInitial := self updateIYL: minY at: 1 rest: nil.
			chain := (2 to: children size) inject: ihInitial into: [ :ih :i | 
				         | child |
				         child := children at: i.

				         self firstWalk: child.

				         minY := self bottom: (self erOf: child).

				         "/Store lowest vertical coordinate while extreme nodes still point in current subtree."
				         self
					         separate: v
					         children: children
					         at: i
					         rest: ih.

				         "Update data about the widths"
				         self updateIYL: minY at: i rest: ih ].

			self
				positionRoot: v
				leftMostChild: leftMostChild
				rightMostChild: rightMostChild.

			self
				setExtremesOfNonLeaf: v
				leftMostChild: leftMostChild
				rightMostChild: rightMostChild ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> indexOfIYL: aValueLink [

	| anAssoc |
	anAssoc := aValueLink value.
	^ anAssoc key
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> initDescriptor: aShape [

	| x |
	self
		modOf: aShape put: 0;
		changeOf: aShape put: 0;
		shiftOf: aShape put: 0;
		prelimOf: aShape put: 0;
		mselOf: aShape put: 0;
		mserOf: aShape put: 0;
		threadOf: aShape put: nil;
		rthreadOf: aShape put: nil;
		elOf: aShape put: nil;
		erOf: aShape put: nil.

	x := self is: aShape ifRoot: [ 0 ] ifNotRoot: [ :hierarchyParent | 
		     (self bottom: hierarchyParent) + self horizontalGap ].

	self xOf: aShape put: x.

	super initDescriptor: aShape
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> lowYofIYL: aValueLink [

	| anAssoc |
	anAssoc := aValueLink value.
	^ anAssoc value
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> moveSubtree: children at: i other: si distance: dist [

	"Move subtree by changing mod."

	| child intermediateChildren |
	child := children at: i.
	self modOf: child put: (self modOf: child) + dist.
	self mselOf: child put: (self mselOf: child) + dist.
	self mserOf: child put: (self mserOf: child) + dist.

	"Are there intermediate children? (originally extracted in the `distributedExtra` function)"
	self assert: i > si.

	(intermediateChildren := i - si) > 1 ifTrue: [ 
		| siChild ratio |
		ratio := dist / intermediateChildren.
		siChild := children at: si + 1.
		self shiftOf: siChild put: (self shiftOf: siChild) + ratio.
		self shiftOf: child put: (self shiftOf: child) - ratio.
		self changeOf: child put: (self changeOf: child) - dist + ratio ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> nextLeftContour: v [

	^ self
		  is: v
		  ifLeaf: [ self threadOf: v ]
		  ifNotLeaf: [ (self childrenOf: v) first ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> nextRightContour: v [

	^ self
		  is: v
		  ifLeaf: [ self rthreadOf: v ]
		  ifNotLeaf: [ (self childrenOf: v) last ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> positionRoot: v leftMostChild: leftMostChild rightMostChild: rightMostChild [

	| childrenPrelim |
	"Set the prelim for hierarchy item v."
	childrenPrelim := (self prelimOf: leftMostChild)
	                  + (self modOf: leftMostChild)
	                  + (self prelimOf: rightMostChild)
	                  + (self modOf: rightMostChild)
	                  + rightMostChild height - v height.

	self prelimOf: v put: childrenPrelim / 2
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> secondWalk: v x: n y: m [

	| mNext children x y |
	mNext := m + (self modOf: v).

	x := n + (self xOf: v).
	y := (self prelimOf: v) + mNext.

	v position: x @ y + (v extent / 2).

	children := self childrenOf: v.

	self addChildSpacing: children.

	"Recur over my onw children."
	^ children inject: y into: [ :maxY :aChild | 
		  | curY |
		  curY := self secondWalk: aChild x: n y: mNext.
		  maxY max: curY ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> separate: v children: children at: i rest: aValueLink [

	| sr cl mssr mscl ih |
	"Right contour node of left siblings and its sum of modfiers."
	sr := children at: i - 1.
	mssr := self modOf: sr.

	"Left contour node of current subtree and its sum of modfiers."
	cl := children at: i.
	mscl := self modOf: cl.

	"Looping"
	ih := aValueLink.
	[ sr isNotNil and: [ cl isNotNil ] ] whileTrue: [ 
		| dist sy cy |
		(self bottom: sr) > (self lowYofIYL: ih) ifTrue: [ 
			ih := ih nextLink ].

		"How far to the left of the right side of sr is the left side of cl?"
		dist := mssr + (self prelimOf: sr) + sr height + self verticalGap
		        - (mscl + (self prelimOf: cl)).

		dist > 0 ifTrue: [ 
			mscl := mscl + dist.
			self
				moveSubtree: children
				at: i
				other: (self indexOfIYL: ih)
				distance: dist ].

		"Advance highest node(s) and sum(s) of modifiers (Coordinate system increases downwards)"
		sy := self bottom: sr.
		cy := self bottom: cl.

		sy <= cy ifTrue: [ 
			sr := self nextRightContour: sr.
			sr ifNotNil: [ mssr := mssr + (self modOf: sr) ] ].

		sy >= cy ifTrue: [ 
			cl := self nextLeftContour: cl.
			cl ifNotNil: [ mscl := mscl + (self modOf: cl) ] ] ].

	"Set threads and update extreme nodes."
	(sr isNil and: [ cl isNotNil ])
		ifTrue: [ "the current subtree must be taller than the left siblings."
			self
				setLeftThread: v
				leftMostChild: children first
				currentChild: (children at: i)
				child: cl
				acc: mscl ]
		ifFalse: [ "the left siblings must be taller than the current subtree."
			(sr isNotNil and: [ cl isNil ]) ifTrue: [ 
				self
					setRightThread: v
					previousChild: (children at: i - 1)
					currentChild: (children at: i)
					child: sr
					acc: mssr ] ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setExtremesOfLeaf: v [

	self
		elOf: v put: v;
		erOf: v put: v;
		mselOf: v put: 0;
		mserOf: v put: 0
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setExtremesOfNonLeaf: v leftMostChild: leftMostChild rightMostChild: rightMostChild [

	self
		elOf: v put: (self elOf: leftMostChild);
		erOf: v put: (self erOf: rightMostChild);
		mselOf: v put: (self mselOf: leftMostChild);
		mserOf: v put: (self mserOf: rightMostChild)
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setLeftThread: v leftMostChild: leftMostChild currentChild: child child: cl acc: mscl [

	| li diff |
	li := self elOf: leftMostChild.
	self threadOf: li put: cl.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mscl - (self modOf: cl) - (self mselOf: leftMostChild).
	self modOf: li put: (self modOf: li) + diff.

	"Change preliminary x coordinate so that the node does not move."
	self prelimOf: li put: (self prelimOf: li) - diff.

	"Update extreme node and its sum of modifiers."
	self
		elOf: leftMostChild put: (self elOf: child);
		mselOf: leftMostChild put: (self mselOf: child)
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setRightThread: v previousChild: previousChild currentChild: currentChild child: sr acc: mssr [

	| ri diff |
	ri := self erOf: currentChild.
	self rthreadOf: ri put: sr.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mssr - (self modOf: sr) - (self mserOf: currentChild).
	self modOf: ri put: (self modOf: ri) + diff.

	"Change preliminary x coordinate so that the node does not move."
	self prelimOf: ri put: (self prelimOf: ri) - diff.

	"Update extreme node and its sum of modifiers."
	self
		erOf: currentChild put: (self erOf: previousChild);
		mserOf: currentChild put: (self mserOf: previousChild)
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> updateIYL: minY at: i rest: aValueLink [

	| ih |
	"Remove siblings that are hidden by the new subtree."
	ih := aValueLink.
	[ ih isNotNil and: [ minY >= (self lowYofIYL: ih) ] ] whileTrue: [ 
		ih := ih nextLink ].

	"Prepend the new subtree"
	^ ValueLink new
		  value: i -> minY;
		  nextLink: ih;
		  yourself
]
