"
read 

https://graphviz.org/
"
Class {
	#name : #RSGraphVizExamples,
	#superclass : #Object,
	#category : #'Roassal3-GraphViz-Example'
}

{ #category : #examples }
RSGraphVizExamples >> example01Basic [
	<script: 'self new example01Basic'>

	| process |
	process := OSSUnixSubprocess new
		command: RSGraphvizLayout commandLocation;
		arguments: {'-Tjson'};
		workingDirectory: FileLocator home fullName;
		addAllEnvVariablesFromParentWithoutOverride;
		redirectStdout;
		redirectStderr;
		redirectStdin;
		run.

	process stdinStream
		nextPutAll: '
	digraph G {Hello->World}
	';
		close.
	process waitForExit.
	process stdoutStream upToEndOfFile inspect.
	process closeAndCleanStreams
]

{ #category : #examples }
RSGraphVizExamples >> example02Basic [
	"<script: 'self new example02Basic'>"
	"this is just an idea for a future example"
	true ifTrue: [ ^ self ].
	RSGraphVizExamples fromString: '
## "It encodes the so-called philosophers dilemma.  Neato pretty much approximates the way how humans would layout the graph." Contributed by Manfred Jeusfield.
## Command to generate the layout: "neato -Tpng thisfile > thisfile.png"


digraph PhiloDilemma {
node [shape=box];  bec3; rel3; bec2; rel2; acq2; acq3; bec1; rel1; acq1;
node [shape=circle,fixedsize=true,width=0.9];  hu3; th3; ri3; ea3; hu2; th2; ri2; ea2; hu1; th1; ri1; ea1;
ri3->acq2;
ri3->acq3;
hu3->acq3;
bec3->hu3;
th3->bec3;
rel3->th3;
rel3->ri3;
ea3->rel3;
acq3->ea3;
ri2->acq1;
ri2->acq2;
hu2->acq2;
bec2->hu2;
th2->bec2;
rel2->th2;
rel2->ri2;
ea2->rel2;
acq2->ea2;
ri1->acq3;
ri1->acq1;
hu1->acq1;
bec1->hu1;
th1->bec1;
rel1->th1;
rel1->ri1;
ea1->rel1;
acq1->ea1;

overlap=false
label="PetriNet Model PhiloDilemma\nExtracted from ConceptBase and layed out by Graphviz "
fontsize=12;
}
' "a RSComposite"

"canvas asDOT.""aString"

"RSGraphVizLayout on: canvas shapes."
]

{ #category : #examples }
RSGraphVizExamples >> example03Basic [
	<script: 'self new example03Basic'>
	| canvas node converter process |
	canvas := RSCanvas new.
	node := [ :str | | ellipse label |
		ellipse := RSEllipse new withBorder; noPaint.
		label := RSLabel new text: str.
		ellipse extent: label extent + 20.
		RSComposite new
			model: str;
			children: {ellipse. label };
			yourself ].
	canvas add: (node value: 'Hello').
	canvas add: (node value: 'World').
	canvas nodes @ RSDraggable.
	canvas add: (RSArrowedLine new
		withBorderAttachPoint;
		from: canvas nodes first;
		to: canvas nodes second;
		yourself).
	converter := RSNeatoDotConverter new.
	canvas accept: converter.

	process := OSSUnixSubprocess new
		command: RSGraphvizLayout commandLocation;
		arguments: {'-Tsvg'};
		workingDirectory: FileLocator home fullName;
		addAllEnvVariablesFromParentWithoutOverride;
		redirectStdout;
		redirectStderr;
		redirectStdin;
		run.

	process stdinStream
		nextPutAll: converter stream contents;
		close.
	process waitForExit.
	process stdoutStream upToEndOfFile inspect.
	process closeAndCleanStreams.
	canvas open
]

{ #category : #examples }
RSGraphVizExamples >> example04Layout [
	<script: 'self new example04Layout'>
	| canvas node |
	canvas := RSCanvas new.
	node := [ :str | | ellipse label |
		ellipse := RSEllipse new withBorder; noPaint.
		label := RSLabel new text: str.
		ellipse extent: label extent + 20.
		RSComposite new
			model: str;
			children: {ellipse. label };
			yourself ].
	canvas add: (node value: 'Hello').
	canvas add: (node value: 'World').
	canvas nodes @ RSDraggable.
	canvas add: (RSArrowedLine new
		withBorderAttachPoint;
		from: canvas nodes first;
		to: canvas nodes second;
		yourself).
	RSGraphvizLayout on: canvas nodes.
	canvas open
]

{ #category : #examples }
RSGraphVizExamples >> example05Layout [
	<script: 'self new example05Layout'>
	| canvas node labeled |
	canvas := RSCanvas new.

	node := [ :str | | label |
		label := RSLabel new text: str.
		RSBox new
			model: str;
			extent: label extent + 20;
			noPaint;
			withBorder;
			draggable;
			yourself ].

	Collection withAllSubclassesDo: [ :cls |
		canvas add: (node value: cls name).
		 ].

	RSEdgeBuilder arrowedLine
		canvas: canvas;
		withBorderAttachPoint;
		shapes: canvas nodes;
		connectFrom: [:str | (Smalltalk globals at: str asSymbol) superclass name ].

	RSGraphvizLayout twoPi on: canvas nodes.
	labeled := RSLabeled new.
	labeled location center; middle.
	canvas nodes @ labeled.
	canvas @ RSCanvasController.
	canvas open
]

{ #category : #examples }
RSGraphVizExamples >> example06UniFamilyTree [
	<script: 'self new example06UniFamilyTree inspect'>
	| canvas nodeBlock labeled edges nodes baseline |
	canvas := RSCanvas new.

	nodeBlock := [ :str | | label |
		label := RSLabel new text: str.
		RSEllipse new
			model: str;
			extent: label extent + 20;
			color: Color white;
			withBorder;
			draggable;
			yourself ].
	edges := self unixFamilyTree.
	nodes := (edges collect: [ :asso | asso key ] as: Set).
	nodes := nodes addAll: (edges collect: [ :asso | asso value ] as: Set).
	canvas addAll: (nodes collect: nodeBlock).
	labeled := RSLabeled new.
	labeled location center; middle.
	canvas nodes @ labeled.
	baseline := RSGraphvizLine new.

	(RSEdgeBuilder new: baseline)
		canvas: canvas;
		shapes: canvas nodes;
		useAssociations: edges.
	RSGraphvizLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #examples }
RSGraphVizExamples >> example07UniFamilyTreeAnimated [
	<script: 'self new example07UniFamilyTreeAnimated'>
	| canvas nodes com paint base icon show hide animation high labelAnimation force |
	canvas := self example06UniFamilyTree.
	nodes := canvas nodes copy.
	canvas edges pushBack.
	com := RSComposite new.
	com add: (RSLabel new
		fontName: 'Courier';
		color: Color white;
		fontSize: 20;
		text: 'Roassal layouts').
	high := RSHighlightable new.
	labelAnimation := [ :shape :color :delta | | pos |
		shape color: color.
		pos := shape
			propertyAt: #position
			ifAbsentPut: [ shape position ].
		canvas newAnimation
			duration: 200 milliSeconds;
			from: shape position;
			to: pos + delta;
			on: shape set: #position:.
		 ].
	high
		when: RSHighlightEvent do: [ :evt |
			labelAnimation value: evt shape value: Color black value: -5@0.
			 ];
		when: RSUnHighlightEvent do: [:evt |
			labelAnimation value: evt shape value: Color white value: 0@0. ].
	force := RSForceBasedLayout new.
	force charge: -600; length: 100; doNotUseProgressBar.
	com addAll: ({
		'Tree' -> RSTreeLayout new.
		'Force Based' -> force.
		'Sugiyama' -> RSSugiyamaLayout new.
		'GraphViz strict' -> RSGraphvizLayout strict.
		'GraphViz neato' -> RSGraphvizLayout neato.
		'GraphViz digraph' -> RSGraphvizLayout digraph.
		'GraphViz twoPi' -> RSGraphvizLayout twoPi.  }
		collect: [ :assoc | | name layout |
			layout := assoc value.
			name := assoc key.
			RSLabel new
				color: Color white;
				fontName: 'Courier';
				when: RSMouseClick do: [ :evt |
					| fromPos toPos allPoints |
					canvas edges do: [ :ed | ed removeKey: #points ].
					fromPos := nodes collect: #position.
					layout on: nodes.
					toPos := nodes collect: #position.
					allPoints := canvas edges collect: [ :ed | ed propertyAt: #points ].
					canvas edges do: [ :ed | ed removeKey: #points ].
					canvas newAnimation
						duration: 3 seconds;
						onStepDo: [ :t |
							nodes doWithIndex: [ :node :index | | from to |
								from := fromPos at: index.
								to := toPos at: index.
								node translateTo: (from interpolateTo: to at: t)
								].
							canvas zoomToFit.
							].
					allPoints first ifNotNil: [
						canvas newAnimation
							delay: 3 seconds;
							duration: 1 second;
							easing: (RSEasingInterpolator elasticOut period: 0.30; amplitude: 1.3);
							onStepDo: [ :t |
								canvas edges doWithIndex: [ :ed :index|
									| newPoints |
									newPoints := allPoints at: index.
									newPoints := newPoints collectWithIndex: [ :p :i |
										| temp |
										temp := i >= (newPoints size / 2)
											ifTrue: [ newPoints last ]
											ifFalse: [ newPoints first ].
										temp interpolateTo: p at: t
										].
									ed propertyAt: #points put: newPoints.
									ed resetPath.
									canvas signalUpdate. ]
								 ].
						 ].
					 ];
				@ high;
				text: name.
		]).
	RSVerticalLineLayout on: com children.
	com
		adjustToChildren;
		padding: 20;
		translateBy: 10;
		isFixed: true.
	paint := LinearGradientPaint fromArray:
		{0->((Color colorFrom: '30cfd0') alpha: 0.8).
		1->((Color colorFrom: '330867') alpha:0.8) }.
	base := com baseRectangle.
	paint start: base topCenter; stop: base bottomCenter.
	com paint: paint.
	canvas add: com.
	com propertyAt: #position put: com position.
	icon := RSBitmap new form: (self iconNamed: #hierarchy).
	icon translateTo: 10@10.
	icon isFixed: true.
	animation :=  [ :pre :order :easing :post|
		high unhighlightRecordedShapes: canvas.
		(com hasProperty: #anime) ifFalse: [
			| anime ext pos |
			pre value.

			ext := NSScale linear
				range: (order value: {1@1. icon extent / base extent}).
			pos := NSScale linear
				range: (order value: { com propertyAt: #position. icon position }).
			anime := canvas newAnimation
				easing: (easing value: RSEasingInterpolator );
				duration: 500 milliSeconds;
				onStepDo: [ :t | | e p |
					e := ext scale: t.
					p := pos scale: t.
					com matrix
						loadIdentity;
						scaleBy: e;
						translation: p.
					canvas signalUpdate.
					  ];
				when: RSAnimationEndEvent do: [
					post value.
					com removeKey: #anime ].
			com propertyAt: #anime put: anime ].
		 ].
	show := [
		animation
			value: [ icon remove. canvas addShape: com ]
			value: #reverse
			value: #backOut
			value: nil
		 ].
	hide := [
		animation
			value: nil
			value: #yourself
			value: #backIn
			value: [ com remove. canvas addShape: icon ] ].
	canvas when: RSMouseClick do: hide.
	com when: RSMouseClick do: hide.
	icon when: RSMouseClick do: show.
	canvas open extent: 800@600
]

{ #category : #examples }
RSGraphVizExamples >> example08RoassalPackages [
	<script: 'self new example08RoassalPackages'>
	| canvas nodeBlock labeled packagesRegExp packages baseline |
	canvas := RSCanvas new.

	nodeBlock := [ :str | | label |
		label := RSLabel new text: str.
		RSBox new
			model: str;
			cornerRadius: 30;
			extent: label extent + 20;
			color: Color white;
			withBorder;
			draggable;
			yourself ].
	packagesRegExp := { 'Roassal3*' }.
	packages := packagesRegExp flatCollect: [ :regExp |
	    RPackageOrganizer default packages
	        select: [ :p | regExp match: p packageName ] ].
	canvas addAll: (packages collect: nodeBlock).
	labeled := RSLabeled new.
	labeled location center; middle.
	canvas nodes @ labeled.
	baseline := RSGraphvizLine new.

	(RSEdgeBuilder new: baseline)
		canvas: canvas;
		shapes: canvas nodes;
		connectFrom: #yourself toAll: #dependentPackages.
	canvas edges pushBack.
	RSGraphvizLayout on: canvas nodes.
	canvas @ RSCanvasController.
	canvas inspect
]

{ #category : #examples }
RSGraphVizExamples >> example09Arrows [
	<script: 'self new example09Arrows'>
	| c shapes lb |
	c := RSCanvas new.

	shapes := RSLabel models: Collection withAllSubclasses.
	c addAll: shapes.
	RSNormalizer fontSize
		shapes: shapes;
		normalize: [:cls | cls linesOfCode sqrt + 5 ].
	shapes @ RSDraggable.

	lb := RSLineBuilder graphviz.
	lb shapes: shapes.
	lb markerEnd: (RSShapeFactory arrow size: 10; color: Color red).
	lb connectToAll: #dependentClasses.

	RSGraphvizLayout twoPi
		scale: -100;
		on: shapes.

	shapes @ (RSHighlightable red withEdges).
	c @ RSCanvasController.
	c openOnce
]

{ #category : #examples }
RSGraphVizExamples >> example10Mondrian [
	<script: 'self new example10Mondrian'>

	| m layout |
	m := RSMondrian new.
	"m shape box size: 30."
	m shape box size: 30; "width: 30; height: 20;" labeled .
	m nodes: 'abcde'.
	m graphvizLine
		arrowMarkerEnd;
		useAssociations: { $a -> $b . $b -> $c . $a -> $c . $d -> $c . $e -> $c . $e -> $a }.
	layout := m layout graphviz digraph.
	m open
]

{ #category : #examples }
RSGraphVizExamples >> example11RSObjectWithAllSubclasses [
	<script: 'self new example11RSObjectWithAllSubclasses open'>
	| c shapes lb |
	c := RSCanvas new.

	shapes := RSLabel models: RSObject withAllSubclasses.
	c addAll: shapes.
	shapes @ RSDraggable.

	lb := RSLineBuilder graphviz.
	lb shapes: shapes.
	"lb connectFrom: #superclass."
	lb connectToAll: #dependentClasses.

	RSGraphvizLayout on: shapes.
	c @ RSCanvasController.
	^ c
]

{ #category : #examples }
RSGraphVizExamples >> unixFamilyTree [
	^ {'5th Edition' -> '6th Edition'.
	'5th Edition' -> 'PWB 1.0'.
	'6th Edition' -> 'LSX'.
	'6th Edition' -> '1 BSD'.
	'6th Edition' -> 'Mini Unix'.
	'6th Edition' -> 'Wollongong'.
	'6th Edition' -> 'Interdata'.
	'Interdata' -> 'Unix/TS 3.0'.
	'Interdata' -> 'PWB 2.0'.
	'Interdata' -> '7th Edition'.
	'7th Edition' -> '8th Edition'.
	'7th Edition' -> '32V'.
	'7th Edition' -> 'V7M'.
	'7th Edition' -> 'Ultrix-11'.
	'7th Edition' -> 'Xenix'.
	'7th Edition' -> 'UniPlus+'.
	'V7M' -> 'Ultrix-11'.
	'8th Edition' -> '9th Edition'.
	'1 BSD' -> '2 BSD'.
	'2 BSD' -> '2.8 BSD'.
	'2.8 BSD' -> 'Ultrix-11'.
	'2.8 BSD' -> '2.9 BSD'.
	'32V' -> '3 BSD'.
	'3 BSD' -> '4 BSD'.
	'4 BSD' -> '4.1 BSD'.
	'4.1 BSD' -> '4.2 BSD'.
	'4.1 BSD' -> '2.8 BSD'.
	'4.1 BSD' -> '8th Edition'.
	'4.2 BSD' -> '4.3 BSD'.
	'4.2 BSD' -> 'Ultrix-32'.
	'PWB 1.0' -> 'PWB 1.2'.
	'PWB 1.0' -> 'USG 1.0'.
	'PWB 1.2' -> 'PWB 2.0'.
	'USG 1.0' -> 'CB Unix 1'.
	'USG 1.0' -> 'USG 2.0'.
	'CB Unix 1' -> 'CB Unix 2'.
	'CB Unix 2' -> 'CB Unix 3'.
	'CB Unix 3' -> 'Unix/TS++'.
	'CB Unix 3' -> 'PDP-11 Sys V'.
	'USG 2.0' -> 'USG 3.0'.
	'USG 3.0' -> 'Unix/TS 3.0'.
	'PWB 2.0' -> 'Unix/TS 3.0'.
	'Unix/TS 1.0' -> 'Unix/TS 3.0'.
	'Unix/TS 3.0' -> 'TS 4.0'.
	'Unix/TS++' -> 'TS 4.0'.
	'CB Unix 3' -> 'TS 4.0'.
	'TS 4.0' -> 'System V.0'.
	'System V.0' -> 'System V.2'.
	'System V.2' -> 'System V.3'}
]
