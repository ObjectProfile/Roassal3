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
	#classInstVars : [
		'aBlock',
		'maxWithBlock'
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

{ #category : #alignment }
RSAbstractFlowLayout >> alignBottom [
	alignment := #bottom
]

{ #category : #alignment }
RSAbstractFlowLayout >> alignCenter [
	alignment := #center
]

{ #category : #alignment }
RSAbstractFlowLayout >> alignTop [
	alignment := #top
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

{ #category : #accessing }
RSAbstractFlowLayout >> gapSize [
	
	^gapSize
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

{ #category : #testing }
RSAbstractFlowLayout >> isAlignBottom [
	^ alignment = #bottom
]

{ #category : #testing }
RSAbstractFlowLayout >> isAlignCenter [
	^ alignment = #center
]

{ #category : #testing }
RSAbstractFlowLayout >> isAlignTop [
	^ alignment = #top
]

{ #category : #private }
RSAbstractFlowLayout >> maxWidth [
	
	^maxWidth
]

{ #category : #accessing }
RSAbstractFlowLayout >> maxWidth: aSizeInPixels [
	
	maxWidth := aSizeInPixels
]
