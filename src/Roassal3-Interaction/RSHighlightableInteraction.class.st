"
<keyClass>
`RSHighlightable` is an interaction for shapes to make them highlightable. 

*Responsibility*: make shapes highlightable

*Collaborators*: closely colaborate with `RSShape`

*Variables*:
- `announcer`: highlightable uses announcement to trigger the interaction. 
- `copyKey`: symbol that is used to keep in the property the previous color. One needs to modity the `copyKey` to avoid conflict between several highlightable interactions.
- `highlightShapes`: refers to a one-arg-block that takes as parameter a shape and returns the shapes that must be highlighted. 
- `propertyKey`: symbol that is used in the property of the `RSCanvas` to keep highlighted shapes. This is useful to avoid conflicts between different highlightable.
   

*Example*:
```Smalltalk
c := RSCanvas new.

shapes := (1 to: 10) collect: [ :v | RSEllipse new size: 20; model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup @ RSDraggable.

RSGridLayout on: shapes.

eb := RSEdgeBuilder arrowedLineWithOffset: 0.5.
eb canvas: c.
eb connectTo: [ :v | 1 ].

int := RSHighlightable new withEdges highlightColor: Color red.
shapes @ int.

c @ RSCanvasController
```

Another example:
```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSBox new border: (RSBorder new color: Color red; width: 3); model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

RSNormalizer size
	shapes: shapes;
	normalize: #yourself.

interaction := RSHighlightable new.
interaction highlightColor: Color blue.
interaction highlightBorder: (RSBorder new color: Color black; width: 3).
shapes @ interaction.

RSGridLayout on: shapes.
c @ RSCanvasController
```

Another example:
```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSEllipse new  model: v; size: 10 ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

RSEdgeBuilder line
	canvas: c;
	withBorderAttachPoint;
	connectFrom: [ :v | v // 2 ].

interaction := RSHighlightable new.
interaction highlightBorder: (RSBorder new color: Color black; width: 3).
interaction withEdges.
shapes @ interaction.

RSTreeLayout on: shapes.
c @ RSCanvasController
```

```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSBox new  size: 20; model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

interaction := RSHighlightable new.
interaction highlightBorder: (RSBorder new width: 3; color: Color pink).
shapes @ interaction.

RSGridLayout on: shapes.
c @ RSCanvasController
```

