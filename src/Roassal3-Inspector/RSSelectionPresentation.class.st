"
I am used on the inspector for Roassal3, when you select one element the view changes its shapes
"
Class {
	#name : #RSSelectionPresentation,
	#superclass : #RSInteraction,
	#instVars : [
		'presentation'
	],
	#category : #'Roassal3-Inspector-Interaction'
}

{ #category : #hooks }
RSSelectionPresentation >> onShape: anElement [
Halt if: [ anElement isKindOf: RSCanvas ].
	anElement when: RSMouseClick do: [ self presentation selection: anElement model ]
	
]

{ #category : #accessing }
RSSelectionPresentation >> presentation [
	^ presentation
]

{ #category : #accessing }
RSSelectionPresentation >> presentation: aRSRoassalPresentation [
	presentation := aRSRoassalPresentation
]

{ #category : #dependencies }
RSSelectionPresentation >> release [
	presentation := nil
]
