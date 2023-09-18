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

{ #category : #public }
RSTAnnounceable >> click [
	"Simulate a click.

For example:
-=-=-=-=-=-=-=-=-=
c := RSCanvas new.
box := RSBox new size: 40.
box when: RSMouseClick do: [ :evt | self inform: 'hello' ].
c add: box.

box click.

c
-=-=-=-=-=-=-=-=-=
"
	self announce: (RSMouseClick new
		canvas: self canvas;
		shape: self;
		yourself)
]

{ #category : #public }
RSTAnnounceable >> executeWithoutAnnouncer: aBlock [
	| ann |
	ann := self privateAnnouncer.
	self announcer: nil.
	aBlock value.
	self announcer: ann
]

{ #category : #announcer }
RSTAnnounceable >> getInteractionsForClass: anInteractionClass [
	"Return the Announcement subscriptions for the interaction"
	^ self announcer subscriptions getInteractionsForClass: anInteractionClass
]

{ #category : #testing }
RSTAnnounceable >> handleAnnouncementClass: aClass [
	| subscriptions evt |
	evt := aClass new.
	subscriptions := self subscriptions.
	subscriptions ifNil: [ ^ false ].
	^ subscriptions subscriptions anySatisfy: [ :each | each handlesAnnouncement: evt ]
]

{ #category : #testing }
RSTAnnounceable >> hasInteraction: anInteractionClass [
	"Return true or false if the receiver has an interaction. Note that the argument has to be an interaction class. And not an event"
	| subscriptions |
	subscriptions := self subscriptions.
	subscriptions ifNil: [ ^ false ].
	^ subscriptions handleSubscriberClass: anInteractionClass
]

{ #category : #public }
RSTAnnounceable >> leftClick [

	self announce: (RSMouseLeftClick new
		canvas: self canvas;
		shape: self;
		yourself)
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

{ #category : #public }
RSTAnnounceable >> shiftLeftClick [

	self announce: (RSMouseLeftClick new
			 canvas: self canvas;
			 shiftKeyPressed: true;
			 shape: self;
			 yourself)
]

{ #category : #announcer }
RSTAnnounceable >> subscriptions [
	| anAnnouncer |
	anAnnouncer := self privateAnnouncer.
	anAnnouncer ifNil: [ ^ nil ].
	^ anAnnouncer subscriptions
]

{ #category : #protocol }
RSTAnnounceable >> when: anAnnouncementClass do: aValuable [

	| subscriberForDeprecation |
	aValuable receiver ifNil: [
		self error:
			'You must specify a subscriber object for this subscription. Please use #when:do:for: method.' ].

	subscriberForDeprecation := thisContext sender receiver = aValuable receiver
		                            ifTrue: [ 'self' ]
		                            ifFalse: [ '`@arg2 receiver' ].
	self
		deprecated:
			'Since there are some block closures (Clean and Constant) without a receiver, the API of announcements was changed to send the subscriber explicitly. 
			We are deprecating this method because it was asking for the receiver of the block to use it as the subscriber.'
		transformWith: '`@receiver when: `@arg1 do: `@arg2'
			->
			('`@receiver when: `@arg1 do: `@arg2 for: '
			 , subscriberForDeprecation).

	self when: anAnnouncementClass do: aValuable for: aValuable receiver
]

{ #category : #announcer }
RSTAnnounceable >> when: event do: aBlock for: aSubscriber [

	self announcer when: event do: aBlock for: aSubscriber
]

{ #category : #announcer }
RSTAnnounceable >> when: anAnnouncementClass send: aSelector to: anObject [
	self announcer when: anAnnouncementClass send: aSelector to: anObject
]
