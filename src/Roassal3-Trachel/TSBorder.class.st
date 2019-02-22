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
	#category : #'Roassal3-Trachel-Border'
}

{ #category : #visiting }
TSBorder >> accept: visitor [
	visitor visitBorder: self
]

{ #category : #accessing }
TSBorder >> color [
	^ paint
]

{ #category : #accessing }
TSBorder >> color: aColor [
	paint := aColor
]

{ #category : #accessing }
TSBorder >> initialize [
	super initialize.
	paint := Color black.
	width := 1.
	style := nil
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
