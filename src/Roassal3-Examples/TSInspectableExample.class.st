"
I have examples of different ways to inspect views an objects in roassal3
"
Class {
	#name : #TSInspectableExample,
	#superclass : #RSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #examples }
TSInspectableExample >> example01SimpleExample [
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
	RSEdgeBuilder line
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
		builder open ].
	"inspectable inspectElementBlock: [ :cls | GTInspector openOn: cls ]."
	boxes @ inspectable.
	canvas @ RSControlsCanvas.
	^ canvas
]

{ #category : #examples }
TSInspectableExample >> example02Inspect [
	<script: 'self new example02Inspect inspect'>
	
	| view animation lastSize box color |
	view := RSView new.
	color := TSScale category20c.
	box := [ :model | RSElement new
		model: model; 
		shape: (RSBox new
			color: (color scale: model) ;
			yourself);
		size: 20;
		yourself ].
	
	view add: (box value: Collection).
	lastSize := 0.
	animation := nil.
	animation := view animationFrom: { 
		view tAnimation repeat
		easing: RSEasing backOut;
		onStepDo: [ :t |
			view elements do: [ :e |
				| att a b |
				att := e attributes.
				a := att at: #old ifAbsentPut: [ e position ].
				b := att at: #new ifAbsentPut: [ e position ].
				e translateTo: (a interpolateTo: b at: t ) ].
			view zoomToFit.
			 ];
		when: RSAnimationLoopEvent do: [ 
			view elements size = lastSize ifTrue: [ 
				animation stop.
				self inform: 'Done :V!!!' ].
			lastSize := view elements size.
			view elements do: [ :e |
				e outgoingEdges ifEmpty: [ | children |
					children := e model subclasses collect: [:cls | box value: cls ].
					children do: [ :child | child position: e position ].
					view addAll: children ]. ].
			
			view edges copy do: #remove.
			view elements do: [:e |
				e attributes at: #old put: e position ].
			RSEdgeBuilder arrowedLine 
				view: view;
				connectFrom: #superclass.
			view elements do: #updateEdgesOFF.
			RSClusterLayout on: view elements.
			view elements do: #updateEdgesON.
			view elements do: [:e |
				e attributes at: #new put: e position. ].
		 ]}.
	view @ RSControlsCanvas.
	^ view
]

{ #category : #examples }
TSInspectableExample >> example03Easing [
	<script: 'self new example03Easing inspect'>
	^ RSEasing bounceOut
]
