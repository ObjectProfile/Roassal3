"
I represent borders and line styles
"
Class {
	#name : #RSBorder,
	#superclass : #RSObject,
	#instVars : [
		'width',
		'style',
		'paint'
	],
	#category : #'Roassal3-Border'
}

{ #category : #visiting }
RSBorder >> accept: visitor [
	^ visitor visitBorder: self
]

{ #category : #'style-cap' }
RSBorder >> capButt [
	self pStyle capStyle: #capButt.
]

{ #category : #'style-cap' }
RSBorder >> capRound [
	self pStyle capStyle: #capRound.
]

{ #category : #'style-cap' }
RSBorder >> capSquare [
	self pStyle capStyle: #capSquare.
]

{ #category : #accessing }
RSBorder >> color [
	^ paint
]

{ #category : #accessing }
RSBorder >> color: aColor [
	paint := aColor.
	paint isColor ifTrue: [ ^ self ].
	paint := Color colorFrom: aColor.
]

{ #category : #'style-dashes' }
RSBorder >> dashArray: arrayOfNumbers [
	self pStyle dashArray: arrayOfNumbers
	
]

{ #category : #accessing }
RSBorder >> dashOffset [
	^ self pStyle dashOffset
]

{ #category : #accessing }
RSBorder >> dashOffset: offset [
	self pStyle dashOffset: offset
]

{ #category : #initialization }
RSBorder >> initialize [
	super initialize.
	paint := Color black.
	width := 1.
	style := nil
]

{ #category : #'style-join' }
RSBorder >> joinBevel [
	self pStyle joinStyle: #joinBevel
]

{ #category : #'style-join' }
RSBorder >> joinMiter [
	self pStyle joinStyle: #joinMiter
]

{ #category : #'style-join' }
RSBorder >> joinRound [
	self pStyle joinStyle: #joinRound
]

{ #category : #private }
RSBorder >> pStyle [ 
	^ style ifNil: [ style := RSStrokeStyle new ].
]

{ #category : #accessing }
RSBorder >> paint [ 
	^ paint
]

{ #category : #accessing }
RSBorder >> paint: aPaint [
	paint := aPaint
]

{ #category : #accessing }
RSBorder >> style [
	^style
]

{ #category : #accessing }
RSBorder >> style: aStyle [
	style := aStyle
]

{ #category : #accessing }
RSBorder >> width [ 
	^ width
]

{ #category : #accessing }
RSBorder >> width: anInteger [ 
	width := anInteger
]
