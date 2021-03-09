"
I have examples of different ways to inspect views an objects in roassal3
"
Class {
	#name : #RSInspectableExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #examples }
RSInspectableExample >> example01SimpleExample [
	<script: 'self new example01SimpleExample open'>
	| canvas boxes inspectable highligtable |
	canvas := RSCanvas new.
	boxes := Collection withAllSubclasses collect: [ :cls | 
		RSBox new
			model: cls;
			width: (cls instVarNames size * 5 max: 5);
			height: (cls numberOfMethods max: 5);
			yourself] as: RSGroup.
	canvas addAll: boxes.
	RSLineBuilder line
		canvas: canvas;
		shapes: boxes;
		withVerticalAttachPoint;
		connectFrom: #superclass.
	RSTreeLayout on: boxes.
	RSInspectable reset.
	inspectable := RSInspectable new.
	highligtable := inspectable highlightable.
	highligtable highlightColor: Color green.
	inspectable inspectShapeBlock: [ :cls | 
		| builder |
		builder := RSUMLClassBuilder new.
		builder classes: {cls}.
		builder build.
		builder canvas open ].
	"inspectable inspectElementBlock: [ :cls | GTInspector openOn: cls ]."
	boxes @ inspectable.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSInspectableExample >> example02Inspect [
	<script: 'self new example02Inspect inspect'>
	
	| canvas animation lastSize box color |
	canvas := RSCanvas new.
	color := NSScale category20c.
	box := [ :model |
		RSBox new
			model: model;
			color: (color scale: model);
			size: 20;
		yourself ].
	
	canvas add: (box value: Collection).
	lastSize := 0.
	animation := nil.
	animation := canvas animationFrom: { 
		canvas transitionAnimation repeat
		easing: RSEasing backOut;
		onStepDo: [ :t |
			canvas nodes do: [ :shape |
				| att a b |
				att := shape properties.
				a := att at: #old ifAbsentPut: [ shape position ].
				b := att at: #new ifAbsentPut: [ shape position ].
				shape translateTo: (a interpolateTo: b at: t ) ].
			canvas zoomToFit.
		];
		when: RSAnimationLoopEvent do: [ 
			canvas nodes size = lastSize ifTrue: [ 
				animation stop.
				self inform: 'Done :V!!!' ].
			lastSize := canvas nodes size.
			canvas nodes do: [ :shape |
				shape outgoingEdges ifEmpty: [ | children |
					children := shape model subclasses collect: [:cls | box value: cls ].
					children do: [ :child | child position: shape position ].
					canvas addAll: children ]. ].
			
			canvas edges copy do: #remove.
			canvas nodes do: [:shape | shape propertyAt: #old put: shape position ].
			RSLineBuilder arrowedLine 
				canvas: canvas;
				connectFrom: #superclass.
			canvas nodes do: #updateEdgesOFF.
			RSClusterLayout on: canvas nodes.
			canvas nodes do: #updateEdgesON.
			canvas nodes do: [:shape | shape propertyAt: #new put: shape position. ].
		 ]}.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSInspectableExample >> example03Easing [
	<script: 'self new example03Easing inspect'>
	^ RSEasing bounceOut
]

{ #category : #examples }
RSInspectableExample >> example04ChagingContext [
	<script: 'self new example04ChagingContext inspect'>
	| c context int |
	c := RSCanvas new.
	1 to: 100 do: [ :i |
		c add: (RSBox new size: 10; model: i) ].
	c shapes @ RSDraggable.
	RSGridLayout on: c shapes.
	c @ RSCanvasController.
	
	"This is the default context for the inspector"
	context := RSInteractiveContext new.
	int := context interactionsToBeRegistered detect: [ :i | i class = RSSelectionPresentation ].
	int 
		padding: 5;
		shadowColor: (Color red alpha: 0.1).
	c inspectorContext: context.
	
	^ c
]
