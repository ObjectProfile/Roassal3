"
I can add a basic title in a pie
"
Class {
	#name : #RSPieTitleDecorator,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'labelBuilder',
		'labelText'
	],
	#category : #'Roassal3-Pie-Decorators'
}

{ #category : #accessing }
RSPieTitleDecorator >> builder: aBuilder [
]

{ #category : #initialization }
RSPieTitleDecorator >> initialize [
	super initialize.
	labelBuilder := RSMultilineLabelBuilder new.
	labelBuilder layout alignCenter.
]

{ #category : #accessing }
RSPieTitleDecorator >> labelShape [
	^ labelBuilder labelShape
]

{ #category : #accessing }
RSPieTitleDecorator >> labelText [
	^ labelText
]

{ #category : #accessing }
RSPieTitleDecorator >> labelText: aString [
	labelText := aString
]

{ #category : #hooks }
RSPieTitleDecorator >> renderIn: aCanvas [
	| label |
	label := labelBuilder shapeFor: self labelText.
	aCanvas add: label.
]
