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
	v hierarchyChildren
		do: [ :child | 
			child.
			d := d + child shift.
			modsumdelta := modsumdelta + d + child change.
			child mod: child mod + modsumdelta ]
]

{ #category : #'template message' }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> descriptor [
	^ VanDerPloegItemDescriptor new
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> firstWalk: v [
	v isHierarchyLeaf
		ifTrue: [ self setExtremesOfLeaf: v ]
		ifFalse: [ | children leftMostChild chain |
			children := v hierarchyChildren.
			leftMostChild := children first.

			"Recur down on v's leftmost child."
			self firstWalk: leftMostChild.

			"Create siblings in contour minimal vertical coordinate and index list."
			chain := (2 to: children size)
				inject: (self updateIYL: leftMostChild el bottom at: 1 rest: nil)
				into: [ :ih :i | 
					| child |
					child := children at: i.
					self firstWalk: child.

					"/Store lowest vertical coordinate while extreme nodes still point in current subtree."
					self separate: v at: i rest: ih.

					"Update data about the widths"
					self updateIYL: child er bottom at: i rest: ih ].

			"Finally position the root"
			self
				positionRoot: v;
				setExtremesOfNonLeaf: v ]
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> initDescriptor: aDescriptor [
	super initDescriptor: aDescriptor.
	aDescriptor
		rthread: nil;
		el: nil;
		el: nil;
		msel: 0;
		mser: 0
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> moveSubtree: v at: i other: si distance: dist [
	"Move subtree by changing mod."

	| children child intermediateChildren |
	children := v hierarchyChildren.
	child := children at: i.
	child
		mod: child mod + dist;
		msel: child msel + dist;
		mser: child mser + dist.

	"Are there intermediate children? (originally extracted in the `distributedExtra` function)"
	(intermediateChildren := i - si) > 1
		ifTrue: [ | siChild ratio |
			ratio := dist / intermediateChildren.
			siChild := children at: si + 1.
			siChild shift: siChild shift + ratio.
			child
				shift: child shift - ratio;
				change: child change - dist + ratio ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> nextLeftContour: cl [
	^ cl isHierarchyLeaf
		ifTrue: [ cl thread ]
		ifFalse: [ cl hierarchyChildren first ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> nextRightContour: sr [
	^ sr isHierarchyLeaf
		ifTrue: [ sr rthread ]
		ifFalse: [ sr hierarchyChildren last ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> positionRoot: v [
	| children leftMost rightMost childrenPrelim |
	children := v hierarchyChildren.
	leftMost := children first.
	rightMost := children last.

	"Set the prelim for hierarchy item v."
	childrenPrelim := leftMost prelim + leftMost mod + rightMost prelim
		+ rightMost mod.
	v prelim: childrenPrelim / 2
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> prelimOffsetOfHierarchyItem: v [
	^ (super prelimOffsetOfHierarchyItem: v) + (0 @ v mod)
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> separate: v at: i rest: aValueLink [
	| children sr cl mssr mscl ih |
	children := v hierarchyChildren.

	"Right contour node of left siblings and its sum of modfiers."
	sr := children at: i - 1.
	mssr := sr mod.

	"Left contour node of current subtree and its sum of modfiers."
	cl := children at: i.
	mscl := cl mod.

	"Looping"
	ih := aValueLink.
	[ sr isNotNil and: [ cl isNotNil ] ]
		whileTrue: [ | dist sy cy |
			sr bottom > ih value value
				ifTrue: [ ih := ih nextLink ].

			"How far to the left of the right side of sr is the left side of cl?"
			dist := mssr + sr prelim + sr height - (mscl + cl prelim)
				+ (self spacing: sr).
			dist > 0
				ifTrue: [ mscl := mscl + dist.
					self
						moveSubtree: v
						at: i
						other: ih value key
						distance: dist ].

			"Advance highest node(s) and sum(s) of modifiers (Coordinate system increases downwards)"
			sy := sr bottom.
			cy := cl bottom.
			sy <= cy
				ifTrue: [ sr := self nextRightContour: sr.
					sr ifNotNil: [ mssr := mssr + sr mod ] ].
			sy >= cy
				ifTrue: [ cl := self nextLeftContour: cl.
					cl ifNotNil: [ mscl := mscl + cl mod ] ] ].

	"Set threads and update extreme nodes."
	(sr isNil and: [ cl isNotNil ])
		ifTrue: [ "the current subtree must be taller than the left siblings."
			self
				setLeftThread: v
				at: i
				child: cl
				acc: mscl ]
		ifFalse: [ "the left siblings must be taller than the current subtree."
			(sr isNotNil and: [ cl isNil ])
				ifTrue: [ self
						setRightThread: v
						at: i
						child: sr
						acc: mssr ] ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setExtremesOfLeaf: v [
	v
		el: v;
		er: v;
		msel: 0;
		mser: 0
]

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setExtremesOfNonLeaf: v [
	| children leftMostChild rightMostChild |
	children := v hierarchyChildren.
	leftMostChild := children first.
	rightMostChild := children last.
	v
		el: leftMostChild el;
		er: rightMostChild er;
		msel: leftMostChild msel;
		mser: rightMostChild mser
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setLeftThread: v at: i child: cl acc: mscl [
	| elChild diff child leftMostChild |
	leftMostChild := v hierarchyChildren first.
	elChild := leftMostChild el.
	elChild thread: cl.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mscl - cl mod - leftMostChild msel.
	elChild mod: elChild mod + diff.

	"Change preliminary x coordinate so that the node does not move."
	elChild prelim: elChild prelim - diff.

	"Update extreme node and its sum of modifiers."
	child := v hierarchyChildren at: i.
	leftMostChild
		el: child el;
		msel: child msel
]

{ #category : #initialization }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> setRightThread: v at: i child: sr acc: mssr [
	"Symmetrical to setLeftThread:at:child:acc:leftMostDescriptor:"

	| ri diff child prevChild |
	prevChild := v hierarchyChildren at: i - 1.
	child := v hierarchyChildren at: i.
	ri := child er.
	ri rthread: sr.

	"Change mod so that the sum of modifier after following thread is correct."
	diff := mssr - sr mod - child mser.
	ri mod: ri mod + diff.

	"Change preliminary x coordinate so that the node does not move."
	ri prelim: ri prelim - diff.

	"Update extreme node and its sum of modifiers."
	child
		er: prevChild er;
		mser: prevChild mser
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

{ #category : #algorithm }
RSHorizontalWalkBasedVanDerPloegTreeLayout >> zeroWalk: aSequenceableOfHierarchyItems [
	super zeroWalk: aSequenceableOfHierarchyItems.

	"I iterate the hierarchy items in the given *pre-order* visit to set the x value."
	aSequenceableOfHierarchyItems
		do: [ :aDescriptor | 
			| x |
			x := aDescriptor hierarchyParent
				ifNil: [ 0 ]
				ifNotNil: [ :hierarchyParent | hierarchyParent bottom ].
			aDescriptor x: x + marginBetweenAdjacentLayers ]
]
