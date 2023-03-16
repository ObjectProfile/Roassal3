"
based on https://cdn.rawgit.com/ironwallaby/delaunay/master/delaunay.js
"
Class {
	#name : #RSDelaunay,
	#superclass : #RSObject,
	#classInstVars : [
		'epsilon'
	],
	#category : #'Roassal3-Experimental-Delaunay'
}

{ #category : #initialization }
RSDelaunay class >> circumCircle: particles indices: in [
	| p1 p2 p3 y12 y23 xc dx yc dy x1 x2 x3 y1 y2 y3 m2 mx2 my2 m1 mx1 my1 flag |
	p1 := particles at: in first.
	p2 := particles at: in second.
	p3 := particles at: in third.
	x1 := p1 x. y1 := p1 y.
	x2 := p2 x. y2 := p2 y.
	x3 := p3 x. y3 := p3 y.
	y12 := (y1 - y2) abs.
	y23 := (y2 - y3) abs.
	flag := y12 > y23.
	y12 := y12 < epsilon.
	y23 := y23 < epsilon.

	(y12 and: [y23] )ifTrue: [ self error: 'Eek coicident points' ].

	y12 ifTrue: [
		m2 := ((x3 - x2) / (y3 - y2)) negated.
		mx2 := (x2 + x3) / 2.
		my2 := (y2 + y3) / 2.
		xc := (x2 + x1) / 2.
		yc := m2 * (xc - mx2 ) + my2.
	] ifFalse: [
		m1 := ((x2 - x1) / (y2 - y1)) negated.
		y23 ifTrue: [
			mx1 := (x1 + x2) / 2.
			my1 := (y1 + y2) / 2.
			xc := (x3 + x2) / 2.
			yc := m1 * (xc - mx1) + my1.
		] ifFalse: [
			m2 := ((x3 - x2)/ (y3 - y2)) negated.
			mx1 := (x1 + x2) / 2.
			mx2 := (x2 + x3) / 2.
			my1 := (y1 + y2) / 2.
			my2 := (y2 + y3) / 2.

			xc := m1 = m2
				ifTrue: [ Float infinity ]
				ifFalse: [((m1 * mx1) - (m2 * mx2) + my2 - my1 ) / (m1 - m2)].

			yc := flag
				ifTrue: [ m1 * (xc - mx1) + my1 ]
				ifFalse: [ m2 * (xc - mx2) + my2 ].
		]
	].

	dx := x2 - xc.
	dy := y2 - yc.
	^ RSCircleD new
		indices: in;
		position: xc@yc;
		radius:(dx * dx) + (dy * dy );
		yourself
]

{ #category : #initialization }
RSDelaunay class >> dedup: edges [
	| i j a b m n break before |
	j := edges size.
	before := edges copy.
	[ j > 0 ] whileTrue: [
		b := edges at: j.
		j := j - 1.
		a := edges at: j.
		j := j - 1.
		i := j.
		break := false.
		[ i > 0 and: [ break not ] ] whileTrue: [
			n := edges at: i.
			i := i - 1.
			m := edges at: i.
			i := i - 1.

			((a = m and: [ b = n ]) or: [ a = n and: [ b = m ] ]) ifTrue: [
				edges removeAt: j + 1.
				edges removeAt: j + 1.
				edges removeAt: i + 1.
				edges removeAt: i + 1.
				j := j - 2.
				break := true.
			].
		 ].
	 ]
]

{ #category : #initialization }
RSDelaunay class >> generateEdge: open closed: closed vertices: vertices c: c j: j edges: edges [
	| dx circ vertex dy |
	"If this point is to the right of this triangle's circumcircle,
	then this triangle should never get checked again. Remove it
	from the open list, add it to the closed list, and skip."
	circ := open at: j.
	vertex := vertices at: c.
	dx := vertex x - circ x.
	(dx > 0 and: [ dx * dx > circ radius ]) ifTrue: [
		closed add: circ.
		open remove: circ.
		^ self ].
	"If we're outside the circumcircle, skip this triangle."
	dy := vertex y - circ y.
	((dx * dx) + (dy * dy) - circ radius) > epsilon
		ifTrue: [ ^ self ].
	edges addAll:
		{circ i. circ j.
		circ j. circ k.
		circ k. circ i}.
	open remove: circ
]

{ #category : #initialization }
RSDelaunay class >> generateMesh: indices circle: circCircle vertices: vertices [
	| open closed edges size |
	size := vertices size-3.
	open := OrderedCollection with: circCircle.
	closed := OrderedCollection new.
	edges := OrderedCollection new.
	"incrementally add each vertex to the mesh"
	indices reverseDo: [ :i | | c k |
		c := indices at: i.
		(1 to: open size) reverseDo: [ :j |
			self
				generateEdge: open
				closed: closed
				vertices: vertices
				c: c
				j: j
				edges: edges ].
		"Remove any doubled edges"
		self dedup: edges.
		"Add a new triangle for each edge"
		k := edges size.
		[ k > 0 ] whileTrue: [
			| a b |
			b := edges at: k.
			k := k - 1.
			a := edges at: k.
			k := k - 1.
			open add: (self circumCircle: vertices indices: {a. b. c}) ].

		edges removeAll ].
	"Copy any remaining open triangles to the closed list, and then
	remove any triangles that share a vertex with the supertriangle,
	building a list of triplets that represent triangles."
	open reverseDo: [ :o | closed add: o ].
	open removeAll.
	closed reverseDo: [ :c |
		(c isRespectLimit: size)
			ifTrue: [ open addAll: c indices ] ].
	^ open
]

{ #category : #'class initialization' }
RSDelaunay class >> initialize [
	epsilon := 1.0 / 1048576.0
]

{ #category : #initialization }
RSDelaunay class >> supertriangle: vertices [
	| xmin ymin xmax ymax dx dy dmax xmid ymid |
	xmin := ymin := SmallInteger maxVal.
	xmax := ymax := SmallInteger minVal.
	vertices do:[:p |
		xmin := xmin min: p x.
		xmax := xmax max: p x.
		ymin := ymin min: p y.
		ymax := ymax max: p y.
		].
	dx := xmax - xmin.
	dy := ymax - ymin.
	dmax := dx max: dy.
	xmid := dx * 0.5 + xmin.
	ymid := dy * 0.5 + ymin.
	^ {
	 	(xmid - (20 * dmax)) @ (ymid - dmax).
		xmid @ (ymid + (20 * dmax)).
		(xmid + (20 * dmax )) @ (ymid - dmax).
	 }
]

{ #category : #initialization }
RSDelaunay class >> triangulate: particles [
	| indices st circCircle nsize vertices |
	nsize := particles size.
	nsize < 3 ifTrue: [ ^ #() ].
	"create indices sorted by x value"
	vertices := particles copy.
	indices := 1 to: vertices size.

	indices := indices sorted: [ :a :b |
		((particles at: a) x < (particles at: b) x)].
	"Next, find the vertices of the supertriangle (which contains all other
    triangles), and append them onto the end of a (copy of) the vertex
    array."
	st := self supertriangle: vertices.
	vertices addAll: st.
	circCircle := self circumCircle: vertices indices: {nsize + 1. nsize + 2. nsize + 3}.
	"circCircle ifNil: [ ^ #() ]."

	^ self generateMesh: indices circle: circCircle vertices: vertices
]
