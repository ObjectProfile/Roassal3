"
I am usefull to define RSElement and RSEdge
"
Class {
	#name : #RSShapedObject,
	#superclass : #RSObject,
	#instVars : [
		'model',
		'index',
		'parent',
		'shape'
	],
	#category : #'Roassal3-Scripting-Core'
}

{ #category : #adding }
RSShapedObject >> addedIn: c [
	self subclassResponsibility
]

{ #category : #adding }
RSShapedObject >> announceAdded: eventClass parent: aParent [
	| evt |
	parent := aParent.
	evt := eventClass new shapedObject: self.
	parent announce: evt.
	shape announce: evt.
]

{ #category : #accessing }
RSShapedObject >> announcer [
	^ shape announcer
]

{ #category : #'reflective operations' }
RSShapedObject >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: shape 
]

{ #category : #inspector }
RSShapedObject >> gtInspectorCanvasIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Element'];
		initializeCanvas: [ self shape gtCanvasForInspector ]
]

{ #category : #inspector }
RSShapedObject >> gtInspectorSybscriptionsIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite table
		title: ['Subscriptions'];
		display: [ shape announcer subscriptions subscriptions ];
		when: [ shape privateAnnouncer notNil ];
		column: 'Subscriber' evaluated: [ :each | each subscriber asString ];
		column: 'Announcement' evaluated: [ :each | each announcementClass printString ].
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

{ #category : #testing }
RSShapedObject >> isRoassalElement [
	^ true
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

{ #category : #accessing }
RSShapedObject >> parent [
	^ parent
]

{ #category : #accessing }
RSShapedObject >> parent: aViewOrElement [
	parent := aViewOrElement
]

{ #category : #accessing }
RSShapedObject >> privateTrachelShape: aShape [
	shape := aShape
]

{ #category : #removing }
RSShapedObject >> remove [
	self subclassResponsibility
]

{ #category : #rendering }
RSShapedObject >> renderOn: trCanvas [
	shape isNil ifTrue: [ self error: 'Cannot add an element without a shape. Add a shape to myself, using + or addShape:' . ^ self ].
	trCanvas addShape: shape.
	
]

{ #category : #accessing }
RSShapedObject >> shape [
	^ shape 
]

{ #category : #accessing }
RSShapedObject >> shape: aShape [
	| old |
	old := shape. 
	self privateTrachelShape: aShape.
	old ifNil: [ ^ self ].
	aShape loadShape: old.
	old parent shapes replaceAll: old with: shape.
	
]

{ #category : #accessing }
RSShapedObject >> view [
	^ parent view
]

{ #category : #accessing }
RSShapedObject >> view: aView [ 
	parent:= aView
]
