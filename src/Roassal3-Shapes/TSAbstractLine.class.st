"
I represent the abstract lines that have start and end points
"
Class {
	#name : #TSAbstractLine,
	#superclass : #TSShape,
	#traits : 'TMarkeable',
	#classTraits : 'TMarkeable classTrait',
	#category : #'Roassal3-Shapes-Core'
}

{ #category : #visiting }
TSAbstractLine >> accept: visitor [
	visitor visitLine: self.
]

{ #category : #'style-cap' }
TSAbstractLine >> capButt [
	self border capButt
]

{ #category : #'style-cap' }
TSAbstractLine >> capRound [
	self border capRound
]

{ #category : #'style-cap' }
TSAbstractLine >> capSquare [
	self border capSquare
]

{ #category : #accessing }
TSAbstractLine >> color [
	^ self strokePaint
]

{ #category : #accessing }
TSAbstractLine >> color: aColor [
	self strokePaint: aColor
]

{ #category : #accessing }
TSAbstractLine >> computeEncompassingRectangle [
	| cp |
	cp := self controlPoints.
	^ cp 
			ifEmpty: [ 0@0 corner: 0@0 ]
			ifNotEmpty: [ Rectangle encompassing: cp ]
]

{ #category : #accessing }
TSAbstractLine >> controlPoints [
	^ self subclassResponsibility
]

{ #category : #'style-dashes' }
TSAbstractLine >> dashArray: arrayOfNumbers [
	self border dashArray: arrayOfNumbers
	
]

{ #category : #accessing }
TSAbstractLine >> endPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
TSAbstractLine >> endPoint: aPoint [
	self subclassResponsibility
]

{ #category : #testing }
TSAbstractLine >> hasMarkers [
	| m |
	m := self privateMarkers.
	^ m notNil and: [ 
		m anySatisfy: [ :mar | mar notNil ].  ]
]

{ #category : #initialization }
TSAbstractLine >> initialize [ 
	super initialize.
	paint := nil.
	border := TSBorder new.
	
]

{ #category : #testing }
TSAbstractLine >> isControlPointsLine [
	^ false
]

{ #category : #'style-join' }
TSAbstractLine >> joinBevel [
	self border joinBevel
]

{ #category : #'style-join' }
TSAbstractLine >> joinMiter [
	self border joinMiter
]

{ #category : #'style-join' }
TSAbstractLine >> joinRound [
	self border joinRound
]

{ #category : #actions }
TSAbstractLine >> loadShape: other [
	self shouldBeImplemented 
]

{ #category : #'event handling' }
TSAbstractLine >> notifyExtentChanged [
	self announce: [ TSExtentChangedEvent new 
		shape: self;
		oldExtent: nil;
		newExtent: self controlPoints first - self controlPoints last ]
]

{ #category : #private }
TSAbstractLine >> privateMarkers [
	^ nil
]

{ #category : #path }
TSAbstractLine >> resetPath [
	super resetPath.
	self resetBBox
]

{ #category : #path }
TSAbstractLine >> sessionChanged [
	self resetPath.
	self hasMarkers ifFalse: [ ^ self ].
	self markersDo: [ :mark | mark shape sessionChanged ].
	
]

{ #category : #accessing }
TSAbstractLine >> startPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
TSAbstractLine >> startPoint: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
TSAbstractLine >> strokeColor: aColor [
	self strokePaint: aColor
]

{ #category : #accessing }
TSAbstractLine >> strokePaint [
	^ self border paint
]

{ #category : #accessing }
TSAbstractLine >> strokePaint: aPaint [
	self border paint: aPaint.
]

{ #category : #accessing }
TSAbstractLine >> width: aNumber [
	self border width: aNumber.
]
