"
I use the RSShapeBuilder
"
Class {
	#name : #RSLayoutExamples,
	#superclass : #TSAbstractExamples,
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
	TSGridLayout on: elements.
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
	TSGridLayout on: elements.
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
	TSGridLayout on: elements.
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
	TSGridLayout on: elements.
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
	TSGridLayout on: elements.
	v @ TSDraggableCanvas .
	^ v
]

{ #category : #layouts }
RSLayoutExamples >> example05TreeLayout [
	<script: 'self new example05TreeLayout open'>
	| c shapes eb |
	c := TSCanvas new.
	shapes := Collection withAllSubclasses collect: [ :cls |
		TSEllipse new
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
	eb := TSEdgeBuilder line.
	eb canvas: c.
	eb connectFrom: #superclass.
	TSTreeLayout on: shapes.
	shapes do: [ :e | e translateBy: 0 @ 0 ].
	c @ TSDraggableCanvas.
	^ c
]

{ #category : #layouts }
RSLayoutExamples >> example06Cluster [
	<script: 'self new example06Cluster open'>
	| c shapes |
	c := TSCanvas new.
	shapes :=  GLMBrickedMorph withAllSubclasses collect: [ :cls |
		TSEllipse new 
			size: 5;
			color: Color red;
			model: cls;
			yourself ].
	c addAll: shapes.
	TSEdgeBuilder line
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
	TSClusterLayout on: c nodes.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example07ForceBasedLayout [
	<script: 'self new example07ForceBasedLayout open'>
	| c shapes eb |
	c := TSCanvas new.
	shapes := TSShape withAllSubclasses collect: [ :cls |
		TSEllipse new 
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
	eb := TSEdgeBuilder line.
	eb
		canvas: c;
		moveBehind;
		connectFrom: #superclass.
	TSForceBasedLayout new
		doNotUseProgressBar; 
		charge: -350;
		on: c nodes.
	c @ TSControlsCanvas.
	c zoomToFit.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example08HorizontalTree [
	<script: 'self new example08HorizontalTree open setLabel: ''Horizontal Tree'''>
	| c shapes |
	c := TSCanvas new.
	
	shapes := String withAllSubclasses collect: [ :cls | | box lbl |
		lbl := TSLabel new
			text: cls asString;
			yourself.
		box := TSBox new
			withBorder;
			cornerRadius: (TSCornerRadius new right: 10);
			extent: lbl extent + 10.
		TSComposite new
			draggable;
			model: cls;
			shapes: (TSGroup with: box with: lbl );
			yourself ].
	c addAll: shapes.
	c @ TSControlsCanvas.
	TSEdgeBuilder orthoHorizontal
		markerEnd: (TSMarker new 
			offset: 2;
			shape: (RSShapeBuilder triangle 
				color: Color black;
				size: 5;
				element));
		attachPoint: TSHorizontalAttachPoint new; 
		canvas: c;
		shapes: c nodes;
		connectFrom: #superclass.
	TSHorizontalTreeLayout new on: c nodes.
	^ c
]

{ #category : #lines }
RSLayoutExamples >> example09BorderAttachPoint [
	<script: 'self new example09BorderAttachPoint open setLabel: ''TSShape withAllSubclasses'''>
	| v sb |
	v := RSView new.
	sb := RSShapeBuilder square 
		interactionDo: #draggable;
		size: 30.
	v addAll: (sb elementsOn: (TSShape withAllSubclasses) ).
	TSEdgeBuilder arrowedLine 
		withBorderAttachPoint;
		view: v;
		connectFrom: #superclass.
	TSForceBasedLayout new 
		charge: -500; 
		on: v elements.
	v @ TSControlsCanvas.
	^ v
]

{ #category : #lines }
RSLayoutExamples >> example10Locate [
	<script: 'self new example10Locate open'>
	| v shape e1 e2 |
	v := RSView new.
	shape := RSShapeBuilder box
		@ TSDraggable;
		onElement;
		color: TSColorPalette sequential blues3;
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
	v @ TSControlsCanvas.
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
			TSGridLayout on: g.
			g ];
		padding:
			(Margin
				left: 50
				right: 5
				top: 20
				bottom: 5);
		color: Color blue trans.
	elements := shape elementsOn: Collection withAllSubclasses.
	TSGridLayout on: elements.
	v addAll: elements.
	v @ TSControlsCanvas.
	^ v
]

{ #category : #lines }
RSLayoutExamples >> example12AnimatedForceBasedLayout [ 
	<script: 'self new example12AnimatedForceBasedLayout open'>
	| view shape elements layout edges  |
	view := RSView new.
	shape := RSShapeBuilder box
		size: 30;
		interactionDo:[:i | i draggable; labeled].
	elements := shape elementsOn: (1 to: 10).
	edges := TSEdgeBuilder line
		elements: elements;
		connectFrom: [ :i | i // 2 ].
	view
		addAll: edges;
		addAll: elements.
	layout := TSForceBasedLayout new
		length: 80;
		charge: -300;
		nodes: elements;
		edges: view edges;
		start;
		yourself.
	"elements do: [ :e |
		(layout mockElementAt: e) charge: e model * -20 ]."
	view edges do: [ :edge |  (layout mockEdgeAt: edge) length: (edge model key + edge model value) * 10 ].
	view @ TSControlsCanvas.
	
	view @ (TSForceLayoutStepping new layout: layout).
	^ view
]

{ #category : #lines }
RSLayoutExamples >> example13VisualizeQuatree [
	<script: 'self new example13VisualizeQuatree open'>
	| view shape elements layout edges boxBuilder boxes createBoxes colors labelBuilder |
	view := RSView new.
	shape := RSShapeBuilder box
		size: 30;
		interactionDo: [ :i | i draggable; labeled ].
	elements := shape elementsOn: (1 to: 50).
	edges := TSEdgeBuilder line
		elements: elements;
		connectFrom: [ :i | i // 2 ].
	view
		addAll: edges;
		addAll: elements.
	layout := TSForceBasedLayout new
		length: 80;
		charge: -300;
		nodes: elements;
		edges: view edges;
		start;
		yourself.
	view @ TSControlsCanvas.
	view @ (TSForceLayoutStepping new layout: layout).
	colors := TSColorPalette sequential pubu9.
	boxBuilder := RSShapeBuilder box
		border: (TSBorder new color: Color lightGray trans; width: 0.5);
		extent: [ :quad | quad rectangle extent ];
		position: [ :quad | quad rectangle rsCenter ];
		onElement;
		color: [:e | (colors scale: e index) alpha: 0.5 ].
	labelBuilder := RSShapeBuilder label
		text: [:quad | quad charge printShowingDecimalPlaces: 1];
		position: [ :quad | quad rectangle rsCenter ].
	boxes := #().
	createBoxes := nil.
	createBoxes := [ :quad :lvl | | box label |
		box := boxBuilder elementOn: quad index: lvl.
		label := labelBuilder elementOn: quad index: lvl.
		quad subQuadsDo: [ :subQuad | createBoxes value: subQuad value: lvl + 1 ].
		boxes add: box.
		boxes add: label.
		].
	view newAnimation
		repeat;
		duration: 500 milliSeconds;
		when: TSAnimationLoopEvent do: [ :v | 
			boxes do: #remove.
			boxes := TSGroup new.
			createBoxes value: layout currentQuadtree value: 0.
			view addAll: boxes.
			boxes pushBack ].
	^ view
]

{ #category : #lines }
RSLayoutExamples >> example14ClassHierarchy [
	<script: 'self new example14ClassHierarchy open'>
	| v classes es eb eb2 |
	v := RSView new.

	classes := (Object withAllSubclasses first: 300)
		flatCollect: #withAllSuperclasses.
	classes := classes asSet asArray.
	es := RSShapeBuilder circle elementsOn: classes.
	v addAll: es.
	es @ TSPopup @ TSDraggable.
	eb := TSEdgeBuilder line.
	eb color: Color gray.
	eb view: v.
	eb elements: es.
	eb withBorderAttachPoint.
	"eb following: #superclass."
	eb connectFrom: #superclass.
	RSNormalizer size
		elements: es;
		to: 20;
		normalize: #numberOfMethods.
	RSNormalizer color
		elements: es;
		normalize: #numberOfMethods.
	TSClusterLayout on: es.
	eb2 := RSMultiBezierEdgeBuilder multiBezier.
	eb2 borderColor: (Color blue alpha: 0.3).
	eb2 view: v.
	eb2 elements: es.
	eb2 withBorderAttachPoint.
	eb2 following: #superclass.
	eb2 connectToAll: #dependentClasses.
	v @ TSControlsCanvas.
	^ v
]
