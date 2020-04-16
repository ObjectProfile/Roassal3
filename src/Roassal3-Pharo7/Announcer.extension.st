Extension { #name : #Announcer }

{ #category : #'*Roassal3-Pharo7' }
Announcer >> handleSubscriberClass: eventClass [
	^ self subscriptions 
		ifNil: [ false ]
		ifNotNil: [:subscriptions | subscriptions handleSubscriberClass: eventClass]
]
