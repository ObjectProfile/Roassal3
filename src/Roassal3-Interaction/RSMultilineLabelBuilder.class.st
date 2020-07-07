"
I am a builder that can create labels with multiline in roassal3 from objects

```Smalltalk
canvas := RSCanvas new.
shapeBuilder := RSMultilineLabelBuilder new.
shapeBuilder labelShape
	font: 20;
	italic.
canvas add:(shapeBuilder shapeFor: '""tu est loin, 
très loin de tous ces regards vicieux 
qui s''alimentent de ta lumière""').
canvas nodes when: RSMouseClick do: [ :evt | canvas nodes last inspect ].
canvas showEncompassingRectangles.
canvas
```
"
Class {
	#name : #RSMultilineLabelBuilder,
	#superclass : #RSObject,
	#instVars : [
		'labelShape',
		'layout',
		'textBlock'
	],
	#category : #'Roassal3-Interaction-Popup'
}

{ #category : #accessing }
RSMultilineLabelBuilder >> compositeLabelFor: lines [ 
	| shapes |
	shapes := lines collect: [:line | 
		self singleLabelFor: (line copyReplaceAll: String tab with: '   ') ].
	self layout on: shapes.
	^ RSComposite new
		shapes: shapes;
		position: 0@0;
		yourself.
]

{ #category : #initialization }
RSMultilineLabelBuilder >> initialize [
	super initialize.
	self labelShape: RSLabel new; textBlock: #asString
]

{ #category : #accessing }
RSMultilineLabelBuilder >> labelShape [
	^ labelShape
]

{ #category : #accessing }
RSMultilineLabelBuilder >> labelShape: aLabelShape [
	labelShape := aLabelShape
]

{ #category : #accessing }
RSMultilineLabelBuilder >> layout [
	^ layout ifNil: [ layout := RSVerticalLineLayout new 
		alignLeft; 
		gapSize: 0;
		yourself ].
]

{ #category : #hooks }
RSMultilineLabelBuilder >> shapeFor: anObject [
	| text lines |
	text := self textFor: anObject.
	lines := text lines.
	^ lines size = 1
		ifTrue: [ self singleLabelFor: text ]
		ifFalse: [ self compositeLabelFor: lines ]
	
]

{ #category : #accessing }
RSMultilineLabelBuilder >> singleLabelFor: text [
	^ self labelShape copy
		text: text;
		yourself
		
]

{ #category : #accessing }
RSMultilineLabelBuilder >> textBlock: aBlock [
	textBlock := aBlock
]

{ #category : #accessing }
RSMultilineLabelBuilder >> textFor: anObject [
	^ (textBlock rsValue: anObject) asString
]
