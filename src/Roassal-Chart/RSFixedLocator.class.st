"
<keyClass>
`RSFixedLocator` places ticks at fixed positions according to `ticks`. Only positions that are in the domain of the scale are taken into account.

*Responsibility*: Places ticks at fixed positions.

*Collaborators*: `RSFixedLocator` is used when rendering ticks.
"
Class {
	#name : 'RSFixedLocator',
	#superclass : 'RSTickLocator',
	#instVars : [
		'ticks'
	],
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'generate' }
RSFixedLocator >> generateTicks: aScale with: numberOfTicks [

	ticks sort.
	^ ticks select: [ :e | e >= aScale domain first and: e <= aScale domain last ]
]

{ #category : 'generate' }
RSFixedLocator >> ticks [

	^ ticks
]

{ #category : 'generate' }
RSFixedLocator >> ticks: aCollection [

	ticks := aCollection
]
