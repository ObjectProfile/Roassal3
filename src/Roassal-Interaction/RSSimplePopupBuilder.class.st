"
I create a popup from an object
"
Class {
	#name : 'RSSimplePopupBuilder',
	#superclass : 'RSObject',
	#instVars : [
		'labelBuilder',
		'boxBuilder'
	],
	#category : 'Roassal-Interaction-Popup',
	#package : 'Roassal-Interaction',
	#tag : 'Popup'
}

{ #category : 'accessing' }
RSSimplePopupBuilder >> boxBuilder [
	^ boxBuilder
]

{ #category : 'accessing' }
RSSimplePopupBuilder >> boxBuilder: aRSSimpleBoxBuilder [
	boxBuilder := aRSSimpleBoxBuilder
]

{ #category : 'hooks' }
RSSimplePopupBuilder >> boxFor: lbl [
	^ self boxBuilder shapeFor: lbl
]

{ #category : 'initialization' }
RSSimplePopupBuilder >> initialize [
	super initialize.
	self labelBuilder: RSMultilineLabelBuilder new.
	self boxBuilder: RSSimpleBoxBuilder new
]

{ #category : 'accessing' }
RSSimplePopupBuilder >> labelBuilder [
	^ labelBuilder
]

{ #category : 'accessing' }
RSSimplePopupBuilder >> labelBuilder: aLabelBuilder [
	labelBuilder := aLabelBuilder
]

{ #category : 'hooks' }
RSSimplePopupBuilder >> labelFor: anObject [
	^ labelBuilder shapeFor: anObject
]

{ #category : 'hooks' }
RSSimplePopupBuilder >> shapeFor: anObject [
	| lbl box |
	lbl := self labelFor: anObject.
	box := self boxFor: lbl.
	^ RSComposite new
		shapes: {box. lbl};
		yourself
]

{ #category : 'hooks' }
RSSimplePopupBuilder >> textBlock: aBlock [
	labelBuilder textBlock: aBlock
]