Example of multiple selections:
```Smalltalk
classes := Collection withAllSubclasses.

c := RSCanvas new.
shapes := classes collect: [ :cls | RSBox new model: cls ] as: RSGroup.

c addAll: shapes.
RSNormalizer size shapes: shapes; normalize: #numberOfMethods.
RSFlowLayout on: shapes.

shapes @ RSPopup.


buttonReset := RSLabel text: 'Reset'.
c add: buttonReset.
buttonReset setAsFixed.
buttonReset @ (RSHighlightable defaultRed).
buttonReset when: RSMouseClick do: [ :evt | 
	selectedShapes do: [ :s | highlightable restore: s selector: #color ].
	selectedShapes := RSGroup new.
	lbl text: ''.
	c signalUpdate. ].

buttonInspect := RSLabel text: 'Inspect'.
c add: buttonInspect.
buttonInspect setAsFixed.
buttonInspect @ (RSHighlightable defaultRed).
buttonInspect when: RSMouseClick do: [ :evt | selectedShapes inspect ].

lbl := RSLabel new.
c add: lbl.
lbl setAsFixed.
lbl translateTo: 90 @ 30.

g := {buttonReset . buttonInspect } asGroup.
RSHorizontalLineLayout on: g.
g translateTo: g extent / 2 + (10 @ 10).

selectedShapes := RSGroup new.
highlightable := RSHighlightable new.
shapes when: RSMouseClick do: [ :evt |
	(selectedShapes includes: evt shape) 
		ifFalse: [ selectedShapes add: evt shape ].
	highlightable
			record: evt shape
			selector: #color
			value: Color red.
	lbl text: selectedShapes size asString, ' selected shapes'.
	c signalUpdate.
		 ].

c @ RSCanvasController.
c openOnce
```
"
Class {
	#name : #RSHighlightableInteraction,
	#superclass : #RSInteraction,
	#traits : 'RSTAnnounceable',
	#classTraits : 'RSTAnnounceable classTrait',
	#instVars : [
		'announcer',
		'copyKey',
		'highlightShapes',
		'propertyKey'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance colors' }
RSHighlightableInteraction class >> blue [
	^ self color: Color blue
	
]

{ #category : #'instance colors' }
RSHighlightableInteraction class >> color: aColor [
	| inst |
	inst := self new.
	inst highlightColor: aColor.
	^ inst
	
]

{ #category : #'public - lines' }
RSHighlightableInteraction class >> createEdgesWith: aBlock shape: aShape using: aRSLine from: aRSGroup [
	| models lines shapes parent |
	models := aBlock value: aShape model.
	parent := aShape parent.
	shapes := parent shapesFromModels: models.
	lines := shapes collect: [:s | 
		aRSLine copy
			from: aShape;
			to: s;
			yourself ].
	parent addAll: lines.
	^ lines
]

{ #category : #'instance colors' }
RSHighlightableInteraction class >> green [
	^ self color: Color green
]

{ #category : #'instance colors' }
RSHighlightableInteraction class >> red [
	^ self color: Color red
]

{ #category : #'instance creation' }
RSHighlightableInteraction class >> sameModel: aCanvas [
	"Define an highlight object that is able to highlight the same elements pointed by the mouse.
	
For example:
```Smalltalk
values := #(1 1 2 2 2 2 3 3 3 4 4 5 5 5 5 ).

c := RSCanvas new.
boxes := values collect: [ :vv | RSBox new size: 10; model: vv ] as: RSGroup.
c addAll: boxes.
boxes @ RSPopup.
boxes @ (RSHighlightable sameModel: c).
RSGridLayout on: boxes.
c @ RSCanvasController
```"
	^ self new 
		highlightBorder: (RSBorder new color: Color yellow; width: 5); 
		highlightShapes: [ :ss | aCanvas nodes select: [ :sss | (sss model == ss model) and: [ sss ~~ ss ]  ] ]
]

{ #category : #'public - lines' }
RSHighlightableInteraction class >> showEdges: aBlock using: aRSLine [
	^ self showEdges: aBlock using: aRSLine from: [ :aShape | aShape parent shapes ] 
]

{ #category : #'public - lines' }
RSHighlightableInteraction class >> showEdges: aBlock using: aRSLine from: aRSGroup [
	| i |
	i := self new.
	i 
		when: RSHighlightEvent do: [ :evt | 
			evt canvas
				propertyAt: #lines 
				put: (self 
					createEdgesWith: aBlock 
					shape: evt shape 
					using: aRSLine 
					from: aRSGroup).
		];
		when: RSUnHighlightEvent do: [:evt |
			evt shape parent propertyAt: #lines ifPresent: [:lines | lines do: #remove ].
		].
	^ i 
]

{ #category : #public }
RSHighlightableInteraction class >> withAntAnimation [
	| i |
	i := self new.
	i withLines.
	i when: RSHighlightEvent do: [ :evt | | shape border |
		shape := evt shape.
		border := shape border.
		shape propertyAt: #ob put: border.
		border ifNil: [ border := RSBorder new ].
		shape border: (RSBorder new width: border width * 2; color: border color).
		shape isNode ifTrue: [ 
			| array anime |
			array := #(4).
			shape connectedEdges do: [ :edge | edge border 
				color: Color blue; 
				width: 2;
				dashArray: array. ].
			anime := shape newAnimation
				repeat;
				from: 0;
				to: -8;
				duration: 1 second;
				onStepDo: [ :t |
					shape connectedEdges do: [ :ed |ed border dashOffset: t ].
					shape signalUpdate ].
			shape topParent propertyAt: #antAnimation put: anime.
		].
	].
	i when: RSUnHighlightEvent do: [ :evt | 
		| att shape |
		shape := evt shape.
		shape border: (shape propertyAt: #ob).
		shape removeKey: #ob.
		shape isNode ifTrue: [ 
			att := shape topParent properties.
			(att at: #antAnimation) stop.
			att removeKey: #antAnimation.
		 ]
	].
	^ i
]

{ #category : #obsolete }
RSHighlightableInteraction class >> withEdges [

	^ self withLines
]

{ #category : #'instance creation' }
RSHighlightableInteraction class >> withLines [

	^ self new
		  withLines;
		  highlightBorder: (RSBorder new
				   color: Color black)
]

{ #category : #announcer }
RSHighlightableInteraction >> announceHighlight: shape source: shapeOrCanvas [
	self announce: [ RSHighlightEvent new
		interaction: self;
		shape: shape;
		source: shapeOrCanvas ].
]

{ #category : #announcer }
RSHighlightableInteraction >> announceUnHightlight: shape source: shapeOrCanvas [
	self announce: [ RSUnHighlightEvent new
		interaction: self;
		shape: shape;
		source: shapeOrCanvas ].
]

{ #category : #announcer }
RSHighlightableInteraction >> announcementClasses [
	^ RSHighlightableEvent subclasses
]

{ #category : #announcer }
RSHighlightableInteraction >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #'accessing - keys' }
RSHighlightableInteraction >> copyKey [
	^ copyKey ifNil: [ copyKey := #original ].
]

{ #category : #'accessing - keys' }
RSHighlightableInteraction >> copyKey: aSymbol [
	copyKey := aSymbol
]

{ #category : #actions }
RSHighlightableInteraction >> doHighlight: shape [
	| shapes |
	self unhighlightRecordedShapes: shape.
	shapes := self highlightShapesFor: shape.
	shapes do: [ :e | self announceHighlight: e source: shape ].
	
	shape topParent propertyAt: self propertyKey put: shapes.
]

{ #category : #actions }
RSHighlightableInteraction >> doHighlightShapes: shapes [
	"Assuming all the shapes belongs to the same canvas"
	| allHShapes |
	shapes ifEmpty: [ ^ self ].
	self unhighlightRecordedShapes: shapes first.
	allHShapes := shapes flatCollect: [ :s | | hshapes |
		hshapes := self highlightShapesFor: s.
		hshapes do: [ :hs | self announceHighlight: hs source: s ].
		hshapes ].
	shapes first canvas propertyAt: self propertyKey put: allHShapes.
]

{ #category : #actions }
RSHighlightableInteraction >> doUnhighlight: aShape [
	self unhighlightRecordedShapes: aShape
]

{ #category : #public }
RSHighlightableInteraction >> highlightBorder: aBorder [
	"Set the border. For example:

```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSBox new  size: 20; model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

interaction := RSHighlightable new.
interaction highlightBorder: (RSBorder new width: 3; color: Color pink).
shapes @ interaction.

RSGridLayout on: shapes.
c @ RSCanvasController
```
	"
	self 
		when: RSHighlightEvent do: [ :evt | 
			self record: evt shape selector: #border value: aBorder ];
		when: RSUnHighlightEvent do: [ :evt | self restore: evt shape selector: #border ].
]

{ #category : #public }
RSHighlightableInteraction >> highlightColor: aColor [
	"Set the highlight color. For example:

```Smalltalk
c := RSCanvas new.
shapes := (1 to: 30) collect: [ :v | RSBox new  size: 20; model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup.

interaction := RSHighlightable new.
interaction highlightColor: Color blue.
shapes @ interaction.

RSGridLayout on: shapes.
c @ RSCanvasController
```

Here is another example:
```Smalltalk
c := RSCanvas new.

shapes := (1 to: 10) collect: [ :v | RSEllipse new size: 20; model: v ] as: RSGroup.
c addAll: shapes.
shapes @ RSPopup @ RSDraggable.

RSGridLayout on: shapes.

eb := RSEdgeBuilder arrowedLineWithOffset: 0.5.
eb canvas: c.
eb connectTo: [ :v | 1 ].

int := RSHighlightable new withEdges highlightColor: Color red.
shapes @ int.

c @ RSCanvasController
```
	"
	self 
		when: RSHighlightEvent do: [ :evt | self record: evt shape selector: #color value: aColor ];
		when: RSUnHighlightEvent do: [ :evt | self restore: evt shape selector: #color ].
]

{ #category : #accessing }
RSHighlightableInteraction >> highlightShapes: aOneArgBlock [
	"the block accepts a shape (the one selected) should return a collection of shapes. Consider the example:
```	
canvas := RSCanvas new.

shapes := RSEllipse models: (1 to: 30).
shapes @ RSPopup @ RSDraggable.
canvas addAll: shapes.

highlightable := RSHighlightable new.
highlightable highlightColor: Color green.
highlightable highlightShapes: [ :aShape | 
	shapes select: [ :s | (-1 to: 1) includes: (s model - aShape model)  ] ].
shapes @ highlightable.
RSGridLayout on: shapes.

canvas @ RSCanvasController.

canvas open
```
	"
	highlightShapes := aOneArgBlock
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> highlightShapes: aBlock butKeep: aRSHighlightable [
	"aBlock receives a shape and returns a collection of shapes"
	self highlightShapes: [ :e | 
		| shapes |
		shapes := aBlock value: e.
		e canvas properties
			at: aRSHighlightable propertyKey
			ifPresent: [ :hshapes | 
				shapes reject: [ :hs | hshapes includes: hs ] ]
			ifAbsent: [ shapes ] ]
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> highlightShapesButKeep: aRSHighlightable [
	self 
		highlightShapes: [ :e | { e } ]
		butKeep: aRSHighlightable
]

{ #category : #private }
RSHighlightableInteraction >> highlightShapesFor: aShape [
	^ highlightShapes rsValue: aShape
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> incomingLines [
	self highlightShapes: [ :s | 
		s incomingLines collect: #yourself as: RSGroup ].
]

{ #category : #initialization }
RSHighlightableInteraction >> initialize [
	super initialize.
	self highlightShapes: [ :shape | Array with: shape ].

]

{ #category : #public }
RSHighlightableInteraction >> lowColor: lowColor highColor: highColor [
	self 
		when: RSHighlightEvent do: [ :evt | evt shape color: highColor  ];
		when: RSUnHighlightEvent do: [ :evt | evt shape color: lowColor ].
	
]

{ #category : #hooks }
RSHighlightableInteraction >> onShape: aShape [
	aShape
		when: RSMouseEnter do: [ :evt | self doHighlight: evt shape. evt signalUpdate ];
		when: RSMouseLeave do: [ :evt | self doUnhighlight: evt shape. evt signalUpdate ]
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> outgoingLines [
	self highlightShapes: [ :s | 
		s outgoingLines collect: #yourself as: RSGroup ].
]

{ #category : #announcer }
RSHighlightableInteraction >> privateAnnouncer [
	^ announcer
]

{ #category : #'accessing - keys' }
RSHighlightableInteraction >> propertyKey [
	^ propertyKey ifNil: [ propertyKey := self hash asString ]
]

{ #category : #'accessing - keys' }
RSHighlightableInteraction >> propertyKey: aSymbol [
	propertyKey := aSymbol.
]

{ #category : #private }
RSHighlightableInteraction >> record: aShape selector: selector value: anObject [
	"Main method to change an attribute of a shape (e.g., colors, border)
	
For example:

	-=-=-=-=
	c := RSCanvas new.
	shapes := (1 to: 10) collect: [ :n | RSEllipse new size: 20; model: n ] as: RSGroup.
	c addAll: shapes.
	RSGridLayout on: shapes.
	RSHighlightable new record: shapes fifth selector: #color value: Color blue.
	c
	-=-=-=-=
	
	"
	| savedValues |
	savedValues := aShape properties
		at: self copyKey , selector
		ifAbsentPut: [ OrderedCollection new ].
	savedValues add: (aShape perform: selector).
	
	aShape
		perform: selector asMutator
		with: (anObject rsValue: aShape)
]

{ #category : #actions }
RSHighlightableInteraction >> resetHighlightedShapes: shapeOrGroupOrCanvas [
	| att top |
	(shapeOrGroupOrCanvas class == RSGroup)
		ifTrue: [ 
			shapeOrGroupOrCanvas ifEmpty: [ ^ self ].
			top := shapeOrGroupOrCanvas anyOne canvas ]
		ifFalse: [
			top := shapeOrGroupOrCanvas topParent ]. 
		
	att := top properties.
	(att includesKey: self propertyKey) ifFalse: [ ^ self ].
	att removeKey: self propertyKey
]

{ #category : #private }
RSHighlightableInteraction >> restore: aShape selector: selector [
	"Main method to restore the attribute of a shape.

	-=-=-=-=-=-=-=-=-=-=-=-=
	c := RSCanvas new.
	shapes := (1 to: 10) collect: [ :n | RSEllipse new size: 20; model: n ] as: RSGroup.
	c addAll: shapes.
	RSGridLayout on: shapes.
	RSHighlightable new record: shapes fifth selector: #color value: Color blue.
	RSHighlightable new restore: shapes fifth selector: #color.
	c
	-=-=-=-=-=-=-=-=-=-=-=-=
"
	| key savedValues |
	key := self copyKey, selector.
	savedValues := aShape properties 
		at: key
		ifAbsent: [ ^ self ].
	aShape
		perform: selector asMutator
		with: savedValues removeLast.
	savedValues ifEmpty: [ aShape properties removeKey: key ]
	
]

{ #category : #actions }
RSHighlightableInteraction >> unhighlightRecordedShapes: shapeOrGroupOrCanvas [
	| top |
	(shapeOrGroupOrCanvas class == RSGroup)
		ifTrue: [ 
			shapeOrGroupOrCanvas ifEmpty: [ ^ self ].
			top := shapeOrGroupOrCanvas anyOne canvas ]
		ifFalse: [
			top := shapeOrGroupOrCanvas topParent ]. 
		
	top ifNil: [ ^ self ].
	top
		propertyAt: self propertyKey 
		ifPresent: [ :shapes |
			shapes do: [ :s | self announceUnHightlight: s source: shapeOrGroupOrCanvas ].
		 ].
	self resetHighlightedShapes: shapeOrGroupOrCanvas
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> withConnectedShapes [
	"Highlight shapes that are connected to the pointed shape. For example:
```
numberOfNodes := 25. 
numberOfLines := 90.
r := Random seed: 42.
graph := Dictionary new.

1 to: numberOfNodes do: [ :aNode |
	graph at: aNode put: Set new ].

numberOfLines timesRepeat: [ 
	fromNode := r nextInteger: numberOfNodes.
	toNode := r nextInteger: numberOfNodes.
	(graph at: fromNode) add: toNode ].

canvas := RSCanvas new.
nodes := RSCircle models: (1 to: numberOfNodes).
nodes @ RSDraggable @ RSPopup. 
canvas addAll: nodes.

highlightable := RSHighlightable new.
highlightable highlightColor: Color red.
highlightable withEdges.
nodes @ highlightable.

highlightable2 := RSHighlightable new.
highlightable2 highlightColor: Color blue.
highlightable2 withConnectedShapes.
nodes @ highlightable2.

lb := RSLineBuilder line.
lb canvas: canvas.
lb withBorderAttachPoint.
lb makeBidirectional.
lb moveBehind.
lb objects: (1 to: numberOfNodes).
lb connectToAll: [ :aNumber | graph at: aNumber ].

RSForceBasedLayout new charge: -300; on: nodes.
canvas @ RSCanvasController.
canvas open
```
	"

	self highlightShapes: [ :s | 
		| listIncoming listOutgoing |
		listIncoming := s incomingEdges collect: [ :anEdge | anEdge from ] as: RSGroup.
		listOutgoing := s outgoingEdges collect: [ :anEdge | anEdge to ] as: RSGroup.
		listIncoming, listOutgoing ].
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> withEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s connectedEdges copy.
		list add: s.
		list ].
]

{ #category : #obsolete }
RSHighlightableInteraction >> withIncomingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s incomingEdges collect: #yourself as: RSGroup.
		list add: s.
		list ].
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> withIncomingLines [
	self highlightShapes: [ :s | 
		| list |
		list := s incomingLines collect: #yourself as: RSGroup.
		list add: s.
		list ].
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> withLines [
	self highlightShapes: [ :s | 
		| list |
		list := s connectedLines copy.
		list add: s.
		list ].
]

{ #category : #obsolete }
RSHighlightableInteraction >> withOutgoingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s outgoingEdges collect: #yourself as: RSGroup.
		list addAll: (s outgoingEdges collect: #to). 
		list ].
]

{ #category : #'public - hooks' }
RSHighlightableInteraction >> withOutgoingLines [
	self highlightShapes: [ :s | 
		| list |
		list := s outgoingLines collect: #yourself as: RSGroup.
		list addAll: (s outgoingLines collect: #to). 
		list ].
]
