"
Event representing a key pressing (but not releasing)

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
c := TSCanvas new.
e := TSEllipse new.
c addShape: e.
e when: TRKeyDown do: [ :event |
	event keyCombination = $r asKeyCombination ifTrue: [
		e color: Color random.
		v signalUpdate.
	]
].

c open
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSKeyDown,
	#superclass : #RSKeyboardEvent,
	#category : #'Roassal3-Event'
}
