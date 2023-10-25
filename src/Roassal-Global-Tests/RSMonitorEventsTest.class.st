Class {
	#name : 'RSMonitorEventsTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Shapes',
	#package : 'Roassal-Global-Tests',
	#tag : 'Shapes'
}

{ #category : 'tests' }
RSMonitorEventsTest >> testBasic [
	| canvas monitor eventClass timeStamp |
	canvas := RSCanvas new.
	monitor := RSEventsMonitor new.
	monitor target: canvas.

	eventClass := nil.
	timeStamp := nil.
	monitor onNewEventDo: [ :evt |
		eventClass := evt class.
		timeStamp := evt timeStamp.
	] for: self.

	canvas announce: RSMouseLeftClick new.
	self assert: eventClass equals: RSMouseLeftClick.
	self assert: timeStamp isNumber.

	monitor unRegister
]

{ #category : 'tests' }
RSMonitorEventsTest >> testNoTarget [
	| monitor |
	monitor := RSEventsMonitor new.
	self should: [ monitor onNewEventDo: [  ] for: self ] raise: Error
]

{ #category : 'tests' }
RSMonitorEventsTest >> testWriteToFile [
	| canvas monitor events box fileName storage |
	canvas := RSCanvas new.
	box := RSBox new size: 20; yourself.
	monitor := RSEventsMonitor new.
	monitor target: box.
	events := OrderedCollection new.
	monitor onNewEventDo: [:evt | events add: evt className -> evt timeStamp ] for: self.
	box announce: (RSPositionChangedEvent new newPosition: 100@100; yourself).
	self assert: events isNotEmpty.

	fileName := Time microsecondClockValue asString, '.fuel'.
	storage := (FLSerializer class canUnderstand: #serializeToByteArray:)
		ifTrue: [ FLSerializer serializeToByteArray: events. ]
		ifFalse: [
			ByteArray
				new: 100
				streamContents: [ :stream |
					| serializer |
					serializer := FLSerializer new.
					serializer
						perform: #onStream: with: stream;
						perform: #object: with: events.
					#serialize value: serializer ] ].
	self assert: storage size > 100
]
