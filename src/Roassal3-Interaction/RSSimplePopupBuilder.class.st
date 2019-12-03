"
I create a popup from an object
"
Class {
	#name : #RSSimplePopupBuilder,
	#superclass : #RSObject,
	#instVars : [
		'labelBuilder'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #hooks }
RSSimplePopupBuilder >> boxFor: lbl [
	^ RSBox new
		color: (Color colorFrom: 'efefef');
		cornerRadius: 5;
		border: (RSBorder new color: Color gray);
		extent: lbl extent + 5;
		yourself
]

{ #category : #initialization }
RSSimplePopupBuilder >> initialize [
	super initialize.
	self labelBuilder: RSMultilineLabelBuilder new.
]

{ #category : #initialization }
RSSimplePopupBuilder >> labelBuilder [
	^ labelBuilder
]

{ #category : #initialization }
RSSimplePopupBuilder >> labelBuilder: aLabelBuilder [
	labelBuilder := aLabelBuilder
]

{ #category : #hooks }
RSSimplePopupBuilder >> labelFor: anObject [
	^ labelBuilder shapeFor: anObject
]

{ #category : #hooks }
RSSimplePopupBuilder >> shapeFor: anObject [
	| lbl box |
	lbl := self labelFor: anObject.
	box := self boxFor: lbl.
	^ RSComposite new
		shapes: {box. lbl};
		yourself
]

{ #category : #hooks }
RSSimplePopupBuilder >> textBlock: aBlock [
	labelBuilder textBlock: aBlock
]
