"
I have examples of how to manage the uml builder in different cases
"
Class {
	#name : #RSUMLExamples,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-UML-Examples'
}

{ #category : #examples }
RSUMLExamples >> example01Basic [
	<script: 'self new example01Basic open'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	builder build.
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example02ClassDescriptor [
	<script: 'self new example02ClassDescriptor open'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAbstractLine withAllSubclasses.

	builder modelDescriptor methodsLimit: 5.
	builder renderer edgeBuilder
		cornerRadii: 20.
	builder build.
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example03DifferentLines [
	<script: 'self new example03DifferentLines open'>
	| builder marker |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	marker := (RSShapeFactory arrow
		extent: 20@25;
		noPaint;
		withBorder) asMarker offset: -7.

	builder renderer edgeBuilder: (RSEdgeBuilder verticalBezier
		width: 2;
		dashArray: #(4);
		capRound;
		attachPoint: (RSVerticalAttachPoint new startOffset: 20);
		markerStart: marker).
	builder build.
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example04Nolines [
	<script: 'self new example04Nolines open'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.

	builder layout grid.
	builder build.
	builder canvas edges copy do: #remove.
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example05Horizontal [
	<script: 'self new example05Horizontal open'>
	| builder marker |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	marker := (RSShapeFactory arrow
		extent: 20@25;
		noPaint;
		withBorder) asMarker offset: -7.
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
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example06CustomText [
	<script: 'self new example06CustomText open'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSAttachPoint withAllSubclasses.
	builder renderer: RSDarkUMLClassRenderer new.
	builder build.
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example07TorchRenderer [
	<script: 'self new example07TorchRenderer open'>
	| builder |
	builder := RSUMLClassBuilder new.
	builder classes: RSEvent withAllSubclasses.
	builder renderer: RSTorchUMLClassRenderer new.
	builder build.
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example08HierarchyPacker [
	<script: 'self new example08HierarchyPacker open extent: 900@300'>
	| builder classes |
	builder := RSUMLClassBuilder new.
	classes := { 'Roassal3-Layouts'. 'Roassal3' }
		flatCollect: [:pkgname | (RPackage organizer
			packageNamed: pkgname) definedClasses ].
	builder classes: classes.
	builder renderer: RSTorchUMLClassRenderer new.
	builder build.
	builder canvas @ RSHierarchyPacker.
	^ builder canvas.
]

{ #category : #examples }
RSUMLExamples >> example09Package [
	<script: 'self new example09Package open'>
	| builder |
	builder := RSUMLPackageBuilder new.
	builder packages: { self class package}.
	builder build.
	^ builder canvas
]

{ #category : #examples }
RSUMLExamples >> example10AggregationComposition [
	<script: 'self new example10AggregationComposition open'>
	| builder |
	builder := RSUMLClassBuilder new.
	
	builder classes: #(Band Musician Catalog Product Building Room).
	builder modelDescriptor
		classname: #yourself;
		instVars: #();
		methods: #();
		superclass: nil;
		aggregations: { #Musician -> #Band. #Product -> #Catalog };
		compositions: { #Room -> #Building }.
		
	builder renderer layout flow gapSize: 30.
	builder build.
	^ builder canvas
]
