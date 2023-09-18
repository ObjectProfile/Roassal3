"
I define a layouts with horizontal and vertical gap spaces between elements.

### Variables

- horizontalGap, the horizontal gap space between shapes in the layout.
- verticalGap, the vertical gap space between shapes in the layout.
- gapSize, will modify both, horizontal and vertical gaps

"
Class {
	#name : #RSAbstractBoxedLayout,
	#superclass : #RSLayout,
	#instVars : [
		'gapSize',
		'horizontalGap',
		'verticalGap'
	],
	#category : #'Roassal-Layouts-Core'
}

{ #category : #testing }
RSAbstractBoxedLayout class >> isAbstract [
	^ self name = #RSAbstractBoxedLayout
]

{ #category : #configuration }
RSAbstractBoxedLayout >> defaultGapSize [
	^ 5
]

{ #category : #accessing }
RSAbstractBoxedLayout >> gapSize [
	^ gapSize
]

{ #category : #accessing }
RSAbstractBoxedLayout >> gapSize: aSizeInPixels [
	gapSize := aSizeInPixels.
	self horizontalGap: gapSize.
	self verticalGap: gapSize.
]

{ #category : #accessing }
RSAbstractBoxedLayout >> horizontalGap [

	^ horizontalGap
]

{ #category : #accessing }
RSAbstractBoxedLayout >> horizontalGap: aNumber [

	horizontalGap := aNumber
]

{ #category : #initialization }
RSAbstractBoxedLayout >> initialize [
	super initialize.
	self gapSize: self defaultGapSize
]

{ #category : #accessing }
RSAbstractBoxedLayout >> verticalGap [

	^ verticalGap
]

{ #category : #accessing }
RSAbstractBoxedLayout >> verticalGap: aNumber [

	verticalGap := aNumber
]
