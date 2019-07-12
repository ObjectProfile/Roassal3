"
Basic examples about highlighting
"
Class {
	#name : #RSHighlightableExamples,
	#superclass : #RSObject,
	#category : #'Roassal3-Examples'
}

{ #category : #examples }
RSHighlightableExamples >> example01Basic [
	<script: 'self new example01Basic'>
	| v s elements |
	v := RSView new.
	s := RSShapeBuilder box
		size: 10;
		draggable;
		border: TSBorder new;
		@ RSHighlightable;
		color: TSColorPalette sequential bupu3.
	elements := s elementsOn: (1 to: 20).
	RSEdgeBuilder line
		elements: elements;
		addInteraction: RSHighlightable;
			view: v;
		connectFrom: [ :n | n // 2 ].
	v addAll: elements.
	RSClusterLayout on: elements.
	v zoomToFit.
	v open
]

{ #category : #examples }
RSHighlightableExamples >> example02ElementEdges [
	<script: 'self new example02ElementEdges'>
	| v s elements |
	v := RSView new.
	
	s := RSShapeBuilder box
		size: 10;
		draggable;
		border: TSBorder new;
		color: TSColorPalette diverging rdylbu3;
		addInteraction: RSHighlightable new withEdges.
	elements := s elementsOn: (1 to: 20).
	RSEdgeBuilder line
		elements: elements;
		addInteraction: RSHighlightable;
		view: v;
		connectFrom: [ :n | n // 2 ].
	v addAll: elements.
	RSClusterLayout on: elements.
	v zoomToFit.
	v open
]

{ #category : #'examples - animated' }
RSHighlightableExamples >> example03Interactive [
	<script: 'self new example03Interactive'>
	| v s elements interaction update |
	v := RSView new.
	
	s := RSShapeBuilder box
		size: 10;
		draggable;
		border: TSBorder new;
		color: TSColorPalette diverging rdylbu3.
	elements := s elementsOn: (1 to: 20).
	RSEdgeBuilder line
		elements: elements;
		view: v;
		connectFrom: [ :n | n // 2 ].
	v addAll: elements.
	RSClusterLayout on: elements.
	
	interaction := RSHighlightable new withEdges.
	update := [ interaction doHighlight: elements atRandom ].
	update value.
	v newAnimation repeat  when: TSAnimationLoopEvent do: update.
	
	v zoomToFit.
	v open
]

{ #category : #'examples - animated' }
RSHighlightableExamples >> example04Interactive [
	<script: 'self new example04Interactive'>
	| v s elements interaction bool update |
	v := RSView new.
	
	s := RSShapeBuilder box
		size: 10;
		draggable;
		border: TSBorder new;
		color: TSColorPalette diverging rdylbu3.
	elements := s elementsOn: (1 to: 20).
	RSEdgeBuilder line
		elements: elements;
		view: v;
		connectFrom: [ :n | n // 2 ].
	v addAll: elements.
	RSClusterLayout on: elements.
	
	interaction := RSHighlightable new.
	bool := true.
	interaction recordElements: v elements, v edges.
	update := [
		interaction unhighlightRecordedElements: v.
		interaction doHighlightElements: (elements select: [ :e | bool 
				ifTrue: [ e model even ]
				ifFalse: [ e model odd ] ]).
		bool := bool not ].
	update value.
	v newAnimation repeat when: TSAnimationLoopEvent do: update.
	v zoomToFit.
	v open
]

{ #category : #examples }
RSHighlightableExamples >> example05Border [
	<script: 'self new example05Border'>
	| v s elements int |
	v := RSView new.
	s := RSShapeBuilder box
		size: 10;
		draggable;
		border: TSBorder new;
		color: TSColorPalette sequential bupu3.
	elements := s elementsOn: (1 to: 20).
	RSEdgeBuilder line
		elements: elements;
			view: v;
		connectFrom: [ :n | n // 2 ].
	int := RSHighlightable new.
	int noDefaultColor.
	int highlightShape border: (TSBorder new width: 2).
	elements @ int.
	v addAll: elements.
	RSClusterLayout on: elements.
	v zoomToFit.
	v open
]

{ #category : #examples }
RSHighlightableExamples >> example06IterateNext [
	<script: 'self new example06IterateNext'>
	
	| view numbers edges layout legendBuilder highlightableForBoxes highlightableForLabels selectedNumber highlightBlock unhighlightAllBlock |
	view := RSView new.
	legendBuilder := RSLegendBuilder new view: view. 

	"Create the view with numbers as elements."
	numbers := RSShapeBuilder box
		size: 30;
		addInteraction: RSLabeled new;
		elementsOn: (1 to: 10).
	edges := RSEdgeBuilder line
		elements: numbers;
		connectFrom: [ :i | i // 2 ].
	view
		addAll: edges;
		addAll: numbers.
	layout := RSForceBasedLayout new
		length: 80;
		charge: -300;
		nodes: numbers;
		edges: view edges;
		start;
		yourself.
	view newAnimation repeat onStepDo: [ :t | layout step ].
	numbers @ (RSDraggableForce new layout: layout).

	"Set up highlighting interactions"
	highlightableForBoxes := RSHighlightable new.
	highlightableForLabels := RSHighlightable new
		noDefaultColor;
		attributeKey: #exampleKey;
		when: TSHighlightEvent do: [ :evt | evt element bold ];
		when: TSUnHighlightEvent do: [ :evt | evt element normal ].
	highlightBlock := [ :model |
		highlightableForBoxes doHighlight: (view elementFromModel: model).
		highlightableForLabels doHighlight: (legendBuilder elements elementFromModel: model).
		selectedNumber := model ].
	unhighlightAllBlock := [
		highlightableForBoxes unhighlightRecordedElements: view.
		highlightableForLabels unhighlightRecordedElements: view ].

	"Build a legend with all the numbers"
	legendBuilder shape border: TSBorder new.
	legendBuilder defLabel 
		onElement;
		when: TSMouseClick do: [ :e | [ highlightBlock value: e model ] ].
	legendBuilder location 
		outer; right; offset: 70@ -200.
	numbers do: [ :e | 
		legendBuilder text: e model.
		e when: TSMouseClick do: [ :evt | highlightBlock value: e model ]. ].
	legendBuilder build.

	"Unhighlight all when clicking on background."
	view when: TSMouseClick do: unhighlightAllBlock.

	"Highlight next number when N key is pressed. Initial is nothing."
	selectedNumber := 0.
	view when: TSKeyUp do: [ :evt |
		evt keyValue = 45 ifTrue: [
			selectedNumber := (selectedNumber \\ numbers size) + 1.
			highlightBlock value: selectedNumber ] ].

	view open.
]
