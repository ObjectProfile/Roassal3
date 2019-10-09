"
TODO
"
Class {
	#name : #TSAbstractFlowLayout,
	#superclass : #TSLayout,
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
TSAbstractFlowLayout class >> isAbstract [
	^ self name = #TSAbstractFlowLayout
]

{ #category : #'instance creation' }
TSAbstractFlowLayout class >> withMaxWidth: anInteger [
	
	^(self new)
		maxWidth: anInteger;
		yourself
]

{ #category : #'instance creation' }
TSAbstractFlowLayout class >> withMaxWidth: anInteger withGap: anotherInteger [
	
	^(self new)
		maxWidth: anInteger;
		gapSize: anotherInteger;
		yourself
]

{ #category : #alignment }
TSAbstractFlowLayout >> alignBottom [
	alignment := #bottom
]

{ #category : #alignment }
TSAbstractFlowLayout >> alignCenter [
	alignment := #center
]

{ #category : #alignment }
TSAbstractFlowLayout >> alignTop [
	alignment := #top
]

{ #category : #configuration }
TSAbstractFlowLayout >> defaultGapSize [
 ^ 5
]

{ #category : #configuration }
TSAbstractFlowLayout >> defaultMaxWidth [
	
	^ [ :elements | 
		(elements size < 4) ifTrue: [ (((elements collect: [ :each | each width * each height]) * 2) sum ) + (elements size * (gapSize squared)) ]
			ifFalse: [
			((((elements collect: [ :each | each width * each height]) * 2) sum) + (elements size * (gapSize squared))) sqrt ceiling truncated.
			]
		]
]

{ #category : #accessing }
TSAbstractFlowLayout >> gapSize [
	
	^gapSize
]

{ #category : #accessing }
TSAbstractFlowLayout >> gapSize: aSizeInPixels [
	
	gapSize := aSizeInPixels
]

{ #category : #'initialize-release' }
TSAbstractFlowLayout >> initialize [
	
	super initialize.
	maxWidth := self defaultMaxWidth.
	gapSize := self defaultGapSize.
]

{ #category : #testing }
TSAbstractFlowLayout >> isAlignBottom [
	^ alignment = #bottom
]

{ #category : #testing }
TSAbstractFlowLayout >> isAlignCenter [
	^ alignment = #center
]

{ #category : #testing }
TSAbstractFlowLayout >> isAlignTop [
	^ alignment = #top
]

{ #category : #private }
TSAbstractFlowLayout >> maxWidth [
	
	^maxWidth
]

{ #category : #accessing }
TSAbstractFlowLayout >> maxWidth: aSizeInPixels [
	
	maxWidth := aSizeInPixels
]
