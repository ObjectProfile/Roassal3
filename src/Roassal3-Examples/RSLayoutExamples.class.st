"
I use the RSShapeBuilder
"
Class {
	#name : #RSLayoutExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #layouts }
RSLayoutExamples >> example01LayoutBasic [
	<script: 'self new example01LayoutBasic'>

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
	v open
	
]

{ #category : #layouts }
RSLayoutExamples >> example02Grid [
	<script: 'self new example02Grid'>

	| v elements |
	v := RSView new.
	elements := RSShapeBuilder box
		size: #numberOfMethods;
		interactionDo: #draggable;
		elementsOn: (Collection withAllSubclasses).

	v addAll: elements.
	RSGridLayout on: elements.
	v open
	
]

{ #category : #layouts }
RSLayoutExamples >> example03LayoutColorFadingBasic [
	<script: 'self new example03LayoutColorFadingBasic'>

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
	v open
	
]

{ #category : #layouts }
RSLayoutExamples >> example04LayoutColorFadingBasic2 [
	<script: 'self new example04LayoutColorFadingBasic2'>

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
	v open
	
]

{ #category : #layouts }
RSLayoutExamples >> example05LayoutBasicWithColorFading [
	<script: 'self new example05LayoutBasicWithColorFading'>

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
	v @ RSDraggableView .
	v open
	
]

{ #category : #layouts }
RSLayoutExamples >> example05TreeLayout [
	<script: 'self new example05TreeLayout'>
	| v elements eb |
	v := RSView new.
	elements := RSShapeBuilder circle
		interactionDo: #draggable;
		elementsOn: Collection withAllSubclasses.
	v addAll: elements.
	RSNormalizer color
		from: (Color gray alpha: 0.5);
		to: (Color red alpha: 0.5);
		elements: elements;
		normalize: #numberOfMethods.
	RSNormalizer size
		elements: elements;
		normalize: #numberOfMethods.
	eb := RSEdgeBuilder line.
	eb view: v.
	eb connectFrom: #superclass.
	RSTreeLayout on: elements.
	elements do: [ :e | e translateBy: 0 @ 0 ].
	v @ RSDraggableView.
	v open
]

{ #category : #layouts }
RSLayoutExamples >> example06Cluster [
	<script: 'self new example06Cluster'>
	| v sb eb |
	v := RSView new.
	sb := RSShapeBuilder circle.
	v addAll: (sb elementsOn: GLMBrickedMorph withAllSubclasses).
	eb := RSEdgeBuilder line
		view: v;
		color: Color blue trans;
		connectFrom: #superclass.
	RSNormalizer size
		scale:
			(TSScale log
				base: 2.7;
				range: {1 . 30});
		elements: v elements;
		normalize: #numberOfMethods.
	RSNormalizer color
		scale:
			(TSScale log
				base: 2.7;
				range:
					{Color blue.
					Color red});
		elements: v elements;
		normalize: #numberOfMethods.
	RSClusterLayout on: v elements.
	v open
]

{ #category : #lines }
RSLayoutExamples >> example07ForceBasedLayout [
	<script: 'self new example07ForceBasedLayout'>
	| v sb eb |
	v := RSView new.
	sb := RSShapeBuilder circle
		interactionDo: [ :i | 
			i
				draggable;
				popup ].
	v addAll: (sb elementsOn: TSShape withAllSubclasses).
	RSNormalizer size
		elements: v elements;
		normalize: #numberOfMethods.
	RSNormalizer color
		from: (Color green alpha: 0.5);
		to: (Color red alpha: 0.5);
		elements: v elements;
		normalize: #numberOfMethods.
	eb := RSEdgeBuilder line.
	eb
		view: v;
		moveBehind;
		connectFrom: #superclass.
	RSForceBasedLayout new
		charge: -350;
		on: v elements.
	v @ RSControlsView.
	v zoomToFit.
	v open
]

{ #category : #lines }
RSLayoutExamples >> example08HorizontalTree [
	<script: 'self new example08HorizontalTree'>
	| v sb label box |
	v := RSView new.
	label := RSShapeBuilder label.
	box := RSShapeBuilder box
		border: TSBorder new;
		cornerRadius: (TSCornerRadius new right: 10);
		extent: [ :lb | lb extent + 5 ].
	sb := RSShapeBuilder composite
		interactionDo: #draggable;
		shapes: [ :m | | l |
			l := label elementOn: m.
			TSGroup with: (box elementOn: l) with: l].
	v addAll: (sb elementsOn: String withAllSubclasses).
	v @ RSControlsView.
	RSEdgeBuilder orthoHorizontal
		markerEnd: (TSMarker new 
			offset: 2;
			shape: (RSShapeBuilder triangle 
				color: Color black;
				size: 5;
				element));
		attachPoint: RSHorizontalAttachPoint new; 
		view: v;
		elements: v elements;
		connectFrom: #superclass.
	RSHorizontalTreeLayout new on: v elements.
	v open setLabel: 'Horizontal Tree'
]

{ #category : #lines }
RSLayoutExamples >> example09BorderAttachPoint [
	<script: 'self new example09BorderAttachPoint'>
	| v sb |
	v := RSView new.
	sb := RSShapeBuilder square 
		interactionDo: #draggable;
		size: 30.
	v addAll: (sb elementsOn: (TSShape withAllSubclasses) ).
	RSEdgeBuilder arrowedLine 
		withBorderAttachPoint;
		view: v;
		connectFrom: #superclass.
	RSForceBasedLayout new 
		charge: -500; 
		on: v elements.
	v @ RSControlsView.
	v open setLabel: 'TSShape withAllSubclasses'
]

{ #category : #lines }
RSLayoutExamples >> example10Locate [
	<script: 'self new example10Locate'>
	| v shape e1 e2 |
	v := RSView new.
	shape := RSShapeBuilder box
		@ RSDraggable;
		onElement;
		color: TSColorPalette sequential blues3;
		size: 100.
	e1 := shape element.
	"e1 @ RSDraggable."
	e2 := shape element.
	e2 size: 20.
	RSLocate new
		offset: 1@ -1;
		inner;
		bottom;
		left;
		stick: e2 on: e1.
	v addAll:{e1. e2}.
	v @ RSControlsView.
	v open
]

{ #category : #lines }
RSLayoutExamples >> example11PaddingInComposite [
	<script: 'self new example11PaddingInComposite'>
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
	v @ RSControlsView.
	v open
]
