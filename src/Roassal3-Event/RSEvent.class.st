"
<keyClass>
`RSEvent` is the root of all the events handled by Roassal. Events are expressed as an instance of a subclass of `RSEvent`. Some events describe the actions made by the users (e.g., `RSMouseDragEnd`), some other event describes some state change of a shape (e.g., `RSShapeAddedEvent`, `RSHighlightEvent`).

*Responsibility*: model an event triggered either by a user action or a state change.

*Collaborators*: events are emitted by `RSAthensMorph` or by some interaction (e.g., `RSHighlightable`)

*Variables*:
- `canvas`: the `RSCanvas` 
- `morph`: the `RSAthensMorph` 
- `shape`: the shape related to the event
  
"
Class {
	#name : #RSEvent,
	#superclass : #Announcement,
	#instVars : [
		'canvas',
		'morph',
		'shape',
		'timeStamp'
	],
	#category : #'Roassal3-Event'
}

{ #category : #accessing }
RSEvent >> camera [
	^ self canvas camera
]

{ #category : #accessing }
RSEvent >> canvas [

	^ canvas ifNil: [ 
		  canvas := shape ifNil: [ nil ] ifNotNil: [ shape canvas ] ]
]

{ #category : #accessing }
RSEvent >> canvas: aRSCanvas [
	canvas := aRSCanvas
]

{ #category : #initialization }
RSEvent >> initialize [
	super initialize.
	self timeStamp
]

{ #category : #accessing }
RSEvent >> morph [
	^ morph ifNil: [ ^ morph := self canvas morph ]
]

{ #category : #accessing }
RSEvent >> morph: aMorph [
	morph := aMorph
]

{ #category : #accessing }
RSEvent >> shape [
	^ shape
]

{ #category : #accessing }
RSEvent >> shape: aRSShape [
	"An event should now the shape to which it is related to.
	The shape has to be set before emitting the event."
	shape := aRSShape
]

{ #category : #accessing }
RSEvent >> signalUpdate [
	"Trigger a refresh of the morph. The method signalUpdate has to be called when some visual properties are changed (e.g., color, position)"
	morph notNil ifTrue: [ morph changed ]
]

{ #category : #accessing }
RSEvent >> timeStamp [
	"Return the millisecond clock value at which the event was generated"
	^ timeStamp ifNil:[ timeStamp := Time millisecondClockValue ]
]

{ #category : #accessing }
RSEvent >> timeStamp: stamp [
	timeStamp := stamp
]
