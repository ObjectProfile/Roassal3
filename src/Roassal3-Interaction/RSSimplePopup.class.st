"
I create a popup from an object
"
Class {
	#name : #RSSimplePopup,
	#superclass : #RSAbstractShapeBuilder,
	#instVars : [
		'textBlock'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #'as yet unclassified' }
RSSimplePopup >> boxOn: lbl [
	^ RSBox new
		color: (Color colorFrom: 'efefef');
		cornerRadius: 5;
		border: (RSBorder new color: Color gray);
		extent: lbl extent + 5;
		yourself
]

{ #category : #initialization }
RSSimplePopup >> initialize [
	self textBlock: #yourself
]

{ #category : #'as yet unclassified' }
RSSimplePopup >> labelOn: anObject [
	^ RSLabel new
		text: (self textFor: anObject);
		yourself
		
]

{ #category : #'as yet unclassified' }
RSSimplePopup >> shapeOn: anObject [
	| lbl box |
	lbl := self labelOn: anObject.
	box := self boxOn: lbl.
	^ RSComposite new
		shapes: (RSGroup with: box with: lbl);
		yourself
	
	
]

{ #category : #'as yet unclassified' }
RSSimplePopup >> textBlock: aBlock [
	textBlock := aBlock
]

{ #category : #'as yet unclassified' }
RSSimplePopup >> textFor: anObject [
	^ (textBlock rsValue: anObject) asString
]
