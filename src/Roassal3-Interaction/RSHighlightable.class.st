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
"
Class {
	#name : #RSHighlightable,
	#superclass : #RSInteraction,
	#instVars : [
		'announcer',
		'copyKey',
		'highlightShapes',
		'propertyKey'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #'instance creation' }
RSHighlightable class >> defaultRed [
	| inst |
	inst := self new.
	inst highlightColor: Color red.
	^ inst
	
]

{ #category : #'instance creation' }
RSHighlightable class >> withEdges [

	^ self new
		  withEdges;
		  highlightBorder: (RSBorder new
				   color: Color black)
]

{ #category : #announce }
RSHighlightable >> announce: anEvent [
	announcer ifNil: [ ^ self ].
	announcer announce: anEvent value
]

{ #category : #announce }
RSHighlightable >> announceHighlight: shape source: shapeOrCanvas [
	self announce: [ RSHighlightEvent new
		interaction: self;
		shape: shape;
		source: shapeOrCanvas ].
]

{ #category : #announce }
RSHighlightable >> announceUnHightlight: shape source: shapeOrCanvas [
	self announce: [ RSUnHighlightEvent new
		interaction: self;
		shape: shape;
		source: shapeOrCanvas ].
]

{ #category : #announce }
RSHighlightable >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ].
]

{ #category : #announce }
RSHighlightable >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #'accessing - keys' }
RSHighlightable >> copyKey [
	^ copyKey ifNil: [ copyKey := #original ].
]

{ #category : #'accessing - keys' }
RSHighlightable >> copyKey: aSymbol [
	copyKey := aSymbol
]

{ #category : #actions }
RSHighlightable >> doHighlight: shape [
	| shapes |
	self unhighlightRecordedShapes: shape.
	shapes := self highlightShapesFor: shape.
	shapes do: [ :e | self announceHighlight: e source: shape ].
	
	shape topParent propertyAt: self propertyKey put: shapes.
]

{ #category : #actions }
RSHighlightable >> doHighlightShapes: shapes [
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
RSHighlightable >> doUnhighlight: aShape [
	self unhighlightRecordedShapes: aShape
]

{ #category : #public }
RSHighlightable >> highlightBorder: aBorder [
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
		when: RSHighlightEvent do: [ :evt | self record: evt shape selector: #border value: aBorder ];
		when: RSUnHighlightEvent do: [ :evt | self restore: evt shape selector: #border ].
]

{ #category : #public }
RSHighlightable >> highlightColor: aColor [
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
RSHighlightable >> highlightShapes [
	^ highlightShapes
]

{ #category : #accessing }
RSHighlightable >> highlightShapes: aBlockOnArg [
	"the block should return a collection of shapes"
	highlightShapes := aBlockOnArg
]

{ #category : #'public - hooks' }
RSHighlightable >> highlightShapes: aBlock butKeep: aRSHighlightable [
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
RSHighlightable >> highlightShapesButKeep: aRSHighlightable [
	self 
		highlightShapes: [ :e | { e } ]
		butKeep: aRSHighlightable
]

{ #category : #private }
RSHighlightable >> highlightShapesFor: aShape [
	^ highlightShapes rsValue: aShape
]

{ #category : #initialization }
RSHighlightable >> initialize [
	super initialize.
	self highlightShapes: [ :shape | Array with: shape ].

]

{ #category : #public }
RSHighlightable >> lowColor: lowColor highColor: highColor [
	self 
		when: RSHighlightEvent do: [ :evt | evt shape color: highColor  ];
		when: RSUnHighlightEvent do: [ :evt | evt shape color: lowColor ].
	
]

{ #category : #hooks }
RSHighlightable >> onShape: aShape [
	aShape
		when: RSMouseEnter do: [ :evt | self doHighlight: evt shape. evt signalUpdate ];
		when: RSMouseLeave do: [ :evt | self doUnhighlight: evt shape. evt signalUpdate ]
]

{ #category : #'accessing - keys' }
RSHighlightable >> propertyKey [
	^ propertyKey ifNil: [ propertyKey := self hash asString ]
]

{ #category : #'accessing - keys' }
RSHighlightable >> propertyKey: aSymbol [
	propertyKey := aSymbol.
]

{ #category : #private }
RSHighlightable >> record: aShape selector: selector value: anObject [
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
RSHighlightable >> resetHighlightedShapes: shapeOrCanvas [
	| att |
	att := shapeOrCanvas topParent properties.
	(att includesKey: self propertyKey) ifFalse: [ ^ self ].
	att removeKey: self propertyKey
]

{ #category : #private }
RSHighlightable >> restore: aShape selector: selector [
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

{ #category : #public }
RSHighlightable >> setupAntAnimation [
	self withEdges.
	self when: RSHighlightEvent do: [ :evt | | shape border |
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
	self when: RSUnHighlightEvent do: [ :evt | 
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
]

{ #category : #actions }
RSHighlightable >> unhighlightRecordedShapes: shapeOrCanvas [
	| top |
	top := shapeOrCanvas topParent.
	top ifNil: [ ^ self ].
	top
		propertyAt: self propertyKey 
		ifPresent: [ :shapes |
			shapes do: [ :s | self announceUnHightlight: s source: shapeOrCanvas ].
		 ].
	self resetHighlightedShapes: shapeOrCanvas
]

{ #category : #announcing }
RSHighlightable >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #'public - hooks' }
RSHighlightable >> withEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s connectedEdges copy.
		list add: s.
		list ].
]

{ #category : #'public - hooks' }
RSHighlightable >> withIncomingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s incomingEdges collect: #yourself as: RSGroup.
		list add: s.
		list ].
]

{ #category : #'public - hooks' }
RSHighlightable >> withOutgoingEdges [
	self highlightShapes: [ :s | 
		| list |
		list := s outgoingEdges collect: #yourself as: RSGroup.
		list addAll: (s outgoingEdges collect: #to). 
		list ].
]
