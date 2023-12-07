"
This class visualize dependencies of instances of BaselineOf
"
Class {
	#name : 'RSBaselineCalypso',
	#superclass : 'RSUMLClassCalypso',
	#instVars : [
		'lineBorder',
		'notLoadedPopup',
		'loadedPopup',
		'high',
		'highMenu',
		'nodeSizeOption'
	],
	#category : 'Roassal-UML-Calypso-Core',
	#package : 'Roassal-UML-Calypso',
	#tag : 'Core'
}

{ #category : 'testing' }
RSBaselineCalypso class >> shouldBeActivatedInContext: aBrowserContext [
	^ RSUMLCalypsoSettings useCalypsoUML
		and: [ aBrowserContext isClassSelected
			and: [ aBrowserContext lastSelectedClass inheritsFrom: BaselineOf ] ]
]

{ #category : 'building' }
RSBaselineCalypso >> addEdgesOn: canvas [
	| arrow |
	arrow := (RSShapeFactory arrow size: 10; color: Color red translucent) asMarker.
	arrow offset: 0.

	RSLineBuilder line
		markerEnd: arrow;
		canvas: canvas;
		attachPoint: (RSBorderAttachPoint new endOffset: 5);
		border: self border;
		connectToAll: [:name | self dependenciesOf: name ]
]

{ #category : 'building' }
RSBaselineCalypso >> applyControlsOn: canvas [
	| controller |
	controller := RSCanvasController new.
	controller addInteraction: (RSSearchInCanvasInteraction new
		colorToHighlight: Color yellow;
		yourself).
	canvas @ controller
]

{ #category : 'building' }
RSBaselineCalypso >> applyLayoutOn: canvas [
	| interaction layout |
	interaction := RSForceLayoutSteppingInteraction new.
	layout := RSRectangleForceLayout new.
	interaction layout: layout.
	layout
		initialLayout: RSGridLayout new;
		enclosingRectangle: (Rectangle floatCenter: 0@0 extent: 300@100);
		length: 50;
		charge: -600.
	canvas when: RSExtentChangedEvent do: [:evt |
		layout enclosingRectangle: (Rectangle floatCenter: 0@0 extent: canvas extent).
		interaction startSimpleAnimation: canvas.
		canvas newAnimation
			duration: 2 seconds;
			onStepDo: [ canvas zoomToFit ].
		 ].
	RSUMLCalypsoSettings useAnimationInCalypsoBaseline
		ifTrue: [ canvas @ interaction ]
		ifFalse: [
			layout on: canvas nodes.
			canvas nodes @ RSDraggable ]
]

{ #category : 'building' }
RSBaselineCalypso >> applyTheme: canvas [
	| theme |
	theme := Smalltalk ui theme.
	canvas color: theme backgroundColor.
	self border color: theme textColor.
	canvas edges do: [ :ed | ed color: theme textColor ]
]

{ #category : 'accessing' }
RSBaselineCalypso >> border [
	^ lineBorder ifNil: [ lineBorder := RSBorder new color: Color black; yourself ]
]

{ #category : 'building' }
RSBaselineCalypso >> buildLegendOn: canvas [
	| b miniGraph interaction arrow |
	miniGraph := RSComposite new.
	interaction  := RSLabeled new.
	interaction location middle.
	miniGraph add: (RSEllipse new size: 20; model: 'A').
	miniGraph add: (RSEllipse new size: 20; model: 'B').
	miniGraph nodes @ interaction.
	arrow := RSShapeFactory arrow size: 10.
	miniGraph add: (RSLine new
		from: miniGraph nodes first;
		to: miniGraph nodes second;
		attachPoint: (RSBorderAttachPoint new endOffset: 5);
		markerEnd: arrow;
		yourself).
	RSHorizontalLineLayout new gapSize: 10; on: miniGraph nodes.
	miniGraph adjustToChildren.

	b := RSLegend new.
	b container: canvas.
	b title: 'Dependencies of ', self targetClass name.
	b text: 'A loaded baseline' withCircleColor: Color gray.
	b text: self targetClass name withCircleColor: Color blue.
	b text: 'Not loaded baseline' withCircleColor: Color red.
	b text: 'A depends on B' withShape: miniGraph.
	b
		text: 'Error in baseline'
		withShape: (RSShapeFactory star
			size: 20;
			color: Color red;
			yourself).
	b text: ' '.
	b title: 'Interactions on nodes'.
	b text: '-Double click to open class'.
	b text: '-Mouse over to see direct dependencies'.
	b onDemand: 'GraphInfo'.
	b legendDo: [ :s | s color: (Color white alpha: 0.8); withBorder; padding: 10 ].
	b build
]

{ #category : 'building - menus' }
RSBaselineCalypso >> buildMenuMorphSize: evt [
	| menu options |
	menu := MenuMorph new.
	nodeSizeOption ifNil: [ nodeSizeOption := 1 ].
	options := {
		#resizeLinesOfCode: -> 'Change node size using lines of code of each baseline class'.
		#resizePackagesSize: -> 'Change node size using number of packages'.
		#resizeLevel: -> 'Change node size using level'}.
	options doWithIndex: [ :a :index |
		(menu
			add: a value
			target: self
			selector: a key
			argumentList: (Array with: evt))
			icon: (self iconNamed:(index = nodeSizeOption
				ifTrue: [ #radioButtonOn ]
				ifFalse: [ #radioButtonOff ]))
		 ].
	menu popUpInWorld
]

{ #category : 'building - menus' }
RSBaselineCalypso >> buildMenuOn: canvas [

	| menus |
	menus := RSGroup new.
	#('Show names' 'showHideNames:'
	'Change node size using...' 'buildMenuMorphSize:') pairsDo: [ :name :action |
		| label |
		label := RSLabel new
			text: name;
			isFixed: true;
			@ self highlightableMenu;
			when: RSMouseClick send: action asSymbol to: self;
			yourself.
		label when: RSExtentChangedEvent do: [ :evt |
			self layoutMenu: menus.
			 ].
		menus add: label.
		].
	self layoutMenu: menus.

	canvas addAllShapes: menus
]

{ #category : 'building' }
RSBaselineCalypso >> buildUmlCanvas [
	| canvas allProjects |
	canvas := RSCanvas new.
	allProjects := self collectAllProjects.
	canvas addAll: (allProjects associations collect: [:asso | self shapeFor: asso ]).
	self addEdgesOn: canvas.

	self
		setLevels: (canvas nodes
			detect: [ :node| node color = Color blue ]
			ifNone: [ nil ])
		in: Set new
		level: 0.

	self applyLayoutOn: canvas.
	self applyControlsOn: canvas.
	self applyTheme: canvas.
	self buildMenuOn: canvas.
	self buildLegendOn: canvas.
	^ canvas
]

{ #category : 'accessing' }
RSBaselineCalypso >> collectAllProjects [
	| projects |
	projects := Dictionary new.
	self collectAllProjectsIn: projects class: self targetClass level: 0.
	^ projects
]

{ #category : 'accessing' }
RSBaselineCalypso >> collectAllProjectsIn: projects class: clazz level: level [
	| version |
	version := nil.
	projects at: clazz name asSymbol put: clazz.
	[ version := clazz version ] on: Error do: [ :ex |
		^ self ].
	"This is baseline"

	(version projects collect: #constructClassName)
		select: [ :name | name notNil ]
	 	thenDo: [ :name |
			Smalltalk globals at: name asSymbol
				ifPresent: [ :cls | self collectAllProjectsIn: projects class: cls level: level + 1 ]
				ifAbsent: [ projects at: name asSymbol put: nil ]
		]
]

{ #category : 'initialization' }
RSBaselineCalypso >> defaultIconName [
	^ #objects
]

{ #category : 'initialization' }
RSBaselineCalypso >> defaultTitle [
	^'Baselines-Graph'
]

{ #category : 'building' }
RSBaselineCalypso >> dependenciesOf: name [
	^ Smalltalk globals at: name
		ifPresent: [ :cls |

			[cls version projects collect: #constructClassName] on: Error do: [ :ex | #() ] ]
		ifAbsent: [ #() ]
]

{ #category : 'building' }
RSBaselineCalypso >> highlightable [
	^ high ifNil: [
		high := RSHighlightable new withOutgoingEdges.
		high highlightBorder: (RSBorder new color: self theme selectionColor; width: 2).
		high ]
]

{ #category : 'building - menus' }
RSBaselineCalypso >> highlightableMenu [
	^ highMenu ifNil: [
		highMenu := RSHighlightable new.
		highMenu
			when: RSHighlightEvent do: [ :evt |
				evt shape color: Color blue; underline.
				self menuAnimationFor: evt shape to: -5@0 ];
			when: RSUnHighlightEvent do: [ :evt |
				evt shape color: Color gray; normal.
				self menuAnimationFor: evt shape to: 0 ].
		highMenu ]
]

{ #category : 'building - menus' }
RSBaselineCalypso >> layoutMenu: menus [
	RSVerticalLineLayout on: menus.
	menus translateBy: 10@10.
	menus do: [ :lb | lb propertyAt: #opos put: lb position ]
]

{ #category : 'accessing' }
RSBaselineCalypso >> loadedPopup [
	^ loadedPopup ifNil: [ loadedPopup := RSPopup new ]
]

{ #category : 'building - menus' }
RSBaselineCalypso >> menuAnimationFor: shape to: delta [
	| pos |
	pos := shape propertyAt: #opos.
	shape newAnimation
		duration: 200 milliSeconds;
		from: shape position;
		to: pos + delta;
		on: shape set: #position:
]

{ #category : 'accessing' }
RSBaselineCalypso >> notLoadedPopup [
	^ notLoadedPopup ifNil: [ notLoadedPopup :=
		RSPopup text: [ :name | name, String crlf, '--Not loaded--' ].
		notLoadedPopup shapeBuilder labelBuilder
			layout: (RSVerticalLineLayout new gapSize: 0; alignCenter; yourself).
		notLoadedPopup ]
]

{ #category : 'building - menus' }
RSBaselineCalypso >> resizeLevel: evt [
	nodeSizeOption := 3.
	self resizeNodes: evt key: #level
]

{ #category : 'building - menus' }
RSBaselineCalypso >> resizeLinesOfCode: evt [
	nodeSizeOption := 1.
	self resizeNodes: evt key: #linesOfCode
]

{ #category : 'building - menus' }
RSBaselineCalypso >> resizeNodes: evt key: propertyKey [
	| minSize|
	minSize := 15.
	evt canvas nodes do: [ :node |
		node size: minSize + (node propertyAt: propertyKey).
		node updateConnectedLines ].
	evt signalUpdate
]

{ #category : 'building - menus' }
RSBaselineCalypso >> resizePackagesSize: evt [
	nodeSizeOption := 2.
	self resizeNodes: evt key: #packagesSize
]

{ #category : 'building' }
RSBaselineCalypso >> setLevels: node in: set level: level [
	node ifNil: [ ^ self ].
	(set includes: node) ifTrue: [ ^ self ].
	set add: node.
	node propertyAt: #level put: level.
	node outgoingShapes do: [ :shape |
		self setLevels: shape in: set level: level + 10 ]
]

{ #category : 'building' }
RSBaselineCalypso >> shapeFor: assoc [
	| shape minSize |
	minSize := 15.
	shape := RSEllipse new
		border: self border;
		@ self highlightable;
		model: assoc key;
		yourself.
	shape
		when: RSMouseDoubleClick
		do: [ :evt | (self class environment at: evt shape model) browse ].
	shape propertyAt: #level put: 0.
	assoc value ifNil: [
		shape
			@ self notLoadedPopup;
			color: Color red;
			propertyAt: #linesOfCode put: 0;
			propertyAt: #packagesSize put: 0;
			size: minSize ]
	ifNotNil: [ :cls |
		assoc key = self targetClass name
			ifTrue: [ shape color: Color blue ].
		shape @ self loadedPopup.

		shape propertyAt: #linesOfCode put: cls linesOfCode sqrt*2.

		[| size |
		size := cls version packages size.
		shape propertyAt: #packagesSize put: size.
		shape size: minSize + size. ] on: Error do: [ :ex |
			| newShape |
			newShape := RSShapeFactory star.
			newShape announcer: shape announcer.
			newShape properties addAll: shape properties.
			newShape model: shape model.
			newShape color: Color red.
			shape := newShape.
			shape propertyAt: #packagesSize put: 0.
			shape size: minSize.
		 ].
	].
	^ shape
]

{ #category : 'building - menus' }
RSBaselineCalypso >> showHideNames: evt [
	| label textColor |
	label := evt canvas nodes first propertyAt: #RSLabeled.
	textColor := self theme textColor.
	label ifNil: [
		| labeled |
		labeled := RSLabeled new highlightable.
		labeled shapeBuilder: [ :m | RSLabel new color: textColor; text: m ].
		labeled lowColor: textColor translucent.
		evt canvas nodes @ labeled.
		evt shape text: 'Hide names' ]
	ifNotNil: [
		evt canvas nodes do: [ :node |
			(node propertyAt: #RSLabeled) remove.
			node removeKey: #RSLabeled.
			node removeInteractionIfPresent: RSLabeled. ].
		evt shape text: 'Show names' ].
	evt signalUpdate
]
