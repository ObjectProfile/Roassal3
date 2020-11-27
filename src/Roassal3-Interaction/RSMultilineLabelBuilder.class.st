"
I am a builder that can create labels with multiline in roassal3 from objects

```Smalltalk
canvas := RSCanvas new.
shapeBuilder := RSMultilineLabelBuilder new.
shapeBuilder labelShape
 fontSize: 20;
 italic.
canvas add:(shapeBuilder shapeFor: '""tu est loin, 
très loin de tous ces regards vicieux 
qui s''alimentent de ta lumière""').
canvas nodes when: RSMouseClick do: [ :evt | canvas nodes last inspect ].
canvas showEncompassingRectangles.
canvas @ RSCanvasController
```
"
Class {
	#name : #RSMultilineLabelBuilder,
	#superclass : #RSObject,
	#instVars : [
		'labelShape',
		'layout',
		'textBlock',
		'wrapStrategy'
	],
	#category : #'Roassal3-Interaction-Text'
}

{ #category : #hooks }
RSMultilineLabelBuilder >> basicShapeFor: aString [
	| lines |
	lines := aString lines.
	
	^ lines size = 1 
		ifTrue: [ self singleLabelFor: lines first ]
		ifFalse: [ self compositeLabelFor: lines ]
]

{ #category : #hooks }
RSMultilineLabelBuilder >> compositeLabelFor: lines [ 
	| shapes |
	shapes := lines collect: [:line | 
		self singleLabelFor: (line copyReplaceAll: String tab with: '   ') ] 
		as: RSGroup.
	self layout on: shapes.
	^ shapes asShape 
		position: 0@0;
		yourself.
]

{ #category : #initialization }
RSMultilineLabelBuilder >> initialize [
	super initialize.
	self labelShape: RSLabel new; textBlock: #asString.
	self wrapStrategy: RSNoWrapStrategy new.
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

{ #category : #accessing }
RSMultilineLabelBuilder >> layout: aRSLayout [
	layout := aRSLayout
]

{ #category : #hooks }
RSMultilineLabelBuilder >> shapeFor: anObject [
	| text |
	text := self textFor: anObject.
	^ wrapStrategy wrapTextFor: text with: self.
	
	
]

{ #category : #hooks }
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

{ #category : #accessing }
RSMultilineLabelBuilder >> wrapStrategy [
	^ wrapStrategy
]

{ #category : #accessing }
RSMultilineLabelBuilder >> wrapStrategy: aRSWrapStrategy [
	wrapStrategy := aRSWrapStrategy
]
