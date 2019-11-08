"
I am used on the inspector for Roassal3, when you select one element the view changes its shapes
"
Class {
	#name : #TSSelectionPresentation,
	#superclass : #RSInteraction,
	#instVars : [
		'presentation'
	],
	#category : #'Roassal3-Inspector-Interaction'
}

{ #category : #hooks }
TSSelectionPresentation >> onShape: anElement [
Halt if: [ anElement isKindOf: RSCanvas ].
	anElement when: RSMouseClick do: [ self presentation selection: anElement model ]
	
]

{ #category : #accessing }
TSSelectionPresentation >> presentation [
	^ presentation
]

{ #category : #accessing }
TSSelectionPresentation >> presentation: aRSRoassalPresentation [
	presentation := aRSRoassalPresentation
]

{ #category : #dependencies }
TSSelectionPresentation >> release [
	presentation := nil
]
