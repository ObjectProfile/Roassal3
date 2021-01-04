"
I am the base class for many visualizations of the distribution of a continuous variable.

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	barOffset:		<Object>
	barSize:		<Object>
	bars:		<Object>
	gapRatio:		<Object>


    Implementation Points
"
Class {
	#name : #RSAbstractBoxPlot,
	#superclass : #RSAbstractPlot,
	#instVars : [
		'barSize',
		'bars',
		'gapRatio',
		'barOffset',
		'bottom'
	],
	#category : #'Roassal3-Chart-Core'
}

{ #category : #accessing }
RSAbstractBoxPlot >> barOffset [
	^ barOffset
]

{ #category : #accessing }
RSAbstractBoxPlot >> barOffset: aNumber [
	barOffset := aNumber
]

{ #category : #accessing }
RSAbstractBoxPlot >> barScale [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractBoxPlot >> barSize [
	"Return the width of each bar"
	^ barSize ifNil: [ self barScale rangeBand ]
]

{ #category : #accessing }
RSAbstractBoxPlot >> barSize: aBarWidth [
	"Set the width of the bar"
	barSize := aBarWidth
]

{ #category : #accessing }
RSAbstractBoxPlot >> bars [
	^ bars
]

{ #category : #accessing }
RSAbstractBoxPlot >> bottom [
	^ bottom
]

{ #category : #accessing }
RSAbstractBoxPlot >> bottom: aCollection [
	self 
		assert: xValues size = aCollection size
		description: 'Invalid size'.
	bottom := aCollection
]

{ #category : #hooks }
RSAbstractBoxPlot >> computeRectagleFor: aPoint index: index [
	^ self subclassResponsibility
]

{ #category : #initialization }
RSAbstractBoxPlot >> defaultShape [
	^ RSBox new noPaint
]

{ #category : #accessing }
RSAbstractBoxPlot >> gapRatio [
	^ gapRatio
]

{ #category : #accessing }
RSAbstractBoxPlot >> gapRatio: aNumber [
	"aNumber between 0 and 1"
	gapRatio := aNumber
]

{ #category : #initialization }
RSAbstractBoxPlot >> initialize [
	super initialize.
	self
		gapRatio: 0.1;
		barOffset: 0.
]

{ #category : #testing }
RSAbstractBoxPlot >> isBoxPlot [
	^ true
]

{ #category : #hooks }
RSAbstractBoxPlot >> modelFor: aPoint [
	^ self subclassResponsibility
]
