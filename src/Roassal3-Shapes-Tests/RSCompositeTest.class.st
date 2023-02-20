"
I am test class for composite shapes in roassal
"
Class {
	#name : #RSCompositeTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #tests }
RSCompositeTest >> testAdjustChildren [

	| box circle g composite |
	box := RSBox new size: 20.
	circle := RSEllipse new size: 20.
	g := RSGroup new.
	g add: box; add: circle.
	composite := g asShape.
	self assert: composite extent equals: (20 @ 20).

	RSVerticalLineLayout on: g.
	self assert: composite extent equals: (20 @ 20).
	composite adjustToChildren.
	self assert: composite extent equals: (20 @ 50)
]

{ #category : #tests }
RSCompositeTest >> testAdjustChildrenTwice [
	| box circle composite  |
	box := RSBox new size: 20.
	box position: 100@100.
	circle := RSEllipse new size: 20.
	circle position: 50@50.
	composite := RSComposite new.
	composite addAll: { box. circle }.
	self assert: composite extent equals: composite defaultExtent.
	self assert: composite position equals: 0@0.
	composite adjustToChildren.
	self assert: composite extent equals: 70@70.
	self assert: composite position equals: 75@75.

	self assert: box extent equals: 20@20.
	self assert: box position equals: 25@25.
	self assert: circle extent equals: 20@20.
	self assert: circle position equals: -25@ -25.
	composite adjustToChildren.
	self assert: composite extent equals: 70@70.
	self assert: composite position equals: 75@75
]

{ #category : #tests }
RSCompositeTest >> testEdgesCanvasAndComposite01 [
	"basic case in a canvas"
	| c b1 b2 e1 |
	c := RSCanvas new.
	b1 := RSBox new position: 0 @ 0.
	b2 := RSBox new position: 100 @ 100.
	e1 := RSLine new from: b1; to: b2.
	c addAll: { b1. b2. e1 }.

	self assert: e1 startPoint equals: b1 position.
	self assert: e1 endPoint equals: b2 position
]

{ #category : #tests }
RSCompositeTest >> testEdgesCanvasAndComposite02 [
	"basic example in composite"
	| c b1 b2 e1 |
	c := RSComposite new.
	b1 := RSBox new position: 0@0.
	b2 := RSBox new position: 100@100.
	e1 := RSLine new from: b1; to: b2.
	c shapes: { b1. b2. e1 }.

	self assert: e1 startPoint equals: b1 position.
	self assert: e1 endPoint equals: b2 position
]

{ #category : #tests }
RSCompositeTest >> testEdgesCanvasAndComposite03 [
	"from box to child"
	| c b1 b2 e1 com |
	c := RSCanvas new.
	com := RSComposite new.
	b1 := RSBox new size: 10; position: 0@0.
	com add: b1.
	com adjustToChildren.
	b1 position: 50@50.
	com position: 200@0.
	b2 := RSBox new size: 10; position: 100@100.
	e1 := RSLine new from: b1; to: b2.
	c addAll: { com. b2. e1 }.

	self assert: e1 startPoint equals: com position + b1 position.
	self assert: e1 endPoint equals: b2 position
]

{ #category : #tests }
RSCompositeTest >> testEdgesCanvasAndComposite04 [
	"from child to child"
	| c b1 b2 e1 com1 com2 |
	c := RSCanvas new.
	com1 := RSComposite new.
	b1 := RSBox new size: 10; position: 0@0.
	com1 add: b1.
	com1 adjustToChildren.
	b1 position: 50@50.
	com1 position: 200@0.

	com2 := RSComposite new.
	b2 := RSBox new size: 10.
	com2 add: b2.
	com2 adjustToChildren.
	com2 position: -100@0.
	b2 position: 100@100.

	e1 := RSLine new from: b1; to: b2.
	c addAll: { com1. com2. e1 }.

	self assert: e1 startPoint equals: com1 position + b1 position.
	self assert: e1 endPoint equals: com2 position + b2 position
]

{ #category : #tests }
RSCompositeTest >> testEdgesCanvasAndComposite05 [
	"from child to box, where the edge is with the child"
	| c b1 b2 e1 com |
	c := RSCanvas new.
	com := RSComposite new.
	b1 := RSBox new size: 10; position: 50@50.
	com add: b1.
	b2 := RSBox new size: 10; position: 100@100.
	e1 := RSLine new from: b1; to: b2.

	com add: e1.
	com adjustToChildren.
	com position: 200@0.

	c addAll: { com. b2. }.

	self assert: e1 startPoint equals: b1 position.
	"but b2 is not in the space of com"
	self assert: e1 endPoint equals: b2 position
]

{ #category : #tests }
RSCompositeTest >> testHasChildren [
	| b |
	b := RSComposite new.
	self deny: b hasChildren.
	b shapes: {}.
	self deny: b hasChildren.
	b shapes: {RSBox new. RSEllipse new}.
	self assert: b hasChildren
]

{ #category : #tests }
RSCompositeTest >> testModelForIt [

	| s |
	s := RSComposite model: 42 forIt: [ :ss :obj | ss model: (obj + 1). ss color: Color pink ].
	self assert: s class equals: RSComposite.
	self assert: s model equals: 43.
	self assert: s color equals: Color pink
]

{ #category : #tests }
RSCompositeTest >> testPaddingOkay [
	"No error should be raised"

	RSComposite new
		shapes: (RSGroup new add: RSBox new; yourself);
		padding: 5.

	RSComposite new
		shapes: (RSGroup new add: RSBox new; add: RSBox new; yourself);
		padding: 5.

	RSComposite new
		shapes: (RSGroup new);
		padding: 5
]

{ #category : #tests }
RSCompositeTest >> testPositionInCanvas [
	| box composite canvas |
	canvas := RSCanvas new.
	box := RSBox new
		size: 100;
		yourself.
	composite := RSComposite new
		shapes: { box };
		position: 100@100;
		yourself.
	canvas add: composite.
	box translateTo: 10@10.
	self assert: composite position equals: 100@100.
	self assert: composite positionInCanvas equals: 100@100.
	self assert: box position equals: 10@10.
	self assert: box positionInCanvas equals: 110@110
]
