"
With the mouse right click event I show a basic popup

Example:
```Smalltalk
m := RSMondrian new.
m nodes: (1 to: 10).
m build.

m canvas nodes @ (RSMenuActivable new menuDo: [ :menu :element | menu add: 'Inspect' target: element model selector: #inspect ]).

m open
```
"
Class {
	#name : #RSMenuActivableInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'menuBlock'
	],
	#category : #'Roassal3-Interaction-Core'
}

{ #category : #enumerating }
RSMenuActivableInteraction >> menuDo: block [
	"a block with two args
	first arg, a MenuMorph
	second arg, a RSElement or RSView
	"
	menuBlock := block
]

{ #category : #hooks }
RSMenuActivableInteraction >> onShape: aShape [
	"No need to do anything if empty"
	menuBlock isNil ifTrue: [ ^ self ].
	aShape when: RSMouseRightClick do: [ :evt | 
		| menu |
		menu := MenuMorph new.
		menuBlock value: menu value: evt shape.
		menu popUpInWorld ].
	
]
