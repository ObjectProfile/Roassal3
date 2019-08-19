"
I have examples of different ways to inspect views an objects in roassal3
"
Class {
	#name : #RSInspectableExample,
	#superclass : #RSObject,
	#category : #'Roassal3-Inspector-Examples'
}

{ #category : #examples }
RSInspectableExample >> example01SimpleExample [
	<script: 'self new example01SimpleExample'>
	| classes v shape elements inspectable highligtable |
	classes := Collection withAllSubclasses.
	v := RSView new.
	shape := RSShapeBuilder box
		popup;
		width: [ :cls | cls instVarNames size * 5 max: 5 ];
		height: [ :cls | cls numberOfMethods max: 5 ].
	elements := shape elementsOn: classes.
	v addAll: elements.
	RSEdgeBuilder line
		view: v;
		objects: classes;
		withVerticalAttachPoint;
		connectFrom: #superclass.
	RSTreeLayout on: elements.
	RSInspectable reset.
	inspectable := RSInspectable new.
	highligtable := inspectable highlightable.
	highligtable highlightShape color: Color green.
	inspectable
		inspectElementBlock: [ :cls | 
			| builder |
			builder := RSUMLClassBuilder new.
			builder classes: {cls}.
			builder build.
			builder open ].
	"inspectable inspectElementBlock: [ :cls | GTInspector openOn: cls ]."
	elements @ inspectable.
	v @ RSControlsView.
	v open
]

{ #category : #examples }
RSInspectableExample >> example02Inspect [
	<script: 'self new example02Inspect'>
	| view box animation lastSize |
	view := RSView new.
	box := RSShapeBuilder box
		color: TSScale category20c;
		popup;
		draggable;
		size: 20.
	
	view add: (box elementOn: Collection).
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
					children := box elementsOn: e model subclasses.
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
	view @ RSControlsView.
	view inspect
]

{ #category : #examples }
RSInspectableExample >> example03Easing [
	<script: 'self new example03Easing'>
	TSEasing bounceOut inspect.
	
]
