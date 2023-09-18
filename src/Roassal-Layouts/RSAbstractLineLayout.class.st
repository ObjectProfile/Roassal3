"
I represent an abstract line layout for arranging elements in a line-based format.

My subclasses define specific line layout algorithms, such as horizontal or vertical arrangements.

Usage:
- Create an instance of a subclass, such as RSVerticalLineLayout or RSHorizontalLineLayout.
- Set layout-specific properties, such as spacing or alignment, if supported by the subclass.
- Call #on: to perform the layout calculations and update the positions of the elements.
"
Class {
	#name : #RSAbstractLineLayout,
	#superclass : #RSAbstractBoxedLayout,
	#instVars : [
		'alignment'
	],
	#category : #'Roassal-Layouts-Line'
}

{ #category : #testing }
RSAbstractLineLayout class >> isAbstract [
	^ self name = #RSAbstractLineLayout
]

{ #category : #'instance creation' }
RSAbstractLineLayout class >> withGap: anInteger [

	^ self new
		gapSize: anInteger;
		yourself
]

{ #category : #alignment }
RSAbstractLineLayout >> alignNone [
	self alignment: #none
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
RSAbstractLineLayout >> deltaFor: anRSShape [
	^ self subclassResponsibility
]

{ #category : #hook }
RSAbstractLineLayout >> doExecute: shapes [
	| pointer delta |
	pointer := self positionOriginalPointer: shapes.
	shapes do: [ :shape |
		delta := self deltaFor: shape.
		translator translateTopLeftOf: shape to: pointer - delta.
		pointer := self
			movePointer: pointer
			accordingToFigure: shape ]
]

{ #category : #initialization }
RSAbstractLineLayout >> initialize [
	super initialize.
	self alignNone
]

{ #category : #hook }
RSAbstractLineLayout >> movePointer: pointer accordingToFigure: anRSShape [
	^ self subclassResponsibility
]

{ #category : #hook }
RSAbstractLineLayout >> positionOriginalPointer: aCollectionOfShapes [
	^ self subclassResponsibility
]
