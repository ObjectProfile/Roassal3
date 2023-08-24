"
<keyClass>
A shape is a visual element meant to be displayed. Roassal offers numerous shapes, themselves highly configurable. The class `RSShape` is the root of all the Roassal shapes, and a shape is typically created by instantiating a subclass of `RSShape`. For example, a box is defined by instantiating `RSBox`. 

For example, a colored box with a thick border may be defined as:

```Smalltalk
box := RSBox new
			size: 80;
			color: #yellow;
			border: (RSBorder new color: #blue; width: 10).
```

Colors may be provided either as a color object (e.g., `Color blue` or `Color r: 0 g: 0 b: 1.0`) or as a symbol (e.g., `#yellow`). In case a symbol is provided, it is converted to a color object using `Color>>colorFrom:`, as in `Color>>colorFrom: #yellow`. 

Although most of the configuration may be carried out by directly sending an object with a literal (e.g., `size: 80`), part of the configuration of the shape may involve dedicated objects, such as `RSBorder`.

`RSShape` is the root of all the Roassal shapes. A shape represents a visual element meant to be inserted in a `RSCanvas`. `RSShape` is an abstract class, not meant to be directly instantiated therefore.

*Responsibility*: A shape, i.e., subclass of the class `RSShape` is responsible to model a visual element. 

*Collaborators*: A shape is meaningful when inserted in a canvas

*Variables*:
- `paint`: the color of the Athens paint object used to render the visual shape
- `path`: refers to AthensCairoPath, which is a resource of a foreign object, ie., the cairo on
- `border`:
- `parent`: the parent shape
- `isFixed`: a boolean indicating if the shape is fixed (ie., not subject to the camera position and movement)

