Extension { #name : #SubscriptionRegistry }

{ #category : #'*Roassal3-Pharo7' }
SubscriptionRegistry >> handleSubscriberClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"
	^ subscriptions anySatisfy: [ :sub | 
		sub subscriber class includesBehavior: eventClass ]
]
