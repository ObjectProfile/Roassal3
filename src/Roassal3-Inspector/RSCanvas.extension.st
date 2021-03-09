Extension { #name : #RSCanvas }

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> gtInspectorShapesIn: composite [
	<gtInspectorPresentationOrder: 20>
	composite table 
		title: 'Shapes';
		showOnly: 50;
		display: [ :each | each shapes ];
		children: #children;
		column: 'Shape' evaluated: [ :each | each asString ];
		column: 'Model' evaluated: [ :each | each model asString ];
		column: 'Paint' evaluated: [ :each | each paint asString ];
		column: 'Border' evaluated: [ :each | each border asString ].
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Canvas'];
		initializeCanvas: [ self ]
		
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> inspectorCanvas [
	<inspectorPresentationOrder: 90 title: 'Canvas'>
	^ SpRoassal3InspectorPresenter new
		canvas: self;
		yourself
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> inspectorCanvasContext: aContext [
  
  aContext withoutEvaluator
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> inspectorContext [
	"Return the context used in the canvas. The inspector context contains all the registration that is added to a canvas per default, when being used in the GTInspector. Registrations can be easily diseabled, for example, in case one wishes to disable the opening of a new inspector pane by clicking on an object using:
```
c inspectorContext interactionsToBeRegistered removeAll.
```
`c`, being a canvas.

Here is an example:
```
c := RSCanvas new.
c addAll: ((1 to: 10) collect: [ :n | RSEllipse new size: 20; model: n ]).
RSFlowLayout on: c nodes.
c inspectorContext interactionsToBeRegistered removeAll.
c
```
In the example given above, clicking on a circle does not open a new pane in the GT inspector.
	"
	^ self
		propertyAt: RSAbstractContext name asSymbol
		ifAbsentPut: [ RSInteractiveContext new ]
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> inspectorContext: aRSContext [
	^ self
		propertyAt: RSAbstractContext name asSymbol
		put: aRSContext
]

{ #category : #'*Roassal3-Inspector' }
RSCanvas >> inspectorShapes [
	<inspectorPresentationOrder: 100 title: 'Shapes'>
	^ SpTablePresenter new
		items: self shapes, self fixedShapes;
		addColumn: (SpStringTableColumn 
			title: 'Shape'
			evaluated: [ :each | each asString ] );
		addColumn: (SpStringTableColumn 
			title: 'Model'
			evaluated: [ :each | each model asString ] );
		addColumn: (SpStringTableColumn 
			title: 'Paint'
			evaluated: [ :each | each paint asString ] );
		addColumn: (SpStringTableColumn 
			title: 'Border'
			evaluated: [ :each | each border asString ] )
]
