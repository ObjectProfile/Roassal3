"
<keyClass>
`RSLogLocator` places ticks in a logarithmic way. A `RSLogLocator` has a base, by default 10, and places a tick at each power of the base (for ex: 0.1, 1, 10, 100, etc).
However it doesn't rescale the axis.

*Responsibility*: Places logarithmic ticks.

*Collaborators*: `RSLogLocator` is used when rendering ticks.
"
Class {
	#name : #RSLogLocator,
	#superclass : #RSTickLocator,
	#instVars : [
		'base'
	],
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #generate }
RSLogLocator >> base [

	^ base
]

{ #category : #generate }
RSLogLocator >> base: aNumber [

	base := aNumber
]

{ #category : #generate }
RSLogLocator >> generateTicks: aScale with: numberOfTicks [
	"^ (aScale domain first ceiling to: aScale domain last by: 1) select: [
		  :tick |
		  | decimalPart |
		  decimalPart := (tick log: base) fractionPart.
		  decimalPart < self precision or: 1 - decimalPart < self precision ]"

	| first last power collection tick |
	first := aScale domain first.
	last := aScale domain last.

	last < first ifTrue: [
		| temp |
		temp := last.
		last := first.
		first := temp ].

	last <= 0 ifTrue: [
		^ DomainError signal: 'Data has no positive value' ].

	first <= 0 ifTrue: [ first := self smallestIndex ].
	power := (first log: base) rounded.
	collection := OrderedCollection new.
	tick := base ** power.

	[ tick <= last ] whileTrue: [
		collection add: tick.
		power := power + 1.
		tick := base ** power ].

	^ collection
]

{ #category : #initialization }
RSLogLocator >> initialize [

	super initialize.
	base := 10
]

{ #category : #stepping }
RSLogLocator >> smallestIndex [

	^ 10**(-3)
]
