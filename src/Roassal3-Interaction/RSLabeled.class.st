"
<keyClass>
`RSLabeled` adds a label on shape. Per default, it is added on top of the shape. The label may be particularized using #text: in the default string representation is not sufficient. 

*Responsibility*: locate a label on top of a shape.

*Collaborators*: can be added to any Roassal shape

*Variables*:
- `location`: a `RSLocation` indicating where the label should be located
- `isHighlightable`: a boolean indicating whether the label should be highlighted
- `lowColor`: a boolean indicating whether the label should be highlighted

*Example*:
```Smalltalk
c := RSCanvas new.

shapes := RSGroup new.
1 to: 3 do: [ :v |
	shapes add: (RSBox new model: v) ].

shapes @ (RSLabeled new text: [ :m | 'Value = ', m asString ]).

RSNormalizer size
	shapes: shapes;
	from: 20; to: 40;
	normalize: [ :aModel | aModel ].

c addAll: shapes.
RSVerticalLineLayout new gapSize: 30; on: shapes.
c @ RSCanvasController
```

Another example:
```Smalltalk
c := RSCanvas new.
shapes := (1 to: 10) collect: [ :v | RSBox new model: v; size: 30 ] as: RSGroup.
c addAll: shapes.
shapes @ RSLabeled new highlightable.
RSNormalizer size shapes: shapes; normalize: #yourself.
RSGridLayout on: shapes.
c @ RSCanvasController.
c 
```

"
Class {
	#name : #RSLabeled,
	#superclass : #RSInteraction,
	#instVars : [
		'location',
		'isHighlightable',
		'lowColor',
		'target',
		'modelBlock',
		'shapeBuilder'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #hooks }
RSLabeled >> createLabel: aShape [
	| label color set targetLabel |
	label := self shapeBuilder shapeFor: (self modelFor: aShape).
	location stick: label on: aShape.
	isHighlightable 
		ifFalse: [ ^ label ].
	targetLabel := target value: label.
	color := targetLabel color.
	targetLabel color: self lowColor.
	set := [ :c | 
		label pushFront.
		targetLabel color: c.
		label signalUpdate ].
	aShape 
		when: RSMouseEnter do: [ set value: color ];
		when: RSMouseLeave do: [ set value: lowColor ];
		when: RSShapeRemovedEvent do: [ label remove ].
	^ label
]

{ #category : #hooks }
RSLabeled >> getOrCreateLabel: aShape [
	| label parent |
	label := aShape properties 
		at: #RSLabeled
		ifAbsentPut: [ self createLabel: aShape ].
	parent :=aShape parent.
	(label isInACanvas not and: [parent notNil ]) 
		ifTrue: [ parent addShape: label shape ].
	^ label
]

{ #category : #'public - configuration' }
RSLabeled >> highlightable [
	"Make the label highlightable.
For example:
```Smalltalk
c := RSCanvas new.
shapes := (1 to: 10) collect: [ :v | RSBox new model: v; size: 30 ] as: RSGroup.
c addAll: shapes.
shapes @ RSLabeled new highlightable.
RSNormalizer size shapes: shapes; normalize: #yourself.
RSGridLayout on: shapes.
c @ RSCanvasController.
c 
```
"
	isHighlightable := true.
	self 
		lowColor: Color veryVeryLightGray;
		target: #yourself.
]

{ #category : #initialization }
RSLabeled >> initialize [ 
	super initialize.
	self shapeBuilder: RSMultilineLabelBuilder new.
	self model: #model.
	location := RSLocation new above.
	isHighlightable := false.
]

{ #category : #accessing }
RSLabeled >> location [
	^ location
]

{ #category : #accessing }
RSLabeled >> lowColor [
	^ lowColor
]

{ #category : #accessing }
RSLabeled >> lowColor: aColor [
	lowColor := aColor
]

{ #category : #accessing }
RSLabeled >> model [
	^ modelBlock
]

{ #category : #accessing }
RSLabeled >> model: aBlock [
	modelBlock := aBlock
]

{ #category : #hooks }
RSLabeled >> modelFor: anElement [
	^ modelBlock rsValue: anElement.
]

{ #category : #hooks }
RSLabeled >> onShape: aShape [
	
	aShape isInACanvas 
		ifTrue: [ self getOrCreateLabel: aShape ]
		ifFalse: [ aShape when: RSShapeAddedEvent do: [ :evt | 
			self getOrCreateLabel: evt shape ] ].
]

{ #category : #accessing }
RSLabeled >> shapeBuilder [
	^ shapeBuilder
]

{ #category : #accessing }
RSLabeled >> shapeBuilder: aShapeBuilder [
	shapeBuilder := aShapeBuilder
]

{ #category : #accessing }
RSLabeled >> target [
	^ target
]

{ #category : #accessing }
RSLabeled >> target: aBlock [
	target := aBlock
]

{ #category : #'public - configuration' }
RSLabeled >> text: aBlockOrSymbol [
	shapeBuilder textBlock: aBlockOrSymbol
]
