Class {
	#name : #RSMonitorEventsTest,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Shapes'
}

{ #category : #tests }
RSMonitorEventsTest >> testBasic [
	| canvas monitor eventClass timeStamp |
	canvas := RSCanvas new.
	monitor := RSMonitorEvents new.
	monitor target: canvas.
	
	eventClass := nil.
	timeStamp := nil.
	monitor onNewEventDo: [ :evt | 
		eventClass := evt class.
		timeStamp := evt timeStamp.
	].
	
	canvas announce: RSMouseLeftClick new.
	self assert: eventClass equals: RSMouseLeftClick.
	self assert: timeStamp isNumber.
	
	monitor unRegister.
	eventClass := nil.
	self assert: eventClass isNil.
]

{ #category : #tests }
RSMonitorEventsTest >> testNoTarget [ 
	| monitor |
	monitor := RSMonitorEvents new.
	self should: [ monitor onNewEventDo: [  ] ] raise: Error
]

{ #category : #tests }
RSMonitorEventsTest >> testWriteToFile [
	| canvas monitor events box fileName fileReference |
	canvas := RSCanvas new.
	box := RSBox new size: 20; yourself.
	monitor := RSMonitorEvents new.
	monitor target: box.
	events := OrderedCollection new.
	monitor onNewEventDo: [:evt | events add: evt className -> evt timeStamp ].
	box announce: (RSPositionChangedEvent new newPosition: 100@100; yourself).
	self assert: events isNotEmpty.
	
	fileName := Time microsecondClockValue asString, '.fuel'.
	FLSerializer serialize: events toFileNamed: fileName.
	fileReference := fileName asFileReference.
	self assert: fileReference exists.
	fileReference delete.
]
