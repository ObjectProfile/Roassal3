"
Event representing a key release.

[[[
c := TSCanvas new.

c when: TRKeyDown do: [ :event |
	self log: '[DOWN]'; logCr: event keyCombination.
].

c when: TRKeyUp do: [ :event |
	self log: '[UP]'; logCr: event keyCombination.
].

c open
]]]
"
Class {
	#name : #RSKeyUp,
	#superclass : #RSKeyboardEvent,
	#category : #'Roassal3-Event'
}
