Class {
	#name : #TSRenderer,
	#superclass : #TSObject,
	#instVars : [
		'athensCanvas'
	],
	#category : #'Roassal3-Trachel'
}

{ #category : #accessing }
TSRenderer >> canvas [
	^ athensCanvas 
]

{ #category : #accessing }
TSRenderer >> canvas: aCanvas [
	"aCanvas is AthensCanvas"
	athensCanvas := aCanvas
]

{ #category : #visiting }
TSRenderer >> visitBox: box [
	
]

{ #category : #visiting }
TSRenderer >> visitCanvas: aCanvas [
	
]
