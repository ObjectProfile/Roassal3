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
