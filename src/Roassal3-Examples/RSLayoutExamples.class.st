"
I use the RSShapeBuilder
"
Class {
	#name : #RSLayoutExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #layouts }
RSLayoutExamples >> example01LayoutBasic [
	<script: 'self new example01LayoutBasic open'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		interactionDo: #draggable;
		onElement;
		color: [ :e | e index even 
			ifTrue: [ Color red alpha: 0.5 ]
			ifFalse: [ Color blue alpha: 0.5 ] ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	RSGridLayout on: elements.
	^ v
]

{ #category : #layouts }
RSLayoutExamples >> example02Grid [
	<script: 'self new example02Grid open'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		elementsOn: (Collection withAllSubclasses).

	v addAll: elements.
	RSGridLayout on: elements.
	^ v
]

{ #category : #layouts }
RSLayoutExamples >> example03LayoutColorFadingBasic [
	<script: 'self new example03LayoutColorFadingBasic open'>

	| v elements color |
	v := RSView new.
	color := TSScale linear
		domain: #(1 20);
		range: {Color red. Color green}.
		
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		interactionDo: #draggable;
		onElement;
		color: [ :e | color scale: e index ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	RSGridLayout on: elements.
	^ v
]

{ #category : #layouts }
RSLayoutExamples >> example04LayoutColorFadingBasic2 [
	<script: 'self new example04LayoutColorFadingBasic2 open'>

	| v elements color |
	v := RSView new.
	color := TSScale linear
		domain: #(1 10 20);
		range: { Color red. Color green. Color blue }";
		interpolate: TSColorHSVAInterpolator".
		
		
	elements := RSShapeBuilder box
		size: #yourself;
		position: [:m | (1 to: m) sum asPoint -150 ];
		interactionDo: #draggable;
		color: [ :m |color scale: m ];
		elementsOn: (1 to: 20).

	v addAll: elements.
	RSGridLayout on: elements.
	^ v
]

{ #category : #layouts }
RSLayoutExamples >> example05LayoutBasicWithColorFading [
	<script: 'self new example05LayoutBasicWithColorFading open'>

	| v elements minAndMax color |
	v := RSView new.
	minAndMax := Collection withAllSubclasses inject: { 10000 . 0 } into: [ :res :cls | {res first min: cls numberOfMethods . res second max: cls numberOfMethods}].
	color := TSScale linear
		domain: minAndMax;
		range: { Color green . Color red }.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		color: [ :cls | color scale: cls numberOfMethods ];
		elementsOn: (Collection withAllSubclasses).

	v addAll: elements.
	RSGridLayout on: elements.
	v @ RSDraggableCanvas .
	^ v
]

{ #category : #layouts }
RSLayoutExamples >> example05TreeLayout [
	<script: 'self new example05TreeLayout open'>
	| c shapes eb |
	c := RSCanvas new.
	shapes := Collection withAllSubclasses collect: [ :cls |
		RSEllipse new
			model: cls;
			draggable;
			size: 5;
			yourself
		 ].
	
	c addAll: shapes.
	RSNormalizer color
		from: (Color gray alpha: 0.5);
		to: (Color red alpha: 0.5);
		shapes: shapes;
		normalize: #numberOfMethods.
	RSNormalizer size
		shapes: shapes;
		normalize: #numberOfMethods.
	eb := RSEdgeBuilder line.
	eb canvas: c.
	eb connectFrom: #superclass.
	RSTreeLayout on: shapes.
	shapes do: [ :e | e translateBy: 0 @ 0 ].
	c @ RSDraggableCanvas.
	^ c
]

{ #category : #layouts }
RSLayoutExamples >> example06Cluster [
	<script: 'self new example06Cluster open'>
	| c shapes |
	c := RSCanvas new.
	shapes :=  GLMBrickedMorph withAllSubclasses collect: [ :cls |
		RSEllipse new 
			size: 5;
			color: Color red;
			model: cls;
			yourself ].
	c addAll: shapes.
	RSEdgeBuilder line
		canvas: c;
		color: Color blue trans;
		connectFrom: #superclass.
	RSNormalizer size
		scale:
			(TSScale log
				base: 2.7;
				range: {1 . 30});
		shapes: c nodes;
		normalize: #numberOfMethods.
	RSNormalizer color
		scale:
			(TSScale log
				base: 2.7;
				range:
					{Color blue.
					Color red});
		shapes: c nodes;
		normalize: #numberOfMethods.
	RSClusterLayout on: c nodes.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example07ForceBasedLayout [
	<script: 'self new example07ForceBasedLayout open'>
	| c shapes eb |
	c := RSCanvas new.
	shapes := RSShape withAllSubclasses collect: [ :cls |
		RSEllipse new 
			popup;
			draggable;
			model: cls;
			size: 5;
			yourself ].
	c addAll: shapes.
	RSNormalizer size
		shapes: c nodes;
		normalize: #numberOfMethods.
	RSNormalizer color
		from: (Color green alpha: 0.5);
		to: (Color red alpha: 0.5);
		shapes: c nodes;
		normalize: #numberOfMethods.
	eb := RSEdgeBuilder line.
	eb
		canvas: c;
		moveBehind;
		connectFrom: #superclass.
	RSForceBasedLayout new
		doNotUseProgressBar; 
		charge: -350;
		on: c nodes.
	c @ RSCanvasController.
	c zoomToFit.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example08HorizontalTree [
	<script: 'self new example08HorizontalTree open setLabel: ''Horizontal Tree'''>
	| c shapes |
	c := RSCanvas new.
	
	shapes := String withAllSubclasses collect: [ :cls | | box lbl |
		lbl := RSLabel new
			text: cls asString;
			yourself.
		box := RSBox new
			withBorder;
			cornerRadius: (RSCornerRadius new right: 10);
			extent: lbl extent + 10.
		RSComposite new
			draggable;
			model: cls;
			shapes: (RSGroup with: box with: lbl );
			yourself ].
	c addAll: shapes.
	c @ RSCanvasController.
	RSEdgeBuilder orthoHorizontal
		markerEnd: (RSMarker new 
			offset: 2;
			shape: (RSShapeBuilder triangle 
				color: Color black;
				size: 5;
				element));
		attachPoint: RSHorizontalAttachPoint new; 
		canvas: c;
		shapes: c nodes;
		connectFrom: #superclass.
	RSHorizontalTreeLayout new on: c nodes.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example09BorderAttachPoint [
	<script: 'self new example09BorderAttachPoint open setLabel: ''TSShape withAllSubclasses'''>
	| c shapes |
	c := RSCanvas new.
	shapes := RSShape withAllSubclasses collect: [ :cls | 
		RSShape square size: 30; draggable; model: cls; yourself ].
	c addAll: shapes.
	RSEdgeBuilder arrowedLine 
		withBorderAttachPoint;
		canvas: c;
		connectFrom: #superclass.
	RSForceBasedLayout new 
		charge: -500; 
		on: c nodes.
	c @ RSCanvasController.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example10Locate [
	<script: 'self new example10Locate open'>
	| v shape e1 e2 |
	v := RSView new.
	shape := RSShapeBuilder box
		@ RSDraggable;
		onElement;
		color: RSColorPalette sequential blues3;
		size: 100.
	e1 := shape element.
	"e1 @ RSDraggable."
	e2 := shape element.
	e2 size: 20.
	RSLocation new
		offset: 1@ -1;
		inner;
		bottom;
		left;
		stick: e2 on: e1.
	v addAll:{e1. e2}.
	v @ RSCanvasController.
	^ v
]

{ #category : #lines }
RSLayoutExamples >> example11PaddingInComposite [
	<script: 'self new example11PaddingInComposite open'>
	| v box shape elements |
	v := RSView new.
	box := RSShapeBuilder box.
	shape := RSShapeBuilder composite
		popup;
		shapes: [ :cls | 
			| g |
			g := box elementsOn: cls methods.
			RSGridLayout on: g.
			g ];
		padding:
			(Margin
				left: 50
				right: 5
				top: 20
				bottom: 5);
		color: Color blue trans.
	elements := shape elementsOn: Collection withAllSubclasses.
	RSGridLayout on: elements.
	v addAll: elements.
	v @ RSCanvasController.
	^ v
]

{ #category : #lines }
RSLayoutExamples >> example12AnimatedForceBasedLayout [ 
	<script: 'self new example12AnimatedForceBasedLayout open'>
	| canvas shapes layout edges  |
	canvas := RSCanvas new.
	shapes := (1 to: 10) collect: [ :m | 
		RSBox new 
			size: 30;
			draggable;
			labeled;
			model: m;
			yourself ].
	edges := RSEdgeBuilder line
		shapes: shapes;
		connectFrom: [ :i | i // 2 ].
	canvas
		addAll: edges;
		addAll: shapes.
	layout := RSForceBasedLayout new
		length: 80;
		charge: -300;
		nodes: shapes;
		edges: canvas edges;
		start;
		yourself.
	"elements do: [ :e |
		(layout mockElementAt: e) charge: e model * -20 ]."
	canvas edges do: [ :edge |  (layout mockEdgeAt: edge) length: (edge model key + edge model value) * 10 ].
	canvas @ RSCanvasController.
	
	canvas @ (RSForceLayoutStepping new layout: layout).
	^ canvas
]

{ #category : #lines }
RSLayoutExamples >> example13VisualizeQuatree [
	<script: 'self new example13VisualizeQuatree open'>
	| canvas shapes layout edges boxBuilder boxes createBoxes colors labelBuilder |
	canvas := RSCanvas new.
	shapes := (1 to: 50) collect: [:n | 
		RSBox new
			size: 30;
			draggable; 
			labeled;
			model: n;
			yourself].
	edges := RSEdgeBuilder line
		shapes: shapes;
		connectFrom: [ :i | i // 2 ].
	canvas
		addAll: edges;
		addAll: shapes.
	layout := RSForceBasedLayout new
		length: 80;
		charge: -300;
		nodes: shapes;
		edges: canvas edges;
		start;
		yourself.
	canvas @ RSCanvasController.
	canvas @ (RSForceLayoutStepping new layout: layout).
	colors := RSColorPalette sequential pubu9.
	boxBuilder := [ :quad :index |
		RSBox new
			border: (RSBorder new color: Color lightGray trans; width: 0.5);
			extent: quad rectangle extent;
			position: quad rectangle rsCenter;
			color: ((colors scale: index) alpha: 0.5 );
			yourself
			 ]. 
	labelBuilder := [ :quad :index |
		RSLabel new
			text: (quad charge printShowingDecimalPlaces: 1);
			position: quad rectangle rsCenter;
			yourself.
		 ].
	boxes := #().
	createBoxes := nil.
	createBoxes := [ :quad :lvl | | box label |
		box := boxBuilder value: quad value: lvl.
		label := labelBuilder value: quad value: lvl.
		quad subQuadsDo: [ :subQuad | createBoxes value: subQuad value: lvl + 1 ].
		boxes add: box.
		boxes add: label.
		].
	canvas newAnimation
		repeat;
		duration: 500 milliSeconds;
		when: RSAnimationLoopEvent do: [ :v | 
			boxes do: #remove.
			boxes := RSGroup new.
			createBoxes value: layout currentQuadtree value: 0.
			canvas addAll: boxes.
			boxes pushBack ].
	^ canvas
]

{ #category : #lines }
RSLayoutExamples >> example14ClassHierarchy [
	<script: 'self new example14ClassHierarchy open'>
	| c classes |
	c := RSCanvas new.

	classes := (Object withAllSubclasses first: 300)
		flatCollect: #withAllSuperclasses.
	classes := classes asSet 
		collect: [:cls | RSEllipse new model: cls; yourself] 
		as: RSGroup.
	c addAll: classes.
	classes @ RSPopup @ RSDraggable.
	RSEdgeBuilder line
		color: Color gray;
		color: c;
		shapes: classes;
		withBorderAttachPoint;
		connectFrom: #superclass.
	RSNormalizer size
		shapes: classes;
		to: 20;
		normalize: #numberOfMethods.
	RSNormalizer color
		shapes: classes;
		normalize: #numberOfMethods.
	RSClusterLayout on: classes.
	"" RSMultiBezierEdgeBuilder multiBezier.
	"eb2 borderColor: (Color blue alpha: 0.3).
	eb2 view: c.
	eb2 elements: es.
	eb2 withBorderAttachPoint.
	eb2 following: #superclass.
	eb2 connectToAll: #dependentClasses."
	c @ RSCanvasController.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example15SimpleClassHierarchy [
	<script: 'self new example15SimpleClassHierarchy open'>
	| c methods |
	c := RSCanvas new.

	GoferOperation withAllSubclassesDo: [ :cls |
		| composite label |
		methods := cls methods collect: [ :m | RSBox new color: Color red; size: 5; model: m; yourself ] as: RSGroup.
		methods @ (RSPopup text: #selector).
		
		RSGridLayout on: methods.
		composite := RSComposite new.
		label := RSLabel new text: cls name.
		RSLocation new above; move: label on: methods.
		composite shapes:  methods, { label }.
		
		composite color: Color gray.
		composite model: cls.
		composite @ RSAnimatedPopup @ RSDraggable.
		composite padding: 10.
		c add: composite ].

	RSEdgeBuilder line
		canvas: c;
		withVerticalAttachPoint;
		color: Color blue;
		connectFrom: #superclass.

	RSTreeLayout on: c nodes.

	"Making sure we have zooming"
	c @ RSCanvasController.
	^ c 
]

{ #category : #lines }
RSLayoutExamples >> example16SimpleClassHierarchy [
	<script: 'self new example16SimpleClassHierarchy open'>
	| c |
	c := RSCanvas new.

	Collection withAllSubclassesDo: [ :cls |
		| box |
		box := RSBox new.
		box model: cls.
		box height: (cls numberOfMethods max: 5).
		box width: ((cls instVarNames size * 4) max: 5).
		box @ RSPopup @ RSDraggable.
		c add: box.
		 ].

	RSEdgeBuilder line
		canvas: c;
		withVerticalAttachPoint;
		color: Color blue;
		connectFrom: #superclass.

	RSTreeLayout on: c nodes.

	c @ RSCanvasController.
	^ c 
]
