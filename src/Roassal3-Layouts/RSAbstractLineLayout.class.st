"
A ROAbstractLineLayout is the abstract superclass of the line layout.

Instance Variables
	alignment:		<Object>
	gapSize:		<Object>
	horizontalGap:		<Object>
	horizontalOutGap:		<Object>
	horizontallyStretchable:		<Object>
	verticalGap:		<Object>
	verticalOutGap:		<Object>
	verticallyStretchable:		<Object>

alignment
	- xxxxx

gapSize
	- xxxxx

horizontalGap
	- xxxxx

horizontalOutGap
	- xxxxx

horizontallyStretchable
	- xxxxx

verticalGap
	- xxxxx

verticalOutGap
	- xxxxx

verticallyStretchable
	- xxxxx

"
Class {
	#name : #RSAbstractLineLayout,
	#superclass : #RSLayout,
	#instVars : [
		'gapSize',
		'horizontalGap',
		'verticalGap',
		'horizontalOutGap',
		'verticalOutGap',
		'alignment',
		'horizontallyStretchable',
		'verticallyStretchable'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #testing }
RSAbstractLineLayout class >> isAbstract [
	^ self name = #RSAbstractLineLayout
]

{ #category : #'instance creation' }
RSAbstractLineLayout class >> withGap: anInteger [
	
	^(self new)
		gapSize: anInteger;
		yourself
]

{ #category : #accessing }
RSAbstractLineLayout >> alignBottom [
	
	alignment := #bottom
]

{ #category : #accessing }
RSAbstractLineLayout >> alignCenter [
	"Make the element centered"
	alignment := #center
]

{ #category : #accessing }
RSAbstractLineLayout >> alignLeft [
	
	alignment := #left
]

{ #category : #accessing }
RSAbstractLineLayout >> alignRight [
	
	alignment := #right
]

{ #category : #accessing }
RSAbstractLineLayout >> alignTop [
	
	alignment := #top
]

{ #category : #accessing }
RSAbstractLineLayout >> alignment [
	
	^alignment
]

{ #category : #accessing }
RSAbstractLineLayout >> alignment: anObject [
	
	alignment := anObject
]

{ #category : #configuration }
RSAbstractLineLayout >> center [
	self alignment: #center
]

{ #category : #hook }
RSAbstractLineLayout >> deltaFor: aNodeFigure [
	
	^self subclassResponsibility
]

{ #category : #hook }
RSAbstractLineLayout >> doCenter: aGraph [
	self subclassResponsibility 
]

{ #category : #hook }
RSAbstractLineLayout >> doExecute: elements [ 
	| pointer delta |
	horizontallyStretchable ifTrue: 
		[ self doStretchHorizontal: elements ].
	verticallyStretchable ifTrue: 
		[ self doStretchVertical: elements ].
	pointer := self positionOriginalPointer: elements.

	elements do: 
		[ :element |
		delta := self deltaFor: element.
		translator translateTopLeftOf: element to: pointer - delta.
		pointer := self 
					movePointer: pointer
					accordingToFigure: element.
		self step ].
]

{ #category : #hook }
RSAbstractLineLayout >> doStretchHorizontal: aCollectionOfElements [ 

	self subclassResponsibility
]

{ #category : #hook }
RSAbstractLineLayout >> doStretchVertical: aCollectionOfElements [ 

	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLineLayout >> gapSize [
	
	^gapSize
]

{ #category : #accessing }
RSAbstractLineLayout >> gapSize: aNumber [
	gapSize := aNumber. " This value is never used actually "
	
	verticalGap := 2 * aNumber.
	horizontalGap := 2 * aNumber
]

{ #category : #accessing }
RSAbstractLineLayout >> horizontalGap [
	
	^horizontalGap
]

{ #category : #accessing }
RSAbstractLineLayout >> horizontalGap: anInteger [
	
	horizontalGap := anInteger
]

{ #category : #testing }
RSAbstractLineLayout >> horizontallyStretchable [
	^ horizontallyStretchable
]

{ #category : #'initialize-release' }
RSAbstractLineLayout >> initialize [
	
	super initialize.
	verticalGap := 10.
	horizontalGap := 10.
	horizontallyStretchable := false.
	verticallyStretchable := false
]

{ #category : #hook }
RSAbstractLineLayout >> movePointer: pointer accordingToFigure: aNodeFigure [
	
	self subclassResponsibility
]

{ #category : #hook }
RSAbstractLineLayout >> positionOriginalPointer: aGraph [
	
	^self subclassResponsibility
]

{ #category : #configuration }
RSAbstractLineLayout >> stretch [
	horizontallyStretchable := verticallyStretchable := true
]

{ #category : #configuration }
RSAbstractLineLayout >> stretchHorizontally [
	horizontallyStretchable := true
]

{ #category : #configuration }
RSAbstractLineLayout >> stretchVertically [
	verticallyStretchable := true
]

{ #category : #accessing }
RSAbstractLineLayout >> verticalGap [
	
	^verticalGap
]

{ #category : #accessing }
RSAbstractLineLayout >> verticalGap: anInteger [
	
	verticalGap := anInteger
]

{ #category : #testing }
RSAbstractLineLayout >> verticallyStretchable [
	^ verticallyStretchable
]
