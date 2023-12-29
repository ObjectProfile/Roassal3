"
<keyClass>
`RSLogLocator` places ticks in a logarithmic way. A `RSLogLocator` has a base, by default 10, and places a tick at each power of the base (for ex: 0.1, 1, 10, 100, etc).
However it doesn't rescale the axis.

*Responsibility*: Places logarithmic ticks.

*Collaborators*: `RSLogLocator` is used when rendering ticks.
"
Class {
	#name : 'RSLogLocator',
	#superclass : 'RSTickLocator',
	#instVars : [
		'base',
		'smallestIndex',
		'smallestPower'
	],
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'generate' }
RSLogLocator >> base [

	^ base
]

{ #category : 'generate' }
RSLogLocator >> base: aBase [

	base := aBase.
	smallestIndex := aBase**(smallestPower)
]

{ #category : 'generate' }
RSLogLocator >> generateTicks: aScale with: numberOfTicks [

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

	first <= 0 ifTrue: [ first := smallestIndex ].
	power := (first log: base) rounded.
	collection := OrderedCollection new.
	tick := base ** power.

	[ tick <= last ] whileTrue: [
		collection add: tick.
		power := power + 1.
		tick := base ** power ].

	^ collection
]

{ #category : 'initialization' }
RSLogLocator >> initialize [

	super initialize.
	base := 10.
	smallestPower := -3.
	smallestIndex := base**smallestPower
]

{ #category : 'stepping' }
RSLogLocator >> smallestIndex [

	^ smallestIndex
]

{ #category : 'stepping' }
RSLogLocator >> smallestPower [

	^ smallestPower
]

{ #category : 'stepping' }
RSLogLocator >> smallestPower: aPower [

	smallestPower := aPower.
	smallestIndex := base**aPower
]
