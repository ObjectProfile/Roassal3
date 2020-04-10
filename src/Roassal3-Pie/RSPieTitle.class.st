"
I can add a basic title in a pie
"
Class {
	#name : #RSPieTitle,
	#superclass : #AnObsoleteRSInteraction,
	#instVars : [
		'labelBuilder',
		'labelText'
	],
	#category : #'Roassal3-Pie-Interactions'
}

{ #category : #initialization }
RSPieTitle >> initialize [
	super initialize.
	labelBuilder := RSMultilineLabelBuilder new.
	labelBuilder layout alignCenter.
]

{ #category : #accessing }
RSPieTitle >> labelShape [
	^ labelBuilder labelShape
]

{ #category : #accessing }
RSPieTitle >> labelText [
	^ labelText
]

{ #category : #accessing }
RSPieTitle >> labelText: aString [
	labelText := aString
]

{ #category : #hooks }
RSPieTitle >> onShape: aCanvas [
	| label |
	label := labelBuilder shapeFor: self labelText.
	aCanvas add: label.
	
	
]
