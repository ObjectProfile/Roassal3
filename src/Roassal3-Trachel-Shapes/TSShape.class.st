"
I am the top class of shapes
"
Class {
	#name : #TSShape,
	#superclass : #TSObject,
	#instVars : [
		'paint',
		'path',
		'border',
		'announcer',
		'parent',
		'isFixed',
		'encompassingRectangle'
	],
	#category : #'Roassal3-Trachel-Shapes-Core'
}

{ #category : #adding }
TSShape >> addedIn: aCanvas [
	self isFixed
		ifTrue: [ aCanvas addFixedShape: self ]
		ifFalse: [ aCanvas addBasicShape: self ].
	parent ifNotNil: [ self remove ].
	parent := aCanvas.
]

{ #category : #events }
TSShape >> announce: anEventOrAnEventClass [
	"Send an event"
	| theEventToSend |
	announcer ifNil: [ ^ self ].
	theEventToSend := anEventOrAnEventClass value asAnnouncement.
	theEventToSend canvas: self canvas.
	theEventToSend shape: self.
	announcer announce: theEventToSend.
]

{ #category : #events }
TSShape >> announcer [
	announcer isNil ifTrue: [ announcer := Announcer new ].
	^ announcer
]

{ #category : #events }
TSShape >> announcer: anAnnouncer [
	announcer := anAnnouncer
]

{ #category : #converting }
TSShape >> asMarker [
	^ TSMarker new shape: self
]

{ #category : #border }
TSShape >> border [
	^ border
]

{ #category : #border }
TSShape >> border: aBorder [
	border := aBorder
]

{ #category : #border }
TSShape >> borderColor [
	^ self border color
]

{ #category : #border }
TSShape >> borderColor: aColor [
	self border color: aColor
]

{ #category : #border }
TSShape >> borderDo: aBlock [
	border ifNil: [ border := TSBorder new ].
	aBlock value: border
]

{ #category : #'accessing - computed' }
TSShape >> canvas [
	"Return the canvas in which I belong to. Can return nil if the shape is not added to a canvas" 
	parent ifNil: [ ^ nil ].
	^ parent isShape 
		ifTrue: [ parent canvas ]
		ifFalse: [ parent ]
]

{ #category : #accessing }
TSShape >> color [
	^ paint 
]

{ #category : #accessing }
TSShape >> color: aColor [
	paint := aColor.
	paint isColor ifTrue: [ ^ self ].
	paint := Color colorFrom: aColor.
]

{ #category : #accessing }
TSShape >> encompassingRectangle [
	^ self subclassResponsibility 
]

{ #category : #accessing }
TSShape >> encompassingRectangle: aRectangle [
	encompassingRectangle := aRectangle
]

{ #category : #accessing }
TSShape >> extent [
	^ self encompassingRectangle extent
]

{ #category : #testing }
TSShape >> hasBorder [
	^ border notNil and: [ border width > 0 ].
]

{ #category : #testing }
TSShape >> hasEventCallback [
	"Return true if at least one event callback has been added to the shape"
	^ announcer notNil and: [ announcer numberOfSubscriptions > 0 ]
]

{ #category : #accessing }
TSShape >> height [
	^ self extent y
]

{ #category : #testing }
TSShape >> includesPoint: aPoint [
	"Return true or false"
	^ false
]

{ #category : #initialization }
TSShape >> initialize [
	super initialize.
	paint := Color lightGray.
	isFixed := false.
]

{ #category : #testing }
TSShape >> isFixed [ 
	^ isFixed
]

{ #category : #accessing }
TSShape >> isFixed: aBool [
	isFixed := aBool
]

{ #category : #testing }
TSShape >> isInACanvas [
	^ parent notNil
]

{ #category : #testing }
TSShape >> isRoassalElement [
	^ false
]

{ #category : #testing }
TSShape >> isShape [
	"Useful to lookup the canvas in a hierarchy of nested shapes"
	^ true
]

{ #category : #actions }
TSShape >> loadShape: aShape [
	self subclassResponsibility
]

{ #category : #animation }
TSShape >> newAnimation [
	^ parent newAnimation
]

{ #category : #accessing }
TSShape >> noPaint [
	paint := nil
]

{ #category : #accessing }
TSShape >> paint [
	^ paint
]

{ #category : #accessing }
TSShape >> paint: aPaint [
	paint := aPaint
]

{ #category : #accessing }
TSShape >> paintOn: visitor [
	^ visitor paintFor: self form: self paint
]

{ #category : #accessing }
TSShape >> parent [
	^ parent
]

{ #category : #accessing }
TSShape >> parent: aCanvasOrComposite [
	parent := aCanvasOrComposite
]

{ #category : #path }
TSShape >> path [
	^ path
]

{ #category : #path }
TSShape >> path: aPath [
	path := aPath
]

{ #category : #actions }
TSShape >> pushBack [
	parent pushBack: self.
]

{ #category : #actions }
TSShape >> pushFront [
	parent pushFront: self.
]

{ #category : #dependencies }
TSShape >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #actions }
TSShape >> remove [
	"Do nothing if the line is not already in a canvas"
	self isInACanvas ifFalse: [ ^ self ]. 
	parent removeShape: self
]

{ #category : #initialization }
TSShape >> resetBBox [
	encompassingRectangle := nil.
]

{ #category : #path }
TSShape >> resetPath [
	path := nil
]

{ #category : #actions }
TSShape >> setAsFixed [
	parent ifNil: [ self error: 'Add first this shape in the canvas' ].
	parent setAsFixed: self.
	isFixed := true.
]

{ #category : #'accessing - computed' }
TSShape >> shapeWithAction: eventClass forPosition: position [
	^ (self hasEventCallback and: [ 
		(self announcer handleEventClass: eventClass)
			and: [ self includesPoint: position ] ]) 
			
			ifTrue: [ self ]
			ifFalse: [ ^ nil ]
]

{ #category : #'accessing - computed' }
TSShape >> shapeWithActionForPosition: position [
	^ (self hasEventCallback and: [ self includesPoint: position ] ) 
			ifTrue: [ self ]
			ifFalse: [ ^ nil ]
]

{ #category : #actions }
TSShape >> signalUpdate [
	"Refresh the canvas"
	parent ifNil: [ ^ self ].
	parent signalUpdate
]

{ #category : #accessing }
TSShape >> topParent [
	^ parent topParent
]

{ #category : #accessing }
TSShape >> trachelShape [
	^ self
]

{ #category : #events }
TSShape >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #accessing }
TSShape >> width [
	^ self extent x
]
