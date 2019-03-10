"
I represent the abstract lines that have start and end points
"
Class {
	#name : #TSAbstractLine,
	#superclass : #TSShape,
	#category : #'Roassal3-Trachel-Shapes-Core'
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

{ #category : #'style-dashes' }
TSAbstractLine >> dashArray: arrayOfNumbers [
	self border dashArray: arrayOfNumbers
	
]

{ #category : #accessing }
TSAbstractLine >> encompassingRectangle [
	^ Rectangle encompassing: (Array with: self startPoint with: self endPoint)
]

{ #category : #accessing }
TSAbstractLine >> endPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
TSAbstractLine >> endPoint: aPoint [
	self subclassResponsibility
]

{ #category : #initialization }
TSAbstractLine >> initialize [ 
	super initialize.
	paint := nil.
	border := TSBorder new.
	
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
