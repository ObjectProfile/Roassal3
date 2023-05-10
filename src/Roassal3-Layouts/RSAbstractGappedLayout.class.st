"
I define a layouts with horizontal and vertical gap spaces between elements.

### Variables

- horizontalGap, the horizontal gap space between shapes in the layout.
- verticalGap, the vertical gap space between shapes in the layout.
- gapSize, will modify both, horizontal and vertical gaps

"
Class {
	#name : #RSAbstractGappedLayout,
	#superclass : #RSLayout,
	#instVars : [
		'gapSize',
		'horizontalGap',
		'verticalGap'
	],
	#category : #'Roassal3-Layouts-Core'
}

{ #category : #testing }
RSAbstractGappedLayout class >> isAbstract [
	^ self name = #RSAbstractGappedLayout
]

{ #category : #accessing }
RSAbstractGappedLayout class >> layoutDefinition [
	^ RSLayoutDefinition new
		add: (RSLayoutNumberField new
			label: 'Gap size';
			selector: #gapSize;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Horizontal gap size';
			selector: #horizontalGap;
			yourself);
		add: (RSLayoutNumberField new
			label: 'Vertical gap size';
			selector: #verticalGap;
			yourself);
		yourself
]

{ #category : #configuration }
RSAbstractGappedLayout >> defaultGapSize [
	^ 5
]

{ #category : #accessing }
RSAbstractGappedLayout >> gapSize [
	^ gapSize
]

{ #category : #accessing }
RSAbstractGappedLayout >> gapSize: aSizeInPixels [
	gapSize := aSizeInPixels.
	self horizontalGap: gapSize.
	self verticalGap: gapSize.
]

{ #category : #accessing }
RSAbstractGappedLayout >> horizontalGap [

	^ horizontalGap
]

{ #category : #accessing }
RSAbstractGappedLayout >> horizontalGap: aNumber [

	horizontalGap := aNumber
]

{ #category : #initialization }
RSAbstractGappedLayout >> initialize [
	super initialize.
	self gapSize: self defaultGapSize
]

{ #category : #accessing }
RSAbstractGappedLayout >> verticalGap [

	^ verticalGap
]

{ #category : #accessing }
RSAbstractGappedLayout >> verticalGap: aNumber [

	verticalGap := aNumber
]
