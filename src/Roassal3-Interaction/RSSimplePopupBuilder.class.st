"
I create a popup from an object
"
Class {
	#name : #RSSimplePopupBuilder,
	#superclass : #RSObject,
	#instVars : [
		'textBlock',
		'labelShape'
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

{ #category : #hooks }
RSSimplePopupBuilder >> compositeLabelFor: lines [ 
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
RSSimplePopupBuilder >> initialize [
	self labelShape: RSLabel new; textBlock: #yourself.
]

{ #category : #hooks }
RSSimplePopupBuilder >> labelFor: anObject [
	| text lines |
	text := self textFor: anObject.
	lines := text lines.
	^ lines size = 1 
		ifTrue: [ self singleLabelFor: text ]
		ifFalse: [ self compositeLabelFor: lines ]
	
]

{ #category : #accessing }
RSSimplePopupBuilder >> labelShape [
	^ labelShape
]

{ #category : #accessing }
RSSimplePopupBuilder >> labelShape: aLabelShape [
	labelShape := aLabelShape
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
RSSimplePopupBuilder >> singleLabelFor: text [
	^ self labelShape copy
		text: text;
		yourself
		
]

{ #category : #hooks }
RSSimplePopupBuilder >> textBlock: aBlock [
	textBlock := aBlock
]

{ #category : #hooks }
RSSimplePopupBuilder >> textFor: anObject [
	^ (textBlock rsValue: anObject) asString
]
