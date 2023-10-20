Extension { #name : 'SubscriptionRegistry' }

{ #category : '*Roassal' }
SubscriptionRegistry >> getInteractionsForClass: eventClass [
	"Return the list of subscription for a given Event class"
	| answer |
	answer := OrderedCollection new.
	subscriptions do: [ :sub |
		((sub subscriber class == eventClass) or:
			[ sub subscriber class inheritsFrom: eventClass ]) ifTrue: [ answer add: sub subscriber ] ].
	^ answer
]

{ #category : '*Roassal' }
SubscriptionRegistry >> handleEventClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"
	^ subscriptions
		anySatisfy: [ :sub | sub announcementClass includesBehavior: eventClass ]
]
