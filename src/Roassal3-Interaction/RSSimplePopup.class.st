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

{ #category : #hooks }
RSSimplePopup >> boxFor: lbl [
	^ RSBox new
		color: (Color colorFrom: 'efefef');
		cornerRadius: 5;
		border: (RSBorder new color: Color gray);
		extent: lbl extent + 5;
		yourself
]

{ #category : #hooks }
RSSimplePopup >> compositeLabelFor: lines [ 
	| shapes |
	shapes := lines collect: [:line | 
		self singleLabelFor: (line copyReplaceAll: String tab with: '   ') ].
	RSVerticalLineLayout new 
		alignLeft; 
		gapSize: 0; 
		on: shapes.
	^ RSComposite new
		shapes: shapes;
		adjustToChildren;
		yourself.
]

{ #category : #initialization }
RSSimplePopup >> initialize [
	self textBlock: #yourself
]

{ #category : #hooks }
RSSimplePopup >> labelFor: anObject [
	| text lines |
	text := self textFor: anObject.
	lines := text lines.
	^ lines size = 1 
		ifTrue: [ self singleLabelFor: text ]
		ifFalse: [ self compositeLabelFor: lines ]
	
]

{ #category : #hooks }
RSSimplePopup >> shapeFor: anObject [
	| lbl box |
	lbl := self labelFor: anObject.
	box := self boxFor: lbl.
	^ RSComposite new
		shapes: {box. lbl};
		yourself
]

{ #category : #hooks }
RSSimplePopup >> singleLabelFor: text [
	^ RSLabel new
		text: text;
		yourself
		
]

{ #category : #hooks }
RSSimplePopup >> textBlock: aBlock [
	textBlock := aBlock
]

{ #category : #hooks }
RSSimplePopup >> textFor: anObject [
	^ (textBlock rsValue: anObject) asString
]
