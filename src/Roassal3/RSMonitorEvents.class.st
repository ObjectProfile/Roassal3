"
Based on https://developers.google.com/web/tools/chrome-devtools/console/events

MonitoEvents for Roassal3 in order to log some events 
"
Class {
	#name : #RSMonitorEvents,
	#superclass : #RSObject,
	#instVars : [
		'target',
		'announcementClasses'
	],
	#category : #'Roassal3-Core'
}

{ #category : #accessing }
RSMonitorEvents >> announcementClasses [
	^ announcementClasses
]

{ #category : #accessing }
RSMonitorEvents >> announcementClasses: aCollection [
	"aCollection of Announcement "
	announcementClasses := aCollection
]

{ #category : #public }
RSMonitorEvents >> onNewEventDo: aBlockClosure [
	| events |
	self assert: self target isNotNil description: 'Must provide a target'.
	events := self announcementClasses.
	events ifNil:  [ events := target announcementClasses ].
	events do: [ :evt |
		target when: evt do: aBlockClosure ].
]

{ #category : #accessing }
RSMonitorEvents >> target [
	^ target
]

{ #category : #accessing }
RSMonitorEvents >> target: aRSTAnnounceable [
	target := aRSTAnnounceable
]

{ #category : #public }
RSMonitorEvents >> unRegister [
	target removeInteractionIfPresent: self class.
]
