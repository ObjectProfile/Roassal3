"
I have examples of how to manage the uml builder in different cases
"
Class {
	#name : #RSUMLExamples,
	#superclass : #RS3Object,
	#category : #'Roassal3-UML-Examples'
}

{ #category : #examples }
RSUMLExamples >> example01Basic [ 
	<script: 'self new example01Basic'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	builder build.
	builder open
]

{ #category : #examples }
RSUMLExamples >> example02ClassDescriptor [
	<script: 'self new example02ClassDescriptor'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAbstractLine withAllSubclasses.
	
	builder modelDescriptor 
		methods: [ :cls | | methods |
			methods := cls methods sorted: [ :a :b |
				a selector < b selector ].
			methods copyFrom: 1
			to: (methods size min: 5 ) ].
	builder renderer edgeBuilder
		cornerRadii: 20.
	builder build.
	builder open
]

{ #category : #examples }
RSUMLExamples >> example03DifferentLines [
	<script: 'self new example03DifferentLines'>
	| builder marker |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	marker := (RSShapeBuilder arrow
		extent: 20@25;
		noPaint;
		withBorder;
		element) asMarker offset: -7.
	builder renderer edgeBuilder: (RSEdgeBuilder verticalBezier
		width: 2;
		dashArray: #(4);
		capRound;
		attachPoint: (RSVerticalAttachPoint new startOffset: 20);
		markerStart: marker).
	builder build.
	builder open
]

{ #category : #examples }
RSUMLExamples >> example04Nolines [
	<script: 'self new example04Nolines'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	builder renderer marker: ((RSShapeBuilder arrow
		extent: 20@25;
		color: Color black;
		element) asMarker offset: 25/2).
	
	builder layout grid.
	builder build.
	builder view edges copy do: #remove."ugly, maybe later #noEdges or something like that"
	builder open
]

{ #category : #examples }
RSUMLExamples >> example05Horizontal [
	<script: 'self new example05Horizontal'>
	| builder marker |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	marker := (RSShapeBuilder arrow
		extent: 20@25;
		noPaint;
		withBorder;
		element) asMarker offset: -7.
	builder renderer edgeBuilder: (RSEdgeBuilder horizontalBezier
		width: 2;
		dashArray: #(4);
		capRound;
		attachPoint: (RSHorizontalAttachPoint new startOffset: 20);
		markerStart: marker).
	builder layout horizontalTree
		verticalGap: 50;
		horizontalGap: 100.
	builder build.
	builder open
]

{ #category : #examples }
RSUMLExamples >> example06CustomText [
	<script: 'self new example06CustomText'>
	| builder renderer c1 |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	c1 := Color r: 0.130 g: 0.130 b: 0.130.
	builder view color: c1.
	renderer := builder renderer.
	renderer classBoxShape color: c1.
	renderer marker shape color: c1.
	renderer border
		width: 2;
		color: Color white.
	renderer classNameShape: (RSShapeBuilder composite shapes: [:cls | 
		| title g |
		g := RSGroup new.
		title := RSShapeBuilder label fontSize: 20; color: Color white; elementOn: cls.
		g add: title.
		cls hasAbstractMethods ifTrue: [ 
			g addFirst: (RSShapeBuilder label color: Color magenta; italic; elementOn: '<<Abstract>>')
			 ].
		RSVerticalLineLayout new center; gapSize: 0; on: g.
		g ]).
	renderer methodShape 
		color: Color white;
		if: #isOverridden then: [ :s | s color: Color cyan ].
	renderer varShape 
		color: Color white.
	builder build.
	builder open
]

{ #category : #examples }
RSUMLExamples >> example07TorchRenderer [
	<script: 'self new example07TorchRenderer'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: Collection withAllSubclasses.
	builder renderer: RSTorchUMLClassRenderer new.
	builder build.
	builder open
]

{ #category : #examples }
RSUMLExamples >> example08HierarchyPacker [
	<script: 'self new example08HierarchyPacker'>
	| builder classes |
	builder := RSUMLClassBuilder new.
	classes := { 'Roassal3-Layouts'. 'Roassal3-Trachel' }
		flatCollect: [:pkgname | (RPackage organizer 
			packageNamed: pkgname) definedClasses ].
	builder classes: classes.
	builder renderer: RSTorchUMLClassRenderer new.
	builder build.
	builder view @ RSHierarchyPacker.
	builder view open
		extent: 900@300.
]

{ #category : #examples }
RSUMLExamples >> example09Package [
	<script: 'self new example09Package'>
	| builder |
	builder := RSUMLPackageBuilder new.
	builder packages: (Array with: self class package).
	builder renderer: RSBasicUMLPackageRenderer new.
	builder build.
	builder open
]
