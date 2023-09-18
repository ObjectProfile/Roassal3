"
I can add a basic title in a pie
"
Class {
	#name : #RSPieTitleInteraction,
	#superclass : #RSInteraction,
	#instVars : [
		'labelBuilder',
		'labelText'
	],
	#category : #'Roassal3-Pie-Interactions'
}

{ #category : #initialization }
RSPieTitleInteraction >> initialize [
	super initialize.
	labelBuilder := RSMultilineLabelBuilder new.
	labelBuilder layout alignCenter
]

{ #category : #accessing }
RSPieTitleInteraction >> labelShape [
	^ labelBuilder labelShape
]

{ #category : #accessing }
RSPieTitleInteraction >> labelText [
	^ labelText
]

{ #category : #accessing }
RSPieTitleInteraction >> labelText: aString [
	labelText := aString
]

{ #category : #hooks }
RSPieTitleInteraction >> onShape: aCanvas [
	| label |
	label := labelBuilder shapeFor: self labelText.
	aCanvas add: label
]
