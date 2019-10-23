"
I have examples of different ways to inspect views an objects in roassal3
"
Class {
	#name : #TSInspectableExample,
	#superclass : #TSAbstractExamples,
	#category : #'Roassal3-Examples-Basic'
}

{ #category : #examples }
TSInspectableExample >> example01SimpleExample [
	<script: 'self new example01SimpleExample open'>
	| classes view boxes inspectable highligtable edges |
	classes := Collection withAllSubclasses.
	view := RSView new.
	boxes := classes collect: [ :cls | 
		RSElement new
			model: cls;
			shape: (TSBox new
				width: (cls instVarNames size * 5 max: 5);
				height: (cls numberOfMethods max: 5);
				yourself);
			yourself ] as: TSGroup.
	view addAll: boxes.
		
	edges := RSEdgeBuilder line
		view: view;
		objects: classes;
		withVerticalAttachPoint;
		connectFrom: #superclass.
	view addAll: edges.
	TSTreeLayout on: boxes.
	TSInspectable reset.
	inspectable := TSInspectable new.
	highligtable := inspectable highlightable.
	highligtable highlightShape color: Color green.
	inspectable
		inspectShapeBlock: [ :cls | 
			| builder |
			builder := RSUMLClassBuilder new.
			builder classes: {cls}.
			builder build.
			builder open ].
	"inspectable inspectElementBlock: [ :cls | GTInspector openOn: cls ]."
	boxes @ inspectable.
	view @ TSControlsCanvas.
	^ view
]

{ #category : #examples }
TSInspectableExample >> example02Inspect [
	<script: 'self new example02Inspect inspect'>
	
	| view animation lastSize box color |
	view := RSView new.
	color := TSScale category20c.
	box := [ :model | RSElement new
		model: model; 
		shape: (TSBox new
			color: (color scale: model) ;
			yourself);
		size: 20;
		yourself ].
	
	view add: (box value: Collection).
	lastSize := 0.
	animation := nil.
	animation := view animationFrom: { 
		view tAnimation repeat
		easing: TSEasing backOut;
		onStepDo: [ :t |
			view elements do: [ :e |
				| att a b |
				att := e attributes.
				a := att at: #old ifAbsentPut: [ e position ].
				b := att at: #new ifAbsentPut: [ e position ].
				e translateTo: (a interpolateTo: b at: t ) ].
			view zoomToFit.
			 ];
		when: TSAnimationLoopEvent do: [ 
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
			TSClusterLayout on: view elements.
			view elements do: #updateEdgesON.
			view elements do: [:e |
				e attributes at: #new put: e position. ].
		 ]}.
	view @ TSControlsCanvas.
	^ view
]

{ #category : #examples }
TSInspectableExample >> example03Easing [
	<script: 'self new example03Easing inspect'>
	^ TSEasing bounceOut
]
