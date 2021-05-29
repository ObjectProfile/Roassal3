"
```
m := RSMondrian new.
m shape label color: Color blue translucent.
m nodes: Collection withAllSubclasses.
m line connectToAll: #dependentClasses.
m normalizeFontSize: #numberOfMethods.
m layout force.
m  
```

Another example with inner boxes:
```
m := RSMondrian new.
m shape box labeled.
m nodes: #(1 2 3 4) forEach: [ :nb | 
	m shape box labeled; size: 20; color: Color blue.
	m nodes: #(10 20) forEach: [ :nb2 | 
		m nodes: #(100 200) ] ].
m line connectTo: [ :nb | nb + 1 ].
m
```
"
Class {
	#name : #RSMondrian,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'layoutBuilder',
		'shapeBuilder',
		'nodesForLayout',
		'lineBuilder',
		'depth'
	],
	#category : #'Roassal3-Mondrian-Core'
}

{ #category : #'building - graph' }
RSMondrian >> applyLayout [
	layoutBuilder on: nodesForLayout
]

{ #category : #'building - graph' }
RSMondrian >> arrowedLine [
	lineBuilder := RSLineBuilder arrowedLineWithOffset.
	lineBuilder canvas: canvas.
	lineBuilder shapes: canvas nodes.
	lineBuilder withBorderAttachPoint.
	lineBuilder color: self defaultLineColor.
	^ lineBuilder
]

{ #category : #'public - opening and public' }
RSMondrian >> build [
	"This is a public method. It is used to actually build the visualization from the description provided by the user."
	| interaction |
	self applyLayout.
	
	interaction := RSHighlightableInteraction new.
	interaction highlightBorder: (RSBorder new color: Color black; width: 2).
	interaction withOutgoingEdges.
	self canvas nodes @ interaction.
	
	self canvas pushBackEdges.
		 
]

{ #category : #accessing }
RSMondrian >> canvas [
	"Return the canvas that contains the visualization built by Mondrian"
	^ canvas
]

{ #category : #accessing }
RSMondrian >> canvas: aCanvas [
	canvas := aCanvas
]

{ #category : #configuration }
RSMondrian >> defaultLineColor [
	^ Color gray translucent
]

{ #category : #visualization }
RSMondrian >> gtInspectorViewIn: composite [

	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: [ 'Canvas' ];
		initializeCanvas: [ self build; canvas ]
]

{ #category : #'building - graph' }
RSMondrian >> initialize [
	super initialize.
	shapeBuilder := RSShapeBuilder new.
	layoutBuilder := RSLayoutBuilder new.
	canvas := RSCanvas new @ RSCanvasController.
	nodesForLayout := RSGroup new.
	depth := 0
]

{ #category : #visualization }
RSMondrian >> inspectorVisualization [
	<inspectorPresentationOrder: 90 title: 'Mondrian'>
	self build.
	^ SpRoassal3InspectorPresenter new
		canvas: self canvas;
		yourself

]

{ #category : #visualization }
RSMondrian >> inspectorVisualizationContext: aContext [
  
  aContext withoutEvaluator
]

{ #category : #'building - graph' }
RSMondrian >> layout [
	^ layoutBuilder
]

{ #category : #'building - graph' }
RSMondrian >> line [
	lineBuilder := RSLineBuilder line.
	lineBuilder canvas: canvas.
	lineBuilder shapes: (canvas nodes select: #hasModel).
	lineBuilder color: self defaultLineColor.
	^ lineBuilder
]

{ #category : #'building - graph' }
RSMondrian >> nodes: objects [
	"Add a new node represengint an object to the view. The node is a container for other objects.
	
	For example:
	b := RTMondrian new.
	b nodes: (1 to: 10).
	b layout force.
	b open
	
	
	Another example:
	b := RTMondrian new.
	b shape box size: #numberOfMethods.
	b nodes: Collection withAllSubclasses.
	b layout flow.
	b open
	
	Another example:
	b := RTMondrian new.
	b shape box size: #numberOfMethods.
	b nodes: Collection withAllSubclasses.
	b edges connectFrom: #superclass.
	b normalizer 
		normalizeSize: #numberOfMethods;
		normalizeColor: #numberOfMethods.
	b layout cluster.
	b open
	"
	
	| nodes |
	self assert: [ objects isCollection ] description: 'You need to provide a collection to #nodes:'.
	nodes := self shapesOn: objects.
	canvas addAll: nodes.
"	self currentFrame addShapes: els.
	canvas addAll: els.
	self resetShapeBuilder.
	self resetLayoutBuilder.
	self resetInteraction."
	nodesForLayout addAll: nodes.
	^ nodes
]

{ #category : #'building - graph' }
RSMondrian >> nodes: objects forEach: oneArgBlock [
	"Add a new node represengint an object to the view. The node is a container for other objects.
	
	For example:
```
b := RSMondrian new.
b nodes: (1 to: 10).
b layout force.
b open
```	
	
	Another example:
```
b := RSMondrian new.
b shape box size: #numberOfMethods.
b nodes: Collection withAllSubclasses.
b layout flow.
b open
```
	
	Another example:
```
b := RSMondrian new.
b shape box size: #numberOfMethods.
b nodes: Collection withAllSubclasses.
b line connectFrom: #superclass.
b normalizeSize: #numberOfMethods.
b normalizeColor: #numberOfMethods.
b layout cluster.
b open
```
	"
	
	| nodes compo old previousShapeBuilder oldNodesToLayout lbl |
	nodes := RSGroup new.
	objects do: [ :obj |
		previousShapeBuilder := shapeBuilder.
		
		compo := RSComposite new.
		compo model: obj.
		shapeBuilder configureNotCompositeShape: compo model: obj.
		"compo := shapeBuilder configureShape: compo."
		
		old := self canvas.
		oldNodesToLayout := nodesForLayout.
		nodesForLayout := RSGroup new.
		self canvas: compo.
		
		depth := depth + 1.
		
		shapeBuilder := RSShapeBuilder new.
		oneArgBlock rsValue: obj.
		
		nodes add: compo.
		self build.
		
		previousShapeBuilder doesUseLabel ifTrue: [ 
			lbl := RSLabel new color: Color black; text: (previousShapeBuilder labelBlock rsValue: obj).
			RSLocation move: lbl above: compo children.
			compo add: lbl ]. 
		
		nodesForLayout := oldNodesToLayout.
		compo adjustToChildren.
		compo padding: 5.
		compo pushBackEdges.
		self canvas: old.
		shapeBuilder := previousShapeBuilder.
		depth := depth - 1
	].
	canvas addAll: nodes.
	nodes @ RSPopup.
	depth = 0 ifTrue: [ nodes @ RSDraggableInteraction ].
	nodesForLayout addAll: nodes.
	^ nodes
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeColor: oneArgBlock [
	RSNormalizer color
		shapes: self canvas nodes;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeColor: oneArgBlock from: fromColor to: toColor [
	RSNormalizer color
		shapes: self canvas nodes;
		from: fromColor;
		to: toColor;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeFontSize: oneArgBlock [
	RSNormalizer fontSize
		shapes: self canvas nodes;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeFontSize: oneArgBlock from: fromNumber to: toNumber [
	RSNormalizer fontSize
		shapes: self canvas nodes;
		from: fromNumber;
		to: toNumber;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeHeight: oneArgBlock [
	RSNormalizer height
		shapes: self canvas nodes;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeHeight: oneArgBlock from: fromValue to: toValue [
	RSNormalizer height
		shapes: self canvas nodes;
		from: fromValue;
		to: toValue;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeSize: oneArgBlock [
	RSNormalizer size
		shapes: self canvas nodes;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeWidth: oneArgBlock [
	RSNormalizer width
		shapes: self canvas nodes;
		normalize: oneArgBlock
]

{ #category : #'public - normalizer' }
RSMondrian >> normalizeWidth: oneArgBlock from: fromValue to: toValue [
	RSNormalizer width
		shapes: self canvas nodes;
		from: fromValue;
		to: toValue;
		normalize: oneArgBlock
]

{ #category : #'public - opening and public' }
RSMondrian >> open [
	"Open the visualization"
	self build.
	^ canvas open
]

{ #category : #'public - opening and public' }
RSMondrian >> openOnce [
	self build.
	^ canvas openOnce
]

{ #category : #'public - opening and public' }
RSMondrian >> openOnceWithTitle: aTitle [
	self build.
	^ canvas openOnceWithTitle: aTitle
]

{ #category : #'public - opening and public' }
RSMondrian >> openWithTitle: aTitle [
	"Open the visualization"
	self build.
	^ canvas openWithTitle: aTitle
]

{ #category : #'public - normalizer' }
RSMondrian >> ordinalColor: oneArgBlock [
	| numberOfDifferentColors scale |
	numberOfDifferentColors := (self canvas nodes collect: [ :aShape | oneArgBlock rsValue: aShape model ] as: Set) size.
	scale := NSScale ordinalColored: numberOfDifferentColors.
	self canvas nodes do: [ :aShape | aShape color: (scale scale: (oneArgBlock rsValue: aShape model)) ]
]

{ #category : #'building - graph' }
RSMondrian >> orthoHorizontalline [
	lineBuilder := RSLineBuilder orthoHorizontal.
	lineBuilder canvas: canvas.
	lineBuilder shapes: canvas nodes.
	lineBuilder color: self defaultLineColor.
	^ lineBuilder
]

{ #category : #'building - graph' }
RSMondrian >> orthoVerticalLine [
	lineBuilder := RSLineBuilder orthoVertical.
	lineBuilder canvas: canvas.
	lineBuilder shapes: canvas nodes.
	lineBuilder withVerticalAttachPoint.
	lineBuilder color: self defaultLineColor.
	^ lineBuilder
]

{ #category : #accessing }
RSMondrian >> shape [
	^ shapeBuilder
]

{ #category : #'building - graph' }
RSMondrian >> shapesOn: someObjects [
	| ss |
	ss := shapeBuilder shapesOn: someObjects.
	depth = 0 ifTrue: [ ss @ RSDraggableInteraction ].
	ss @ RSPopup.
	^ ss
]

{ #category : #'public - normalizer' }
RSMondrian >> translucentShapes [
	self canvas shapes do: [ :s | s color: s color translucent ]
]
