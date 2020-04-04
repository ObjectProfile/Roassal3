"
I am the top class of shapes
"
Class {
	#name : #RSShape,
	#superclass : #RSAttributableObject,
	#instVars : [
		'paint',
		'path',
		'border',
		'parent',
		'isFixed',
		'encompassingRectangle'
	],
	#category : #'Roassal3-Core'
}

{ #category : #adding }
RSShape >> accept: aVisitor [
	self subclassResponsibility 
]

{ #category : #adding }
RSShape >> addedIn: aCanvas [
	| evt |
	self isFixed
		ifTrue: [ aCanvas addFixedShape: self ]
		ifFalse: [ aCanvas addBasicShape: self ].
	parent ifNotNil: [ self remove ].
	parent := aCanvas.
	
	evt := RSShapeAddedEvent new shape: self.
	self announce: evt.
	"parent announce: evt."
]

{ #category : #announcer }
RSShape >> announce: anEventOrAnEventClass [
	"Send an event"
	| theEventToSend |
	announcer ifNil: [ ^ self ].
	theEventToSend := anEventOrAnEventClass value asAnnouncement.
	theEventToSend canvas: self canvas.
	theEventToSend shape: self.
	announcer announce: theEventToSend.
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
	self border color: aColor
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
	paint := aColor.
	paint isColor ifTrue: [ ^ self ].
	paint := Color colorFrom: aColor.
]

{ #category : #accessing }
RSShape >> computeEncompassingRectangle [
	self subclassResponsibility
]

{ #category : #'accessing - attributes' }
RSShape >> depth [
	^ self attributeAt: #depth
]

{ #category : #'accessing - attributes' }
RSShape >> depth: anObject [
	"depth is used by tree builders usefull to relationate hierarchy visualizations"
	self attributeAt: #depth put: anObject
]

{ #category : #accessing }
RSShape >> encompassingRectangle [
	^ encompassingRectangle ifNil: [ 
		encompassingRectangle := self computeEncompassingRectangle ].
]

{ #category : #accessing }
RSShape >> encompassingRectangle: aRectangle [
	encompassingRectangle := aRectangle
]

{ #category : #accessing }
RSShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #testing }
RSShape >> hasBorder [
	^ border notNil and: [ border width > 0 ].
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

{ #category : #accessing }
RSShape >> height [
	^ self extent y
]

{ #category : #testing }
RSShape >> includesPoint: aPoint [
	"Return true or false"
	^ false
]

{ #category : #'accessing - attributes' }
RSShape >> index [
	^ self attributeAt: #index
]

{ #category : #'accessing - attributes' }
RSShape >> index: anObject [
	"the current index of this object in an object collection"
	self attributeAt: #index put: anObject
]

{ #category : #initialization }
RSShape >> initialize [
	super initialize.
	paint := Color lightGray.
	isFixed := false.
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
RSShape >> isNode [
	^ false
]

{ #category : #'accessing - attributes' }
RSShape >> isSLeaf [
	^ self schildren isEmpty
]

{ #category : #testing }
RSShape >> isShape [
	"Useful to lookup the canvas in a hierarchy of nested shapes"
	^ true
]

{ #category : #actions }
RSShape >> loadShape: aShape [
	self subclassResponsibility
]

{ #category : #'accessing - attributes' }
RSShape >> model [
	^ self attributeAt: #model
]

{ #category : #'accessing - attributes' }
RSShape >> model: anObject [
	"model is used to create popups and other interactions"
	self attributeAt: #model put: anObject
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
	| model |
	super printOn: stream.
	model := self model.
	model ifNil: [ ^ self ].
	stream << '('; << model asString; << ')'.
]

{ #category : #actions }
RSShape >> pushBack [
	"Move the element behind. This method can be called only if the shape is in a canvas"
	self assert: [ parent notNil ] description: 'Should add the shape in a canvas first'.
	parent pushBack: self.
]

{ #category : #actions }
RSShape >> pushFront [
	parent pushFront: self.
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

{ #category : #actions }
RSShape >> replaceWith: aShape [
	parent ifNil: [ ^ self ].
	aShape loadShape: self.
	parent shapes replaceAll: self with: aShape.
	parent nodes replaceAll: self with: aShape.
	
]

{ #category : #initialization }
RSShape >> resetBBox [
	encompassingRectangle := nil.
]

{ #category : #path }
RSShape >> resetPath [
	path := nil
]

{ #category : #'accessing - attributes' }
RSShape >> schildren [
	^ self attributeAt: #schildren
]

{ #category : #'accessing - attributes' }
RSShape >> schildren: anObject [
	"children is used by tree builders usefull to relationate hierarchy visualizations"
	self attributeAt: #schildren put: anObject
]

{ #category : #path }
RSShape >> sessionChanged [
	self resetPath
]

{ #category : #actions }
RSShape >> setAsFixed [
	parent ifNil: [ self error: 'Add first this shape in the canvas' ].
	parent setAsFixed: self.
	isFixed := true.
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
			ifFalse: [ ^ nil ]
]

{ #category : #'accessing - computed' }
RSShape >> shapeWithActionForPosition: position [
	^ (self hasEventCallback and: [ self includesPoint: position ] ) 
			ifTrue: [ self ]
			ifFalse: [ ^ nil ]
]

{ #category : #actions }
RSShape >> signalUpdate [
	"Refresh the canvas"
	parent ifNil: [ ^ self ].
	parent signalUpdate
]

{ #category : #'accessing - attributes' }
RSShape >> sparent [
	^ self attributeAt: #sparent
]

{ #category : #'accessing - attributes' }
RSShape >> sparent: anObject [
	"children is used by tree builders usefull to relationate hierarchy visualizations"
	self attributeAt: #sparent put: anObject
]

{ #category : #accessing }
RSShape >> topParent [
	^ parent topParent
]

{ #category : #accessing }
RSShape >> width [
	^ self extent x
]
