Class {
	#name : #RSMondrian,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'layoutBuilder',
		'shapeBuilder',
		'edgeBuilder',
		'createdNodes'
	],
	#category : #'Roassal3-Mondrian-Core'
}

{ #category : #'building - graph' }
RSMondrian >> applyLayout [
	layoutBuilder on: createdNodes "canvas nodes"
]

{ #category : #'building - graph' }
RSMondrian >> arrowedLine [
	edgeBuilder := RSLineBuilder arrowedLineWithOffset.
	edgeBuilder canvas: canvas.
	edgeBuilder shapes: canvas nodes.
	edgeBuilder withBorderAttachPoint.
	edgeBuilder color: self defaultLineColor.
	^ edgeBuilder
]

{ #category : #'public - opening and public' }
RSMondrian >> build [
	"This is a public method. It is used to actually build the visualization from the description provided by the user."
	| interaction |
	self applyLayout.
	
	interaction := RSHighlightable new.
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
	createdNodes := RSGroup new
]

{ #category : #'building - graph' }
RSMondrian >> layout [
	^ layoutBuilder
]

{ #category : #'building - graph' }
RSMondrian >> line [
	edgeBuilder := RSLineBuilder line.
	edgeBuilder canvas: canvas.
	edgeBuilder shapes: (canvas nodes select: #hasModel).
	edgeBuilder color: self defaultLineColor.
	^ edgeBuilder
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
	createdNodes addAll: nodes.
	^ nodes
]

{ #category : #'building - graph' }
RSMondrian >> nodes: objects forEach: oneArgBlock [
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
	
	| nodes compo old previousShapeBuilder |
	nodes := RSGroup new.
	objects do: [ : obj |
		previousShapeBuilder := shapeBuilder.
		
		compo := RSComposite new.
		compo color: shapeBuilder color.
		compo model: obj.
		old := self canvas.
		self canvas: compo.
		
		shapeBuilder := RSShapeBuilder new.
		oneArgBlock rsValue: obj.
		nodes add: compo.
		self build.
		compo adjustToChildren.
		compo padding: 5.
		compo pushBackEdges.
		self canvas: old.
		shapeBuilder := previousShapeBuilder.
	].
	canvas addAll: nodes.
	nodes @ RSPopup @ RSDraggable.
	createdNodes addAll: nodes.
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
RSMondrian >> normalizeHeight: oneArgBlock [
	RSNormalizer height
		shapes: self canvas nodes;
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

{ #category : #'building - graph' }
RSMondrian >> orthoHorizontalline [
	edgeBuilder := RSLineBuilder orthoHorizontal.
	edgeBuilder canvas: canvas.
	edgeBuilder shapes: canvas nodes.
	edgeBuilder color: self defaultLineColor.
	^ edgeBuilder
]

{ #category : #'building - graph' }
RSMondrian >> orthoVerticalLine [
	edgeBuilder := RSLineBuilder orthoVertical.
	edgeBuilder canvas: canvas.
	edgeBuilder shapes: canvas nodes.
	edgeBuilder withVerticalAttachPoint.
	edgeBuilder color: self defaultLineColor.
	^ edgeBuilder
]

{ #category : #accessing }
RSMondrian >> shape [
	^ shapeBuilder
]

{ #category : #'building - graph' }
RSMondrian >> shapesOn: someObjects [
	| ss |
	ss := shapeBuilder shapesOn: someObjects.
	ss @ RSPopup @ RSDraggable.
	^ ss
]

{ #category : #'public - normalizer' }
RSMondrian >> translucentShapes [
	self canvas shapes do: [ :s | s color: s color translucent ]
]
