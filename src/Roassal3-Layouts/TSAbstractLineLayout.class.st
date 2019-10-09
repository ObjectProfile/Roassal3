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
	#name : #TSAbstractLineLayout,
	#superclass : #TSLayout,
	#instVars : [
		'gapSize',
		'horizontalGap',
		'verticalGap',
		'horizontalOutGap',
		'verticalOutGap',
		'alignment'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #testing }
TSAbstractLineLayout class >> isAbstract [
	^ self name = #TSAbstractLineLayout
]

{ #category : #'instance creation' }
TSAbstractLineLayout class >> withGap: anInteger [
	
	^(self new)
		gapSize: anInteger;
		yourself
]

{ #category : #accessing }
TSAbstractLineLayout >> alignBottom [
	
	alignment := #bottom
]

{ #category : #accessing }
TSAbstractLineLayout >> alignCenter [
	"Make the element centered"
	alignment := #center
]

{ #category : #accessing }
TSAbstractLineLayout >> alignLeft [
	
	alignment := #left
]

{ #category : #accessing }
TSAbstractLineLayout >> alignRight [
	
	alignment := #right
]

{ #category : #accessing }
TSAbstractLineLayout >> alignTop [
	
	alignment := #top
]

{ #category : #accessing }
TSAbstractLineLayout >> alignment [
	
	^alignment
]

{ #category : #accessing }
TSAbstractLineLayout >> alignment: anObject [
	
	alignment := anObject
]

{ #category : #configuration }
TSAbstractLineLayout >> center [
	self alignment: #center
]

{ #category : #hook }
TSAbstractLineLayout >> deltaFor: aNodeFigure [
	
	^self subclassResponsibility
]

{ #category : #hook }
TSAbstractLineLayout >> doCenter: aGraph [
	self subclassResponsibility 
]

{ #category : #hook }
TSAbstractLineLayout >> doExecute: elements [ 
	| pointer delta |
	pointer := self positionOriginalPointer: elements.
	elements do: [ :element |
		delta := self deltaFor: element.
		translator translateTopLeftOf: element to: pointer - delta.
		pointer := self 
			movePointer: pointer
			accordingToFigure: element.
		self step ].
]

{ #category : #accessing }
TSAbstractLineLayout >> gapSize [
	
	^gapSize
]

{ #category : #accessing }
TSAbstractLineLayout >> gapSize: aNumber [
	gapSize := aNumber. " This value is never used actually "
	
	verticalGap := 2 * aNumber.
	horizontalGap := 2 * aNumber
]

{ #category : #accessing }
TSAbstractLineLayout >> horizontalGap [
	
	^horizontalGap
]

{ #category : #accessing }
TSAbstractLineLayout >> horizontalGap: anInteger [
	
	horizontalGap := anInteger
]

{ #category : #'initialize-release' }
TSAbstractLineLayout >> initialize [
	
	super initialize.
	verticalGap := 10.
	horizontalGap := 10.
]

{ #category : #hook }
TSAbstractLineLayout >> movePointer: pointer accordingToFigure: aNodeFigure [
	
	self subclassResponsibility
]

{ #category : #hook }
TSAbstractLineLayout >> positionOriginalPointer: aGraph [
	
	^self subclassResponsibility
]

{ #category : #accessing }
TSAbstractLineLayout >> verticalGap [
	
	^verticalGap
]

{ #category : #accessing }
TSAbstractLineLayout >> verticalGap: anInteger [
	
	verticalGap := anInteger
]
