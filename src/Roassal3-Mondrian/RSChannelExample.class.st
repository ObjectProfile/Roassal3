Class {
	#name : #RSChannelExample,
	#superclass : #Object,
	#category : #'Roassal3-Mondrian-Examples'
}

{ #category : #examples }
RSChannelExample >> example3 [
	<script: 'self new example3'>
	| c names labels classes classeShapes eb channel scale |
	c := RSCanvas new.
	names := #('Set' 'Array' 'Hash' 'Dictionary').
	labels := names collect: [ :aName | RSLabel new fontSize: 20; text: aName ] as: RSGroup.
	c addAll: labels.
	RSHorizontalLineLayout on: labels.

	classes := Collection withAllSubclasses.
	classeShapes := classes collect: [ :cls | RSBox new model: cls ] as: RSGroup.
	classeShapes @ RSPopup.
	c addAll: classeShapes.
	eb := RSLineBuilder orthoVertical.
	eb withVerticalAttachPoint.
	eb shapes: classeShapes.
	eb connectFrom: #superclass.

	RSNormalizer size 
		shapes: classeShapes;
		normalize: #numberOfMethods.

	RSTreeLayout on: classeShapes.

	RSVerticalLineLayout new alignCenter; on: (RSGroup with: labels with: classeShapes).

	"-------"
	scale := NSScale ordinalColored: labels size.
	labels doWithIndex: [ :l :i |
		channel := RSChannel new.
		channel color: Color random"(scale scale: i)".
		channel input: { l }.
		channel output: (classeShapes select: [ :s | ('*', l text, '*') match: s model name ]).
		channel build.
	].
	"-------"
	c @ RSCanvasController.
	c open
]

{ #category : #examples }
RSChannelExample >> exampleBasic [

	<script: 'self new exampleBasic'>
	| c box1 box2 label connection |
	c := RSCanvas new.

	box1 := RSBox new
		        size: 50;
		        color: Color gray translucent.
	box2 := RSBox new
		        size: 30;
		        color: Color gray translucent.
	box1 @ RSDraggableInteraction.
	box2 @ RSDraggableInteraction.
	c
		add: box1;
		add: box2.

	box1 translateBy: 150 @ -40.

	label := RSLabel new text: 'Move the mouse above me'.
	c add: label.
	RSLocation new
		above;
		stick: label on: box1.

	"-------"
	"Connection here"

	connection := RSChannel new.
	connection input: { box1 } asGroup.
	connection output: { box2 } asGroup.
	connection build.
	"connection effect: [ :evt |  ]"

	"-------"

	c open
]

{ #category : #examples }
RSChannelExample >> exampleBasic2 [
	<script: 'self new exampleBasic2'>
	| c m mondrianNodes oddLabel evenLabel g channel smallLabel bigLabel |
	c := RSCanvas new.

	m := RSMondrian new.
	m canvas: c.
	m shape box size: 40.
	m nodes: (1 to: 30).
	m layout flow gapSize: 20.
	m build.

	mondrianNodes := c nodes copy.


	oddLabel := RSLabel text: 'Odd'.
	evenLabel := RSLabel text: 'Label'.
	smallLabel := RSLabel text: 'Small'.
	bigLabel := RSLabel text: 'Big'.

	g := { oddLabel . evenLabel . smallLabel . bigLabel } asGroup.
	c addAll: g.
	RSHorizontalLineLayout on: g.
	RSVerticalLineLayout new alignCenter; on: { g .  mondrianNodes}.

	"-------" 
	channel := RSChannel new.
	channel color: Color green.
	channel input: { oddLabel }.
	channel output: (mondrianNodes select: [ :e | e model odd ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel color: Color red.
	channel input: { evenLabel }.
	channel output: (mondrianNodes select: [ :e | e model even ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel color: Color blue.
	channel input: { smallLabel }.
	channel output: (mondrianNodes select: [ :e | e model < 15 ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel color: Color purple.
	channel input: { bigLabel }.
	channel output: (mondrianNodes select: [ :e | e model >= 15 ]).
	channel build.
	"-------"

	c @ RSCanvasController.
	c open
]

{ #category : #examples }
RSChannelExample >> exampleBasic3 [
	<script: 'self new exampleBasic3'>
	| c m mondrianNodes oddLabel evenLabel g channel smallLabel bigLabel |
	c := RSCanvas new.

	m := RSMondrian new.
	m canvas: c.
	m shape box size: 40.
	m nodes: (1 to: 30).
	m layout flow gapSize: 20.
	m build.

	mondrianNodes := c nodes copy.


	oddLabel := RSLabel text: 'Odd'.
	evenLabel := RSLabel text: 'Even'.
	smallLabel := RSLabel text: 'Small'.
	bigLabel := RSLabel text: 'Big'.

	g := { oddLabel . evenLabel . smallLabel . bigLabel } asGroup.
	c addAll: g.
	RSHorizontalLineLayout on: g.
	RSVerticalLineLayout new alignCenter; on: { g .  mondrianNodes}.

	"-------" 
	channel := RSChannel new.
	channel color: Color green.
	channel input: { oddLabel }.
	channel output: (mondrianNodes select: [ :e | e model odd ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel color: Color green.
	channel input: (mondrianNodes select: [ :e | e model odd ]).
	channel output: { oddLabel }.
	channel build.

	"-------"
	channel := RSChannel new.
	channel color: Color red.
	channel input: { evenLabel }.
	channel output: (mondrianNodes select: [ :e | e model even ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel color: Color red.
	channel input: (mondrianNodes select: [ :e | e model even ]).
	channel output: { evenLabel }.
	channel build.
	"-------"

	channel := RSChannel new.
	channel color: Color blue.
	channel input: { smallLabel }.
	channel output: (mondrianNodes select: [ :e | e model < 15 ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel color: Color blue.
	channel input: (mondrianNodes select: [ :e | e model < 15 ]).
	channel output: { smallLabel }.
	channel build.
	"-------"

	channel := RSChannel new.
	channel color: Color purple.
	channel input: { bigLabel }.
	channel output: (mondrianNodes select: [ :e | e model >= 15 ]).
	channel build.
	"-------"
	channel := RSChannel new.
	channel color: Color purple.
	channel input: (mondrianNodes select: [ :e | e model >= 15 ]).
	channel output: { bigLabel }.
	channel build.
	"-------"
	
	
	

	c @ RSCanvasController.
	c open
]
