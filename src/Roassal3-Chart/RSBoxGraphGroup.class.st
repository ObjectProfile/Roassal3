Class {
	#name : #RSBoxGraphGroup,
	#superclass : #RSObject,
	#instVars : [
		'boxGraphics'
	],
	#category : #'Roassal3-Chart-Plots'
}

{ #category : #accessing }
RSBoxGraphGroup class >> boxGraphics: aCollectionOfRSBoxGraphics [
	| boxGraphGroup |
	boxGraphGroup := self new.
	boxGraphGroup boxGraphics: aCollectionOfRSBoxGraphics.
	^ boxGraphGroup.
]

{ #category : #accessing }
RSBoxGraphGroup >> boxGraphics [
	^ boxGraphics.
]

{ #category : #accessing }
RSBoxGraphGroup >> boxGraphics: aCollectionOfRSBoxGraphs [
	boxGraphics := aCollectionOfRSBoxGraphs.
]
