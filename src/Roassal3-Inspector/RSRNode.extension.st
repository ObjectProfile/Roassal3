Extension { #name : #RSRNode }

{ #category : #'*Roassal3-Inspector' }
RSRNode >> addMenu: canvas [
	canvas addAll: ((1 to: self height) collect: [ :each |
		RSLabel new
			color: 'black';
			isFixed: true;
			model: each;
			yourself.
		 ]).
	RSHorizontalLineLayout on: canvas fixedShapes.
	canvas fixedShapes when: RSMouseClick do: [ :evt | 
		canvas shapes do: [ :node |
			(node propertyAt: #level) = evt shape model 
				ifTrue: [ node 
					color: (node propertyAt: #originalColor);
					border: (RSBorder new color: 'black'). ]
				ifFalse: [ node noPaint; noBorder ] ].
		canvas signalUpdate
		].
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> addWithChildren: canvas [
	| circle label |
	circle := RSEllipse new
		size: 20;
		color: (self isBalanced 
			ifTrue: [ Color blue translucent]
			ifFalse: [ Color red ]);
		yourself.
	label := RSLabel new
		text: (self isLeaf
			ifTrue: [ contents model asString ]
			ifFalse: [ '[]' ]);
		color: Color black;
		yourself.
	canvas add: ({ circle. label } asShape
		model: self;
		yourself).
	self childrenDo: [ :child | child addWithChildren: canvas ].
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> addWithChildren: canvas level: level palette: palette [
	| color |
	color := (palette scale: level) alpha: 0.7.
	canvas add: (RSBox new
		model: self;
		fromRectangle: rectangle;
		color: color;
		propertyAt: #level put: level;
		propertyAt: #originalColor put: color;
		yourself).
	self childrenDo: [ :child | child addWithChildren: canvas level: level + 1 palette: palette ].
		
		
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> addWithChildren: canvas level: level palette: palette parent: parent [
	| color box |
	color := (palette scale: level) alpha: 0.7.
	box := RSBox new
		model: self;
		fromRectangle: rectangle;
		noPaint;
		propertyAt: #parent put: parent;
		propertyAt: #level put: level;
		propertyAt: #originalColor put: color;
		yourself.
	self isLeaf ifTrue: [ box color: 'black' ].
	canvas add: box.
	self childrenDo: [ :child | 
		child 
			addWithChildren: canvas 
			level: level + 1 
			palette: palette
			parent: box ].
		
		
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> asRSCanvasForRectangles [
	| canvas palette |
	palette := NSScale category20.
	canvas := RSCanvas new.
	self addWithChildren: canvas level: 1 palette: palette.
	canvas nodes @ RSHighlightable red.
	self addMenu: canvas.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> asRSCanvasTree [
	| canvas palette |
	palette := NSScale category20. 
	canvas := RSCanvas new.
	self addWithChildren: canvas.
	RSLineBuilder line
		withVerticalAttachPoint;
		shapes: canvas nodes;
		connectToAll: [ :node | node children ].
	
	RSTreeLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> asRSCanvasWithParentPath [
	| canvas palette leafs |
	palette := NSScale category20. 
	canvas := RSCanvas new.
	self addWithChildren: canvas level: 1 palette: palette parent: nil.
	leafs := canvas shapes select: [ :node | node model isLeaf ].
	leafs
		pushFront;
		addInteraction: (RSPopup text: [:node | | shape parents |
			shape := (canvas shapeFromModel: node).
			parents := OrderedCollection new.
			self parentsFor: shape list: parents.
			'Parents size: ' ,parents size asString.
			]);
		when: RSMouseEnter do: [ :evt | | parents |
			parents := OrderedCollection new.
			self parentsFor: evt shape list: parents.
			parents do: [ :each |
				each color: (each propertyAt: #originalColor).
				 ].
			evt canvas propertyAt: #parents put: parents.
			evt signalUpdate.
			 ];
		when: RSMouseLeave do: [ :evt |
			evt canvas propertyAt: #parents ifPresent: [ :parents | parents do: #noPaint ].
			evt signalUpdate.
		].
	
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> inspectorRectangles [
	<inspectorPresentationOrder: 1 title: 'Rectangles'>
	^ SpRoassal3InspectorPresenter new
		canvas: self asRSCanvasForRectangles;
		yourself
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> inspectorTree [
	<inspectorPresentationOrder: 3 title: 'Tree'>
	^ SpRoassal3InspectorPresenter new
		canvas: self asRSCanvasTree;
		yourself
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> inspectorWithParent [
	<inspectorPresentationOrder: 2 title: 'With Parent'>
	^ SpRoassal3InspectorPresenter new
		canvas: self asRSCanvasWithParentPath;
		yourself
]

{ #category : #'*Roassal3-Inspector' }
RSRNode >> parentsFor: shape list: list [
	shape ifNil: [ ^ self ].
	shape model isLeaf ifFalse: [ list add: shape ].
	self parentsFor: (shape propertyAt: #parent) list: list.
]
