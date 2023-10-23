Class {
	#name : 'RSRoassalTest',
	#superclass : 'RSTest',
	#category : 'Roassal-Global-Tests-Core',
	#package : 'Roassal-Global-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
RSRoassalTest >> testInitializeInRoassal [

	| pkgs methods violating |
	pkgs := self class packageOrganizer packages select: [ :pkg | 'Roassal*' match: pkg name ].
	methods := pkgs flatCollect: [ :pkg | pkg definedClasses flatCollect: [ :class | class methods ] ].
	violating := methods select: [ :method | method selector = #initialize and: [ method protocolName ~= #initialization ] ].
	self assert: violating isEmpty description: 'Roassal initialize methods should be categorized in initialization'
]

{ #category : 'tests' }
RSRoassalTest >> testOpen [

	| v |
	v := RSCanvas new open.
	self assert: v class == SystemWindow.
	v delete
]

{ #category : 'tests' }
RSRoassalTest >> testOpenOnce [

	| v |
	v := RSCanvas new openOnce.
	self assert: v class == SystemWindow.
	v delete
]

{ #category : 'tests' }
RSRoassalTest >> testRemoveInteractionIfPresent [
	| box |
	box := RSBox new.
	self deny: (box announcer handleSubscriberClass: RSPopup).
	box popup.
	self assert: (box announcer handleSubscriberClass: RSPopup).

	box removeInteractionIfPresent: RSPopup.
	self deny: (box announcer handleSubscriberClass: RSPopup).
	self deny: box hasEventCallback.

	box := RSBox new.
	box popup.
	self assert: (box announcer handleEventClass: RSMouseMove).
	box removeInteractionIfPresent: RSMouseMove.
	self assert: (box announcer handleEventClass: RSMouseMove)
]

{ #category : 'tests' }
RSRoassalTest >> testSubscriberClass [
	| box |
	box := RSBox new.
	self deny: (box announcer handleSubscriberClass: RSPopup).
	box popup.
	self assert: (box announcer handleSubscriberClass: RSPopup).
	"but popup adds a lot of events, RSPopup is not an event"
	self deny: (box announcer handleEventClass: RSPopup).
	{RSPopup activationEvent}, RSPopup removeEvents do: [ :evt | self assert:  (box announcer handleEventClass: evt). ]
]

{ #category : 'tests' }
RSRoassalTest >> testsRsValue [
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
