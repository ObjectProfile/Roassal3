"
Abstract class for flow layouts.
I define the maximum width, gap size and alignment (`RSAlignment`)
"
Class {
	#name : #RSAbstractFlowLayout,
	#superclass : #RSLayout,
	#instVars : [
		'maxWidth',
		'gapSize',
		'alignment',
		'horizontalGap',
		'verticalGap'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #public }
RSAbstractFlowLayout class >> isAbstract [
	^ self name = #RSAbstractFlowLayout
]

{ #category : #'instance creation' }
RSAbstractFlowLayout class >> withMaxWidth: anInteger [

	^ self new
		maxWidth: anInteger;
		yourself
]

{ #category : #'instance creation' }
RSAbstractFlowLayout class >> withMaxWidth: anInteger withGap: anotherInteger [

	^ self new
		maxWidth: anInteger;
		gapSize: anotherInteger;
		yourself
]

{ #category : #accessing }
RSAbstractFlowLayout >> alignment [

	^ alignment
]

{ #category : #accessing }
RSAbstractFlowLayout >> alignment: anObject [

	alignment := anObject
]

{ #category : #configuration }
RSAbstractFlowLayout >> defaultGapSize [
	^ 5
]

{ #category : #configuration }
RSAbstractFlowLayout >> defaultMaxWidth [
	^ [ :shapes |
		(shapes size < 4) 
			ifTrue: [ 
				(((shapes collect: [ :each | each width * each height]) * 2) sum ) + (shapes size * (gapSize squared)) ]
			ifFalse: [
			((((shapes collect: [ :each | each width * each height]) * 2) sum) + (shapes size * (gapSize squared))) sqrt ceiling truncated.
			]
		]
]

{ #category : #hook }
RSAbstractFlowLayout >> doExecute: shapes [

	| lines align mocks |
	shapes ifEmpty: [ ^ self ].
	mocks := shapes collect: [ :shape | RSMockShape new realShape: shape ].
	lines := self linesFor: mocks.
	align := RSAlignment new.
	lines do: [ :line |
		align shapes: line.
		alignment value: align.
		 ].
	mocks do: [:mock | mock applyToRealElement ]
]

{ #category : #accessing }
RSAbstractFlowLayout >> gapSize [
	^ gapSize
]

{ #category : #accessing }
RSAbstractFlowLayout >> gapSize: aSizeInPixels [
	gapSize := aSizeInPixels.
	self horizontalGap: gapSize.
	self verticalGap: gapSize.
]

{ #category : #accessing }
RSAbstractFlowLayout >> horizontalGap [

	^ horizontalGap
]

{ #category : #accessing }
RSAbstractFlowLayout >> horizontalGap: aNumber [

	horizontalGap := aNumber
]

{ #category : #initialization }
RSAbstractFlowLayout >> initialize [
	super initialize.
	self 
		maxWidth: self defaultMaxWidth;
		gapSize: self defaultGapSize
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

{ #category : #accessing }
RSAbstractFlowLayout >> verticalGap [

	^ verticalGap
]

{ #category : #accessing }
RSAbstractFlowLayout >> verticalGap: aNumber [

	verticalGap := aNumber
]
