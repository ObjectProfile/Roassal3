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

{ #category : #'instance creation' }
TSGroup class >> new: size [
	| inst |
	inst := self basicNew.
	inst initializeMatrix.
	inst children: (OrderedCollection new: size).
	^ inst.
]

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

{ #category : #accessing }
TSGroup >> children: collection [
	children := collection 
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

{ #category : #accessing }
TSGroup >> extent [
	"THIS IS WEIRD. 
	SHOULD TSGROUPD BE A SUBCLASS OF TSBOX?"
	^ self encompassingRectangle extent
]

{ #category : #adding }
TSGroup >> initialize [
	super initialize.
	children := OrderedCollection new.
]
