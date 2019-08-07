Extension { #name : #RSShapedObject }

{ #category : #'*Roassal3-Inspector' }
RSShapedObject >> gtInspectorSybscriptionsIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite table
		title: ['Subscriptions'];
		display: [ shape announcer subscriptions subscriptions ];
		when: [ shape privateAnnouncer notNil ];
		column: 'Subscriber' evaluated: [ :each | each subscriber asString ];
		column: 'Announcement' evaluated: [ :each | each announcementClass printString ].
]

{ #category : #'*Roassal3-Inspector' }
RSShapedObject >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: ['Element'];
		initializeView: [ self shape gtViewForInspector ]
]
