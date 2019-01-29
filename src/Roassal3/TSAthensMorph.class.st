Class {
	#name : #TSAthensMorph,
	#superclass : #Morph,
	#instVars : [
		'renderer',
		'canvas',
		'session',
		'surface'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #accessing }
TSAthensMorph >> canvas [
	^ canvas
]

{ #category : #accessing }
TSAthensMorph >> canvas: aTrachelCanvas [
	canvas := aTrachelCanvas
]

{ #category : #accessing }
TSAthensMorph >> open [

	
]

{ #category : #accessing }
TSAthensMorph >> renderer [
	^ renderer
]

{ #category : #accessing }
TSAthensMorph >> renderer: aRenderer [
	renderer := aRenderer
]
