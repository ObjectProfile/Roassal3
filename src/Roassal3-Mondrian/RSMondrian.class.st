Class {
	#name : #RSMondrian,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'layoutBuilder',
		'shapeBuilder',
		'edgeBuilder'
	],
	#category : #'Roassal3-Mondrian'
}

{ #category : #'building - graph' }
RSMondrian >> applyLayout [
	layoutBuilder on: canvas nodes
]

{ #category : #visualization }
RSMondrian >> build [
	self applyLayout
]

{ #category : #accessing }
RSMondrian >> canvas [
	^ canvas
]

{ #category : #accessing }
RSMondrian >> canvas: aCanvas [
	canvas := aCanvas
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
	canvas := RSCanvas new @ RSCanvasController
]

{ #category : #'building - graph' }
RSMondrian >> layout [
	^ layoutBuilder
]

{ #category : #'building - graph' }
RSMondrian >> line [
	edgeBuilder := RSEdgeBuilder line.
	edgeBuilder canvas: canvas.
	edgeBuilder shapes: canvas nodes.
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
	
	| shapes |
	self assert: [ objects isCollection ] description: 'You need to provide a collection to #nodes:'.
	shapes := self shapesOn: objects.
	canvas addAll: shapes.
"	self currentFrame addShapes: els.
	canvas addAll: els.
	self resetShapeBuilder.
	self resetLayoutBuilder.
	self resetInteraction."
	^ shapes
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
	
	| shapes compo old previousShapeBuilder |
	shapes := RSGroup new.
	objects do: [ : obj |
		previousShapeBuilder := shapeBuilder.
		shapeBuilder := RSShapeBuilder new.
		compo := RSComposite new.
		compo color: shapeBuilder color.
		compo model: obj.
		old := self canvas.
		self canvas: compo.
		oneArgBlock rsValue: obj.
		shapes add: compo.
		self build.
		compo adjustToChildren.
		compo padding: 5.
		compo pushBackEdges.
		self canvas: old.
		shapeBuilder := previousShapeBuilder.
	].
	canvas addAll: shapes.
	shapes @ RSPopup @ RSDraggable.
	^ shapes
]

{ #category : #'instance creation' }
RSMondrian >> open [
	self build.
	^ canvas open
]

{ #category : #'instance creation' }
RSMondrian >> openOnce [
	self build.
	^ canvas openOnce
]

{ #category : #'building - graph' }
RSMondrian >> orthoHorizontalline [
	edgeBuilder := RSEdgeBuilder orthoHorizontal.
	edgeBuilder canvas: canvas.
	edgeBuilder shapes: canvas nodes.
	^ edgeBuilder
]

{ #category : #'building - graph' }
RSMondrian >> orthoVerticalLine [
	edgeBuilder := RSEdgeBuilder orthoVertical.
	edgeBuilder canvas: canvas.
	edgeBuilder shapes: canvas nodes.
	edgeBuilder withVerticalAttachPoint.
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
