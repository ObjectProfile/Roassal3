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

	| canvas shapes |
	canvas := RSCanvas new.
	shapes := (1 to: 20) collect: [ :m | 
		RSBox new
			size: m;
			position: (1 to: m) sum asPoint -150;
			draggable;
			color: (m even
				ifTrue: Color red
				ifFalse: Color blue);
			yourself ].
	shapes do: [ :s | s color: (s color alpha: 0.5) ].
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example02Grid [
	<script: 'self new example02Grid open'>

	| canvas shapes |
	canvas := RSCanvas new.
	shapes := Collection withAllSubclasses collect: [ :cls |
		RSBox new
			size: cls numberOfMethods;
			draggable;
			yourself ].
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example03LayoutColorFadingBasic [
	<script: 'self new example03LayoutColorFadingBasic open'>

	| canvas shapes color |
	canvas := RSCanvas new.
	color := NSScale linear
		domain: #(1 20);
		range: {Color red. Color green}.
		
	shapes := (1 to: 20) collect: [ :m |
		RSBox new
			size: m;
			position: (1 to: m) sum asPoint -150;
			draggable;
			color: (color scale: m);
			yourself ].
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example04LayoutColorFadingBasic2 [
	<script: 'self new example04LayoutColorFadingBasic2 open'>

	| canvas shapes color |
	canvas := RSCanvas new.
	color := NSScale linear
		domain: #(1 10 20);
		range: { Color red. Color green. Color blue }";
		interpolate: TSColorHSVAInterpolator".
		
	shapes := (1 to: 20) collect: [ :m |
		RSBox new
			size: m;
			position: (1 to: m) sum asPoint -150;
			draggable;
			color: (color scale: m);
			yourself ].
	canvas addAll: shapes.
	RSGridLayout on: shapes.
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example05LayoutBasicWithColorFading [
	<script: 'self new example05LayoutBasicWithColorFading open'>
	| canvas shapes minAndMax color |
	canvas := RSCanvas new.
	minAndMax := Collection withAllSubclasses inject: { 10000 . 0 } into: [ :res :cls | {res first min: cls numberOfMethods . res second max: cls numberOfMethods}].
	color := NSScale linear
		domain: minAndMax;
		range: { Color green . Color red }.

	shapes := Collection withAllSubclasses collect: [ :cls |
		RSBox new
			size: cls numberOfMethods;
			draggable;
			color: (color scale: cls numberOfMethods);
			yourself ].

	canvas addAll: shapes.
	RSGridLayout on: shapes.
	canvas @ RSDraggableCanvasInteraction.
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example06TreeLayout [
	<script: 'self new example06TreeLayout open'>
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
	eb := RSLineBuilder line.
	eb canvas: c.
	eb connectFrom: #superclass.
	RSTreeLayout on: shapes.
	shapes do: [ :e | e translateBy: 0 @ 0 ].
	c @ RSCanvasController.
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
	eb := RSLineBuilder line.
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
			text: cls;
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
	RSLineBuilder orthoHorizontal
		markerEnd: (RSMarker new 
			offset: 2;
			shape: (RSShapeFactory triangle 
				color: Color black;
				size: 5;
				yourself));
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
		RSShapeFactory square size: 30; draggable; model: cls; yourself ].
	c addAll: shapes.
	RSLineBuilder arrowedLine 
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
	| canvas newshape e1 e2 color |
	canvas := RSCanvas new.
	color := RSColorPalette sequential blues3.
	newshape := [ :m |
		RSBox new
			draggable;
			color: (color scale: m) ;
			size: 100;
			yourself].
	e1 := newshape value: 1.
	e2 := newshape value: 2.
	e2 size: 20.
	RSLocation new
		offset: 1@ -1;
		inner;
		bottom;
		left;
		stick: e2 on: e1.
	canvas addAll:{e1. e2}.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #lines }
RSLayoutExamples >> example11PaddingInComposite [
	<script: 'self new example11PaddingInComposite open'>
	| canvas shapes |
	canvas := RSCanvas new.
	
	shapes := Collection withAllSubclasses collect: [ :cls | | methods |
		methods := cls methods collect: [:met | RSBox new color: Color black; size: 5; yourself ].
		RSGridLayout on: methods.
		RSComposite new
			model: cls;
			popup;
			shapes: methods;
			padding: (Margin
				left: 50
				right: 5
				top: 20
				bottom: 5);
			color: Color blue translucent;
			yourself  ].
	RSGridLayout on: shapes.
	canvas addAll: shapes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #animations }
RSLayoutExamples >> example12AnimatedForceBasedLayout [ 
	<script: 'self new example12AnimatedForceBasedLayout open'>
	| c |
	c := RSCanvas new.
	c addAll: ((1 to: 100) collect: [:i | RSEllipse new size: 10; model: i]).

	RSLineBuilder line
		canvas: c;
		connectFrom: [ :v | v // 2 ].
	c @ RSForceLayoutStepping.
	^ c
]

{ #category : #animations }
RSLayoutExamples >> example13VisualizeQuatree [
	<script: 'self new example13VisualizeQuatree open'>
	| canvas shapes stepping edges newBox boxes createBoxes colors newLabel |
	canvas := RSCanvas new.
	shapes := (1 to: 50) collect: [:n | 
		RSBox new
			size: 30;
			labeled;
			model: n;
			yourself].
	edges := RSLineBuilder line
		shapes: shapes;
		connectFrom: [ :i | i // 2 ].
	canvas
		addAll: edges;
		addAll: shapes.
	stepping := RSForceLayoutStepping new.
	stepping layout
		length: 80;
		charge: -300.
	canvas @ RSCanvasController.
	canvas @ stepping.
	colors := RSColorPalette sequential pubu9.
	newBox := [ :quad :index |
		RSBox new
			border: (RSBorder new color: Color lightGray translucent; width: 0.5);
			extent: quad rectangle extent;
			position: quad rectangle floatCenter;
			color: ((colors scale: index) alpha: 0.5 );
			yourself
			 ]. 
	newLabel := [ :quad :index |
		RSLabel new
			text: (quad charge printShowingDecimalPlaces: 1);
			position: quad rectangle floatCenter;
			yourself.
		 ].
	boxes := #().
	createBoxes := nil.
	createBoxes := [ :quad :lvl | | box label |
		box := newBox value: quad value: lvl.
		label := newLabel value: quad value: lvl.
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
			createBoxes value: stepping layout currentQuadtree value: 0.
			canvas addAll: boxes.
			boxes pushBack ].
	^ canvas
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
		composite @ RSAnimatedPopup @ RSDraggableInteraction.
		composite padding: 10.
		c add: composite ].

	RSLineBuilder line
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
		box @ RSPopup @ RSDraggableInteraction.
		c add: box.
		 ].

	RSLineBuilder line
		canvas: c;
		withVerticalAttachPoint;
		color: Color blue;
		connectFrom: #superclass.

	RSTreeLayout on: c nodes.

	c @ RSCanvasController.
	^ c 
]

{ #category : #animations }
RSLayoutExamples >> example17ForceBasedLayout [
	<script: 'self new example17ForceBasedLayout open'>
	| canvas shapes stepping edges  layout |
	canvas := RSCanvas new.
	shapes := (1 to: 10) collect: [ :m | 
		RSBox new 
			size: 30;
			draggable;
			labeled;
			model: m;
			yourself ].
	edges := RSLineBuilder line
		shapes: shapes;
		connectFrom: [ :i | i // 2 ].
	canvas
		addAll: edges;
		addAll: shapes.
	stepping := RSForceLayoutStepping new.
	
	(layout := stepping layout)
		length: 80;
		charge: -300.
	canvas @ stepping.
	canvas edges do: [ :edge | 
		(layout mockEdgeAt: edge) 
			length: (edge model key + edge model value) * 10 ].
	canvas @ RSCanvasController.
	
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example18Cluster [
	<script: 'self new example18Cluster open'>
	| canvas shapes |
	canvas := RSCanvas new.
	canvas addAll: (#(linear sqrt log) collect: [ :scale | 
		| group |
		group := RSGroup new.
		shapes :=  GLMBrickedMorph withAllSubclasses collect: [ :cls |
			RSEllipse new 
				size: 5;
				draggable;
				color: Color red;
				model: cls;
				yourself ].
		group addAll: shapes.
		RSLineBuilder line
			color: Color blue translucent;
			canvas: group;
			shapes: shapes;
			connectFrom: #superclass.
		
		RSNormalizer size
			scale: (NSScale perform: scale);
			from: 1;
			to: 30;
			shapes: shapes;
			normalize: #numberOfMethods.
		RSNormalizer color
			scale: (NSScale perform: scale);
			from: Color blue;
			to: Color red;
			shapes: shapes;
			normalize: #numberOfMethods.
		RSClusterLayout on: shapes.
		RSComposite new
			color: Color veryLightGray translucent;
			model: scale;
			labeled;
			draggable;
			shapes: group;
			yourself.
		]).
	RSGridLayout new gapSize: 20; on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example19AutomaticLayoutWhenWindowIsResized [
	<script: 'self new example19AutomaticLayoutWhenWindowIsResized open'>
	| classes shapes c eb |
	classes := { 'Roassal3-Layouts'. 'Roassal3' }
		flatCollect: [:pkgname | (RPackage organizer
			packageNamed: pkgname) definedClasses ].
	shapes := RSGroup new.
	classes do: [ :cls | shapes add: (RSEllipse new model: cls) ].

	c := RSCanvas new.
	c addAll: shapes.

	eb := RSLineBuilder orthoVertical.
	eb canvas: c.
	eb connectFrom: #superclass.

	RSNormalizer size
		shapes: shapes;
		normalize: [ :cls | cls numberOfMethods + 5 ].
	RSTreeLayout on: shapes.
	^ c @ RSCanvasController @ RSHierarchyPackerInteraction
]

{ #category : #layouts }
RSLayoutExamples >> example20FlowLayout [
	<script: 'self new example20FlowLayout open extent: 700@500'>
	| words labels canvas menuAnimation high newLabel |
	words := (String loremIpsum: 100) substrings.
	labels := words collectWithIndex: [ :word :index |
		RSLabel new
			text: word;
			fontSize: 10 + ((index % 10)*2);
			underline;
			yourself.
		 ].

	RSFlowLayout on: labels.
	canvas := RSCanvas new.
	canvas addAll: labels.
	menuAnimation := [ :s :d |
		| p |
		p := s
			propertyAt: #opos
			ifAbsentPut: [ s position ].
		canvas newAnimation
			duration: 200 milliSeconds;
			from: s position;
			to: p + d;
			on: s set: #position:].
	high := RSHighlightableInteraction new.
	high 
		when: RSHighlightEvent do: [ :evt | 
			evt shape color: Color blue; underline.
			menuAnimation value: evt shape value: -5@0 ];
		when: RSUnHighlightEvent do: [ :evt |
			evt shape color: Color gray; normal.
			menuAnimation value: evt shape value: 0 ].
		
	newLabel := [ :s |
		canvas add: (RSLabel new
			text: s;
			isFixed: true;
			@ high;
			yourself) ].
	{'FlowTop'. RSFlowLayout new alignTop.
	'FlowMiddle'. RSFlowLayout new alignMiddle.
	'FlowBot'. RSFlowLayout new alignBottom.
	'FlowLabel'. RSFlowLayout new alignLabel.
	'FlowLeft'. RSHorizontalFlowLayout new alignLeft.
	'FlowCenter'. RSHorizontalFlowLayout new alignCenter.
	'FlowRight'. RSHorizontalFlowLayout new alignRight.
	'HorizontalTop'. RSHorizontalLineLayout new alignTop.
	'HorizontalMid'. RSHorizontalLineLayout new alignMiddle.
	'HorizontalBot'. RSHorizontalLineLayout new alignBottom.
	'HorizontalLabel'.RSHorizontalLineLayout new alignLabel.
	'VerticalLeft'. RSVerticalLineLayout new.
	'VerticalCenter'. RSVerticalLineLayout new alignCenter.
	'VerticalRight'. RSVerticalLineLayout new alignRight.
	} pairsDo: [:s :layout | 
		(newLabel value: s)
			when: RSMouseClick do: [ :evt |
				| last current |
				last := labels collect: #position.
				layout on: labels.
				current := labels collect: #position.
				canvas newAnimation
					duration: 1 second;
					onStepDo:[:t | 
						labels doWithIndex: [ :l :i |
							l translateTo: ((last at: i) interpolateTo: (current at: i) at: t) ].
						canvas zoomToFit.
						].
				 ]
		].
	{'Show/Hide Boxes'. [ canvas showRectangles
		ifTrue: [ canvas hideEncompassingRectangles ]
		ifFalse: [ canvas showEncompassingRectangles ]  ].
	'Show/Hide Underlines'. [ labels first isUnderlined
		ifTrue: [ labels do: #normal ]
		ifFalse: [ labels do: #underline ] ].
	} pairsDo: [:s :a |
		(newLabel value: s)
			fontSize: 12;
			when: RSMouseClick do: [ a value. canvas signalUpdate ].
		].
	canvas showEncompassingRectangles.
	RSVerticalLineLayout new gapSize: 3; on: canvas fixedShapes.
	canvas fixedShapes translateBy: 7.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #layouts }
RSLayoutExamples >> example21Spaces [
	<script: 'self new example21Spaces open'>
	| b prop r |
	b := RSForceLayoutInSpaces new.
	b numberOfSpaces: 4.
	b classes: Collection withAllSubclasses.
	b build.
	prop := 0.1.
	r := Random new.
	b canvas newAnimation
		repeat;
		onStepDo: [ :t | | s space |
			r next < 0.01 ifTrue: [ 
				s := b shapes atRandom.
				space := b canvas shapeFromModel: (2 to: b numberOfSpaces) atRandom.
				
				b canvas newAnimation
					duration: 500 milliSeconds;
					from: s position;
					to: space position;
					on: s set: #position:;
					when: RSAnimationEndEvent do: [ b dragEnd: s ].
				].
			 ].
	^ b canvas 
	


]

{ #category : #layouts }
RSLayoutExamples >> example22TreeLayoutEllipses [
	<script: 'self new example22TreeLayoutEllipses open'>
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
	RSNormalizer height
		shapes: shapes;
		normalize: #numberOfMethods.
	RSNormalizer width
		shapes: shapes;
		normalize: [:cls | cls numberOfVariables].
	eb := RSLineBuilder line.
	eb withBorderAttachPoint.
	eb canvas: c.
	eb connectFrom: #superclass.
	RSTreeLayout on: shapes.
	shapes do: [ :e | e translateBy: 0 @ 0 ].
	c @ RSCanvasController.
	^ c
]
