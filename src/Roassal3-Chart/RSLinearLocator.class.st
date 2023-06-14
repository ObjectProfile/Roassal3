"
<keyClass>
`RSLinearTickLocator` places ticks at regular intervals between the minimum and the maximum data value, even if the value of the ticks are not ""round"".

*Responsibility*: Places ticks linearly.

*Collaborators*: `RSLinearTickLocator` is used when rendering ticks.
"
Class {
	#name : #RSLinearLocator,
	#superclass : #RSTickLocator,
	#category : #'Roassal3-Chart-Ticks'
}

{ #category : #generate }
RSLinearLocator >> generateTicks: aScale with: numberOfTicks [
	
	^ aScale ticks: numberOfTicks 
]
