"
I am a refinement of the Walker algorithm described in the publication ""Drawing non-layered tidy trees in linear time"" by Atze van der Ploeg [1] (companion repo at [2]).

[1]: https://www.semanticscholar.org/paper/Drawing-non-layered-tidy-trees-in-linear-time-Ploeg/d45f66231e053590c64c9d901fb7b028dbc5c923
[2]: https://github.com/cwi-swat/non-layered-tidy-trees
"
Class {
	#name : #RSHorizontalWalkBasedVanDerPloegTreeLayout,
	#superclass : #RSHorizontalWalkBasedWalkerTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> addChildSpacing: v [

	| d modsumdelta |
	d := 0.
	modsumdelta := 0.
	(self childrenOf: v) do: [ :child | 
		d := d + (self shiftOf: child).
		modsumdelta := modsumdelta + d + (self changeOf: child).
		self modOf: child put: (self modOf: child) + modsumdelta ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> firstWalk: v [

	self
		is: v
		ifLeaf: [ self setExtremesOfLeaf: v ]
		ifNotLeaf: [ :children | 
			| leftMostChild chain |
			leftMostChild := children first.

			"Recur down on v's leftmost child."
			self firstWalk: leftMostChild.

			"Create siblings in contour minimal vertical coordinate and index list."
			chain := (2 to: children size)
				         inject: (self
						          updateIYL:
						          (self elOf: leftMostChild) encompassingRectangle
							          bottom
						          at: 1
						          rest: nil)
				         into: [ :ih :i | 
					         | child |
					         child := children at: i.
					         self firstWalk: child.

					         "/Store lowest vertical coordinate while extreme nodes still point in current subtree."
					         self separate: v at: i rest: ih.

					         "Update data about the widths"
					         self
						         updateIYL:
						         (self erOf: child) encompassingRectangle bottom
						         at: i
						         rest: ih ].

			"Finally position the root"
			self
				positionRoot: v;
				setExtremesOfNonLeaf: v ]
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> initDescriptor: aDescriptor [

	| x |
	super initDescriptor: aDescriptor.

	self
		rthreadOf: aDescriptor put: nil;
		elOf: aDescriptor put: nil;
		erOf: aDescriptor put: nil;
		mselOf: aDescriptor put: 0;
		mserOf: aDescriptor put: 0.

	x := (self fatherOf: aDescriptor)
		     ifNil: [ 0 ]
		     ifNotNil: [ :hierarchyParent | 
		     hierarchyParent encompassingRectangle bottom ].

	self xOf: aDescriptor put: x + self horizontalGap
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> moveSubtree: v at: i other: si distance: dist [

	"Move subtree by changing mod."

	| children child intermediateChildren |
	children := self childrenOf: v.
	child := children at: i.
	self modOf: child put: (self modOf: child) + dist.
	self mselOf: child put: (self mselOf: child) + dist.
	self mserOf: child put: (self mserOf: child) + dist.

	"Are there intermediate children? (originally extracted in the `distributedExtra` function)"
	(intermediateChildren := i - si) > 1 ifTrue: [ 
		| siChild ratio |
		ratio := dist / intermediateChildren.
		siChild := children at: si + 1.
		self shiftOf: siChild put: (self shiftOf: siChild) + ratio.
		self shiftOf: child put: (self shiftOf: child) - ratio.
		self changeOf: child put: (self changeOf: child) - dist + ratio ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> nextLeftContour: cl [

	^ self
		  is: cl
		  ifLeaf: [ self threadOf: cl ]
		  ifNotLeaf: [ (self childrenOf: cl) first ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> nextRightContour: sr [

	^ self
		  is: sr
		  ifLeaf: [ self rthreadOf: sr ]
		  ifNotLeaf: [ (self childrenOf: sr) last ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> positionRoot: v [

	| children leftMost rightMost childrenPrelim |
	children := self childrenOf: v.
	leftMost := children first.
	rightMost := children last.

	"Set the prelim for hierarchy item v."
	childrenPrelim := (self prelimOf: leftMost) + (self modOf: leftMost)
	                  + (self prelimOf: rightMost)
	                  + (self modOf: rightMost).

	self prelimOf: v put: childrenPrelim / 2
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> prelimOffsetOfHierarchyItem: v [

	^ (super prelimOffsetOfHierarchyItem: v) + (0 @ (self modOf: v))
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> separate: v at: i rest: aValueLink [

	| children sr cl mssr mscl ih |
	children := self childrenOf: v.

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
		sr encompassingRectangle bottom > ih value value ifTrue: [ 
			ih := ih nextLink ].

		"How far to the left of the right side of sr is the left side of cl?"
		dist := mssr + (self prelimOf: sr) + sr height
		        - (mscl + (self prelimOf: cl)) + (self spacing: sr).

		dist > 0 ifTrue: [ 
			mscl := mscl + dist.
			self
				moveSubtree: v
				at: i
				other: ih value key
				distance: dist ].

		"Advance highest node(s) and sum(s) of modifiers (Coordinate system increases downwards)"
		sy := sr encompassingRectangle bottom.
		cy := cl encompassingRectangle bottom.
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
				at: i
				child: cl
				acc: mscl ]
		ifFalse: [ "the left siblings must be taller than the current subtree."
			(sr isNotNil and: [ cl isNil ]) ifTrue: [ 
				self
					setRightThread: v
					at: i
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
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setExtremesOfNonLeaf: v [

	| children leftMostChild rightMostChild |
	children := self childrenOf: v.
	leftMostChild := children first.
	rightMostChild := children last.

	self
		elOf: v put: (self elOf: leftMostChild);
		erOf: v put: (self erOf: rightMostChild);
		mselOf: v put: (self mselOf: leftMostChild);
		mserOf: v put: (self mserOf: rightMostChild)
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setLeftThread: v at: i child: cl acc: mscl [

	| elChild diff child leftMostChild |
	leftMostChild := (self childrenOf: v) first.
	elChild := self elOf: leftMostChild.
	self threadOf: elChild put: cl.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mscl - (self modOf: cl) - (self mselOf: leftMostChild).
	self modOf: elChild put: (self modOf: elChild) + diff.

	"Change preliminary x coordinate so that the node does not move."
	self prelimOf: elChild put: (self prelimOf: elChild) - diff.

	"Update extreme node and its sum of modifiers."
	child := (self childrenOf: v) at: i.
	self
		elOf: leftMostChild put: (self elOf: child);
		mselOf: leftMostChild put: (self mselOf: child)
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setRightThread: v at: i child: sr acc: mssr [

	"Symmetrical to setLeftThread:at:child:acc:leftMostDescriptor:"

	| ri diff child prevChild vChildren |
	vChildren := self childrenOf: v.
	prevChild := vChildren at: i - 1.
	child := vChildren at: i.
	ri := self erOf: child.
	self rthreadOf: ri put: sr.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mssr - (self modOf: sr) - (self mserOf: child).
	self modOf: ri put: (self modOf: ri) + diff.

	"Change preliminary x coordinate so that the node does not move."
	self prelimOf: ri put: (self prelimOf: ri) - diff.

	"Update extreme node and its sum of modifiers."
	self
		erOf: child put: (self erOf: prevChild);
		mserOf: child put: (self mserOf: prevChild)
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> updateIYL: minY at: i rest: aValueLink [
	| ih |
	ih := aValueLink.
	[ ih isNotNil and: [ minY >= ih value value ] ]
		whileTrue: [ ih := ih nextLink ].
	^ ValueLink new
		value: i -> minY;
		nextLink: ih;
		yourself
]