"
Class {
	#name : #RSShape,
	#superclass : #RSObjectWithProperty,
	#instVars : [
		'paint',
		'path',
		'border',
		'parent',
		'isFixed',
		'encompassingRectangle',
		'model'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
RSShape class >> model: anObject [
	"Create an instance of myself with anObject as model"
	^ self new model: anObject
]

{ #category : #accessing }
RSShape class >> model: anObject forIt: aTwoArgBlock [
	"Create an instance of myself with anObject as model. The second argument is a one arg block that is used to initialize the shape"
	| r |
	r := self new.
	r model: anObject.
	aTwoArgBlock value: r value: anObject.
	^ r
]

{ #category : #accessing }
RSShape class >> models: someObjects [
	"Create a RSGroup made of shapes. Each shape has an element of the argument as model."
	^ someObjects collect: [ :obj | self model: obj ] as: RSGroup
]

{ #category : #accessing }
RSShape class >> models: someObjects forEach: twoArgBlock [
	"Create a RSGroup made of shapes. Each shape has an element of the argument as model. The second argument is used to initialize the shape.

	For example:
```
c := RSCanvas new.

classes := RSCircle models: Collection withAllSubclasses forEach: [ :aShape :aClass | aShape size: aClass numberOfMethods ].

c addAll: classes.
RSFlowLayout on: classes.
c @ RSCanvasController
```
	"

	| r |
	r := someObjects collect: [ :obj | self model: obj ] as: RSGroup.
	r with: someObjects do: [ :aShape :anObject | twoArgBlock value: aShape value: anObject ].
	^ r
]

{ #category : #adding }
RSShape >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #'private - adding' }
RSShape >> addPendingAnimationsIn: aShapeOrCanvas [
	| key myAnimations parentAnimations |
	key := #todoAnimations.
	(self hasProperty: key) ifFalse: [ ^ self ].
	myAnimations := self propertyAt: key.
	aShapeOrCanvas isShape ifTrue: [
		parentAnimations := parent propertyAt: key ifAbsentPut: [ OrderedCollection new ].
		parentAnimations addAll: myAnimations.
	] ifFalse: [
		myAnimations do: [:anime|
			aShapeOrCanvas addAnimation: anime ] ].
	self removeKey: key
]

{ #category : #adding }
RSShape >> addRecursivelyIn: aCollection [
	aCollection add: self
]

{ #category : #adding }
RSShape >> addShapesIn: aCollection position: position [
	(self includesPoint: position)
		ifTrue: [ aCollection add: self ]
]

{ #category : #'private - adding' }
RSShape >> addedIn: aCanvas [
	"This is a private method"
	| evt |
	self isFixed
		ifTrue: [ aCanvas addFixedShape: self ]
		ifFalse: [ aCanvas addBasicShape: self ].
	parent ifNotNil: [ self remove ].
	parent := aCanvas.
	self addPendingAnimationsIn: parent.

	evt := RSShapeAddedEvent new shape: self.
	aCanvas announce: evt.
	self announce: evt
]

{ #category : #announcer }
RSShape >> announce: anEventOrAnEventClassOrABlock [

	"Send an event. The event is provided as argument, and may be either an event object, an event class, or a block (taking no argument) that returns an event object. These different way of specifying events addresses some performance concern."

	| theEventToSend |
	announcer ifNil: [ ^ self ].
	theEventToSend := anEventOrAnEventClassOrABlock value asAnnouncement.
	theEventToSend canvas ifNil: [ theEventToSend canvas: self canvas ].

	theEventToSend shape: self.
	announcer announce: theEventToSend
]

{ #category : #announcer }
RSShape >> announcementClasses [
	^ RSShapeEvent withAllSubclasses
		reject: [ :subcls| subcls hasSubclasses ]
]

{ #category : #border }
RSShape >> border [
	^ border
]

{ #category : #border }
RSShape >> border: aBorder [
	border := aBorder
]

{ #category : #border }
RSShape >> borderColor [
	^ self border color
]

{ #category : #border }
RSShape >> borderColor: aColor [
	"Set a border with the provided color. For example:

```
c := RSCanvas new.
r := Random seed: 42.
40 timesRepeat: [
	box := RSBox new width: (r nextInteger: 80); height: (r nextInteger: 80); color: Color gray; cornerRadius: 10.
	box borderColor: #black.
	box color: Color random translucent.
	box translateTo: (r nextInteger: 200) @ (r nextInteger: 200).
	c add: box.
].
c @ RSCanvasController.
c open
```"
	border ifNil: [ self withBorder ].
	self border color: aColor
]

{ #category : #border }
RSShape >> borderWidth: aNumber [
	border ifNil: [ self withBorder ].
	self border width: aNumber
]

{ #category : #'accessing - computed' }
RSShape >> canvas [
	"Return the canvas in which I belong to. Can return nil if the shape is not added to a canvas"
	parent ifNil: [ ^ nil ].
	^ parent isShape
		ifTrue: [ parent canvas ]
		ifFalse: [ parent ]
]

{ #category : #accessing }
RSShape >> children [
	"only RSComposite can use children"
	^ nil
]

{ #category : #accessing }
RSShape >> color [
	^ paint
]

{ #category : #accessing }
RSShape >> color: aColor [
	"Set the color of the shape.

```Smalltalk
c := RSCanvas new.
c add: (RSBox new size: 50; color: #blue).
c
```

```Smalltalk
c := RSCanvas new.
c add: (RSBox new size: 50; color: Color blue).
c
```
	"
	paint := aColor.
	paint isColor ifTrue: [ ^ self ].
	paint := Color colorFrom: aColor
]

{ #category : #accessing }
RSShape >> computeEncompassingRectangle [
	self subclassResponsibility
]

{ #category : #accessing }
RSShape >> computeEncompassingRectangleFor: rect matrix: aMatrix [
	| groupOfPoints |
	groupOfPoints := #(topLeft topRight bottomRight bottomLeft)
		collect: [ :s | aMatrix transform: (s value: rect) ].
	^ Rectangle encompassing: groupOfPoints
]

{ #category : #copying }
RSShape >> copyWithAnnouncer [
	"Answer a copy of this shape that shares the same instance of announcer (The default #postCopy cleans it).
	This means that interactions and subscription handlers to any RSEvent will be shared between both instances.
	This is useful for optimizations. Senders should be careful!

	Example:
		base := RSBox new
		    size: 100;
		    color: Color blue;
		    popup;
		    draggable.

		shapes := (1 to: 20) collect:[:i |
		    base copyWithEvents
		        model: i;
		        yourself.
		    ].
		c := RSCanvas new.
		RSHorizontalLineLayout on: shapes.
		c addAll: shapes.
		c zoomToFit.
	"

	^ self copy
		announcer: announcer;
		yourself
]

{ #category : #copying }
RSShape >> copyWithoutAnnouncer [
	^ self copy
]

{ #category : #'looking up shapes' }
RSShape >> deepShapeFromModel: anObject result: result [
	self model = anObject ifTrue: [ result add: self ]
]

{ #category : #'looking up shapes' }
RSShape >> deepShapesFromModel: anObject result: result [
	self model = anObject ifTrue: [ result add: self ]
]

{ #category : #'looking up shapes' }
RSShape >> deepShapesFromModels: someObjects result: result [
	(someObjects includes: self model) ifTrue: [ result add: self ]
]

{ #category : #defaults }
RSShape >> defaultColor [
	^ Color lightGray
]

{ #category : #'accessing - attributes' }
RSShape >> depth [
	^ self propertyAt: #depth
]

{ #category : #'accessing - attributes' }
RSShape >> depth: anObject [
	"depth is used by tree builders usefull to relationate hierarchy visualizations"
	self propertyAt: #depth put: anObject
]

{ #category : #accessing }
RSShape >> encompassingRectangle [
	^ encompassingRectangle ifNil: [
		encompassingRectangle := self computeEncompassingRectangle ]
]

{ #category : #accessing }
RSShape >> encompassingRectangle: aRectangle [
	encompassingRectangle := aRectangle
]

{ #category : #accessing }
RSShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #accessing }
RSShape >> fill: aColor [
	self color: (aColor isNumber ifTrue: [ Color r: aColor g: aColor b: aColor range: 255 ])
]

{ #category : #accessing }
RSShape >> globalEncompassingRectangle [
	^ self encompassingRectangle
]

{ #category : #testing }
RSShape >> hasBorder [
	^ border notNil and: [ border width > 0 ]
]

{ #category : #testing }
RSShape >> hasChildren [
	^ false
]

{ #category : #testing }
RSShape >> hasEventCallback [
	"Return true if at least one event callback has been added to the shape"

	^ announcer notNil and: [ announcer numberOfSubscriptions > 0 ]
]

{ #category : #testing }
RSShape >> hasModel [
	"Return true if a model is set in the shape. Return false otherwise"
	^ model notNil
]

{ #category : #accessing }
RSShape >> height [
	^ self extent y
]

{ #category : #testing }
RSShape >> includesPoint: aPoint [
	"Answer whether this shape includes aPoint."

	^ false
]

{ #category : #'accessing - attributes' }
RSShape >> index [
	^ self propertyAt: #index
]

{ #category : #'accessing - attributes' }
RSShape >> index: anObject [
	"the current index of this object in an object collection"
	self propertyAt: #index put: anObject
]

{ #category : #initialization }
RSShape >> initialize [
	super initialize.
	paint := self defaultColor.
	isFixed := false
]

{ #category : #testing }
RSShape >> intersects: aRectangle [
	"used in drawing operation
	aRectangle is the visible rectangle of the canvas, then this method is used
	to draw or not this shape"
	^ self subclassResponsibility
]

{ #category : #testing }
RSShape >> isComposite [
	^ false
]

{ #category : #testing }
RSShape >> isEdge [
	^ false
]

{ #category : #testing }
RSShape >> isFixed [
	^ isFixed
]

{ #category : #accessing }
RSShape >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #testing }
RSShape >> isInACanvas [
	^ parent notNil
]

{ #category : #testing }
RSShape >> isLabel [
	^ false
]

{ #category : #testing }
RSShape >> isLine [
	^ false
]

{ #category : #testing }
RSShape >> isNode [
	^ false
]

{ #category : #testing }
RSShape >> isShape [
	"Useful to lookup the canvas in a hierarchy of nested shapes"
	^ true
]

{ #category : #'accessing - attributes' }
RSShape >> model [
	"Return the model object of the shape. If no model has been set, it return `nil`"
	^ model
]

{ #category : #'accessing - attributes' }
RSShape >> model: anObject [
	"Set the model of the shape. A shape represents a visual description of the model object. In case no model is specified, the value is nil. A model is used when using interaction (e.g., popup, labeled) and normalizations."
	model := anObject
]

{ #category : #border }
RSShape >> noBorder [
	border := nil
]

{ #category : #accessing }
RSShape >> noPaint [
	paint := nil
]

{ #category : #accessing }
RSShape >> paint [
	^ paint
]

{ #category : #accessing }
RSShape >> paint: aPaint [
	"Receive a Color or an Athens paint object"
	paint := aPaint
]

{ #category : #accessing }
RSShape >> paintOn: visitor [
	^ visitor paintFor: self form: self paint
]

{ #category : #accessing }
RSShape >> parent [
	^ parent
]

{ #category : #accessing }
RSShape >> parent: aCanvasOrComposite [
	parent := aCanvasOrComposite
]

{ #category : #path }
RSShape >> path [
	^ path
]

{ #category : #path }
RSShape >> path: aPath [
	"Set the path of the shape. It set an AthensCairoPath. Note that this value is set to nil when the Pharo image is restarted"
	path := aPath
]

{ #category : #copying }
RSShape >> postCopy [
	self
		parent: nil;
		announcer: nil;
		resetPath;
		resetBBox
]

{ #category : #printing }
RSShape >> printOn: stream [
	super printOn: stream.
	model ifNil: [ ^ self ].
	stream << '('; << model asString; << ')'
]

{ #category : #actions }
RSShape >> pushBack [
	"Move the element behind. This method can be called only if the shape is in a canvas"
	self assert: [ parent notNil ] description: 'Should add the shape in a canvas first'.
	parent pushBack: self
]

{ #category : #actions }
RSShape >> pushFront [
	parent pushFront: self
]

{ #category : #actions }
RSShape >> remove [
	"Do nothing if the line is not already in a canvas"
	self isInACanvas ifFalse: [ ^ self ].
	parent removeShape: self
]

{ #category : #adding }
RSShape >> renderOn: aCanvas [
	self subclassResponsibility
]

{ #category : #initialization }
RSShape >> resetBBox [
	| shouldUpdate |
	shouldUpdate := parent notNil and: [ self isFixed not ].
	shouldUpdate 
		ifTrue: [ parent updateInShapeCollection: self ]
		ifFalse: [ encompassingRectangle := nil ]
]

{ #category : #accessing }
RSShape >> resetChildren [
]

{ #category : #path }
RSShape >> resetPath [
	path := nil
]

{ #category : #path }
RSShape >> sessionChanged [
	"This method releases all the native graphical resources. This method is typically invoked when starting a Pharo image with a visualization that was previously open"
	self resetPath
]

{ #category : #actions }
RSShape >> setAsFixed [
	"Per default, a shape is subject to the camera mouvement. If the camera is relocated, shapes appears to be relocated. This behavior can be avoided by sending the message #setAsFixed to a shape, which makes the shape fixed in the canvas. This is useful to define menus.

	The message setAsFixed must be send after being added to a canvas"
	parent ifNil: [ self error: 'Add first this shape in the canvas' ].
	parent setAsFixed: self.
	isFixed := true
]

{ #category : #accessing }
RSShape >> shape [
	^ self
]

{ #category : #'accessing - computed' }
RSShape >> shapeWithAction: eventClass forPosition: position [
	^ (self hasEventCallback and: [
		(self announcer handleEventClass: eventClass)
			and: [ self includesPoint: position ] ])
			ifTrue: [ self ]
			ifFalse: [ nil ]
]

{ #category : #'accessing - computed' }
RSShape >> shapeWithActionForPosition: position [
	^ (self hasEventCallback and: [ self includesPoint: position ] )
			ifTrue: [ self ]
			ifFalse: [ nil ]
]

{ #category : #actions }
RSShape >> signalUpdate [
	"Refresh the canvas"
	parent ifNil: [ ^ self ].
	parent signalUpdate
]

{ #category : #accessing }
RSShape >> width [
	^ self extent x
]
