"
With the mouose right click event I show a basic popup
"
Class {
	#name : #RSMenuActivable,
	#superclass : #RSInteraction,
	#instVars : [
		'menuBlock'
	],
	#category : #'Roassal3-Interaction'
}

{ #category : #enumerating }
RSMenuActivable >> menuDo: block [
	menuBlock := block
]

{ #category : #hooks }
RSMenuActivable >> onElement: anElement [
	anElement when: TSMouseRightClick do: [ :evt | 
		| menu |
		menu := MenuMorph new.
		menuBlock value: menu.
		menu popUpInWorld ].
]
