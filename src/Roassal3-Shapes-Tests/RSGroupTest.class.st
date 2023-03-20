"
A TSGroupTest is a test class for testing the behavior of TSGroup
"
Class {
	#name : #RSGroupTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
RSGroupTest >> testAddShape [
	| g |
	g := RSGroup new.
	g add: RSBox new
]

{ #category : #tests }
RSGroupTest >> testAsGroup [
	| t |
	t := #(1 2 3) asGroup.
	self assert: t asArray equals: #(1 2 3).
	self assert: t class equals: RSGroup
]

{ #category : #tests }
RSGroupTest >> testCache01 [

	| shapes shape |
	shapes := (1 to: 5) collect: [:n | RSBox new model: n; yourself ] as: RSGroup.
	self assert: shapes class equals: RSGroup.
	self assert: shapes shapeFromModelCache isEmpty.

	shape := shapes shapeFromModel: 2.
	self assert: shape class equals: RSBox.
	self assert: shape model equals: 2.

	self deny: shapes shapeFromModelCache isEmpty
]

{ #category : #tests }
RSGroupTest >> testCache02 [

	| shapes s sps |
	shapes := #(1 1) collect: [:n | RSBox new model: n; yourself] as: RSGroup.

	s := shapes shapeFromModel: 1.
	self assert: s class equals: RSBox.
	self assert: s model equals: 1.

	sps := shapes shapesFromModel: 1.
	self assert: sps class equals: RSGroup.
	self assert: sps size equals: 2
]

{ #category : #tests }
RSGroupTest >> testCache03 [

	| shapes shape |
	shapes := #(1 1) collect: [:n | RSBox new model: n; yourself] as: RSGroup.

	shapes shapesFromModel: 1.
	shape := shapes shapeFromModel: 1.
	self assert: shape class equals: RSBox.
	self assert: shape model equals: 1
]

{ #category : #tests }
RSGroupTest >> testCache04 [

	| es |
	es := #(1) collect: [:n | RSBox new model: n; yourself] as: RSGroup.
	self assert: (es shapesFromModel: 1) size equals: 1.

	es addAll: (#(1) collect: [:n | RSBox new model: n; yourself] as: RSGroup).
	self assert: (es shapesFromModel: 1) size equals: 2
]

{ #category : #tests }
RSGroupTest >> testDrawGroup [
	| g c com |
	c := RSCanvas new.
	g := RSGroup new.
	g add: RSBox new.
	com := RSComposite new
		shapes: g.
	c addShape: com.
	self assert: c numberOfShapes equals: 1.
	c createMorph drawOnMockCanvas
]

{ #category : #tests }
RSGroupTest >> testModels [
	| g |
	g := RSGroup new.
	g add: RSBox new.
	g add: RSBox new.
	g add: RSBox new.

	self assert: (g allSatisfy: [ :s | s model isNil ]).
	g models: #('hello' 'world' 'bonjour').

	self assert: (g collect: [ :s | s model ]) asArray equals: #('hello' 'world' 'bonjour')
]

{ #category : #tests }
RSGroupTest >> testNodesAndLines [

	| g |
	g := RSGroup new.
	g addAll: (RSCircle models: (1 to: 10)).
	g addAll: (RSLine models: (1 to: 5)).

	self assert: g nodes size equals: 10.
	self assert: g lines size equals: 5
]

{ #category : #tests }
RSGroupTest >> testShapeFromModel [
	| group |
	group := (1 to: 5) collect: [:n | RSBox new model: n; yourself] as: RSGroup.
	self assert: (group shapeFromModel: 1) equals: group first.
	self assert: (group shapeFromModel: 5) equals: group last
]

{ #category : #tests }
RSGroupTest >> testTranslateTopLeftTo [
	| g |
	g := RSBox models: #(1 2).
	RSHorizontalLineLayout on: g.
	self assert: (g collect: #position as: Array) equals: {(5.0@5.0). (25.0@5.0)}.
	self assert: g position equals: 15 @ 5.

	g translateTopLeftTo: 40 @ 42.
	self assert: (g collect: #position as: Array) equals: {(45.0@47.0). (65.0@47.0)}.
	self assert: g position equals: 55 @ 47
]

{ #category : #tests }
RSGroupTest >> testTranslucent [
	| g |
	g := RSGroup new.
	g add: RSBox new.
	g add: RSBox new.
	g add: RSBox new.

	self assert: (g allSatisfy: [ :s | s color alpha = 1 ]).
	g translucent.
	self assert: (g allSatisfy: [ :s | s color alpha < 1 ])
]
