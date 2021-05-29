"
This class visualize dependencies of instances of BaselineOf
"
Class {
	#name : #RSBaselineCalypso,
	#superclass : #RSUMLClassCalypso,
	#instVars : [
		'lineBorder',
		'notLoadedPopup',
		'loadedPopup',
		'high',
		'highMenu',
		'isUsingPackageSize'
	],
	#category : #'Roassal3-UML-Calypso'
}

{ #category : #testing }
RSBaselineCalypso class >> shouldBeActivatedInContext: aBrowserContext [
	^ RSUMLCalypsoSettings useCalypsoUML 
		and: [ aBrowserContext isClassSelected 
			and: [ aBrowserContext lastSelectedClass inheritsFrom: BaselineOf ] ].
	
]

{ #category : #building }
RSBaselineCalypso >> addEdgesOn: canvas [
	| arrow |
	arrow := (RSShapeFactory arrow size: 10; color: Color red translucent) asMarker.
	arrow offset: 0.
	
	RSLineBuilder line
		markerEnd: arrow;
		canvas: canvas;
		attachPoint: (RSBorderAttachPoint new endOffset: 5);
		border: self border;
		connectToAll: [:name | self dependenciesOf: name ].
]

{ #category : #building }
RSBaselineCalypso >> applyControlsOn: canvas [
	| controller |
	controller := RSCanvasController new.
	controller addInteraction: (RSSearchInCanvas new
		colorToHighlight: Color yellow;
		yourself).
	canvas @ controller
]

{ #category : #building }
RSBaselineCalypso >> applyLayoutOn: canvas [
	| interaction layout |
	interaction := RSForceLayoutStepping new.
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
	canvas @ interaction.
	
]

{ #category : #building }
RSBaselineCalypso >> applyTheme: canvas [
	| theme |
	theme := Smalltalk ui theme.
	canvas color: theme backgroundColor.
	self border color: theme textColor.
	canvas edges do: [ :ed | ed color: theme textColor ].
]

{ #category : #accessing }
RSBaselineCalypso >> border [
	^ lineBorder ifNil: [ lineBorder := RSBorder new color: Color black; yourself ].
]

{ #category : #building }
RSBaselineCalypso >> buildLegendOn: canvas [
	| b miniGraph interaction arrow |
	miniGraph := RSComposite new.
	interaction  := RSLabeledInteraction new.
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
	b text: ' '.
	b title: 'Interactions on nodes'.
	b text: '-Double click to open class'.
	b text: '-Mouse over to see direct dependencies'.
	b onDemand: 'GraphInfo'.
	b legendDo: [ :s | s color: (Color white alpha: 0.8); withBorder; padding: 10 ].
	b build.
		
]

{ #category : #'building - menus' }
RSBaselineCalypso >> buildMenuOn: canvas [
	
	| menus |
	menus := RSGroup new.
	#('Show names' 'showHideNames:'
	'Change node size using number of packages' 'resizeNodes:') pairsDo: [ :name :action | 
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
	
	canvas addAllShapes: menus.
]

{ #category : #building }
RSBaselineCalypso >> buildUmlCanvas [
	| canvas allProjects |
	canvas := RSCanvas new.
	allProjects := self collectAllProjects.
	canvas addAll: (allProjects associations collect: [:asso | self shapeFor: asso ]).
	self addEdgesOn: canvas.
	self applyLayoutOn: canvas.
	self applyControlsOn: canvas.
	self applyTheme: canvas.
	self buildMenuOn: canvas.
	self buildLegendOn: canvas.
	^ canvas
]

{ #category : #accessing }
RSBaselineCalypso >> collectAllProjects [
	| projects |
	projects := Dictionary new.
	self collectAllProjectsIn: projects class: self targetClass level: 0.
	^ projects
]

{ #category : #accessing }
RSBaselineCalypso >> collectAllProjectsIn: projects class: clazz level: level [
	projects at: clazz name asSymbol put: clazz.
	"This is baseline"
	(clazz version projects collect: #constructClassName)
		select: [ :name | name notNil ]
	 	thenDo: [ :name |
			Smalltalk globals at: name asSymbol
				ifPresent: [ :cls | self collectAllProjectsIn: projects class: cls level: level + 1 ]
				ifAbsent: [ projects at: name asSymbol put: nil ]
		]
]

{ #category : #initialization }
RSBaselineCalypso >> defaultIconName [
	^ #objects
]

{ #category : #initialization }
RSBaselineCalypso >> defaultTitle [
	^'Baselines-Graph'
]

{ #category : #building }
RSBaselineCalypso >> dependenciesOf: name [
	^ Smalltalk globals at: name
		ifPresent: [ :cls |
			cls version projects collect: #constructClassName ]
		ifAbsent: [ #() ]
]

{ #category : #building }
RSBaselineCalypso >> highlightable [
	^ high ifNil: [ 
		high := RSHighlightableInteraction new withOutgoingEdges.
		high highlightBorder: (RSBorder new color: Smalltalk ui theme selectionColor; width: 2).
		high ]
]

{ #category : #'building - menus' }
RSBaselineCalypso >> highlightableMenu [
	^ highMenu ifNil: [ 
		highMenu := RSHighlightableInteraction new.
		highMenu 
			when: RSHighlightEvent do: [ :evt |
				evt shape color: Color blue; underline.
				self menuAnimationFor: evt shape to: -5@0 ];
			when: RSUnHighlightEvent do: [ :evt |
				evt shape color: Color gray; normal.
				self menuAnimationFor: evt shape to: 0 ].
		highMenu ]
]

{ #category : #'building - menus' }
RSBaselineCalypso >> layoutMenu: menus [
	RSVerticalLineLayout on: menus.
	menus translateBy: 10@10.
	menus do: [ :lb | lb propertyAt: #opos put: lb position ].
]

{ #category : #accessing }
RSBaselineCalypso >> loadedPopup [
	^ loadedPopup ifNil: [ loadedPopup := RSPopup new ]
]

{ #category : #'building - menus' }
RSBaselineCalypso >> menuAnimationFor: shape to: delta [
	| pos |
	pos := shape propertyAt: #opos.
	shape newAnimation
		duration: 200 milliSeconds;
		from: shape position;
		to: pos + delta;
		on: shape set: #position:.
]

{ #category : #accessing }
RSBaselineCalypso >> notLoadedPopup [
	^ notLoadedPopup ifNil: [ notLoadedPopup := 
		RSPopup text: [ :name | name, String crlf, '--Not loaded--' ].
		notLoadedPopup shapeBuilder labelBuilder 
			layout: (RSVerticalLineLayout new gapSize: 0; alignCenter; yourself).
		notLoadedPopup ]
]

{ #category : #'building - menus' }
RSBaselineCalypso >> resizeNodes: evt [
	| minSize newText propertyKey |
	isUsingPackageSize ifNil: [ isUsingPackageSize := true ].
	minSize := 15.
	isUsingPackageSize ifTrue: [ 
		isUsingPackageSize := false.
		newText := 'Change node size using number of packages'.
		propertyKey := #linesOfCode.
	] ifFalse: [ 
		isUsingPackageSize := true.
		propertyKey := #packagesSize.
		newText := 'Change node size using lines of code of each baseline class' ].
	
	evt canvas nodes do: [ :node |
		node size: minSize + (node propertyAt: propertyKey).
		node updateConnectedEdges ].
	evt shape text: newText.
	evt signalUpdate.
]

{ #category : #building }
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
	assoc value ifNil: [ 
		shape @ self notLoadedPopup.
		shape color: Color red.
		shape propertyAt: #linesOfCode put: 0.
		shape propertyAt: #packagesSize put: 0.
		shape size: minSize ]
	ifNotNil: [ :cls | 
		assoc key = self targetClass name
			ifTrue: [ shape color: Color blue ].
		shape @ self loadedPopup.
		shape propertyAt: #linesOfCode put: cls linesOfCode sqrt*2.
		shape propertyAt: #packagesSize put: cls version packages size.
		shape size: minSize + cls version packages size ].
	^ shape
]

{ #category : #'building - menus' }
RSBaselineCalypso >> showHideNames: evt [
	| label textColor |
	label := evt canvas nodes first propertyAt: #RSLabeledInteraction.
	textColor :=  Smalltalk ui theme textColor.
	label ifNil: [ 
		| labeled |
		labeled := RSLabeledInteraction new highlightable.
		labeled shapeBuilder: [ :m | RSLabel new color: textColor; text: m ].
		labeled lowColor: textColor translucent.
		evt canvas nodes @ labeled.
		evt shape text: 'Hide names' ]
	ifNotNil: [ 
		evt canvas nodes do: [ :node | 
			(node propertyAt: #RSLabeledInteraction) remove.
			node removeKey: #RSLabeledInteraction.
			node removeInteractionIfPresent: RSLabeledInteraction. ].
		evt shape text: 'Show names' ].
	evt signalUpdate
]
