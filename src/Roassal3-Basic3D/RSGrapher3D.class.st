"
TODO
"
Class {
	#name : 'RSGrapher3D',
	#superclass : 'Object',
	#instVars : [
		'extent',
		'tmat',
		'view',
		'meshes',
		'elements'
	],
	#category : 'Roassal3-Basic3D-TODO',
	#package : 'Roassal3-Basic3D',
	#tag : 'TODO'
}

{ #category : 'public' }
RSGrapher3D class >> sampleData [
	| r data |
	r := SharedRandom globalGenerator.
	data := OrderedCollection new.
	1 to: 20 do: [ :x |
		1 to: 20 do: [ :z |
			data add: { x. r next * 10. z  }. ] ].
	^ data
]
