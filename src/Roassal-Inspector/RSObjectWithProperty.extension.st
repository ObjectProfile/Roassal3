Extension { #name : 'RSObjectWithProperty' }

{ #category : '*Roassal-Inspector' }
RSObjectWithProperty >> inspectorAnnouncer [
	<inspectorPresentationOrder: 110 title: 'Announcer'>
	^ announcer inspectionSubscriptions
]

{ #category : '*Roassal-Inspector' }
RSObjectWithProperty >> inspectorAnnouncerContext: aContext [
	aContext active: announcer notNil
]
