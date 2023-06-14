"
<keyClass>
`RSNiceTickLocator` places ticks in a ""nice"" way. Their values are ""round"", but the final tick may be greater than the maximum data value, and the number of ticks may be close but not equal to the one requested.

*Responsibility*: Places ticks nicely.

*Collaborators*: `RSNiceTickLocator` is used when rendering ticks.
"
Class {
	#name : #RSAutoLocator,
	#superclass : #RSTickLocator,
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #generate }
RSAutoLocator >> generateTicks: aScale with: numberOfTicks [
	
	^ aScale niceTicks: numberOfTicks 
]
