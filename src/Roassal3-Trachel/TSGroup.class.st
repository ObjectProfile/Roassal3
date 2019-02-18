"
I am a shape but also I am a composition of shapes
"
Class {
	#name : #TSGroup,
	#superclass : #TSBox,
	#instVars : [
		'children'
	],
	#category : #'Roassal3-Trachel-Shapes'
}

{ #category : #visiting }
TSGroup >> accept: visitor [
	visitor visitGroup: self
]

{ #category : #adding }
TSGroup >> addShape: shape [
	children add: shape
]

{ #category : #accessing }
TSGroup >> children [
	^ children
]

{ #category : #'reflective operations' }
TSGroup >> doesNotUnderstand: message [
	^ children perform: message selector withArguments: message arguments
]

{ #category : #accessing }
TSGroup >> encompassingRectangle [
	^ self
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ Rectangle merging: (self collect: #encompassingRectangle) ]
]

{ #category : #adding }
TSGroup >> initialize [
	super initialize.
	children := OrderedCollection new.
]
