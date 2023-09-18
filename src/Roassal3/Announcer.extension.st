Extension { #name : #Announcer }

{ #category : #'*Roassal3' }
Announcer >> handleEventClass: eventClass [
	"Return true if the receiver has a callback subscripbed for the event class"
	^ self subscriptions handleEventClass: eventClass
]
