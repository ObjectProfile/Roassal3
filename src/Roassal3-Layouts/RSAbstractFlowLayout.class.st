"
I contain gap distance size between each element, in vertical and horizontal axis.
### Variables

- horizontalGap, the horizontal distance size between elements in the layout
- verticalGap, the vertical distance size between elements in the layout
- gapSize, a number used to change both values, vertical and horizontal
"
Class {
	#name : #RSAbstractFlowLayout,
	#superclass : #RSAbstractBoxedLayout,
	#instVars : [
		'maxWidth',
		'alignment'
	],
	#category : #'Roassal3-Layouts-Flow'
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
	mocks := RSMockShape shapes: shapes.
	lines := self linesFor: mocks.
	align := RSAlignment new.
	lines do: [ :line |
		align shapes: line.
		alignment value: align.
		 ].
	mocks do: [:mock | mock applyToRealElement ]
]

{ #category : #initialization }
RSAbstractFlowLayout >> initialize [
	super initialize.
	self maxWidth: self defaultMaxWidth
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
