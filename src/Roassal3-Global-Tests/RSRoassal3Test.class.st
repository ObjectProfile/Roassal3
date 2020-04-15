Class {
	#name : #RSRoassal3Test,
	#superclass : #RSTest,
	#category : #'Roassal3-Global-Tests-Core'
}

{ #category : #'as yet unclassified' }
RSRoassal3Test >> testSubscriberClass [
	| box |
	box := RSBox new.
	self deny: (box announcer handleSubscriberClass: RSPopup).
	box popup.
	self assert: (box announcer handleSubscriberClass: RSPopup).
	"but popup adds a lot of events, RSPopup is not an event"
	self deny: (box announcer handleEventClass: RSPopup).
	self assert: (box announcer handleEventClass: RSMouseEnter).
	self assert: (box announcer handleEventClass: RSMouseMove).
	self assert: (box announcer handleEventClass: RSMouseLeave).

]

{ #category : #'as yet unclassified' }
RSRoassal3Test >> testsRsValue [
	| myCutomObjectValueProvider posiblesValuesForRoassal model colors |
	myCutomObjectValueProvider := NSScale category10.
		
	posiblesValuesForRoassal:= {
		Color red.
		nil.
		Color random.
		[ Color random ].
		#color.
		[ :obj | obj color ].
		myCutomObjectValueProvider  }.
		
	model := Morph new.

	colors := posiblesValuesForRoassal collect: [ :value |
		value rsValue: model ] as: OrderedCollection.
	self assert: (colors includes: nil).
	colors remove: nil.
	colors do: [ :color | self assert: color class equals: Color ]
]
