"
I create a popup from an object
"
Class {
	#name : #TSSimplePopup,
	#superclass : #TSAbstractShapeBuilder,
	#instVars : [
		'textBlock'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #'as yet unclassified' }
TSSimplePopup >> boxOn: lbl [
	^ TSBox new
		color: (Color colorFrom: 'efefef');
		cornerRadius: 5;
		border: (TSBorder new color: Color gray);
		extent: lbl extent + 5;
		yourself
]

{ #category : #initialization }
TSSimplePopup >> initialize [
	self textBlock: #yourself
]

{ #category : #'as yet unclassified' }
TSSimplePopup >> labelOn: anObject [
	^ TSLabel new
		text: (self textFor: anObject);
		yourself
		
]

{ #category : #'as yet unclassified' }
TSSimplePopup >> shapeOn: anObject [
	| lbl box |
	lbl := self labelOn: anObject.
	box := self boxOn: lbl.
	^ TSComposite new
		shapes: (TSGroup with: box with: lbl);
		yourself
	
	
]

{ #category : #'as yet unclassified' }
TSSimplePopup >> textBlock: aBlock [
	textBlock := aBlock
]

{ #category : #'as yet unclassified' }
TSSimplePopup >> textFor: anObject [
	^ (textBlock rsValue: anObject) asString
]
