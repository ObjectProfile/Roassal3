"
The representaion of a 3d model just the mesh
"
Class {
	#name : #RSMesh3D,
	#superclass : #Object,
	#instVars : [
		'matrix',
		'tranformed',
		'vertices',
		'edges',
		'transformed',
		'tvertices',
		'meshMode',
		'elements',
		'polygonBuilder'
	],
	#category : #'Roassal3-Basic3D-Core'
}

{ #category : #public }
RSMesh3D class >> cubeVector: array [
	| inst data|
	inst := self new.
	data := #(
		#(-1.0 -1.0 -1.0 -1.0 -1.0 1.0 -1.0 1.0 1.0) "Left Side"
		#(-1.0 -1.0 -1.0 -1.0 1.0 1.0 -1.0 1.0 -1.0)  "Left Side"
		#(1.0 1.0 -1.0 -1.0 -1.0 -1.0 -1.0 1.0 -1.0)  "Back Side"
		#(1.0 -1.0 1.0 -1.0 -1.0 -1.0 1.0 -1.0 -1.0)  "Bottom Side"
		#(1.0 1.0 -1.0 1.0 -1.0 -1.0 -1.0 -1.0 -1.0)  "Back Side"
		#(1.0 -1.0 1.0 -1.0 -1.0 1.0 -1.0 -1.0 -1.0)  "Bottom Side"
		#(-1.0 1.0 1.0 -1.0 -1.0 1.0 1.0 -1.0 1.0)  "Front Side"
		#(1.0 1.0 1.0 1.0 -1.0 -1.0 1.0 1.0 -1.0)  "Right Side"
		#(1.0 -1.0 -1.0 1.0 1.0 1.0 1.0 -1.0 1.0)  "Right Side"
		#(1.0 1.0 1.0 1.0 1.0 -1.0 -1.0 1.0 -1.0)  "Top Side"
		#(1.0 1.0 1.0 -1.0 1.0 -1.0 -1.0 1.0 1.0)  "Top Side"
		#(1.0 1.0 1.0 -1.0 1.0 1.0 1.0 -1.0 1.0)  "Front Side"
	).
	inst addAll: (data collect: [ :vertex | | tri |
		tri := RSTriangle3D new 
			v1: (vertex copyFrom: 1 to: 3);
			v2: (vertex copyFrom: 4 to: 6);
			v3: (vertex copyFrom: 7 to: 9);
			color: Color white.
		tri mult: array.
		tri ]).
	
	^ inst
]

