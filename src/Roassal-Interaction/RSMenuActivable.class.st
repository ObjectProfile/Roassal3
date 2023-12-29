"
With the mouse right click event I show a basic popup.

`menuDo:` recives a block of two arguments to build the menu.
- First argument is an instance of `MenuMorph`.
- Second argument is the shape with the event

### Example
- `RSMenuActivable class >> #example`

"
Class {
	#name : 'RSMenuActivable',
	#superclass : 'RSInteraction',
	#instVars : [
		'menuBlock'
	],
	#category : 'Roassal-Interaction-Core',
	#package : 'Roassal-Interaction',
	#tag : 'Core'
}

{ #category : 'enumerating' }
RSMenuActivable >> menuDo: block [
	"a block with two args
	first arg, a MenuMorph
	second arg, a RSElement or RSView
	"
	menuBlock := block
]

{ #category : 'hooks' }
RSMenuActivable >> onShape: aShape [
	"No need to do anything if empty"
	menuBlock isNil ifTrue: [ ^ self ].
	aShape when: RSMouseRightClick do: [ :evt |
		| menu |
		menu := MenuMorph new.
		menuBlock value: menu value: evt shape.
		menu popUpInWorld ]
	for: self
]
