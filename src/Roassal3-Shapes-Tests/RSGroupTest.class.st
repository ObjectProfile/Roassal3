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
	shapes := #(1 1) collect: [:n | RSBox new model: n; yourself] as: RSGroup.
	
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
RSGroupTest >> testShapeFromModel [
	| group |
	group := (1 to: 5) collect: [:n | RSBox new model: n; yourself] as: RSGroup.
	self assert: (group shapeFromModel: 1) equals: group first.
	self assert: (group shapeFromModel: 5) equals: group last.

]

{ #category : #tests }
RSGroupTest >> testShapeFromModelNestingWithinRSCompositesWithModels [
	| group box1 box2 box3 composite |
	box1 := RSBox new model: 1.
	box2 := RSBox new model: 2.
	box3 := RSBox new model: 3.
	composite := RSComposite new
		             model: 2;
		             "shadowing the one within the box."shapes: { 
				             box1.
				             box2.
				             box3 }.


	"One nesting level, transparent look up using RSComposite objects."
	group := RSGroup new
		         add: composite;
		         yourself.
	self assert: (group shapeFromModel: 2) equals: composite.

	"Two nesting level, transparent look up using RSComposite objects."
	composite := RSComposite new
		             model: 2;
		             shapes: { 
				             box1.
				             box2 }.
	group := RSGroup new
		         add: (RSComposite new
				          model: 1;
				          shapes: { 
						          box3.
						          composite });
		         yourself.
	self assert: (group shapeFromModel: 2) equals: nil.

	"On the other hand, if the outer most composite hasn't a model, 
	then it became transpart and forward the look up."
	group := RSGroup new
		         add: (RSComposite new shapes: { 
						          box3.
						          composite });
		         yourself.
	self assert: (group shapeFromModel: 2) equals: composite.

	"Looking for a shape from a foreign model."
	self assert: (group shapeFromModel: 0) equals: nil
]

{ #category : #tests }
RSGroupTest >> testShapeFromModelNestingWithinRSCompositesWithoutModels [
	| group box1 box2 box3 |
	box1 := RSBox new model: 1.
	box2 := RSBox new model: 2.
	box3 := RSBox new model: 3.

	"One nesting level, transparent look up using RSComposite objects."
	group := RSGroup new
		         add: (RSComposite new shapes: { 
						          box1.
						          box2.
						          box3 });
		         yourself.
	self assert: (group shapeFromModel: 2) equals: box2.

	"Two nesting level, transparent look up using RSComposite objects."
	group := RSGroup new
		         add: (RSComposite new shapes: { 
						          (RSComposite new shapes: { 
									           box1.
									           box2 }).
						          box3 });
		         yourself.
	self assert: (group shapeFromModel: 2) equals: box2.

	"Looking for a shape from a foreign model."
	self assert: (group shapeFromModel: 0) equals: nil
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
	self assert: (g allSatisfy: [ :s | s color alpha < 1 ]).
	 
]
