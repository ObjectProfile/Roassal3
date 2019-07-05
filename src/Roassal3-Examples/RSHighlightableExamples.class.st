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
