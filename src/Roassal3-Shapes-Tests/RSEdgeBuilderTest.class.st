"
I have tests for RSEdgeBuilder
"
Class {
	#name : #RSEdgeBuilderTest,
	#superclass : #RSTest,
	#instVars : [
		'b',
		'canvas',
		'shapes'
	],
	#category : #'Roassal3-Shapes-Tests'
}

{ #category : #running }
RSEdgeBuilderTest >> setUp [
	super setUp.
	canvas := RSCanvas new.
	shapes := (1 to: 10) collect: [ :n | RSBox new model: n; size: 5; yourself ] as: RSGroup.
	canvas addAll: shapes. 
	b := RSLineBuilder line.
]

{ #category : #tests }
RSEdgeBuilderTest >> testAllowRepetitionAndUseAssociations [

	| eb |
	canvas := RSCanvas new.
	canvas addAll: ((1 to: 3) collect: [ :n | RSBox new model: n; yourself] ).

	eb := RSLineBuilder line.
	eb canvas: canvas.
	eb color: (Color red alpha: 0.5).
	eb noRepetition.
	eb useAssociations: (Array with: 1 -> 2 with: 2 -> 3 with: 1 -> 2).
	
	(Smalltalk globals at: #RSGridLayout)  on: canvas nodes.
	
	self assert: canvas numberOfEdges equals: 2
]

{ #category : #tests }
RSEdgeBuilderTest >> testBorder [
	| numberOfEdges |
	b canvas: canvas.
	b connectFrom: [ :vv | vv // 2 ].
	
	numberOfEdges := canvas edges size.
	self assert: numberOfEdges > 0.
	
	self assert: (canvas edges collect: #border) asSet size equals: numberOfEdges
]

{ #category : #tests }
RSEdgeBuilderTest >> testConnectFrom [
	| e |
	b canvas: canvas.
	b objects: #(1 2).
	b connectFrom: [ :v | v - 1 ].
	
	self assert: canvas numberOfEdges equals: 1.
	
	e := canvas edges anyOne.
	self assert: e from model equals: 1.
	self assert: e to model equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testConnectFromAll [
	| c es |
	c := RSCanvas new.
	es := (1 to: 2) collect: [ :m | RSEllipse new size: 20; model: m; yourself ].
	c addAll: es.
	
	self assert: c edges size equals: 0.
	RSLineBuilder line
		canvas: c;
		objects: (1 to: 2);
		connectFromAll: (Array with: 1) to: 2.
		
	(Smalltalk globals at: #RSTreeLayout) on: es.

	self assert: c edges size equals: 1.
	self assert: c edges first from position equals: (15.0@15.0).
	self assert: c edges first to position equals: (15.0@55.0).
]

{ #category : #tests }
RSEdgeBuilderTest >> testConnectTo [
	| e |
	b canvas: canvas.
	b objects: #(1 2).
	b connectTo: [ :v | v - 1 ].
	
	self assert: canvas numberOfEdges equals: 1.
	
	e := canvas edges anyOne.
	self assert: e from model equals: 2.
	self assert: e to model equals: 1.
]

{ #category : #tests }
RSEdgeBuilderTest >> testConnectToAll [
	| eFrom eTo |
	b canvas: canvas.
	b objects: #(1 2 3).
	b connectToAll: [ :v | Array with: v - 1 with: v - 2 ].
	
	self assert: canvas numberOfEdges equals: 3.
	 
	eFrom := (canvas edges collect: [ :edge | edge from model ]) sorted asArray.
	eTo := (canvas edges collect: [ :edge | edge to model ]) sorted asArray.
	self assert: eFrom equals: #(2 3 3).
	self assert: eTo equals: #(1 1 2).
]

{ #category : #tests }
RSEdgeBuilderTest >> testDefault [
	self assert: canvas numberOfEdges equals: 0
]

{ #category : #tests }
RSEdgeBuilderTest >> testElements [

	| es |
	b := RSLineBuilder line.
	b canvas: canvas.
	self assert: b fromShapes equals: canvas nodes.
	
	es := (1 to: 4) collect: [:n | RSBox new model: n; yourself] as: RSGroup.
	b shapes: es.
	self assert: b fromShapes equals: es.
]

{ #category : #tests }
RSEdgeBuilderTest >> testElementsToLookup [

	| es1 es2 edges c |
	es1 := #(1 2 3) collect: [:n | RSEllipse new model: n; yourself].
	es2 := #(1 2 3) collect: [:n | RSBox new model: n; yourself].
	c := RSCanvas new.
	c addAll: es1.
	c addAll: es2.
	edges := RSLineBuilder line
					canvas: c;
					fromShapes: es1;
					toShapes: es2;
					connectTo: #yourself.
	self assert: edges size equals: 3.
	
	self assert: edges first from equals: es1 first.
	self assert: edges first to equals: es2 first.
]

{ #category : #'tests error' }
RSEdgeBuilderTest >> testErrors [
	| eb |
	eb := RSLineBuilder line.
	
	self should: [ eb shapes: #(1 2 3) ] raise: AssertionFailure.
	self should: [ eb shapes: 'hello world' ] raise: AssertionFailure.
	self should: [ eb shapes: 42 ] raise: AssertionFailure.
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromObjects [
	| edges |
	b canvas: canvas.
	b fromObjects: #(1 2).
	b connectFrom: #yourself to: 10.
	self assert: canvas numberOfEdges equals: 2.
	edges := canvas edges.
	self assert: edges first from model equals: 1.
	self assert: edges first to model equals: 10.

	self assert: b toObjects asArray equals: (1 to: 10) asArray.
	self assert: b fromObjects asArray equals: #(1 2).
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromObjects02 [
	b canvas: canvas.
	b fromObjects: #(1).
	b connectFrom: #yourself to: 10.
	self assert: canvas numberOfEdges equals: 1.

	self assert: b toObjects asArray equals: (1 to: 10) asArray.
	self assert: b fromObjects asArray equals: #(1).
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromObjectsError [

"
view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."
	self should: [ RSLineBuilder new  fromObjects: #(1 2) ] raise: Error
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromObjectsToElements [
	| edges |
	b canvas: canvas.
	edges := 
		b fromObjects: #(1 2);
			toShapes: (shapes copyFrom: 10 to: 10);
			connectTo: 10.
	self assert: edges size equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testHasEdges [
	| s1 s2 |
	s1 := canvas nodes first.
	s2 := canvas nodes second.
	self deny: s1 hasEdges.
	self deny: s2 hasEdges.
	
	b canvas: canvas.
	b objects: #(1 2).
	b connectTo: [ :v | v - 1 ].
	
	self assert: s1 hasEdges.
	self assert: s2 hasEdges.
	self assert: s1 connectedEdges size equals: 1
	
]

{ #category : #tests }
RSEdgeBuilderTest >> testInferCanvas [

	self assert: b canvas isNil.
	b toShapes: canvas nodes.
	self assert: b canvas isNil.
	
	b fromShapes: canvas nodes.
	self assert: b canvas equals: canvas.
]

{ #category : #tests }
RSEdgeBuilderTest >> testInferCanvas2 [

	self assert: b canvas isNil.
	b shapes: canvas nodes.
	self assert: b canvas equals: canvas.
]

{ #category : #tests }
RSEdgeBuilderTest >> testInferCanvas3 [

	| c |
	c := RSCanvas new.
	1 to: 100 do: [ :i | 
		c add: (RSLabel new
				 text: i;
				 model: i) ].

	RSLineBuilder line
		shapes: c nodes;
		connectFrom: [ :i | i // 2 ].

	RSGridLayout on: c nodes.
	c @ RSCanvasController.

	self assert: c numberOfEdges equals: 99
]

{ #category : #tests }
RSEdgeBuilderTest >> testInit [
	| eb |
	eb := RSLineBuilder line.
	self deny: eb shouldAllowRepetition.
	eb allowRepetition.
	self assert: eb shouldAllowRepetition.
]

{ #category : #tests }
RSEdgeBuilderTest >> testNoMoveBehind [
	RSLineBuilder line
		canvas: canvas;
		useAssociations: (Array 
									with: 1 -> 2
									with: 2 -> 3
									with: 5 -> 6).
	self assert: (canvas canvas shapes collect: [ :c | c class name ]) asArray equals: #(#RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSLine #RSLine #RSLine)
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjectFrom [
	| e |
	b canvas: canvas.
	b objects: #(1 2); connectFrom: [ :v | v - 1 ].
	
	self assert: canvas numberOfEdges equals: 1.
	
	e := canvas edges anyOne.
	self assert: e from model equals: 1.
	self assert: e to model equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjectTo [
	| e |
	b canvas: canvas.
	b objects: #(1 2); connectTo: [ :v | v - 1 ].
	
	self assert: canvas numberOfEdges equals: 1.
	
	e := canvas edges anyOne.
	self assert: e from model equals: 2.
	self assert: e to model equals: 1.
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjects [
	b canvas: canvas.
	b objects: (1 to: 5).
	self assert: b fromShapes equals: (shapes copyFrom: 1 to: 5)

"	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjects02 [
	b canvas: canvas.
	b objects: #even.
	self assert: (b fromShapes collect: #model) asArray equals: #(2 4 6 8 10)

]

{ #category : #tests }
RSEdgeBuilderTest >> testObjects03 [
	b canvas: canvas.
	b objects: #odd.
	self assert: (b fromShapes collect: #model) asArray equals: #(1 3 5 7 9)
]

{ #category : #tests }
RSEdgeBuilderTest >> testShouldAllowBidirection [

	self assert: canvas numberOfEdges equals: 0.
	self assert: b isBidirectional.
	b canvas: canvas.
	b noBidirectional.
	b objects: #(1 2).
	b useAssociations: (Array with: 1 -> 2 with: 2 -> 1 ).
	self deny: b isBidirectional. 
	
	shapes := canvas shapesFromModels: #(1 2).
	self assert: shapes size equals: 2.
	self assert: (b shouldCreateEdgeFrom: shapes first to: shapes second).
	
	self assert: canvas numberOfEdges equals: 1.
	self assert: canvas edges anyOne from model equals: 1.
	self assert: canvas edges anyOne to model equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testShouldNotAllowBidirection [

	self assert: canvas numberOfEdges equals: 0.
	b canvas: canvas.
	b objects: #(1 2).
	b useAssociations: (Array with: 1 -> 2 with: 2 -> 1).
	self assert: canvas numberOfEdges equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testShouldNotInstantiate [

	self should: [ RSLineBuilder new ] raise: Error
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple [

	RSLineBuilder line
		canvas: canvas;
		useElementAssociations: (Array 
									with: shapes first -> shapes second
									with: shapes second -> shapes third).
	self assert: canvas numberOfEdges equals: 2
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple2 [

	RSLineBuilder line
		canvas: canvas;
		useAssociations: (Array 
									with: 1 -> 2
									with: 2 -> 3
									with: 5 -> 6).
	self assert: canvas numberOfEdges equals: 3
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple3 [

	RSLineBuilder line
		canvas: canvas;
		fromObjects: #(1 2 3 6);
		toObjects: (1 to: 10);
		connectFrom: #yourself to: [ :v | v + 1 ].
	self assert: canvas numberOfEdges equals: 4.
	self assert: (canvas edges collect: [ :e | e from model -> e to model ]) asArray equals: ((Array new: 4) at: 1 put: (1->2); at: 2 put: (2->3); at: 3 put: (3->4); at: 4 put: (6->7); yourself)
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple4 [

	RSLineBuilder line
		canvas: canvas;
		fromObjects: #(1 2 3 6);
		toObjects: #(1 2 3 6);
		connectFrom: #yourself to: [ :v | v + 1 ].
	self assert: canvas numberOfEdges equals: 2.
	self assert: (canvas edges collect: [ :e | e from model -> e to model ]) asArray equals: ((Array new: 2) at: 1 put: (1->2); at: 2 put: (2->3); yourself)
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple5 [

	RSLineBuilder line
		canvas: canvas;
		fromObjects: #(1 2 3 6);
		connectFrom: #yourself toAll: [ :v | Array with: v + 1 with: v + 2 ].
		
	self assert: canvas numberOfEdges equals: 8.

]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple6 [

	RSLineBuilder line
		canvas: canvas;
		fromObjects: (Array with: 2);
		connectFromAll: (Array with: 2) to: 3.
	self assert: canvas numberOfEdges equals: 1.

]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple7 [

	RSLineBuilder line
		canvas: canvas;
		useAssociation: 1 -> 2;
		useAssociation: 2 -> 3;
		useAssociation: 5 -> 6.

	self assert: canvas numberOfEdges equals: 3
]

{ #category : #tests }
RSEdgeBuilderTest >> testSource [
	| c es eb col |
	c := RSCanvas new.
	es := #(1 2 3) collect: [:n | RSBox new model: n; yourself]. 
	c addAll: es.
	
	eb := RSLineBuilder line.
	eb canvas: c.
	
	col := OrderedCollection new.
	col add: 1 -> 2.
	col add: 3 -> 1.
	eb source: col connectFrom: #key to: #value.
	
	self assert: c numberOfEdges equals: 2
]

{ #category : #tests }
RSEdgeBuilderTest >> testToObjects [
	b canvas: canvas.
	b toObjects: #(1 2).
	b connectFrom: #yourself to: 10.
	self assert: canvas numberOfEdges equals: 0.

	self assert: b toObjects asArray equals: #(1 2).
	self assert: b fromObjects asArray equals: (1 to: 10) asArray.
]

{ #category : #tests }
RSEdgeBuilderTest >> testWithMoveBehind [

	RSLineBuilder line
		canvas: canvas;
		moveBehind;
		useAssociations: (Array 
									with: 1 -> 2
									with: 2 -> 3
									with: 5 -> 6).
	self assert: (canvas canvas shapes collect: [ :c | c class name ]) asArray equals: #(#RSLine #RSLine #RSLine #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox)
]

{ #category : #tests }
RSEdgeBuilderTest >> testWithMoveBehind02 [

	RSLineBuilder line
		canvas: canvas;
		moveBehind;
		connectFrom: [ :v | v - 1 ].
	self assert: (canvas canvas shapes collect: [ :c | c class name ]) asArray equals: #(#RSLine #RSLine #RSLine #RSLine #RSLine #RSLine #RSLine #RSLine #RSLine #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox #RSBox)
]

{ #category : #tests }
RSEdgeBuilderTest >> testconnectFromToAll [

	| es1 es2 edges c |
	es1 := #(1 2 3) collect: [:n | RSEllipse new model: n; yourself].
	es2 := #(1 2 3) collect: [:n | RSBox new model: n; yourself].
	c := RSCanvas new.
	c addAll: es1; addAll: es2.
	edges := RSLineBuilder line
					canvas: c;
					fromShapes: es1;
					toShapes: es2;
					connectFrom: #yourself toAll: [ :obj | Array with: obj ].
	self assert: edges size equals: 3.
	
	self assert: edges first from equals: es1 first.
	self assert: edges first to equals: es2 first.
]
