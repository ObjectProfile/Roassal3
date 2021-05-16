"
Implementation of the Walker algorithm [1] with the fix shown in [2] that makes it run in O(n),
where n is the number of nodes in the hierarchy.

[1]: http://www.cs.unc.edu/techreports/89-034.pdf
[2]: http://dirk.jivas.de/papers/buchheim02improving.pdf
"
Class {
	#name : #RSHorizontalWalkBasedWalkerTreeLayout,
	#superclass : #RSHorizontalWalkBasedTreeLayout,
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> addChildSpacing: v [
	"No additional spacing to add."

	
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> ancestor: v_left_i v: v default: defaultAncestor [

	| a |
	a := self ancestorOf: v_left_i.
	^ (self is: a siblingOf: v)
		  ifTrue: [ a ]
		  ifFalse: [ defaultAncestor ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> apportion: v ancestor: defaultAncestor [

	| anAncestor i |
	i := self indexInFatherOf: v.
	anAncestor := defaultAncestor.
	i > 1 ifTrue: [ 
		| w vSiblings v_left_i v_left_o v_right_i v_right_o s_left_i s_left_o s_right_i s_right_o |
		"Here `v` has a left sibling.""First, set siblings."
		vSiblings := self siblingsOf: v.
		w := vSiblings at: i - 1.

		"Second, set running variables."
		v_right_i := v.
		v_right_o := v.
		v_left_i := w.
		v_left_o := vSiblings first.

		"Fourth, set shifts."
		s_right_i := self modOf: v_right_i.
		s_right_o := self modOf: v_right_o.
		s_left_i := self modOf: v_left_i.
		s_left_o := self modOf: v_left_o.
		[ "Do updates eargerly because they are used in the following ifs."
		v_left_i := self nextRight: v_left_i.
		v_right_i := self nextLeft: v_right_i.
		v_left_i isNotNil and: [ v_right_i isNotNil ] ] whileTrue: [ 
			| s |
			"Forward output refs and the corresponding descriptors."
			v_left_o := self nextLeft: v_left_o.
			v_right_o := self nextRight: v_right_o.

			"Update the ancestor."
			self ancestorOf: v_right_o put: v.

			"Compute and apply the shift if positive."
			s := (self prelimOf: v_left_i) - (self prelimOf: v_right_i)
			     + s_left_i - s_right_i + v_right_i height
			     + (self spacing: v_left_i).
			s > 0 ifTrue: [ 
				| sa |
				sa := self ancestor: v_left_i v: v default: anAncestor.
				self moveSubtree: sa v: v shift: s.
				s_right_i := s_right_i + s.
				s_right_o := s_right_o + s ].

			"Some increments"
			s_left_i := s_left_i + (self modOf: v_left_i).
			s_right_i := s_right_i + (self modOf: v_right_i).
			s_left_o := s_left_o + (self modOf: v_left_o).
			s_right_o := s_right_o + (self modOf: v_right_o) ].

		"Update the *right* contour."
		(v_left_i isNotNil and: [ (self nextRight: v_right_o) isNil ]) 
			ifTrue: [ 
				self
					threadOf: v_right_o put: v_left_i;
					modOf: v_right_o
					put: (self modOf: v_right_o) + s_left_i - s_right_o ].

		"Update the *left* contour, adjust the default ancestor too."
		(v_right_i isNotNil and: [ (self nextLeft: v_left_o) isNil ]) 
			ifTrue: [ 
				self
					threadOf: v_left_o put: v_right_i;
					modOf: v_left_o
					put: (self modOf: v_left_o) + s_right_i - s_left_o.
				anAncestor := v ] ].
	^ anAncestor
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> executeShifts: v [

	| s c |
	s := 0.
	c := 0.
	(self childrenOf: v) reverseDo: [ :w | 
		self
			prelimOf: w put: (self prelimOf: w) + s;
			modOf: w put: (self modOf: w) + s.
		c := c + (self changeOf: w).
		s := s + c + (self shiftOf: w) ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> firstWalk: v [

	| i |
	"Some useful auxiliaries."
	i := (self indexInFatherOf: v) ifNil: [ 1 ].

	"Start with the Walker algorithm."
	self
		is: v
		ifLeaf: [ 
			| pre |
			"v is the left most sibling"
			pre := i = 1
				       ifTrue: [ 0 ]
				       ifFalse: [ 
					       | w |
					       w := (self siblingsOf: v) at: i - 1.
					       (self prelimOf: w) + w height + self verticalGap ].
			self prelimOf: v put: pre ]
		ifNotLeaf: [ :children | 
			| midpoint |
			"Fold children from left to right, discard the final ancestor because useless from the rest."
			children inject: children first into: [ :defaultAncestor :w | 
				self
					firstWalk: w;
					apportion: w ancestor: defaultAncestor ].

			"Perform shifts."
			self executeShifts: v.

			"Prepare for the preliminary position of v."
			midpoint := (self prelimOf: children first)
			            + (self prelimOf: children last) / 2.

			"v has at least a sibling on its left hand side"
			i > 1
				ifTrue: [ 
					| w prelim |
					w := (self siblingsOf: v) at: i - 1.
					prelim := self prelimOf: v put: (self prelimOf: w) + w height.
					self modOf: v put: prelim - midpoint ]
				ifFalse: [ self prelimOf: v put: midpoint ] ]
]

{ #category : #'initialize - release' }
RSHorizontalWalkBasedWalkerTreeLayout >> initDescriptor: aDescriptor [

	super initDescriptor: aDescriptor.

	self
		modOf: aDescriptor put: 0;
		changeOf: aDescriptor put: 0;
		shiftOf: aDescriptor put: 0;
		prelimOf: aDescriptor put: 0;
		ancestorOf: aDescriptor put: aDescriptor;
		threadOf: aDescriptor put: nil
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> moveSubtree: w_left v: w_right shift: s [

	| subtrees ratio |
	"Some auxiliary variables."
	subtrees := (self indexInFatherOf: w_right)
	            - (self indexInFatherOf: w_left).
	ratio := s / subtrees.

	"Updating the left item."
	self changeOf: w_left put: (self changeOf: w_left) + ratio.

	"Updating the right item."
	self changeOf: w_right put: (self changeOf: w_right) - ratio.
	self shiftOf: w_right put: (self shiftOf: w_right) + s.
	self prelimOf: w_right put: (self prelimOf: w_right) + s.
	self modOf: w_right put: (self modOf: w_right) + s
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> nextLeft: v [

	^ (self childrenOf: v)
		  ifEmpty: [ self threadOf: v ]
		  ifNotEmpty: [ :children | children first ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> nextRight: v [

	^ (self childrenOf: v)
		  ifEmpty: [ self threadOf: v ]
		  ifNotEmpty: [ :children | children last ]
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> prelimOffsetOfHierarchyItem: v [

	^ 0 @ (self prelimOf: v)
]

{ #category : #algorithm }
RSHorizontalWalkBasedWalkerTreeLayout >> secondWalk: v x: n y: m [

	| nNext mNext positionOffset |
	"Some useful auxiliaries."
	nNext := n + v width + self horizontalGap.
	mNext := m + (self modOf: v).

	"Set absolute vertical and horizontal coordinates, depending on the node meter."
	positionOffset := self prelimOffsetOfHierarchyItem: v.

	v position: n @ m + positionOffset + (v extent / 2).

	"Put additional spacing if needed (by my subclasses perhaps)."
	self addChildSpacing: v.

	"Recur over my onw children."
	(self childrenOf: v) do: [ :hierarchyChild | 
		self secondWalk: hierarchyChild x: nNext y: mNext ]
]
