Extension { #name : #SubscriptionRegistry }

{ #category : #'*Roassal3-Trachel' }
SubscriptionRegistry >> handleEventClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"
	^ subscriptions
		anySatisfy: [ :sub | sub announcementClass includesBehavior: eventClass ]
]
