"
Based on https://developers.google.com/web/tools/chrome-devtools/console/events

MonitorEvents for Roassal in order to log some events 
"
Class {
	#name : 'RSEventsMonitor',
	#superclass : 'RSObject',
	#instVars : [
		'target',
		'announcementClasses'
	],
	#category : 'Roassal-Core',
	#package : 'Roassal',
	#tag : 'Core'
}

{ #category : 'examples' }
RSEventsMonitor class >> example [
	| canvas monitor |
	canvas := RSCanvas new.
	monitor := self new.
	monitor target: canvas.
	monitor onNewEventDo: [ :evt |
		evt class trace.
		' ' trace.
		evt timeStamp traceCr.
		] for: self.
	canvas when: RSMouseClick send: #open to: Transcript.
	^ canvas open
]

{ #category : 'accessing' }
RSEventsMonitor >> announcementClasses [
	^ announcementClasses
]

{ #category : 'accessing' }
RSEventsMonitor >> announcementClasses: aCollection [
	"aCollection of Announcement "
	announcementClasses := aCollection
]

{ #category : 'public' }
RSEventsMonitor >> onNewEventDo: aBlockClosure for: aSubscriber [
	| events |
	self assert: self target isNotNil description: 'Must provide a target'.
	events := self announcementClasses.
	events ifNil:  [ events := target announcementClasses ].
	events do: [ :evt |
		target when: evt do: aBlockClosure for: aSubscriber ]
]

{ #category : 'accessing' }
RSEventsMonitor >> target [
	^ target
]

{ #category : 'accessing' }
RSEventsMonitor >> target: aRSTAnnounceable [
	target := aRSTAnnounceable
]

{ #category : 'public' }
RSEventsMonitor >> unRegister [
	target removeInteractionIfPresent: self class
]
