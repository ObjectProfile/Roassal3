"
I have tests for RSEdgeBuilder
"
Class {
	#name : #RSEdgeBuilderTest,
	#superclass : #TSTest,
	#instVars : [
		'view',
		'elements',
		'b'
	],
	#category : #'Roassal3-Tests-Roassal'
}

{ #category : #tests }
RSEdgeBuilderTest >> expectedFailures [
	^ #(#testFromAll #testUseInLayout #testWithMoveBehind #testWithMoveBehind02)
]

{ #category : #running }
RSEdgeBuilderTest >> setUp [
	super setUp.
	view := RSView new.
	elements := RSShapeBuilder box elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RSEdgeBuilder line.
]

{ #category : #tests }
RSEdgeBuilderTest >> testAllowRepetitionAndUseAssociations [

	| v eb |
	v := RSView new.
	v addAll: (RSShapeBuilder box elementsOn: (1 to: 3)).

	eb := RSEdgeBuilder line.
	eb view: v.
	eb color: (Color red alpha: 0.5).
	eb noRepetition.
	eb useAssociations: (Array with: 1 -> 2 with: 2 -> 3 with: 1 -> 2).
	
	RSGridLayout on: v elements.
	
	self assert: v numberOfEdges equals: 2
]

{ #category : #tests }
RSEdgeBuilderTest >> testConnectFrom [
	| e |
	b view: view.
	b objects: #(1 2).
	b connectFrom: [ :v | v - 1 ].
	
	self assert: view numberOfEdges equals: 1.
	
	e := view edges anyOne.
	self assert: e from model equals: 1.
	self assert: e to model equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testConnectTo [
	| e |
	b view: view.
	b objects: #(1 2).
	b connectTo: [ :v | v - 1 ].
	
	self assert: view numberOfEdges equals: 1.
	
	e := view edges anyOne.
	self assert: e from model equals: 2.
	self assert: e to model equals: 1.
]

{ #category : #tests }
RSEdgeBuilderTest >> testConnectToAll [
	| eFrom eTo |
	b view: view.
	b objects: #(1 2 3).
	b connectToAll: [ :v | Array with: v - 1 with: v - 2 ].
	
	self assert: view numberOfEdges equals: 3.
	 
	eFrom := (view edges collect: [ :edge | edge from model ]) sorted asArray.
	eTo := (view edges collect: [ :edge | edge to model ]) sorted asArray.
	self assert: eFrom equals: #(2 3 3).
	self assert: eTo equals: #(1 1 2).
]

{ #category : #tests }
RSEdgeBuilderTest >> testDefault [
	self assert: view numberOfEdges equals: 0
]

{ #category : #tests }
RSEdgeBuilderTest >> testElements [

	| es |
	b := RSEdgeBuilder new.
	b view: view.
	self assert: b fromElements equals: view elements.
	
	es := RSShapeBuilder box elementsOn: (1 to: 4).
	b elements: es.
	self assert: b fromElements equals: es.
]

{ #category : #tests }
RSEdgeBuilderTest >> testElementsToLookup [

	| es1 es2 edges v |
	es1 := RSShapeBuilder circle elementsOn: #(1 2 3).
	es2 := RSShapeBuilder box elementsOn: #(1 2 3).
	v := RSView new.
	v addAll: es1.
	v addAll: es2.
	edges := RSEdgeBuilder line
					view: v;
					fromElements: es1;
					toElements: es2;
					connectTo: #yourself.
	self assert: edges size equals: 3.
	
	self assert: edges first from equals: es1 first.
	self assert: edges first to equals: es2 first.
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromAll [

	| v es |
	v := RSView new.

	es := (RSShapeBuilder circle size: 20) elementsOn: (1 to: 2).
	v addAll: es.
	
	self assert: v edges size equals: 0.
	RSEdgeBuilder new
		view: v;
		objects: (1 to: 2);
		connectFromAll: (Array with: 1) to: 2.
		
	RSTreeLayout on: es.

	self assert: v edges size equals: 1.
	self assert: v edges first from position equals: (15.0@15.0).
	self assert: v edges first to position equals: (15.0@55.0).
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromObjects [
	"
	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."

	| edges |
	b view: view.
	b fromObjects: #(1 2).
	b connectFrom: #yourself to: 10.
	self assert: view numberOfEdges equals: 2.
	edges := view edges.
	self assert: edges first from model equals: 1.
	self assert: edges first to model equals: 10.

	self assert: b toObjects asArray equals: (1 to: 10) asArray.
	self assert: b fromObjects asArray equals: #(1 2).
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromObjects02 [
	"
	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."
	
	b view: view.
	b fromObjects: #(1).
	b connectFrom: #yourself to: 10.
	self assert: view numberOfEdges equals: 1.

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
	self should: [ RSEdgeBuilder new  fromObjects: #(1 2) ] raise: Error
]

{ #category : #tests }
RSEdgeBuilderTest >> testFromObjectsToElements [
	| edges |
	b view: view.
	edges := 
		b fromObjects: #(1 2);
			toElements: (elements copyFrom: 10 to: 10);
			connectTo: 10.
	self assert: edges size equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testInit [
	| eb |
	eb := RSEdgeBuilder new.
	self deny: eb shouldAllowRepetition.
	eb allowRepetition.
	self assert: eb shouldAllowRepetition.
]

{ #category : #tests }
RSEdgeBuilderTest >> testNoMoveBehind [

	RSEdgeBuilder line
		view: view;
		useAssociations: (Array 
									with: 1 -> 2
									with: 2 -> 3
									with: 5 -> 6).
	self assert: (view canvas shapes collect: [ :c | c class name ]) asArray equals: #(#TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSLine #TSLine #TSLine)
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjectFrom [
	| e |
	b view: view.
	b objects: #(1 2); connectFrom: [ :v | v - 1 ].
	
	self assert: view numberOfEdges equals: 1.
	
	e := view edges anyOne.
	self assert: e from model equals: 1.
	self assert: e to model equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjectTo [
	| e |
	b view: view.
	b objects: #(1 2); connectTo: [ :v | v - 1 ].
	
	self assert: view numberOfEdges equals: 1.
	
	e := view edges anyOne.
	self assert: e from model equals: 2.
	self assert: e to model equals: 1.
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjects [
	b view: view.
	b objects: (1 to: 5).
	self assert: b fromElements equals: (elements copyFrom: 1 to: 5)

"	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjects02 [
	b view: view.
	b objects: #even.
	self assert: (b fromElements collect: #model) asArray equals: #(2 4 6 8 10)

"	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."
]

{ #category : #tests }
RSEdgeBuilderTest >> testObjects03 [
	b view: view.
	b objects: #odd.
	self assert: (b fromElements collect: #model) asArray equals: #(1 3 5 7 9)

"	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."
]

{ #category : #tests }
RSEdgeBuilderTest >> testShouldAllowBidirection [

	self assert: view numberOfEdges equals: 0.
	self assert: b isBidirectional.
	b view: view.
	b noBidirectional.
	b objects: #(1 2).
	b useAssociations: (Array with: 1 -> 2 with: 2 -> 1 ).
	self deny: b isBidirectional. 
	
	elements := view elementsFromModels: #(1 2).
	self assert: elements size equals: 2.
	self assert: (b shouldCreateEdgeFrom: elements first to: elements second).
	
	self assert: view numberOfEdges equals: 1.
	self assert: view edges anyOne from model equals: 1.
	self assert: view edges anyOne to model equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testShouldNotAllowBidirection [

	self assert: view numberOfEdges equals: 0.
	b view: view.
	b objects: #(1 2).
	b useAssociations: (Array with: 1 -> 2 with: 2 -> 1).
	self assert: view numberOfEdges equals: 2.
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple [

	RSEdgeBuilder line
		view: view;
		useElementAssociations: (Array 
									with: elements first -> elements second
									with: elements second -> elements third).
	self assert: view numberOfEdges equals: 2
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple2 [

	RSEdgeBuilder line
		view: view;
		useAssociations: (Array 
									with: 1 -> 2
									with: 2 -> 3
									with: 5 -> 6).
	self assert: view numberOfEdges equals: 3
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple3 [

	RSEdgeBuilder line
		view: view;
		fromObjects: #(1 2 3 6);
		toObjects: (1 to: 10);
		connectFrom: #yourself to: [ :v | v + 1 ].
	self assert: view numberOfEdges equals: 4.
	self assert: (view edges collect: [ :e | e from model -> e to model ]) asArray equals: ((Array new: 4) at: 1 put: (1->2); at: 2 put: (2->3); at: 3 put: (3->4); at: 4 put: (6->7); yourself)
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple4 [

	RSEdgeBuilder line
		view: view;
		fromObjects: #(1 2 3 6);
		toObjects: #(1 2 3 6);
		connectFrom: #yourself to: [ :v | v + 1 ].
	self assert: view numberOfEdges equals: 2.
	self assert: (view edges collect: [ :e | e from model -> e to model ]) asArray equals: ((Array new: 2) at: 1 put: (1->2); at: 2 put: (2->3); yourself)
]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple5 [

	RSEdgeBuilder line
		view: view;
		fromObjects: #(1 2 3 6);
		connectFrom: #yourself toAll: [ :v | Array with: v + 1 with: v + 2 ].
		
	self assert: view numberOfEdges equals: 8.

]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple6 [

	RSEdgeBuilder line
		view: view;
		fromObjects: (Array with: 2);
		connectFromAll: (Array with: 2) to: 3.
	self assert: view numberOfEdges equals: 1.

]

{ #category : #tests }
RSEdgeBuilderTest >> testSimple7 [

	RSEdgeBuilder line
		view: view;
		useAssociation: 1 -> 2;
		useAssociation: 2 -> 3;
		useAssociation: 5 -> 6.

	self assert: view numberOfEdges equals: 3
]

{ #category : #tests }
RSEdgeBuilderTest >> testSource [

	| v es eb c |
	v := RSView new.
	es := RSShapeBuilder box elementsOn: #(1 2 3). 
	v addAll: es.
	
	eb := RSEdgeBuilder line.
	eb view: v.
	
	c := OrderedCollection new.
	c add: 1 -> 2.
	c add: 3 -> 1.
	eb source: c connectFrom: #key to: #value.
	
	self assert: v numberOfEdges equals: 2
]

{ #category : #tests }
RSEdgeBuilderTest >> testToObjects [
	"
	view := RTView new.
	elements := RTBox elementsOn: (1 to: 10).
	view addAll: elements. 
	b := RTEdgeBuilder new."

	b view: view.
	b toObjects: #(1 2).
	b connectFrom: #yourself to: 10.
	self assert: view numberOfEdges equals: 0.

	self assert: b toObjects asArray equals: #(1 2).
	self assert: b fromObjects asArray equals: (1 to: 10) asArray.
]

{ #category : #'tests - use in layout' }
RSEdgeBuilderTest >> testUseInLayout [

	b
		view: view; 
		notUseInLayout; 
		connectTo: [ :v | v + 1 ].
	RSTreeLayout on: view elements.
	
	self assert: (view elements collect: #position) asArray equals: ((Array new: 10) at: 1 put: ((7.5@7.5)); at: 2 put: ((15.5@7.5)); at: 3 put: ((23.5@7.5)); at: 4 put: ((31.5@7.5)); at: 5 put: ((39.5@7.5)); at: 6 put: ((47.5@7.5)); at: 7 put: ((55.5@7.5)); at: 8 put: ((63.5@7.5)); at: 9 put: ((71.5@7.5)); at: 10 put: ((79.5@7.5)); yourself)
]

{ #category : #'tests - use in layout' }
RSEdgeBuilderTest >> testUseInLayoutDefault [

	b 
		view: view;
		connectTo: [ :v | v + 1 ].
	RSTreeLayout on: view elements.
	
	self assert: (view elements collect: #position) asArray equals: ((Array new: 10) at: 1 put: ((7.5@7.5)); at: 2 put: ((7.5@32.5)); at: 3 put: ((7.5@57.5)); at: 4 put: ((7.5@82.5)); at: 5 put: ((7.5@107.5)); at: 6 put: ((7.5@132.5)); at: 7 put: ((7.5@157.5)); at: 8 put: ((7.5@182.5)); at: 9 put: ((7.5@207.5)); at: 10 put: ((7.5@232.5)); yourself)
]

{ #category : #tests }
RSEdgeBuilderTest >> testWithMoveBehind [

	RSEdgeBuilder new
		view: view;
		moveBehind;
		useAssociations: (Array 
									with: 1 -> 2
									with: 2 -> 3
									with: 5 -> 6).
	self assert: (view canvas shapes collect: [ :c | c class name ]) asArray equals: #(#TSLine #TSLine #TSLine #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox)
]

{ #category : #tests }
RSEdgeBuilderTest >> testWithMoveBehind02 [

	RSEdgeBuilder new
		view: view;
		moveBehind;
		connectFrom: [ :v | v - 1 ].
	self assert: (view canvas shapes collect: [ :c | c class name ]) asArray equals: #(#TSLine #TSLine #TSLine #TSLine #TSLine #TSLine #TSLine #TSLine #TSLine #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox #TSBox)
]

{ #category : #tests }
RSEdgeBuilderTest >> testconnectFromToAll [

	| es1 es2 edges v |
	es1 := RSShapeBuilder circle elementsOn: #(1 2 3).
	es2 := RSShapeBuilder box elementsOn: #(1 2 3).
	v := RSView new.
	v addAll: es1; addAll: es2.
	edges := RSEdgeBuilder line
					view: v;
					fromElements: es1;
					toElements: es2;
					connectFrom: #yourself toAll: [ :obj | Array with: obj ].
	self assert: edges size equals: 3.
	
	self assert: edges first from equals: es1 first.
	self assert: edges first to equals: es2 first.
]
