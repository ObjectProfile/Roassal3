"
I use the RSShapeBuilder
"
Class {
	#name : #RoassalShapeExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #layouts }
RoassalShapeExamples >> example11LayoutBasicWithColorFading [
	<script: 'self new example11LayoutBasicWithColorFading'>

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
RoassalShapeExamples >> example12TreeLayout [
	<script: 'self new example12TreeLayout'>
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
