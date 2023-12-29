"
<keyClass>
`RSAutoLocator` places ticks in a ""nice"" way, meaning their values are ""round"". However the final tick may be greater than the maximum data value, and the number of ticks may be close but not equal to the one requested.

*Responsibility*: Places ticks nicely.

*Collaborators*: `RSAutoLocator` is used when rendering ticks.
"
Class {
	#name : 'RSAutoLocator',
	#superclass : 'RSTickLocator',
	#category : 'Roassal-Chart-Ticks',
	#package : 'Roassal-Chart',
	#tag : 'Ticks'
}

{ #category : 'generate' }
RSAutoLocator >> generateTicks: aScale with: numberOfTicks [

	^ aScale niceTicks: numberOfTicks
]
