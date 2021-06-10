"
Used for objects and shapes with an announcer
"
Trait {
	#name : #RSTAnnounceable,
	#category : #'Roassal3-Core'
}

{ #category : #announcer }
RSTAnnounceable >> announce: anEvent [
	| a |
	a := self privateAnnouncer.
	a ifNil: [ ^ self ].
	a announce: anEvent value
]

{ #category : #announcer }
RSTAnnounceable >> announcementClasses [
	"must return a collection of Announcement classes"
	^ self explicitRequirement
]

{ #category : #announcer }
RSTAnnounceable >> announcer [
	^ self privateAnnouncer ifNil: [ 
		| a |
		a := Announcer new.
		self announcer: a.
		a ]
]

{ #category : #announcer }
RSTAnnounceable >> announcer: anAnnouncer [
	self explicitRequirement
]

{ #category : #announcer }
RSTAnnounceable >> getInteractionsForClass: anInteractionClass [
	"Return the Announcement subscriptions for the interaction"
	^ self announcer subscriptions getInteractionsForClass: anInteractionClass
]

{ #category : #testing }
RSTAnnounceable >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	self announcer subscriptions ifNil: [ ^ false ].
	^ self announcer subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : #announcer }
RSTAnnounceable >> privateAnnouncer [
	^ self explicitRequirement
]

{ #category : #removing }
RSTAnnounceable >> removeInteractionIfPresent: anInteractionClass [
	"Remove all the callbacks associated to the interaction."
	(self hasInteraction: anInteractionClass) ifFalse: [ ^ self ].
	(self getInteractionsForClass: anInteractionClass) do: [ :int | self announcer unsubscribe: int ]
]

{ #category : #announcer }
RSTAnnounceable >> when: event do: aBlock [
	self announcer when: event do: aBlock
]

{ #category : #announcer }
RSTAnnounceable >> when: anAnnouncementClass send: aSelector to: anObject [
	self announcer when: anAnnouncementClass send: aSelector to: anObject
]
