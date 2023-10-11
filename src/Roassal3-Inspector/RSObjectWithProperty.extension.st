Extension { #name : 'RSObjectWithProperty' }

{ #category : '*Roassal3-Inspector' }
RSObjectWithProperty >> inspectorAnnouncer [
	<inspectorPresentationOrder: 110 title: 'Announcer'>
	^ announcer inspectionSubscriptions
]

{ #category : '*Roassal3-Inspector' }
RSObjectWithProperty >> inspectorAnnouncerContext: aContext [
	aContext active: announcer notNil
]
