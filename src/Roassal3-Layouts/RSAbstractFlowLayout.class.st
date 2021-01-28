"
TODO
"
Class {
	#name : #RSAbstractFlowLayout,
	#superclass : #RSLayout,
	#instVars : [
		'maxWidth',
		'gapSize',
		'alignment'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
RSAbstractFlowLayout class >> isAbstract [
	^ self name = #RSAbstractFlowLayout
]

{ #category : #'instance creation' }
RSAbstractFlowLayout class >> withMaxWidth: anInteger [
	
	^(self new)
		maxWidth: anInteger;
		yourself
]

{ #category : #'instance creation' }
RSAbstractFlowLayout class >> withMaxWidth: anInteger withGap: anotherInteger [
	
	^(self new)
		maxWidth: anInteger;
		gapSize: anotherInteger;
		yourself
]

{ #category : #configuration }
RSAbstractFlowLayout >> defaultGapSize [
	^ 5
]

{ #category : #configuration }
RSAbstractFlowLayout >> defaultMaxWidth [
	^ [ :elements | 
		(elements size < 4) ifTrue: [ (((elements collect: [ :each | each width * each height]) * 2) sum ) + (elements size * (gapSize squared)) ]
			ifFalse: [
			((((elements collect: [ :each | each width * each height]) * 2) sum) + (elements size * (gapSize squared))) sqrt ceiling truncated.
			]
		]
]

{ #category : #hook }
RSAbstractFlowLayout >> doExecute: elements [

	| lines align |
	elements ifEmpty: [ ^ self ].
	lines := self linesFor: elements.
	align := RSAlignment new.
	lines do: [ :line | 
		align shapes: line.
		alignment value: align.
		 ].
	
	
]

{ #category : #accessing }
RSAbstractFlowLayout >> gapSize [
	^ gapSize
]

{ #category : #accessing }
RSAbstractFlowLayout >> gapSize: aSizeInPixels [
	gapSize := aSizeInPixels
]

{ #category : #'initialize-release' }
RSAbstractFlowLayout >> initialize [
	super initialize.
	maxWidth := self defaultMaxWidth.
	gapSize := self defaultGapSize.
]

{ #category : #hook }
RSAbstractFlowLayout >> linesFor: elements [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractFlowLayout >> maxWidth [
	^ maxWidth
]

{ #category : #accessing }
RSAbstractFlowLayout >> maxWidth: aSizeInPixels [
	maxWidth := aSizeInPixels
]
