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
	g add: RSBox new.
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
	
	self deny: shapes shapeFromModelCache isEmpty.
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
	shapes := #(1 1) collect: [:n | RSBox new model: n; yourself] as: RSGroup..
	
	shapes shapesFromModel: 1.
	shape := shapes shapeFromModel: 1.
	self assert: shape class equals: RSBox.
	self assert: shape model equals: 1.
	
]

{ #category : #tests }
RSGroupTest >> testCache04 [

	| es |
	es := #(1) collect: [:n | RSBox new model: n; yourself] as: RSGroup.
	self assert: (es shapesFromModel: 1) size equals: 1.
	
	es addAll: (#(1) collect: [:n | RSBox new model: n; yourself] as: RSGroup). 
	self assert: (es shapesFromModel: 1) size equals: 2.
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
	c createMorph drawOnMockCanvas.
]

{ #category : #tests }
RSGroupTest >> testElementFromModel [
	| group |
	group := (1 to: 5) collect: [:n | RSBox new model: n; yourself] as: RSGroup..
	self assert: (group shapeFromModel: 1) == group first.
	self assert: (group shapeFromModel: 5) == group last.

]