{ #category : #public }
RSMesh3D class >> cubeWidth: width height: height depth: depth [
	^ self cubeVector: { width. height. depth }.
]

{ #category : #public }
RSMesh3D class >> inflate: triangles [
	| res m1 m2 m3 |
	res := OrderedCollection new.
	triangles do: [ :t |
		m1 := {
			(t v1 first + t v2 first)/2.
			(t v1 second + t v2 second)/2.
			(t v1 third + t v2 third)/2.
		}.
		m2 := {
			(t v2 first + t v3 first)/2.
			(t v2 second + t v3 second)/2.
			(t v2 third + t v3 third)/2.
		}.
		m3 := {
			(t v1 first + t v3 first)/2.
			(t v1 second + t v3 second)/2.
			(t v1 third + t v3 third)/2.
		}.
		res 
			add: (RSTriangle3D new v1: t v1; v2: m1; v3: m3; color: t color);
			add: (RSTriangle3D new v1: t v2; v2: m1; v3: m2; color: t color);
			add: (RSTriangle3D new v1: t v3; v2: m2; v3: m3; color: t color);
			add: (RSTriangle3D new v1: m1; v2: m2; v3: m3; color: t color).
		 ].
	
	res do: [ :t |
		{ t v1. t v2. t v3 } do: [ :v | | l |
			l := ((v first * v first) + (v second * v second) + (v third * v third)) sqrt / 30000 sqrt.
			v at: 1 put: v first / l.
			v at: 2 put: v second / l.
			v at: 3 put: v third / l.
			 ].
		 ].
	^ res.
]

{ #category : #public }
RSMesh3D class >> tetrahedron [
	| list |
	list := OrderedCollection new.
	list add: (RSTriangle3D new
		v1: #(100 100 100);
		v2: #(-100 -100 100);
		v3: #(-100 100 -100);
		color: Color white);
	add: (RSTriangle3D new
		v1: #(100 100 100);
		v2: #(-100 -100 100);
		v3: #(100 -100 -100);
		color: Color red);
	add: (RSTriangle3D new
		v1: #(-100 100 -100);
		v2: #(100 -100 -100);
		v3: #(100 100 100);
		color: Color green);
	add: (RSTriangle3D new
		v1: #(-100 100 -100);
		v2: #(100 -100 -100);
		v3: #(-100 -100 100);
		color: Color blue).
	^ list
]

{ #category : #adding }
RSMesh3D >> add: triangle [
	triangle addedIn: self.
]

{ #category : #adding }
RSMesh3D >> addAll: list [
	list do: [ :e | self add: e ].
]

{ #category : #private }
RSMesh3D >> addTriangle: kv [
	edges add: kv
]

{ #category : #private }
RSMesh3D >> addVertex: vertex [
	| index |
	index := vertices indexOf: vertex.
	index = 0 ifTrue: [ 
		vertices add: vertex.
		index := vertices size ].
	^ index
]

{ #category : #public }
RSMesh3D >> areaMode [
	meshMode := false
]

{ #category : #private }
RSMesh3D >> cos: a [
	| p v1 v2 v3 ab ac norm normalLenght |
	p := a key.
	v1 := tvertices at: p first.
	v2 := tvertices at: p second.
	v3 := tvertices at: p third.
	ab := { 
		v2 first - v1 first. 
		v2 second - v1 second.
		v2 third - v1 third }.
	ac := { 
		v3 first - v1 first.
		v3 second - v1 second.
		v3 third - v1 third }.
	norm := { 
		(ab second * ac third) - (ab third * ac second).
		(ab third * ac first) - (ab first * ac third).
		(ab first * ac second) - (ab second * ac first) }.
	normalLenght := 
		((norm first * norm first) + 
		(norm second * norm second)+
		(norm third * norm third)) sqrt.
	^ (norm third / normalLenght) abs
	


]

{ #category : #private }
RSMesh3D >> createElements [
	| p v |
	polygonBuilder := RSShapeBuilder polygon
		color: [ :a |
			v := self getShade: a. 
			meshMode 
				ifTrue: [ Color transparent ]
				ifFalse: [ v ] ];
		points: [ :a |
			a key collect: [ :i | 
				p := tvertices at: i.
				p first @ p second ] ];
		border: [ TSBorder new color: v ].
	elements := polygonBuilder elementsOn: edges.
	
	
]

{ #category : #accessing }
RSMesh3D >> edges [
	^ edges
]

{ #category : #public }
RSMesh3D >> elements [
	^ elements ifNil: [ 
		self createElements.
		elements. ]
]

{ #category : #private }
RSMesh3D >> getShade: a [
	| angleCos c r g b |
	angleCos := self cos: a.
	c := a value.
	r := (c red raisedTo: 2.4) * angleCos.
	g := (c green raisedTo: 2.4) * angleCos.
	b := (c blue raisedTo: 2.4) * angleCos.
	
	r := r raisedTo: 1/2.4.
	g := g raisedTo: 1/2.4.
	b := b raisedTo: 1/2.4.
	^ Color r: r g: g b: b
	
	
]

{ #category : #initialization }
RSMesh3D >> initialize [
	super initialize.
	matrix := RSMatrix3D new.
	transformed := false.
	vertices := OrderedCollection new.
	edges := OrderedCollection new.
	self areaMode.
]

{ #category : #accessing }
RSMesh3D >> matrix [
	^ matrix
]

{ #category : #public }
RSMesh3D >> meshMode [
	meshMode := true
]

{ #category : #transformations }
RSMesh3D >> transform [
	transformed ifTrue: [ ^ self ].
	vertices ifEmpty: [ ^ self ].
	tvertices ifNil: [ tvertices := Array new: vertices size ].
	matrix tranform: vertices in: tvertices.
	transformed := true.
]

{ #category : #testing }
RSMesh3D >> transformed [
	^ transformed 
]

{ #category : #accessing }
RSMesh3D >> transformed: aBool [
	transformed := aBool
]

{ #category : #accessing }
RSMesh3D >> tvertices [
	^ tvertices
]

{ #category : #public }
RSMesh3D >> update [
	elements sort: [ :a :b | 
		(self zof: a) < (self zof: b) ].
	elements do: [ :e | 
		e pushBack.
		e  ].
	polygonBuilder updateElements: elements.
	^ self.
]

{ #category : #private }
RSMesh3D >> zof: e [
	| points sum p |
	points := e model key.
	sum := 0.
	points do: [ :i |
		p := tvertices at: i.
		sum := sum + p third. ].
	^ sum
]
