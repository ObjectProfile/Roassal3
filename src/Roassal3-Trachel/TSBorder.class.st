"
I represent borders and line styles
"
Class {
	#name : #TSBorder,
	#superclass : #TSObject,
	#instVars : [
		'width',
		'style',
		'color'
	],
	#category : #'Roassal3-Trachel-Border'
}

{ #category : #visiting }
TSBorder >> accept: visitor [
	visitor visitBorder: self
]

{ #category : #accessing }
TSBorder >> color [
	^ color
]

{ #category : #accessing }
TSBorder >> color: aColor [
	color := aColor
]

{ #category : #accessing }
TSBorder >> initialize [
	super initialize.
	color := Color black.
	width := 1.
	style := nil
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
