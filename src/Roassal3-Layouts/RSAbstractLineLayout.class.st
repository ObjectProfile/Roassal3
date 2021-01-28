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
		'alignment'
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
RSAbstractLineLayout >> alignment [
	^ alignment
]

{ #category : #accessing }
RSAbstractLineLayout >> alignment: anObject [
	alignment := anObject
]

{ #category : #hook }
RSAbstractLineLayout >> deltaFor: aNodeFigure [
	^ self subclassResponsibility
]

{ #category : #hook }
RSAbstractLineLayout >> doExecute: elements [ 
	| pointer delta |
	pointer := self positionOriginalPointer: elements.
	elements do: [ :element |
		delta := self deltaFor: element.
		translator translateTopLeftOf: element to: pointer - delta.
		pointer := self 
			movePointer: pointer
			accordingToFigure: element.
		].
]

{ #category : #accessing }
RSAbstractLineLayout >> gapSize [
	^ gapSize
]

{ #category : #accessing }
RSAbstractLineLayout >> gapSize: aNumber [
	gapSize := aNumber. " This value is never used actually "
	
	verticalGap := 2 * aNumber.
	horizontalGap := 2 * aNumber
]

{ #category : #accessing }
RSAbstractLineLayout >> horizontalGap [
	^ horizontalGap
]

{ #category : #accessing }
RSAbstractLineLayout >> horizontalGap: anInteger [
	"Set the horizontal space, in pixel, between two neighbors"
	horizontalGap := anInteger
]

{ #category : #'initialize-release' }
RSAbstractLineLayout >> initialize [
	super initialize.
	verticalGap := 10.
	horizontalGap := 10.
]

{ #category : #hook }
RSAbstractLineLayout >> movePointer: pointer accordingToFigure: aNodeFigure [
	self subclassResponsibility
]

{ #category : #hook }
RSAbstractLineLayout >> positionOriginalPointer: aGraph [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLineLayout >> verticalGap [
	^ verticalGap
]

{ #category : #accessing }
RSAbstractLineLayout >> verticalGap: anInteger [
	"Set the vertical space, in pixel, between a layer and a children layer"
	verticalGap := anInteger
]
