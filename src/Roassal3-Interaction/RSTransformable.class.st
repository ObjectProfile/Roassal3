"
I provide element resizing in all eight directions. 

Resizing handles are displayed after clicking on an associated shape, and are automatically removed when clicked on a canvas or another shape.

!! Assumptions

You must provide this class with aCanvas instance or the initialized element must be already added to the canvas.


"
Class {
	#name : #RSTransformable,
	#superclass : #RSInteraction,
	#instVars : [
		'currentShape',
		'currentMatrix',
		'baseRectangle'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #rectangle }
RSTransformable >> bottomCenter: position rectangle: rectangle [ 
	^ rectangle origin -> (rectangle corner x @ position y)
]

{ #category : #rectangle }
RSTransformable >> bottomLeft: position rectangle: rectangle [ 
	^ (position x @ rectangle origin y) -> (rectangle corner x @ position y)
]

{ #category : #rectangle }
RSTransformable >> bottomRight: position rectangle: rectangle [ 
	^ rectangle origin -> position
]

{ #category : #'accessing - shapes' }
RSTransformable >> boxShape [
	^ RSPolygon new
		noPaint;
		border: (RSBorder new
			color: Color gray);
		yourself
		
	
	
]

{ #category : #accessing }
RSTransformable >> cornersAndSides [
	^ {
	
	#topLeft -> #topLeft.
	#topCenter -> #top.
	#topRight -> #topRight.
	#rightCenter -> #right.
	#bottomRight -> #bottomRight.
	#bottomCenter -> #bottom.
	#bottomLeft -> #bottomLeft.
	#leftCenter -> #left.}.
]

{ #category : #'accessing - shapes' }
RSTransformable >> createHandleFor: association [
	| handle |
	handle := RSEllipse new
		size: 20;
		model: association;
		color: Color white;
		border: (RSBorder new width: 5; color: Color gray);
		draggable;
		yourself.
	handle announcer
		when: RSMouseEnter send: #showCursor: to: self;
		when: RSMouseLeave send: #removeCursor to: self;
		when: RSMouseDragStart send: #saveCurrentShapeState to: self;
		when: RSPositionChangedEvent send: #updateCurrentShape: to: self.
	^ handle
]

{ #category : #'accessing - shapes' }
RSTransformable >> createHandlesFor: shape [
	| handles circles |
	handles := RSGroup new.
	currentShape := shape.
	self saveCurrentShapeState.
	handles add: self boxShape.
	circles := self cornersAndSides collect: [ :sel | self createHandleFor: sel ].
	handles addAll: circles.
	"TODO
	handles add: self rotationShape."
	self saveHandles: handles evt: shape.
	self updateHandles: shape.
	^ handles.
		
	
	
]

{ #category : #cursor }
RSTransformable >> cursorForCorner: aCorner [
	^ Cursor perform: ('resize' , aCorner capitalized) asSymbol
]

{ #category : #public }
RSTransformable >> disableHandles: evt [
	| shape key bool |
	shape := evt shape.
	key := self key.
	bool := shape hasProperty: key.
	self removeHandles: evt.
	bool ifFalse: [ ^ self ].
	shape propertyAt: key put: #disable.
]

{ #category : #public }
RSTransformable >> enableHandles: evt [
	| shape key |
	shape := evt shape.
	key := self key.
	(shape hasProperty: key) ifFalse: [ ^ self ].
	shape removeKey: key.
	self showHandles: evt.
	
]

{ #category : #accessing }
RSTransformable >> key [
	^ self class name
]

{ #category : #rectangle }
RSTransformable >> leftCenter: position rectangle: rectangle [ 
	^ (position x @ rectangle origin y) -> rectangle corner
]

{ #category : #hooks }
RSTransformable >> onShape: aShape [
	aShape isNode ifFalse: [ ^ self ].
	aShape announcer
		when: RSMouseLeftClick send: #showHandles: to: self;
		when: RSMouseDragStart send: #disableHandles: to: self;
		when: RSMouseDragEnd send: #enableHandles: to: self.
]

{ #category : #private }
RSTransformable >> registerCanvasEventsIfNecessary: evt [
	| canvas |
	canvas := evt canvas.
	(canvas hasInteraction: self class) ifTrue: [ ^ self ].
	canvas announcer
		when: RSMouseClick 
		send: #removeHandles:
		to: self
]

{ #category : #cursor }
RSTransformable >> removeCursor [
	self setCursor: nil
	
]

{ #category : #public }
RSTransformable >> removeHandles: evt [
	| canvas key handles |
	canvas := evt canvas.
	key := self key.
	handles := canvas propertyAt: key.
	handles ifNil: [ ^ self ].
	evt shape ifNotNil: [ :s | s removeKey: key ].
	
	handles do: #remove.
	canvas removeKey: key.
	canvas signalUpdate.
]

{ #category : #rectangle }
RSTransformable >> rightCenter: position rectangle: rectangle [ 
	^ rectangle origin -> (position x @ rectangle corner y)
]

{ #category : #'accessing - shapes' }
RSTransformable >> rotationShape [
	"TODO"
	^ RSBitmap new
		form: (self iconNamed: #smallUpdate);
		scaleBy: 2;
		when: RSMouseEnter send: #showRotationCursor to: self;
		when: RSMouseLeave send: #removeCursor to: self;
		yourself
]

{ #category : #private }
RSTransformable >> saveCurrentShapeState [
	| r matrix |
	currentShape ifNil: [ ^ self ].
	matrix := currentShape matrix.
	r := matrix.
	r := r sx sign @ r sy sign.
	r := currentShape extent * r / 2.
	
	baseRectangle := Rectangle basicNew
		privateSetOrigin: r negated;
		privateSetCorner: r;
		yourself.
		
	currentMatrix := matrix copy
		loadIdentity;
		translation: currentShape position.
]

{ #category : #private }
RSTransformable >> saveHandles: handles evt: evt [
	evt canvas propertyAt: self key put: handles.
]

{ #category : #cursor }
RSTransformable >> setCursor: cursor [
	self currentWorld currentHand showTemporaryCursor: cursor
]

{ #category : #cursor }
RSTransformable >> showCursor: evt [
	self setCursor: (self cursorForCorner: evt shape model value).
]

{ #category : #public }
RSTransformable >> showHandles: evt [ 
	
	| parent shape handles |
	self removeHandles: evt.
	self registerCanvasEventsIfNecessary: evt.
	shape := evt shape.
	shape propertyAt: self key put: #enable.
	handles := self createHandlesFor: shape.
	
	parent := shape parent.
	parent addAll: handles.
	evt signalUpdate.
	
	
	
	
		
		
		
	
	
]

{ #category : #cursor }
RSTransformable >> showRotationCursor [
	self setCursor: Cursor webLink
]

{ #category : #rectangle }
RSTransformable >> topCenter: position rectangle: rectangle [ 
	^ (rectangle origin x @ position y) -> rectangle corner
]

{ #category : #rectangle }
RSTransformable >> topLeft: position rectangle: rectangle [ 
	^ position -> rectangle corner
]

{ #category : #rectangle }
RSTransformable >> topRight: position rectangle: rectangle [ 
	^ (rectangle origin x @ position y) -> (position x @ rectangle corner y)
]

{ #category : #update }
RSTransformable >> updateCurrentShape: evt [
	| handle  newRec scale pos rect  e |
	currentShape ifNil: [ ^ self ].
	handle := evt shape.
	pos := currentMatrix rsInverseTransform: handle position.
	newRec := self 
		perform: (handle model key, ':rectangle:') asSymbol
		withArguments: { pos. baseRectangle}.
	scale := (newRec value - newRec key) / currentShape baseRectangle extent.
	
	e := Float epsilon.
	scale x abs < e ifTrue: [ scale := (e * scale x sign) @ scale y ].
	scale y abs < e ifTrue: [ scale := scale x @ (e * scale y sign) ].
	
	rect := newRec value corner: newRec key.
	rect := currentShape 
		computeEncompassingRectangleFor: (newRec key corner: newRec value)
		matrix: currentMatrix.

	currentShape matrix
		loadIdentity.
	currentShape scaleBy: scale.
	currentShape translateTo: rect floatCenter.
	
	self updateHandles: evt.
	evt signalUpdate.
]

{ #category : #update }
RSTransformable >> updateHandles: evt [
	| canvas handles rect base points circles matrix  |
	currentShape ifNil: [ ^ self ].
	canvas := evt canvas.
	handles := canvas propertyAt: self key ifAbsent: [ ^ self ].
	rect := currentShape baseRectangle.
	base := handles first.
	circles := handles copyFrom: 2 to: handles size.
	points := Array new: circles size.
	matrix := currentShape matrix.
	circles doWithIndex: [ :h :index | | position |
		position := matrix transform: (h model key value: rect).
		h position: position.
		points at: index put: position ].
	base points: points.
	
	"TODO
	rotate := handles last.
	rotate position: (matrix transform: rect topCenter - (0@30) )."
]
