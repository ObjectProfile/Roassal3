"
I represent borders and line styles
"
Class {
	#name : #TSBorder,
	#superclass : #TSObject,
	#instVars : [
		'width',
		'style',
		'paint'
	],
	#category : #'Roassal3-Trachel-Shapes-Border'
}

{ #category : #visiting }
TSBorder >> accept: visitor [
	visitor visitBorder: self
]

{ #category : #'style-cap' }
TSBorder >> capButt [
	self pStyle capStyle: #capButt.
]

{ #category : #'style-cap' }
TSBorder >> capRound [
	self pStyle capStyle: #capRound.
]

{ #category : #'style-cap' }
TSBorder >> capSquare [
	self pStyle capStyle: #capSquare.
]

{ #category : #accessing }
TSBorder >> color [
	^ paint
]

{ #category : #accessing }
TSBorder >> color: aColor [
	paint := aColor
]

{ #category : #'style-dashes' }
TSBorder >> dashArray: arrayOfNumbers [
	self pStyle dashArray: arrayOfNumbers
	
]

{ #category : #accessing }
TSBorder >> dashOffset [
	^ self pStyle dashOffset
]

{ #category : #accessing }
TSBorder >> dashOffset: offset [
	self pStyle dashOffset: offset
]

{ #category : #initialization }
TSBorder >> initialize [
	super initialize.
	paint := Color black.
	width := 1.
	style := nil
]

{ #category : #'style-join' }
TSBorder >> joinBevel [
	self pStyle joinStyle: #joinBevel
]

{ #category : #'style-join' }
TSBorder >> joinMiter [
	self pStyle joinStyle: #joinMiter
]

{ #category : #'style-join' }
TSBorder >> joinRound [
	self pStyle joinStyle: #joinRound
]

{ #category : #private }
TSBorder >> pStyle [ 
	^ style ifNil: [ style := TSStrokeStyle new ].
]

{ #category : #accessing }
TSBorder >> paint [ 
	^ paint
]

{ #category : #accessing }
TSBorder >> paint: aPaint [
	paint := aPaint
]

{ #category : #accessing }
TSBorder >> style [
	^style
]

{ #category : #accessing }
TSBorder >> style: aStyle [
	style := aStyle
]

{ #category : #accessing }
TSBorder >> width [ 
	^ width
]

{ #category : #accessing }
TSBorder >> width: anInteger [ 
	width := anInteger
]
