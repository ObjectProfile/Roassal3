"
I am usefull to define RSElement and RSEdge
"
Class {
	#name : #RSShapedObject,
	#superclass : #RSAnnounceableObject,
	#instVars : [
		'model',
		'index',
		'view',
		'trachelShape'
	],
	#category : #'Roassal3-Core'
}

{ #category : #adding }
RSShapedObject >> addedIn: c [
	self subclassResponsibility
]

{ #category : #accessing }
RSShapedObject >> announcer [
	^ trachelShape announcer
]

{ #category : #'reflective operations' }
RSShapedObject >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: trachelShape 
]

{ #category : #accessing }
RSShapedObject >> index [
	^ index
]

{ #category : #accessing }
RSShapedObject >> index: anInteger [
	index := anInteger
]

{ #category : #testing }
RSShapedObject >> isEdge [
	^ false
]

{ #category : #testing }
RSShapedObject >> isElement [
	^ false
]

{ #category : #accessing }
RSShapedObject >> model [
	^ model
]

{ #category : #accessing }
RSShapedObject >> model: anObject [
	model := anObject
]

{ #category : #'reflective operations' }
RSShapedObject >> onMyselfDo: ablock [
	ablock value: self.
]

{ #category : #removing }
RSShapedObject >> remove [
	self subclassResponsibility
]

{ #category : #rendering }
RSShapedObject >> renderOn: trCanvas [
	trachelShape isNil ifTrue: [ self error: 'Cannot add an element without a shape. Add a shape to myself, using + or addShape:' . ^ self ].
	trCanvas addShape: trachelShape.
	
]

{ #category : #accessing }
RSShapedObject >> trachelShape [
	^ trachelShape 
]

{ #category : #accessing }
RSShapedObject >> trachelShape: aShape [
	| old |
	old := trachelShape. 
	trachelShape := aShape.
	old ifNil: [ ^ self ].
	aShape loadShape: old.
	old parent shapes replaceAll: old with: trachelShape.
	
]

{ #category : #accessing }
RSShapedObject >> view [
	^ view
]

{ #category : #accessing }
RSShapedObject >> view: aView [ 
	view := aView
]
